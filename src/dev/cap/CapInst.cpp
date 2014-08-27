#include <iostream>
using std::cout;
using std::endl;

#include "CapInst.h"

#include "Matrix.h"

CapInst::CapInst(const string& str, const string& modelStr): 
	InstBase(str, modelStr),
	capcitance(1),
	voltageIC(0),
	brPtr(),
	initial(false)
{}

CapInst::CapInst(const CapInst& rhs): 
	InstBase(rhs),
	capcitance(rhs.capcitance),
	voltageIC(rhs.voltageIC),
	initial(rhs.initial)
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
	
	VTp = nodeTable[0].lock()->getTPtr();
	VTn = nodeTable[1].lock()->getTPtr();
}

void CapInst::loadOP() {
	*pMatbb += 1;
}

void CapInst::loadDC() {
	*pMatbb += 1;
}

void CapInst::loadTRAN(double time, double timeStep, bool flagInitial) {
	if(flagInitial) {
		if(initial) {
			*pMatpb += 1;
			*pMatnb -= 1;
			*pMatbp += 1;
			*pMatbn -= 1;
			*pRhsb += voltageIC;
		} else *pMatbb += 1;
	} else {
		double tmpV = capcitance / timeStep;
		*pMatpb += 1;
		*pMatnb -= 1;
		*pMatbp += tmpV;
		*pMatbn -= tmpV;
		*pMatbb -= 1;
		*pRhsb += tmpV * (*VTp - *VTn);
	}
}