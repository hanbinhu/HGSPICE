#include "Ckt.h"

Ckt::Ckt()
{
	nRes = 0;
	nCap = 0;
	nInd = 0;
	nVCVS = 0;
	nCCCS = 0;
	nVCCS = 0;
	nCCVS = 0;
	nDiode = 0;
	nMOS = 0;

	nAnaOP = 0;
	nAnaDC = 0;
	nAnaAC = 0;
	nAnaTRAN = 0;

	nVsrc = 0;
	nIsrc = 0;
}

Ckt::~Ckt()
{
}

void Ckt::ParseRes(char *str, char *nodep, char *noden, double value)
{
    cout << "[Resistor Parsed...]" << endl;
    cout << "   name=" << str << ", node+=" << nodep << ", node-=" << noden << ", R=" << value << endl;
	nRes++;
}

void Ckt::ParseCap(char *str, char *nodep, char *noden, double value, double init)
{
    cout << "[Capacitor Parsed...]" << endl;
    cout << "   name=" << str << ", node+=" << nodep << ", node-=" << noden << ", C=" << value << ", init=" << init << endl;
	nCap++;
}

void Ckt::ParseInd(char *str, char *nodep, char *noden, double value, double init)
{
    cout << "[Inductor Parsed...]" << endl;
    cout << "   name=" << str << ", node+=" << nodep << ", node-=" << noden << ", L=" << value << ", init=" << init << endl;
	nInd++;
}

void Ckt::ParseVCVS(char *str, char *nodeop, char *nodeon, char *nodeip, char *nodein, double value)
{
    cout << "[VCVS Parsed...]" << endl;
    cout << "   name=" << str << ", nodeo+=" << nodeop << ", nodeo-=" << nodeon << ", nodei+=" << nodeip << ",nodei-=" << nodein << ", E=" << value << endl;
	nVCVS++;
}

void Ckt::ParseCCCS(char *str, char *nodeop, char *nodeon, char *vsens, double value)
{
    cout << "[CCCS Parsed...]" << endl;
    cout << "   name=" << str << ", nodeo+=" << nodeop << ", nodeo-=" << nodeon << ", vname=" << vsens << ", F=" << value << endl;
	nCCCS++;
}

void Ckt::ParseVCCS(char *str, char *nodeop, char *nodeon, char *nodeip, char *nodein, double value)
{
    cout << "[VCCS Parsed...]" << endl;
    cout << "   name=" << str << ", nodeo+=" << nodeop << ", nodeo-=" << nodeon << ", nodei+=" << nodeip << ",nodei-=" << nodein << ", G=" << value << endl;
	nVCCS++;
}

void Ckt::ParseCCVS(char *str, char *nodeop, char *nodeon, char *vsens, double value)
{
    cout << "[CCVS Parsed...]" << endl;
    cout << "   name=" << str << ", nodeo+=" << nodeop << ", nodeo-=" << nodeon << ", vname=" << vsens << ", H=" << value << endl;
	nCCVS++;
}

void Ckt::ParseDiode(char *str, char *nodep, char *noden, char *model)
{
    cout << "[Diode Parsed...]" << endl;
    cout << "   name=" << str << ", node+=" << nodep << ", node-=" << noden << ", model=" << model << endl;
	nDiode++;
}

void Ckt::ParseMOS(char *str, char *noded, char *nodeg, char *nodes, char *nodeb, char *model, double l, double w)
{
    cout << "[MOSFET Parsed...]" << endl;
    cout << "   name=" << str << ", nodeDrain=" << noded << ", nodeGate=" << nodeg << ", nodeSource=" << nodes << ",nodeBulk=" << nodeb << ", model=" << model << ", L=" << l << ", W=" << w << endl;
	nMOS++;
}

void Ckt::ParseAnaOP()
{
    cout << "[AnalysisOP Parsed...]" << endl;
	nAnaOP++;
}

void Ckt::ParseAnaDC(char *source, double start, double end, double step)
{
    cout << "[AnalysisDC Parsed...]" << endl;
    cout << "   source=" << source << ", start=" << start << ", end=" << end << ", step=" << step << endl;
	nAnaDC++;
}

void Ckt::ParseAnaAC(char *sweepType, double n, double fstart, double fend)
{
    cout << "[AnalysisAC Parsed...]" << endl;
    cout << "   sweepType=" << sweepType << ", nper=" << n << ", fstart=" << fstart << ", fend=" << fend << endl;
	nAnaDC++;
}

void Ckt::ParseAnaTRAN(double tstep, double tend, double tstart)
{
    cout << "[AnalysisTRAN Parsed...]" << endl;
    cout << "   tstart=" << tstart << ", tend=" << tend << ", tstep=" << tstep << endl;
	nAnaDC++;
}

void Ckt::ParseVsrc(char *str, char *nodep, char *noden, double value)
{
    cout << "[Voltage Source Parsed...]" << endl;
    cout << "   name=" << str << ", node+=" << nodep << ", node-=" << noden << ", V=" << value << endl;
	nVsrc++;
}

void Ckt::ParseIsrc(char *str, char *nodep, char *noden, double value)
{
    cout << "[Current Source Parsed...]" << endl;
    cout << "   name=" << str << ", node+=" << nodep << ", node-=" << noden << ", I=" << value << endl;
	nIsrc++;
}

void Ckt::Summarize()
{
    cout << "[Parsing Finished!]" << endl;
    cout << "   res=" << nRes
         << ", cap=" << nCap
         << ", ind=" << nInd
         << ", vsrc=" << nVsrc
         << ", isrc=" << nIsrc << endl;
}
