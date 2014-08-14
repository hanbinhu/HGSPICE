#include <iomanip>
#include <iostream>
using std::cout;
using std::endl;

#include "XSubInst.h"

XSubInst::XSubInst(const string& str): 
	InstBase(str, "__X%"),
	mSubCktDef()
{}

void XSubInst::specifyParam(const string& param, double value) {
	paramTab.push_back(param);
	paramValueTab.push_back(value);
}

void XSubInst::printInf() const {
	cout << "****************************************" << endl;
	cout << "Inst Name: " << getInstName() << endl;
	cout << "Sub Circuit Definition name is " << subCktName << endl;
	cout << getInstName() << " has " << exNodeName.size() << " external nodes. The nodes are listed below:" << endl;
	cout.flags(std::ios::left);
	for(const string& mNode: exNodeName)
			cout << std::setw(8) << mNode;
	cout << endl;
	cout << "Parameters (" << paramTab.size() << ") are defined in SubCkt " << getInstName() << endl;
	cout.flags(std::ios::left);
	cout << std::setw(15) << "Parameters" << std::setw(10) << "Values" << endl;
	for(int i = 0; i < paramTab.size(); ++i)
		cout << std::setw(15) << paramTab[i] << std::setw(20) << paramValueTab[i] << endl;
}

void XSubInst::specifySubCkt() {
	subCktName = exNodeName.back();
	exNodeName.pop_back();
}
