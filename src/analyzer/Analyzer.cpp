#include <stdexcept>
#include <iostream>
using std::cout;
using std::endl;

#include "Analyzer.h"

#include "Ckt.h"

#include "EigenMatrix.h"

#include "OPAnalysis.h"
#include "DCAnalysis.h"
#include "ACAnalysis.h"
#include "TranAnalysis.h"

Analyzer::Analyzer(const string& str):
	inputFile(str),
	prefixname(str),
	taskList(),
	processState(INIT),
	nOP(0),
	nDC(0),
	nAC(0),
	nTRAN(0)
{
	const string suffix(".sp");
	unsigned int pos = prefixname.rfind(suffix);
	if(pos == std::string::npos) throw std::runtime_error("Only accept \".sp\" file!");
	if(pos != prefixname.size() - suffix.size()) throw std::runtime_error("Only accept \".sp\" file!");
	prefixname.replace(pos, suffix.length(), "");
}

void Analyzer::linkSrc(std::shared_ptr< Ckt > mCkt) {
	processState = LINKCKT;
	for (AnalysisPtr taskPtr : taskList) {
		std::shared_ptr< DCAnalysis > tmpTask = std::dynamic_pointer_cast< DCAnalysis >(taskPtr);
		if(tmpTask == nullptr) continue;
		const string srcN = tmpTask->SrcName();
		std::shared_ptr< InstBase > tmpInst = mCkt->findInst(srcN);
		if(tmpInst == nullptr) throw std::runtime_error(srcN + " cannot be found in Circuit.");
		tmpTask->linkSrcInst(tmpInst);
	}
}

void Analyzer::initialMat(unsigned int dim) {
	std::shared_ptr< Matrix<double> > tmp( new EigenMatrix<double>(dim) );
	cktMatrix = tmp;
	processState = COMPLETEANA;
}

void Analyzer::runAnalysis(const std::shared_ptr< Ckt >& mCkt) {
	for(AnalysisPtr elem : taskList) {
		elem->analyze(mCkt, cktMatrix);
	}
}

void Analyzer::ParseOPAnalysis() {
	if(processState != INIT)
		throw std::runtime_error("Can't parse more analysis task now.");
	if(!nOP)
		taskList.push_back(AnalysisPtr(new OPAnalysis(nOP++, prefixname + "_op")));
}

void Analyzer::ParseDCAnalysis(const string& src, double vs, double ve, double vi) {
	if(processState != INIT)
		throw std::runtime_error("Can't parse more analysis task now.");
	taskList.push_back(AnalysisPtr(new DCAnalysis(nDC++, prefixname + "_dc", src, vs, ve,vi)));
}

void Analyzer::ParseTranAnalysis(double vi, double ve, double vs) {
	if(processState != INIT)
		throw std::runtime_error("Can't parse more analysis task now.");
	taskList.push_back(AnalysisPtr(new TranAnalysis(nTRAN++, prefixname + "_tr", vi, ve,vs)));
}

void Analyzer::ParseACAnalysis(ACAnalysis::SweepType mType, int n, double fs, double fe){
	if(processState != INIT)
		throw std::runtime_error("Can't parse more analysis task now.");
	taskList.push_back(AnalysisPtr(new ACAnalysis(nAC++, prefixname + "_ac", mType, n, fs, fe)));
}

void Analyzer::PrintAllAnalysis() const{
	cout << "Print all the analysis tasks (" << taskList.size() << ") below: " << endl;
	for(AnalysisPtr mTask : taskList) mTask->PrintInf();
}