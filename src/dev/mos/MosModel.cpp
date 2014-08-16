#include <iostream>
using std::cout;
using std::endl;

#include "MosModel.h"
#include "regex"

#define Lmin modelParamTable[0]
#define Lmax modelParamTable[1]
#define Wmin modelParamTable[2]
#define Wmax modelParamTable[3]
#define Phi modelParamTable[4]
#define Cox modelParamTable[5]
#define gamma modelParamTable[6]
#define Vth0 modelParamTable[7]
#define kvalue modelParamTable[8]
#define lambda modelParamTable[9]
#define xj modelParamTable[10]
#define Esat modelParamTable[11]

MosModel::MosModel(const string& str, MosType type): 
	ModelBase(str, arraySize),
	mType(type)
{
	Lmin = 1.8e-7;
	Lmax = 20e-6;
	Wmin = 2.2e-7;
	Wmax = 900e-6;
	Phi = 0.9;
	Cox = 8.58e-3;
	gamma = 0.3;
	Vth0 = 0.4;
	kvalue = 390e-6;
	lambda = 0.5;
	xj = 30e-9;
	Esat = 5e6;
}

void MosModel::addParam(const string& param, double val) {
	if(std::regex_match(param, std::regex("Imin", std::regex::icase))) Lmin = val;
	else if(std::regex_match(param, std::regex("Imax", std::regex::icase))) Lmax = val;
	else if(std::regex_match(param, std::regex("wmin", std::regex::icase))) Wmin = val;
	else if(std::regex_match(param, std::regex("wmax", std::regex::icase))) Wmax = val;
	else if(std::regex_match(param, std::regex("phi", std::regex::icase))) Phi = val;
	else if(std::regex_match(param, std::regex("cox", std::regex::icase))) Cox = val;
	else if(std::regex_match(param, std::regex("gamma", std::regex::icase))) gamma = val;
	else if(std::regex_match(param, std::regex("vth0", std::regex::icase))) Vth0 = val;
	else if(std::regex_match(param, std::regex("k", std::regex::icase))) kvalue = val;
	else if(std::regex_match(param, std::regex("lambda", std::regex::icase))) lambda = val;
	else if(std::regex_match(param, std::regex("xj", std::regex::icase))) xj = val;
	else if(std::regex_match(param, std::regex("esat", std::regex::icase))) Esat = val;
	else throw std::runtime_error(string("No parameter ") + param + " for diodes.");
}

void MosModel::printInf() const {
	printGenInf();
	cout << "Min Length: " << Lmin << "m" << endl;
	cout << "Max Length: " << Lmax << "m" << endl;
	cout << "Min Width: " << Wmin << "m" << endl;
	cout << "Max Width: " << Wmax << "m" << endl;
	cout << "Fermi potential(*2): " << Phi << "V" << endl;
	cout << "Gate oxide capacitance: " << Cox << "F/m^2" << endl;
	cout << "Body Effect: " << gamma << "V^0.5" << endl;
	cout << "Long-channel threshold voltage: " << Vth0 << "V" << endl;
	cout << "Transconductance: " << kvalue << "A/V^2" << endl;
	cout << "Junction depth: " << xj << "m" << endl;
	cout << "Longitudinal critical field: " << Esat << "V/m" << endl;
}

#undef Lmin
#undef Lmax
#undef Wmin
#undef Wmax
#undef Phi
#undef Cox
#undef gamma
#undef Vth0
#undef kvalue
#undef lambda
#undef xj
#undef Esat