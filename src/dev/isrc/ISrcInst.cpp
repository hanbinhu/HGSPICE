#include <iostream>
#include <exception>
using std::cout;
using std::endl;

#include "ISrcInst.h"

ISrcInst::ISrcInst(const string& str, const string& modelStr): 
	InstBase(str, modelStr),
	dcCurrent(0),
	acCurrent(0),
	acCurrentPhase(0),
	printFunc(nullptr),
	calFunc(nullptr),
	paramTable()
{}

ISrcInst::ISrcInst(const ISrcInst& rhs): 
	InstBase(rhs),
	dcCurrent(rhs.dcCurrent),
	acCurrent(rhs.acCurrent),
	acCurrentPhase(rhs.acCurrentPhase),
	printFunc(rhs.printFunc),
	calFunc(rhs.calFunc),
	paramTable(rhs.paramTable)
{}

void ISrcInst::printInf() const {
	printGenInf();
	cout << "DC Current: " << dcCurrent << "A" << endl;
	cout << "AC Current: " << acCurrent << "A" << endl;
	cout << "AC Current Phase: " << acCurrentPhase << "°" << endl;
	if(printFunc != nullptr) printFunc(paramTable, SrcFunc::I);
	else cout << "No transient function." << endl;
}

void ISrcInst::specifyFunc(SrcFunc::TranFuncType mFuncType, const vector< double >& paramTab) {
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

std::shared_ptr< InstBase > ISrcInst::Clone() {
	return std::static_pointer_cast< InstBase >( std::shared_ptr< ISrcInst >(new ISrcInst( *this ) ) );
}