#include <stdexcept>
#include <iostream>
using std::cout;
using std::endl;

#include "Analyzer.h"

#include "OPAnalysis.h"
#include "DCAnalysis.h"
#include "ACAnalysis.h"
#include "TranAnalysis.h"

Analyzer::Analyzer(const string& str):
	inputFile(str),
	taskList(),
	processState(INIT)
{}

void Analyzer::ParseOPAnalysis() {
	if(processState != INIT)
		throw std::runtime_error("Can't parse more analysis task now.");
	taskList.push_back(AnalysisPtr(new OPAnalysis()));
}

void Analyzer::ParseDCAnalysis(const string& src, double vs, double ve, double vi) {
	if(processState != INIT)
		throw std::runtime_error("Can't parse more analysis task now.");
	taskList.push_back(AnalysisPtr(new DCAnalysis(src, vs, ve,vi)));
}

void Analyzer::ParseTranAnalysis(double vi, double ve, double vs) {
	if(processState != INIT)
		throw std::runtime_error("Can't parse more analysis task now.");
	taskList.push_back(AnalysisPtr(new TranAnalysis(vi, ve,vs)));
}

void Analyzer::ParseACAnalysis(ACAnalysis::SweepType mType, int n, double fe, double fs){
	if(processState != INIT)
		throw std::runtime_error("Can't parse more analysis task now.");
	taskList.push_back(AnalysisPtr(new ACAnalysis(mType, n, fs, fe)));
}

void Analyzer::PrintAllAnalysis() const{
	cout << "Print all the analysis tasks (" << taskList.size() << ") below: " << endl;
	for(AnalysisPtr mTask : taskList) mTask->PrintInf();
}
