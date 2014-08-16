#include <iostream>
using std::cout;
using std::endl;

#include "DiodeModel.h"
#include "regex"

#define IS modelParamTable[0]

DiodeModel::DiodeModel(const string& str): 
	ModelBase(str, arraySize)
{
	IS = 1e-12;
}

void DiodeModel::addParam(const string& param, double val) {
	if(std::regex_match(param, std::regex("is", std::regex::icase))) {
		IS = val;
	} else throw std::runtime_error(string("No parameter ") + param + " for diodes.");
}

void DiodeModel::printInf() const {
	printGenInf();
	cout << "Saturation Current: " << IS << "A" << endl;
}

#undef IS