#include <iostream>
using std::cout;
using std::endl;

#include "VCCSInst.h"

#include "Matrix.h"

VCCSInst::VCCSInst(const string& str, const string& modelStr): 
	InstBase(str, modelStr),
	g(0)
{}

VCCSInst::VCCSInst(const VCCSInst& rhs): 
	InstBase(rhs),
	g(rhs.g)
{}

void VCCSInst::printFileTitle(ofstream& outF, const string& title) const {
	printFileTitleGen(getInstName() + ":CS", outF, title);
}

void VCCSInst::printFileValue(ofstream& outF) const {
	printSeperator(outF);
	double Vp = *(nodeTable[2].lock()->getTPtr());
	double Vn = *(nodeTable[3].lock()->getTPtr());
	double I = (Vp - Vn) * g;
	outF << I;
}

void VCCSInst::printInf() const {
	printGenInf();
	cout << "Transconductance: " << g << endl;
}

std::shared_ptr< InstBase > VCCSInst::Clone() {
	return std::static_pointer_cast< InstBase >( std::shared_ptr< VCCSInst >(new VCCSInst( *this ) ) );
}

void VCCSInst::stamp(const std::shared_ptr< Matrix< double > >& mMat) {
	unsigned int nodeP = nodeTable[0].lock()->getId();
	unsigned int nodeN = nodeTable[1].lock()->getId();
	unsigned int nodeCP = nodeTable[2].lock()->getId();
	unsigned int nodeCN = nodeTable[3].lock()->getId();
	pMatpcp = mMat->getMatPtr(nodeP, nodeCP);
	pMatpcn = mMat->getMatPtr(nodeP, nodeCN);
	pMatncp = mMat->getMatPtr(nodeN, nodeCP);
	pMatncn = mMat->getMatPtr(nodeN, nodeCN);
}

void VCCSInst::stampAC(const std::shared_ptr< Matrix< std::complex< double > > >& mMat) {
	unsigned int nodeP = nodeTable[0].lock()->getId();
	unsigned int nodeN = nodeTable[1].lock()->getId();
	unsigned int nodeCP = nodeTable[2].lock()->getId();
	unsigned int nodeCN = nodeTable[3].lock()->getId();
	pMatACpcp = mMat->getMatPtr(nodeP, nodeCP);
	pMatACpcn = mMat->getMatPtr(nodeP, nodeCN);
	pMatACncp = mMat->getMatPtr(nodeN, nodeCP);
	pMatACncn = mMat->getMatPtr(nodeN, nodeCN);
}

void VCCSInst::load() {
	*pMatpcp += g;
	*pMatpcn -= g;
	*pMatncp -= g;
	*pMatncn += g;
}

void VCCSInst::loadOP() {
	load();
}

void VCCSInst::loadDC() {
	load();
}

void VCCSInst::loadAC(double freq) {
	*pMatACpcp += g;
	*pMatACpcn -= g;
	*pMatACncp -= g;
	*pMatACncn += g;
}

void VCCSInst::loadTRAN(double time, double timeStep, bool flagInitial) {
	load();
}