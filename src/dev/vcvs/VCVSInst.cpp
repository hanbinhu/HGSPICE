#include <iostream>
using std::cout;
using std::endl;

#include "VCVSInst.h"

#include "Matrix.h"

VCVSInst::VCVSInst(const string& str, const string& modelStr): 
	InstBase(str, modelStr),
	e(0)
{}

VCVSInst::VCVSInst(const VCVSInst& rhs): 
	InstBase(rhs),
	e(rhs.e)
{}

void VCVSInst::printInf() const {
	printGenInf();
	cout << "Voltage amplify coefficient: " << e << endl;
}

std::shared_ptr< InstBase > VCVSInst::Clone() {
	return std::static_pointer_cast< InstBase >( std::shared_ptr< VCVSInst >(new VCVSInst( *this ) ) );
}

void VCVSInst::stamp(const std::shared_ptr< Matrix< double > >& mMat) {
	unsigned int nodeP = nodeTable[0].lock()->getId();
	unsigned int nodeN = nodeTable[1].lock()->getId();
	unsigned int nodeCP = nodeTable[2].lock()->getId();
	unsigned int nodeCN = nodeTable[3].lock()->getId();
	unsigned int branch = brVSPtr.lock()->getId();
	pMatpb = mMat->getMatPtr(nodeP, branch);
	pMatnb = mMat->getMatPtr(nodeN, branch);
	pMatbp = mMat->getMatPtr(branch, nodeP);
	pMatbn = mMat->getMatPtr(branch, nodeN);
	pMatbcp = mMat->getMatPtr(branch, nodeCP);
	pMatbcn = mMat->getMatPtr(branch, nodeCN);
}

void VCVSInst::load() {
	*pMatpb += 1;
	*pMatnb -= 1;
	*pMatbp += 1;
	*pMatbn -= 1;
	*pMatbcp -= e;
	*pMatbcn += e;
}

void VCVSInst::loadOP(){
	load();
}

void VCVSInst::loadDC() {
	load();
}