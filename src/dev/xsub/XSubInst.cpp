#include <iostream>
using std::cout;
using std::endl;

#include "XSubInst.h"

XSubInst::XSubInst(const string& str, const string& modelStr): 
	InstBase(str, modelStr)
{}

void XSubInst::printInf() const {
	printGenInf();
}
