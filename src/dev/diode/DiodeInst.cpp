#include <iostream>
using std::cout;
using std::endl;

#include "DiodeInst.h"

DiodeInst::DiodeInst(const string& str, const string& modelStr): 
	InstBase(str, modelStr)
{}

DiodeInst::DiodeInst(const DiodeInst& rhs): 
	InstBase(rhs)
{}

void DiodeInst::printInf() const {
	printGenInf();
}

std::shared_ptr< InstBase > DiodeInst::Clone() {
	return std::static_pointer_cast< InstBase >( std::shared_ptr< DiodeInst >(new DiodeInst( *this ) ) );
}