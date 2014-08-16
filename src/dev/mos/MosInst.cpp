#include <iostream>
using std::cout;
using std::endl;

#include "MosInst.h"

MosInst::MosInst(const string& str, const string& modelStr): 
	InstBase(str, modelStr)
{}

void MosInst::printInf() const {
	printGenInf();
	cout << "Length of transistor is " << L << "m." << endl;
	cout << "Width of transistor is " << W << "m." << endl;
}
