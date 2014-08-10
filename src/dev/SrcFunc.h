#ifndef  SRCFUNC_H
#define  SRCFUNC_H

#include <string>
#include <vector>
using std::string;
using std::vector;

class SrcFunc {
public:
	enum TranFuncType {Sine, Exp, Pulse, SFFM};
	enum SignalType {V, I};
	
	static double SineFunc(const vector<double>& paramTable, double t);
	static void SinePrint(const vector<double>& paramTable, SignalType type);
	
	static double ExpFunc(const vector<double>& paramTable, double t);
	static void ExpPrint(const vector<double>& paramTable, SignalType type);
	
	static double PulseFunc(const vector<double>& paramTable, double t);
	static void PulsePrint(const vector<double>& paramTable, SignalType type);
	
	static double SFFMFunc(const vector<double>& paramTable, double t);
	static void SFFMPrint(const vector<double>& paramTable, SignalType type);
	
private:
	static string SelUnit(SignalType type);
};

#endif  /*SRCFUNC_H*/
