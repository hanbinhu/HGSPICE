#include <iostream>
#include <exception>
using std::cout;
using std::endl;

#include "VSrcInst.h"

VSrcInst::VSrcInst(const string& str, const string& modelStr): 
	InstBase(str, modelStr),
	dcVoltage(0),
	acVoltage(0),
	acVoltagePhase(0),
	printFunc(nullptr),
	calFunc(nullptr),
	paramTable()
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