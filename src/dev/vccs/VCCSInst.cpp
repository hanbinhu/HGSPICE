#include <iostream>
using std::cout;
using std::endl;

#include "VCCSInst.h"

VCCSInst::VCCSInst(const string& str, const string& modelStr): 
	InstBase(str, modelStr),
	g(0)
{}

VCCSInst::VCCSInst(const VCCSInst& rhs): 
	InstBase(rhs),
	g(rhs.g)
{}

void VCCSInst::printInf() const {
	printGenInf();
	cout << "Transconductance: " << g << endl;
}

std::shared_ptr< InstBase > VCCSInst::Clone() {
	return std::static_pointer_cast< InstBase >( std::shared_ptr< VCCSInst >(new VCCSInst( *this ) ) );
}