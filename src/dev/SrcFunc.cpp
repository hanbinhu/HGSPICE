#include <iostream>
#include <stdexcept>
using std::cout;
using std::endl;

#include <cmath>

#include "SrcFunc.h"

string SrcFunc::SelUnit(SignalType type) {
	if(type == V) return "V";
	else if(type == I) return "A";
	else throw std::runtime_error("Wrong SignalType for SrcFunc::SelUnit");
}

double SrcFunc::SineFunc(const vector<double>& paramTable, double t) {
	if(paramTable.size() != 5) 
		throw std::runtime_error("Wrong number of parameter for SrcFunc::SineFunc");

	const double V0 = paramTable[0];
	const double VA = paramTable[1];
	const double FREQ = paramTable[2];
	const double TD = paramTable[3];
	const double THETA = paramTable[4];
	
	if (t < TD) return V0;
	return (V0 + VA * exp(-(t - TD) * THETA) * sin(2 * M_PI * FREQ * (t - TD)));
}

void SrcFunc::SinePrint(const vector<double>& paramTable, SignalType type) {
	if(paramTable.size() != 5) 
		throw std::runtime_error("Wrong number of parameter for SrcFunc::SinePrint");
	const string signalUnit(SelUnit(type));
	
	const double V0 = paramTable[0];
	const double VA = paramTable[1];
	const double FREQ = paramTable[2];
	const double TD = paramTable[3];
	const double THETA = paramTable[4];
	cout << "Function: Sinusoidal Wave" << endl;
	cout << "\tInitial Voltage: " << V0 << signalUnit << endl;
	cout << "\tAmplitude: " << VA << signalUnit << endl;
	cout << "\tFrequency: " << FREQ << "Hz" << endl;
	cout << "\tTime Delay: " << TD << "s" << endl;
	cout << "\tAttenuation Coefficient: " << THETA << endl;
}

double SrcFunc::ExpFunc(const vector<double>& paramTable, double t) {
	if(paramTable.size() != 6) 
		throw std::runtime_error("Wrong number of parameters for SrcFunc::ExpFunc");
	
	const double V1 = paramTable[0];
	const double V2 = paramTable[1];
	const double TD1 = paramTable[2];
	const double TAU1 = paramTable[3];
	const double TD2 = paramTable[4];
	const double TAU2 = paramTable[5];
	
	if(t < TD1) return V1;
	if(t < TD2) return V1 + (V2 - V1) * (1 - exp(-(t - TD1) / TAU1));
	return V1 + (V2 - V1) * (1 - exp(-(TD2 - TD1) / TAU1)) + (V1 - V2) *  (1 - exp(-(t - TD2) / TAU2));
}

void SrcFunc::ExpPrint(const vector<double>& paramTable, SignalType type) {
	if(paramTable.size() != 6) 
		throw std::runtime_error("Wrong number of parameters for SrcFunc::ExpPrint");
	const string signalUnit(SelUnit(type));
	
	const double V1 = paramTable[0];
	const double V2 = paramTable[1];
	const double TD1 = paramTable[2];
	const double TAU1 = paramTable[3];
	const double TD2 = paramTable[4];
	const double TAU2 = paramTable[5];
	cout << "Function: Exponential Wave" << endl;
	cout << "\tInitial Voltage: " << V1 << signalUnit << endl;
	cout << "\tPulsed Voltage: " << V2 << signalUnit << endl;
	cout << "\tRise Time Delay: " << TD1 << "s" << endl;
	cout << "\tFall Time Delay: " << TD2 << "s" << endl;
	cout << "\tRise Time Constant: " << TAU1 << "s" << endl;
	cout << "\tFall Time Constant: " << TAU2 << "s" << endl;
}

double SrcFunc::PulseFunc(const vector<double>& paramTable, double t) {
	if(paramTable.size() != 7) 
		throw std::runtime_error("Wrong number of parameters for SrcFunc::PulseFunc");
	
	const double V1 = paramTable[0];
	const double V2 = paramTable[1];
	const double TD = paramTable[2];
	const double TR = paramTable[3];
	const double TF = paramTable[4];
	const double PW = paramTable[5];
	const double PER = paramTable[6];
	
	if(t < TD) return V1;
	double reVal = V1;
	double tRel = t - TD;
	while(tRel >= PER) tRel -= PER;
	if(tRel < TR) reVal += (V2 - V1) / TR * tRel;
	if(TR <= tRel && tRel <= TR + PW) reVal = V2;
	if(TR + PW < tRel && tRel < TR + PW + TF) reVal += (V2 - V1) / TF * (TR + PW + TF - tRel);
	return reVal;
}

void SrcFunc::PulsePrint(const vector<double>& paramTable, SignalType type) {
	if(paramTable.size() != 7) 
		throw std::runtime_error("Wrong number of parameters for SrcFunc::PulsePrint");
	const string signalUnit(SelUnit(type));
	
	const double V1 = paramTable[0];
	const double V2 = paramTable[1];
	const double TD = paramTable[2];
	const double TR = paramTable[3];
	const double TF = paramTable[4];
	const double PW = paramTable[5];
	const double PER = paramTable[6];
	cout << "Function: Pulse Wave" << endl;
	cout << "\tInitial Value: " << V1 << signalUnit << endl;
	cout << "\tPulsed Value: " << V2 << signalUnit << endl;
	cout << "\tTime Delay: " << TD << "s" << endl;
	cout << "\tRise Time: " << TR << "s" << endl;
	cout << "\tFall Time: " << TF << "s" << endl;
	cout << "\tPulse Width: " << PW << "s" << endl;
	cout << "\tPeriod: " << PER << "s" << endl;
}

double SrcFunc::SFFMFunc(const vector<double>& paramTable, double t) {
	if(paramTable.size() != 5) 
		throw std::runtime_error("Wrong number of parameter for SrcFunc::SFFMFunc");
	
	const double V0 = paramTable[0];
	const double VA = paramTable[1];
	const double FC = paramTable[2];
	const double MDI = paramTable[3];
	const double FS = paramTable[4];
	
	return (V0 + VA * sin(2 * M_PI * FC * t + MDI * sin(2 * M_PI * FS * t)));
}

void SrcFunc::SFFMPrint(const vector<double>& paramTable, SignalType type) {
	if(paramTable.size() != 5) 
		throw std::runtime_error("Wrong number of parameter for SrcFunc::SFFMPrint");
	const string signalUnit(SelUnit(type));
	
	const double V0 = paramTable[0];
	const double VA = paramTable[1];
	const double FC = paramTable[2];
	const double MDI = paramTable[3];
	const double FS = paramTable[4];
	cout << "Function: Frequency-Modulated Sinusoidal Function" << endl;
	cout << "\tInitial Value: " << V0 << signalUnit << endl;
	cout << "\tAmplitude: " << VA << signalUnit << endl;
	cout << "\tCarrier Frequency: " << FC << "Hz" << endl;
	cout << "\tSignal Frequency:" << FS << "Hz" << endl;
	cout << "\tModulation index: " << MDI << endl;
}