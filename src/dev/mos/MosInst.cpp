#include <iostream>
using std::cout;
using std::endl;

#include <tuple>

#include "MosInst.h"

#include "Matrix.h"

MosInst::MosInst(const string& str, const string& modelStr): 
	InstBase(str, modelStr)
{}

MosInst::MosInst(const MosInst& rhs): 
	InstBase(rhs),
	W(rhs.W),
	L(rhs.L)
{}

void MosInst::setModel(const ModelPtr& mModel) {
	 myModel = std::dynamic_pointer_cast<MosModel>(mModel);
	 if(!myModel.lock()->checkSize(L, W))
		 throw std::runtime_error(getInstName() + " has wrong size.");
}

void MosInst::printFileTitle(ofstream& outF, const string& title) const {

}

void MosInst::printFileValue(ofstream& outF) const {

}

void MosInst::printInf() const {
	printGenInf();
	cout << "Length of transistor is " << L << "m." << endl;
	cout << "Width of transistor is " << W << "m." << endl;
}

std::shared_ptr< InstBase > MosInst::Clone() {
	return std::static_pointer_cast< InstBase >( std::shared_ptr< MosInst >(new MosInst( *this ) ) );
}

void MosInst::stamp(const std::shared_ptr< Matrix< double > >& mMat) {
	unsigned int nodeD = nodeTable[0].lock()->getId();
	unsigned int nodeG = nodeTable[1].lock()->getId();
	unsigned int nodeS = nodeTable[2].lock()->getId();
	unsigned int nodeB = nodeTable[3].lock()->getId();
	pMatdd = mMat->getMatPtr(nodeD, nodeD);
	pMatdg = mMat->getMatPtr(nodeD, nodeG);
	pMatds = mMat->getMatPtr(nodeD, nodeS);
	pMatdb = mMat->getMatPtr(nodeD, nodeB);
	pMatsd = mMat->getMatPtr(nodeS, nodeD);
	pMatsg = mMat->getMatPtr(nodeS, nodeG);
	pMatss = mMat->getMatPtr(nodeS, nodeS);
	pMatsb = mMat->getMatPtr(nodeS, nodeB);
	pRhsd = mMat->getRhsPtr(nodeD);
	pRhss = mMat->getRhsPtr(nodeS);
	
	VDd = nodeTable[0].lock()->getDPtr();
	VDg = nodeTable[1].lock()->getDPtr();
	VDs = nodeTable[2].lock()->getDPtr();
	VDb = nodeTable[3].lock()->getDPtr();
}

void MosInst::load() {
	std::make_tuple(std::ref(Id), std::ref(gm), std::ref(gds), std::ref(gmb)) = myModel.lock()->modelCalc(L, W, *VDd, *VDg, *VDs, *VDb);
	double Vgs = *VDg - *VDs;
	double Vds = *VDd - *VDs;
	double Vbs = *VDb - *VDs;
	double I0 = Id - gm * Vgs - gds * Vds - gmb * Vbs;
	
	*pMatdd += gds;
	*pMatdg += gm;
	*pMatds -= (gm + gds + gmb);
	*pMatdb += gmb;
	*pMatsd -= gds;
	*pMatsg -= gm;
	*pMatss += (gm + gds + gmb);
	*pMatsb -= gmb;
	
	*pRhsd -= I0;
	*pRhss += I0;
}

void MosInst::loadOP() {
	load();
}

void MosInst::loadDC() {
	load();
}

void MosInst::loadTRAN(double time, double timeStep, bool flagInitial) {
	load();
}