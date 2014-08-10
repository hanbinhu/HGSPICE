#include <iostream>
using std::cout;
using std::endl;

#include "ResInst.h"

ResInst::ResInst(const string& str, const string& modelStr): 
	InstBase(str, modelStr),
	resistance(1)
{}

void ResInst::printInf() const {
	printGenInf();
	cout << "Resistance: " << resistance << "Ω" << endl;
}
