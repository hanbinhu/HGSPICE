#include <iostream>
using std::cout;
using std::endl;

#include <tuple>

#include <cmath>

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
	printFileTitleGen(getInstName(), outF, title);
	printFileTitleGen(getInstName() + ":gm", outF, title);
	printFileTitleGen(getInstName() + ":gds", outF, title);
	printFileTitleGen(getInstName() + ":gmb", outF, title);
	printFileTitleGen(getInstName() + ":cgs", outF, title);
	printFileTitleGen(getInstName() + ":cgd", outF, title);
	printFileTitleGen(getInstName() + ":cgb", outF, title);
	printFileTitleGen(getInstName() + ":csb", outF, title);
	printFileTitleGen(getInstName() + ":cdb", outF, title);
}

void MosInst::printFileValue(ofstream& outF) const {
	printSeperator(outF);
	outF << Id;
	printSeperator(outF);
	outF << gm;
	printSeperator(outF);
	outF << gds;
	printSeperator(outF);
	outF << gmb;
	printSeperator(outF);
	outF << cgs;
	printSeperator(outF);
	outF << cgd;
	printSeperator(outF);
	outF << cgb;
	printSeperator(outF);
	outF << csb;
	printSeperator(outF);
	outF << cdb;
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

void MosInst::stampAC(const std::shared_ptr< Matrix< std::complex< double > > >& mMat) {
	unsigned int nodeD = nodeTable[0].lock()->getId();
	unsigned int nodeG = nodeTable[1].lock()->getId();
	unsigned int nodeS = nodeTable[2].lock()->getId();
	unsigned int nodeB = nodeTable[3].lock()->getId();
		
	pMatACdd = mMat->getMatPtr(nodeD, nodeD);
	pMatACdg = mMat->getMatPtr(nodeD, nodeG);
	pMatACds = mMat->getMatPtr(nodeD, nodeS);
	pMatACdb = mMat->getMatPtr(nodeD, nodeB);
	pMatACsd = mMat->getMatPtr(nodeS, nodeD);
	pMatACsg = mMat->getMatPtr(nodeS, nodeG);
	pMatACss = mMat->getMatPtr(nodeS, nodeS);
	pMatACsb = mMat->getMatPtr(nodeS, nodeB);
	pMatACgg = mMat->getMatPtr(nodeG, nodeG);
	pMatACgs = mMat->getMatPtr(nodeG, nodeS);
	pMatACgd = mMat->getMatPtr(nodeG, nodeD);
	pMatACgb = mMat->getMatPtr(nodeG, nodeB);
	pMatACbb = mMat->getMatPtr(nodeB, nodeB);
	pMatACbs = mMat->getMatPtr(nodeB, nodeS);
	pMatACbd = mMat->getMatPtr(nodeB, nodeD);
	pMatACbg = mMat->getMatPtr(nodeB, nodeG);
}

void MosInst::load() {
	setSmallParam();
	double Vgs = *VDg - *VDs;
	double Vds = *VDd - *VDs;
	double Vbs = *VDb - *VDs;
	double I0 = Id - gm * Vgs - gds * Vds - gmb * Vbs;
	
	*pMatdd += gds;
	*pMatdg += gm;
	*pMatds -= gm + gds + gmb;
	*pMatdb += gmb;
	*pMatsd -= gds;
	*pMatsg -= gm;
	*pMatss += gm + gds + gmb;
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

void MosInst::loadAC(double freq) {
	double w = 2 * M_PI * freq;
	
	*pMatACdd += std::complex<double>(gds, w * (cgd+cdb));
	*pMatACdg += std::complex<double>(gm, w * (-cgd));
	*pMatACds += std::complex<double>(-gm - gds - gmb, 0);
	*pMatACdb += std::complex<double>(gmb, w * (-cdb));
	*pMatACsd += std::complex<double>(-gds, 0);
	*pMatACsg += std::complex<double>(-gm, w * (-cgs));
	*pMatACss += std::complex<double>(gm + gds + gmb, w * (cgs+csb));
	*pMatACsb += std::complex<double>(-gmb, w * (-csb));
	*pMatACgg += std::complex<double>(0, w * (cgs+cgd+cgb));
	*pMatACgs += std::complex<double>(0, w * (-cgs));
	*pMatACgd += std::complex<double>(0, w * (-cgd));
	*pMatACgb += std::complex<double>(0, w * (-cgb));
	*pMatACbb += std::complex<double>(0, w * (cgb+csb+cdb));
	*pMatACbs += std::complex<double>(0, w * (-csb));
	*pMatACbd += std::complex<double>(0, w * (-cdb));
	*pMatACbg += std::complex<double>(0, w * (-cgb));
}

void MosInst::loadTRAN(double time, double timeStep, bool flagInitial) {
	load();
}

void MosInst::setSmallParam() {
	std::make_tuple(std::ref(Id), std::ref(gm), std::ref(gds), std::ref(gmb), std::ref(cgs), std::ref(cgd), std::ref(cgb), std::ref(csb), std::ref(cdb)) \
		= myModel.lock()->modelCalc(L, W, *VDd, *VDg, *VDs, *VDb);
}