#include <iostream>
using std::cout;
using std::endl;

#include "CCVSInst.h"
#include "../vsrc/VSrcInst.h"

CCVSInst::CCVSInst(const string& str, const string& modelStr): 
	InstBase(str, modelStr),
	h(0)
{}

void CCVSInst::printInf() const {
	printGenInf();
	cout << "Transresistance: " << h << endl;
	cout << "CC provided by " << CCName << endl;
}