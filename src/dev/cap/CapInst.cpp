#include <iostream>
using std::cout;
using std::endl;

#include "CapInst.h"

CapInst::CapInst(const string& str, const string& modelStr): 
	InstBase(str, modelStr),
	capcitance(1),
	voltageIC(0),
	brPtr()
{}

void CapInst::printInf() const {
	printGenInf();
	cout << "Capcitance: " << capcitance << "F" << endl;
	cout << "Initial Condition voltage: " << voltageIC << "V" << endl;
}