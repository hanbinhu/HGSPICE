#include <iostream>
using std::cout;
using std::endl;

#include "ResInst.h"

ResInst::ResInst(const string& str, const string& modelStr): 
	InstBase(str, modelStr),
	resistance(1)
{}

ResInst::ResInst(const ResInst& rhs): 
	InstBase(rhs),
	resistance(rhs.resistance)
{}

void ResInst::printInf() const {
	printGenInf();
	cout << "Resistance: " << resistance << "Ω" << endl;
}

std::shared_ptr< InstBase > ResInst::Clone() {
	return std::static_pointer_cast< InstBase >( std::shared_ptr< ResInst >(new ResInst( *this ) ) );
}
