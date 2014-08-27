#include <iostream>
using std::cout;
using std::endl;

#include "ResInst.h"

#include "Matrix.h"

ResInst::ResInst(const string& str, const string& modelStr): 
	InstBase(str, modelStr),
	resistance(1)
{}

ResInst::ResInst(const ResInst& rhs): 
	InstBase(rhs),
	resistance(rhs.resistance)
{}

void ResInst::printInf() const {
	printGenInf();
	cout << "Resistance: " << resistance << "Ω" << endl;
}

std::shared_ptr< InstBase > ResInst::Clone() {
	return std::static_pointer_cast< InstBase >( std::shared_ptr< ResInst >(new ResInst( *this ) ) );
}

void ResInst::stamp(const std::shared_ptr< Matrix< double > >& mMat) {
	unsigned int nodeP = nodeTable[0].lock()->getId();
	unsigned int nodeN = nodeTable[1].lock()->getId();
	pMatpp = mMat->getMatPtr(nodeP, nodeP);
	pMatpn = mMat->getMatPtr(nodeP, nodeN);
	pMatnp = mMat->getMatPtr(nodeN, nodeP);
	pMatnn = mMat->getMatPtr(nodeN, nodeN);
}

void ResInst::load() {
	*pMatpp += 1/resistance;
	*pMatpn -= 1/resistance;
	*pMatnp -= 1/resistance;
	*pMatnn += 1/resistance;
}

void ResInst::loadOP() {
	load();
}

void ResInst::loadDC() {
	load();
}

void ResInst::loadTRAN(double time, double timeStep, bool flagInitial) {
	load();
}