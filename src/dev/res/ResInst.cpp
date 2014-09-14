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

void ResInst::printFileTitle(ofstream& outF, const string& title) const {
	printFileTitleGen(getInstName(), outF, title);
}

void ResInst::printFileValue(ofstream& outF) const {
	printSeperator(outF);
	double Vp = *(nodeTable[0].lock()->getTPtr());
	double Vn = *(nodeTable[1].lock()->getTPtr());
	double I = (Vp - Vn) / resistance;
	outF << I;
}

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

void ResInst::stampAC(const std::shared_ptr< Matrix< std::complex< double > > >& mMat) {
	unsigned int nodeP = nodeTable[0].lock()->getId();
	unsigned int nodeN = nodeTable[1].lock()->getId();
	pMatACpp = mMat->getMatPtr(nodeP, nodeP);
	pMatACpn = mMat->getMatPtr(nodeP, nodeN);
	pMatACnp = mMat->getMatPtr(nodeN, nodeP);
	pMatACnn = mMat->getMatPtr(nodeN, nodeN);
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

void ResInst::loadAC(double freq) {
	*pMatACpp += 1/resistance;
	*pMatACpn -= 1/resistance;
	*pMatACnp -= 1/resistance;
	*pMatACnn += 1/resistance;
}

void ResInst::loadTRAN(double time, double timeStep, bool flagInitial) {
	load();
}