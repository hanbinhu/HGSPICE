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

void OPAnalysis::analyze(const std::shared_ptr< Ckt >& mCkt, std::shared_ptr< Matrix< double > > mMat) {
	std::ofstream outFile(outputFile, std::fstream::out);
	outFile.setf(std::ios::scientific);
	
	mCkt->LoadOP();
	mMat->solveVI();
	
	vector<double> vVec;
	for(unsigned int i = 0; i < mMat->getDim(); i++) vVec.push_back(mMat->getResVal(i));
	mCkt->SetTForNAB(vVec);
	
	outFile << "NS";
	mCkt->printFile(0, true, outFile);
	
	mMat.reset();
}