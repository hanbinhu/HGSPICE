#include <iostream>
using std::cout;
using std::endl;

#include "DCAnalysis.h"

DCAnalysis::DCAnalysis(const string& src, double vs, double ve, double vi):
	SrcName(src),
	vStart(vs),
	vStop(ve),
	vInc(vi)
{}

void DCAnalysis::PrintInf() {
	cout << "****************************************" << endl;
	cout << "Analysis Type: DC" << endl;
	cout << "\tSweep Source Name: " << SrcName << endl;
	cout << "\tStart Value: " << vStart << endl;
	cout << "\tStop Value: " << vStop << endl;
	cout << "\tIncremental Value: " << vInc << endl;
}