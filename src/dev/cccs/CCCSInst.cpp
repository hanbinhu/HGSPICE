#include <iostream>
using std::cout;
using std::endl;

#include "CCCSInst.h"
#include "../vsrc/VSrcInst.h"

CCCSInst::CCCSInst(const string& str, const string& modelStr): 
	InstBase(str, modelStr),
	f(0)
{}

CCCSInst::CCCSInst(const CCCSInst& rhs): 
	InstBase(rhs),
	f(rhs.f),
	CCName(rhs.CCName)
{}

void CCCSInst::printInf() const {
	printGenInf();
	cout << "Current amplify coefficient: " << f << endl;
	cout << "CC provided by " << CCName << endl;
}

std::shared_ptr< InstBase > CCCSInst::Clone() {
	return std::static_pointer_cast< InstBase >( std::shared_ptr< CCCSInst >(new CCCSInst( *this ) ) );
}