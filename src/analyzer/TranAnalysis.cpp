#include <iostream>
#include <fstream>
using std::cout;
using std::endl;

#include <vector>
using std::vector;

#include "TranAnalysis.h"

#include "Ckt.h"
#include "Matrix.h"

TranAnalysis::TranAnalysis(int id, const string& filename, double ti, double te, double ts):
	Analysis(id, filename),
	tStep(ti),
	tStop(te),
	tStart(ts)
{}

void TranAnalysis::PrintInf() {
	cout << "****************************************" << endl;
	cout << "Analysis Type: Tran" << endl;
	cout << "\tStart Time: " << tStart << "s" << endl;
	cout << "\tStop Time: " << tStop << "s" << endl;
	cout << "\tStep Time: " << tStep << "s" << endl;
}

void TranAnalysis::analyze(const std::shared_ptr< Ckt >& mCkt, std::shared_ptr< Matrix< double > > mMat) {
	bool flagINI =  true;
	std::ofstream outFile(outputFile, std::fstream::out);
	outFile.setf(std::ios::scientific);
	
	for(double t = tStart; t <= tStop; t += tStep) {
		mCkt->LoadTRAN(t, tStep, flagINI);
		mMat->solveVI();
		
		vector<double> vVec;
		for(unsigned int i = 0; i < mMat->getDim(); i++) vVec.push_back(mMat->getResVal(i));
		mCkt->SetTForNAB(vVec);
		
		if(flagINI) outFile << "Time(s)";
		mCkt->printFile(t, flagINI, outFile);
		
		mMat->reset();
		flagINI = false;
	}
	outFile.close();
}