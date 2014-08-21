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

IndInst::IndInst(const IndInst& rhs): 
	InstBase(rhs),
	inductance(rhs.inductance),
	currentIC(rhs.currentIC)
{}

void IndInst::printInf() const {
	printGenInf();
	cout << "Inductance: " << inductance << "H" << endl;
	cout << "Initial Condition current: " << currentIC << "A" << endl;
}

std::shared_ptr< InstBase > IndInst::Clone() {
	return std::static_pointer_cast< InstBase >( std::shared_ptr< IndInst >(new IndInst( *this ) ) );
}