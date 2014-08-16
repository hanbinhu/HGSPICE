#include <iostream>
using std::cout;
using std::endl;

#include "DiodeInst.h"

DiodeInst::DiodeInst(const string& str, const string& modelStr): 
	InstBase(str, modelStr)
{}

void DiodeInst::printInf() const {
	printGenInf();
}
