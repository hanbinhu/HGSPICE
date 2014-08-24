#include <iostream>
using std::cout;
using std::endl;

#include "IndInst.h"

#include "Matrix.h"

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

void IndInst::stamp(const std::shared_ptr< Matrix< double > >& mMat) {
	unsigned int nodeP = nodeTable[0].lock()->getId();
	unsigned int nodeN = nodeTable[0].lock()->getId();
	unsigned int branch = brPtr.lock()->getId();
	pMatpb = mMat->getMatPtr(nodeP, branch);
	pMatnb = mMat->getMatPtr(nodeN, branch);
	pMatbp = mMat->getMatPtr(branch, nodeP);
	pMatbn = mMat->getMatPtr(branch, nodeN);
	pMatbb = mMat->getMatPtr(branch, branch);
	pRhsb = mMat->getRhsPtr(branch);
}