#include <iostream>
#include <stdexcept>
using std::cout;
using std::endl;

#include "ACAnalysis.h"

ACAnalysis::ACAnalysis(ACAnalysis::SweepType mType, int n, double fs, double fe):
	mSweepType(mType),
	nPoints(n),
	fStart(fs),
	fStop(fe)
{}

void ACAnalysis::PrintInf() {
	cout << "****************************************" << endl;
	cout << "Analysis Type: AC" << endl;
	cout << "\tSweep Method: ";
	switch(mSweepType) {
		case DEC:
			cout << "DEC" << endl;
			break;
		case OCT:
			cout << "OCT" << endl;
			break;
		case LIN:
			cout << "LIN" << endl;
			break;
		default:
			throw std::runtime_error("No this sweep type in ACAnalysis.");
	}
	cout << "\t# of points: " << nPoints << endl;
	cout << "\tStart Frequency: " << fStart << "Hz" << endl;
	cout << "\tStop Frequency: " << fStop << "Hz" << endl;
}