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

void CCCSInst::printFileTitle(ofstream& outF, const string& title) const {
	printFileTitleGen(getInstName() + ":CS", outF, title);
}

void CCCSInst::printFileValue(ofstream& outF) const {
	printSeperator(outF);
	double I = f * mVPtr.lock()->getBrI();
	outF << I;
}

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

void CCCSInst::stampAC(const std::shared_ptr< Matrix< std::complex< double > > >& mMat) {
	unsigned int nodeP = nodeTable[0].lock()->getId();
	unsigned int nodeN = nodeTable[1].lock()->getId();
	unsigned int branchC = mVPtr.lock()->getBrId();
	pMatACpcb = mMat->getMatPtr(nodeP, branchC);
	pMatACncb = mMat->getMatPtr(nodeN, branchC);
}

void CCCSInst::load() {
	*pMatpcb += f;
	*pMatncb -= f;
}

void CCCSInst::loadOP() {
	load();
}

void CCCSInst::loadDC() {
	load();
}

void CCCSInst::loadAC(double freq) {
	*pMatACpcb += f;
	*pMatACncb -= f;
}

void CCCSInst::loadTRAN(double time, double timeStep, bool flagInitial) {
	load();
}