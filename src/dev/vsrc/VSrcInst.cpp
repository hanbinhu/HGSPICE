#include <iostream>
#include <exception>
using std::cout;
using std::endl;

#include "VSrcInst.h"

#include "Matrix.h"

VSrcInst::VSrcInst(const string& str, const string& modelStr): 
	InstBase(str, modelStr),
	dcVoltage(0),
	acVoltage(0),
	acVoltagePhase(0),
	printFunc(nullptr),
	calFunc(nullptr),
	paramTable()
{}

VSrcInst::VSrcInst(const VSrcInst& rhs): 
	InstBase(rhs),
	dcVoltage(rhs.dcVoltage),
	acVoltage(rhs.acVoltage),
	acVoltagePhase(rhs.acVoltagePhase),
	printFunc(rhs.printFunc),
	calFunc(rhs.calFunc),
	paramTable(rhs.paramTable)
{}

void VSrcInst::printInf() const {
	printGenInf();
	cout << "DC Current: " << dcVoltage << "V" << endl;
	cout << "AC Current: " << acVoltage << "V" << endl;
	cout << "AC Current Phase: " << acVoltagePhase << "°" << endl;
	if(printFunc != nullptr) printFunc(paramTable, SrcFunc::V);
	else cout << "No transient function." << endl;
}

void VSrcInst::specifyFunc(SrcFunc::TranFuncType mFuncType, const vector< double >& paramTab) {
	switch(mFuncType) {
		case SrcFunc::Sine:
			calFunc = &SrcFunc::SineFunc;
			printFunc = &SrcFunc::SinePrint;
			paramTable = paramTab;
			break;
		case SrcFunc::Exp:
			calFunc = &SrcFunc::ExpFunc;
			printFunc = &SrcFunc::ExpPrint;
			paramTable = paramTab;
			break;
		case SrcFunc::Pulse:
			calFunc = &SrcFunc::PulseFunc;
			printFunc = &SrcFunc::PulsePrint;
			paramTable = paramTab;
			break;
		case SrcFunc::SFFM:
			calFunc = &SrcFunc::SFFMFunc;
			printFunc = &SrcFunc::SFFMPrint;
			paramTable = paramTab;
			break;
		default:
			throw std::runtime_error(string("Unexpected function type found in ") + getInstName());
	}
}

std::shared_ptr< InstBase > VSrcInst::Clone() {
	return std::static_pointer_cast< InstBase >( std::shared_ptr< VSrcInst >(new VSrcInst( *this ) ) );
}

void VSrcInst::stamp(const std::shared_ptr< Matrix< double > >& mMat){
	unsigned int nodeP = nodeTable[0].lock()->getId();
	unsigned int nodeN = nodeTable[1].lock()->getId();
	unsigned int branch = brPtr.lock()->getId();
	pMatpb = mMat->getMatPtr(nodeP, branch);
	pMatnb = mMat->getMatPtr(nodeN, branch);
	pMatbp = mMat->getMatPtr(branch, nodeP);
	pMatbn = mMat->getMatPtr(branch, nodeN);
	pRhsb = mMat->getRhsPtr(branch);
}