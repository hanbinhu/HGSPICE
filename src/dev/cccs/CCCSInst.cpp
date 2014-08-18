#include <iostream>
using std::cout;
using std::endl;

#include "CCCSInst.h"
#include "../vsrc/VSrcInst.h"

CCCSInst::CCCSInst(const string& str, const string& modelStr): 
	InstBase(str, modelStr),
	f(0)
{}

void CCCSInst::printInf() const {
	printGenInf();
	cout << "Current amplify coefficient: " << f << endl;
	cout << "CC provided by " << CCName << endl;
}