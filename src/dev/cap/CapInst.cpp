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

CapInst::CapInst(const CapInst& rhs): 
	InstBase(rhs),
	capcitance(rhs.capcitance),
	voltageIC(rhs.voltageIC)
{}

void CapInst::printInf() const {
	printGenInf();
	cout << "Capcitance: " << capcitance << "F" << endl;
	cout << "Initial Condition voltage: " << voltageIC << "V" << endl;
}

std::shared_ptr< InstBase > CapInst::Clone() {
	return std::static_pointer_cast< InstBase >( std::shared_ptr< CapInst >(new CapInst( *this ) ) );
}