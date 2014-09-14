#include <iostream>
using std::cout;
using std::endl;
#include <fstream>

#include "OPAnalysis.h"

#include "Ckt.h"
#include "Matrix.h"

#include <vector>
using std::vector;

OPAnalysis::OPAnalysis(int id, const string& filename): 
	Analysis(id, filename)
{}

void OPAnalysis::PrintInf() {
	cout << "****************************************" << endl;
	cout << "Analysis Type: OP" << endl;
	cout << "No Special Information" << endl;
}

void OPAnalysis::opAna(const std::shared_ptr< Ckt >& mCkt, std::shared_ptr< Matrix< double > > mMat) {
	mCkt->randInitial();
	
	vector<double> vVec;
	vVec.reserve(mMat->getDim());
	
	int iterCnt = 0;
	bool flagConv = false;
	do {
		mCkt->LoadOP();
		//mMat->printMat();
		//mMat->printRhs();
		bool SolveSuccess = mMat->solveVI();
		if(!SolveSuccess) cout << "OP: doesn't converge" << endl;
		vVec.clear();
		for(unsigned int i = 0; i < mMat->getDim(); i++) vVec.push_back(mMat->getResVal(i));
		flagConv = mCkt->SetDForNAB(vVec, epsilonA, epsilonR);
		mMat->reset();
		iterCnt++;
	} while(!flagConv);
	
	mCkt->SetTForNAB(vVec);
	mCkt->SmallSignalSet();
}

void OPAnalysis::analyze(const std::shared_ptr< Ckt >& mCkt, std::shared_ptr< Matrix< double > > mMat) {
	std::ofstream outFile(outputFile, std::fstream::out);
	outFile.setf(std::ios::scientific);
	
	opAna(mCkt, mMat);
	
	outFile << "NS";
	mCkt->printFile(0, true, outFile);
}