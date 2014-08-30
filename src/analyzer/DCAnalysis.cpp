#include <iostream>
using std::cout;
using std::endl;
#include <fstream>

#include "DCAnalysis.h"
#include "Devices.h"

#include "Ckt.h"
#include "Matrix.h"

DCAnalysis::DCAnalysis(int id, const string& filename, const string& src, double vs, double ve, double vi):
	Analysis(id, filename),
	mSrcName(src),
	vStart(vs),
	vStop(ve),
	vInc(vi)
{
	switch(mSrcName[0]) {
		case 'V':
		case 'v': {
			mType = V;
		} break;
		case 'I':
		case 'i': {
			mType = I;
		} break;
		default:
			throw std::runtime_error(mSrcName + " is not a source name.");
	}
}

void DCAnalysis::linkSrcInst(std::shared_ptr< InstBase > srcInst) {
	if(mType == V) {
		mVSrcInst = std::dynamic_pointer_cast< VSrcInst >(srcInst);
	} else {
		mISrcInst = std::dynamic_pointer_cast< ISrcInst >(srcInst);
	}
}

void DCAnalysis::PrintInf() {
	cout << "****************************************" << endl;
	cout << "Analysis Type: DC" << endl;
	cout << "\tSweep Source Name: " << mSrcName << endl;
	cout << "\tStart Value: " << vStart << endl;
	cout << "\tStop Value: " << vStop << endl;
	cout << "\tIncremental Value: " << vInc << endl;
}

void DCAnalysis::analyze(const std::shared_ptr< Ckt >& mCkt, std::shared_ptr< Matrix< double > > mMat) {
	std::ofstream outFile(outputFile, std::fstream::out);
	outFile.setf(std::ios::scientific);
	
	mCkt->NodeInitial();
	
	for(double v = vStart; v <= vStop; v += vInc) {
		if(mType == V) mVSrcInst.lock()->setLoad(v);
		else mISrcInst.lock()->setLoad(v);
		
		vector<double> vVec;
		bool flagConv = false;
		do {
			mCkt->LoadDC();
			mMat->solveVI();
			vVec.clear();
			for(unsigned int i = 0; i < mMat->getDim(); i++) vVec.push_back(mMat->getResVal(i));
			flagConv = mCkt->SetDForNAB(vVec, epsilonA, epsilonR);
		} while(!flagConv);
		
		mCkt->SetTForNAB(vVec);
		
		bool initial = (v == vStart);
		if(initial) {
			outFile << mSrcName;
			if(mType == V) outFile << "(V)";
			else outFile << "(A)";
		}
		mCkt->printFile(v, initial, outFile);
		
		mMat->reset();
	}
	outFile.close();
}