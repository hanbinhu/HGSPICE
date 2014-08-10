#include <iostream>
using std::cout;
using std::endl;

#include "VCCSInst.h"

VCCSInst::VCCSInst(const string& str, const string& modelStr): 
	InstBase(str, modelStr),
	g(0)
{}

void VCCSInst::printInf() const {
	printGenInf();
	cout << "Transconductance: " << g << endl;
}