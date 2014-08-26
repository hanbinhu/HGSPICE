#include <iostream>
using std::cout;
using std::endl;

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
	mCkt->LoadOP();
	mMat->solveVI();
	cout << outputFile << endl;
	mMat->printRes();
	mMat.reset();
}