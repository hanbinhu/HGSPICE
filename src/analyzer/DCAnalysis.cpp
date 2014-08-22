#include <iostream>
using std::cout;
using std::endl;

#include "DCAnalysis.h"
#include "Devices.h"

DCAnalysis::DCAnalysis(const string& src, double vs, double ve, double vi):
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