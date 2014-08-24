#include <iostream>
using std::cout;
using std::endl;

#include "CCCSInst.h"
#include "../vsrc/VSrcInst.h"

#include "Matrix.h"

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

void CCCSInst::stamp(const std::shared_ptr< Matrix< double > >& mMat) {
	unsigned int nodeP = nodeTable[0].lock()->getId();
	unsigned int nodeN = nodeTable[1].lock()->getId();
	unsigned int branchC = mVPtr.lock()->getBrId();
	pMatpcb = mMat->getMatPtr(nodeP, branchC);
	pMatncb = mMat->getMatPtr(nodeN, branchC);
}

void CCCSInst::loadDC() {
	*pMatpcb += f;
	*pMatncb -= f;
}