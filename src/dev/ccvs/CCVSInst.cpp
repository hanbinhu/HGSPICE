#include <iostream>
using std::cout;
using std::endl;

#include "CCVSInst.h"
#include "../vsrc/VSrcInst.h"

CCVSInst::CCVSInst(const string& str, const string& modelStr): 
	InstBase(str, modelStr),
	h(0)
{}

CCVSInst::CCVSInst(const CCVSInst& rhs): 
	InstBase(rhs),
	h(rhs.h),
	CCName(rhs.CCName)
{}

void CCVSInst::printInf() const {
	printGenInf();
	cout << "Transresistance: " << h << endl;
	cout << "CC provided by " << CCName << endl;
}

std::shared_ptr< InstBase > CCVSInst::Clone() {
	return std::static_pointer_cast< InstBase >( std::shared_ptr< CCVSInst >(new CCVSInst( *this ) ) );
}