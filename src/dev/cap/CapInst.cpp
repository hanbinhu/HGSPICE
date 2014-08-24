#include <iostream>
using std::cout;
using std::endl;

#include "CapInst.h"

#include "Matrix.h"

CapInst::CapInst(const string& str, const string& modelStr): 
	InstBase(str, modelStr),
	capcitance(1),
	voltageIC(0),
	brPtr()
{}

CapInst::CapInst(const CapInst& rhs): 
	InstBase(rhs),
	capcitance(rhs.capcitance),
	voltageIC(rhs.voltageIC)
{}

void CapInst::printInf() const {
	printGenInf();
	cout << "Capcitance: " << capcitance << "F" << endl;
	cout << "Initial Condition voltage: " << voltageIC << "V" << endl;
}

std::shared_ptr< InstBase > CapInst::Clone() {
	return std::static_pointer_cast< InstBase >( std::shared_ptr< CapInst >(new CapInst( *this ) ) );
}

void CapInst::stamp(const std::shared_ptr< Matrix< double > >& mMat) {
	unsigned int nodeP = nodeTable[0].lock()->getId();
	unsigned int nodeN = nodeTable[1].lock()->getId();
	unsigned int branch = brPtr.lock()->getId();
	pMatpb = mMat->getMatPtr(nodeP, branch);
	pMatnb = mMat->getMatPtr(nodeN, branch);
	pMatbp = mMat->getMatPtr(branch, nodeP);
	pMatbn = mMat->getMatPtr(branch, nodeN);
	pMatbb = mMat->getMatPtr(branch, branch);
	pRhsb = mMat->getRhsPtr(branch);
}

void CapInst::loadDC() {
	
}