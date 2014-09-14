#include <iostream>
using std::cout;
using std::endl;

#include <cmath>

#include "IndInst.h"

#include "Matrix.h"

IndInst::IndInst(const string& str, const string& modelStr): 
	InstBase(str, modelStr),
	inductance(1),
	currentIC(0),
	brPtr(),
	initial(false)
{}

IndInst::IndInst(const IndInst& rhs): 
	InstBase(rhs),
	inductance(rhs.inductance),
	currentIC(rhs.currentIC),
	initial(rhs.initial)
{}

void IndInst::printFileTitle(ofstream& outF, const string& title) const {
	printFileTitleGen(getInstName(), outF, title);
}

void IndInst::printFileValue(ofstream& outF) const {
	printSeperator(outF);
	outF << *IT;
}

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
	unsigned int nodeN = nodeTable[1].lock()->getId();
	unsigned int branch = brPtr.lock()->getId();
	pMatpb = mMat->getMatPtr(nodeP, branch);
	pMatnb = mMat->getMatPtr(nodeN, branch);
	pMatbp = mMat->getMatPtr(branch, nodeP);
	pMatbn = mMat->getMatPtr(branch, nodeN);
	pMatbb = mMat->getMatPtr(branch, branch);
	pRhsb = mMat->getRhsPtr(branch);
	
	IT = brPtr.lock()->getTPtr();
}

void IndInst::stampAC(const std::shared_ptr< Matrix< std::complex< double > > >& mMat) {
	unsigned int nodeP = nodeTable[0].lock()->getId();
	unsigned int nodeN = nodeTable[1].lock()->getId();
	unsigned int branch = brPtr.lock()->getId();
	pMatACpb = mMat->getMatPtr(nodeP, branch);
	pMatACnb = mMat->getMatPtr(nodeN, branch);
	pMatACbp = mMat->getMatPtr(branch, nodeP);
	pMatACbn = mMat->getMatPtr(branch, nodeN);
	pMatACbb = mMat->getMatPtr(branch, branch);
}

void IndInst::loadOP() {
	*pMatpb += 1;
	*pMatnb -= 1;
	*pMatbp += 1;
	*pMatbn -= 1;
}

void IndInst::loadDC() {
	*pMatpb += 1;
	*pMatnb -= 1;
	*pMatbp += 1;
	*pMatbn -= 1;
}

void IndInst::loadAC(double freq) {
	double w = 2 * M_PI * freq;
	*pMatACpb += 1;
	*pMatACnb -= 1;
	*pMatACbp += 1;
	*pMatACbn -= 1;
	*pMatACbb -= std::complex<double> (0, w * inductance);
}

void IndInst::loadTRAN(double time, double timeStep, bool flagInitial) {
	*pMatpb += 1;
	*pMatnb -= 1;
	if(flagInitial) {
		if(initial) {
			*pMatbb += 1;
			*pRhsb += currentIC;
		} else {
			*pMatbp += 1;
			*pMatbn -= 1;
		}
	} else {
		double tmpV = inductance / timeStep;
		*pMatbp += 1;
		*pMatbn -= 1;
		*pMatbb -= tmpV;
		*pRhsb -= *IT * tmpV;
	}
}