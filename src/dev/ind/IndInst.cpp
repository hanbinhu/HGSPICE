#include <iostream>
using std::cout;
using std::endl;

#include "IndInst.h"

IndInst::IndInst(const string& str, const string& modelStr): 
	InstBase(str, modelStr),
	inductance(1),
	currentIC(0),
	brPtr()
{}

void IndInst::printInf() const {
	printGenInf();
	cout << "Inductance: " << inductance << "H" << endl;
	cout << "Initial Condition current: " << currentIC << "A" << endl;
}