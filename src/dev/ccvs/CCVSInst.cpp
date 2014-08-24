#include <iostream>
using std::cout;
using std::endl;

#include "CCVSInst.h"
#include "../vsrc/VSrcInst.h"

#include "Matrix.h"

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

void CCVSInst::stamp(const std::shared_ptr< Matrix< double > >& mMat) {
	unsigned int nodeP = nodeTable[0].lock()->getId();
	unsigned int nodeN = nodeTable[1].lock()->getId();
	unsigned int branch = brVSPtr.lock()->getId();
	unsigned int branchC = mVPtr.lock()->getBrId();
	pMatpb = mMat->getMatPtr(nodeP, branch);
	pMatnb = mMat->getMatPtr(nodeN, branch);
	pMatbp = mMat->getMatPtr(branch, nodeP);
	pMatbn = mMat->getMatPtr(branch, nodeN);
	pMatbcb = mMat->getMatPtr(branch, branchC);
}

void CCVSInst::loadDC() {
	*pMatpb += 1;
	*pMatnb -= 1;
	*pMatbp += 1;
	*pMatbn -= 1;
	*pMatbcb -= h;
}