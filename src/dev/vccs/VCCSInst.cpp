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

void VCCSInst::loadTRAN(double time, double timeStep, bool flagInitial) {
	load();
}