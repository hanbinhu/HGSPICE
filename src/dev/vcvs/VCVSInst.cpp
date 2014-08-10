#include <iostream>
using std::cout;
using std::endl;

#include "VCVSInst.h"

VCVSInst::VCVSInst(const string& str, const string& modelStr): 
	InstBase(str, modelStr),
	e(0)
{}

void VCVSInst::printInf() const {
	printGenInf();
	cout << "Voltage amplify coefficient: " << e << endl;
}