#include <iostream>
using std::cout;
using std::endl;

#include "OPAnalysis.h"

#include "Ckt.h"
#include "Matrix.h"

void OPAnalysis::PrintInf() {
	cout << "****************************************" << endl;
	cout << "Analysis Type: OP" << endl;
	cout << "No Special Information" << endl;
}

void OPAnalysis::analyze(const string& filename, const std::shared_ptr< Ckt >& mCkt, std::shared_ptr< Matrix< double > >& mMat) {
	mCkt->LoadDC();
	mMat->solveVI();
}