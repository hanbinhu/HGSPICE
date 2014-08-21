#include <iostream>
using std::cout;
using std::endl;

#include "VCVSInst.h"

VCVSInst::VCVSInst(const string& str, const string& modelStr): 
	InstBase(str, modelStr),
	e(0)
{}

VCVSInst::VCVSInst(const VCVSInst& rhs): 
	InstBase(rhs),
	e(rhs.e)
{}

void VCVSInst::printInf() const {
	printGenInf();
	cout << "Voltage amplify coefficient: " << e << endl;
}

std::shared_ptr< InstBase > VCVSInst::Clone() {
	return std::static_pointer_cast< InstBase >( std::shared_ptr< VCVSInst >(new VCVSInst( *this ) ) );
}