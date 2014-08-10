#include <iostream>
#include <iomanip>
#include <exception>
using std::cout;
using std::cerr;
using std::endl;

#include <algorithm>

#include "Ckt.h"

#include "SpParser.hpp"
extern FILE* yyin;


Ckt::Ckt(const string& filename) :
	processState(INIT)
{
	if (!(yyin = fopen(filename.c_str(), "r"))) {
		throw std::ios_base::failure(filename + " doesn't exist.");
	}
	processState = PARSING;
	yy::SpParser spiceParser(this);
	spiceParser.parse();
	processState = LINKCKT;
}

Ckt::Ckt() {
	nDiode = 0;
	nMOS = 0;

	nAnaOP = 0;
	nAnaDC = 0;
	nAnaAC = 0;
	nAnaTRAN = 0;

	nVsrc = 0;
	nIsrc = 0;
}

Ckt::~Ckt() {
}

const std::shared_ptr< Node > Ckt::newNode(const string& strNode) {
	const std::unordered_map< string, NodePtr >::const_iterator reVal = nodeHashMap.find(strNode);
	if(reVal == nodeHashMap.end()) {
		string str(strNode);
		
		//Check the gnd and 0;
		if(str.size() == 3) {
			string strTmp(str);
			std::transform(strTmp.begin(), strTmp.end(), strTmp.begin(), tolower);
			if(strTmp == "gnd") {
				const std::unordered_map< string, NodePtr >::const_iterator reValgnd = nodeHashMap.find("0");
				if(reValgnd != nodeHashMap.end())
					return reValgnd->second;
				str = "0";
			}
		}
		
		const NodePtr mNodePtr(new Node(str));
		if("0" != str) nodeList.push_back(mNodePtr);
		else nodeList.insert(nodeList.begin(), mNodePtr);
		nodeHashMap.insert({str, mNodePtr});
		return mNodePtr;
	} else return reVal->second;
}

void Ckt::addInst(const std::shared_ptr< InstBase >& mInstPtr) {
	const std::unordered_map< string, InstPtr >::const_iterator reVal = instHashMap.find(mInstPtr->getInstName());
	if(reVal == instHashMap.end()) {
		instList.push_back(mInstPtr);
		instHashMap.insert({mInstPtr->getInstName(), mInstPtr});
	} else {
		throw std::runtime_error(string("Find Duplicate Instance Name ") + mInstPtr->getInstName() + ".");
	}
}

std::shared_ptr< InstBase > Ckt::getLastInst() {
	if(processState != PARSING) throw std::runtime_error("Attempt to getLastInst when not parsing.");
	return instList.back();
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

void Ckt::printAllNodes() const {
	cout << "****************************************" << endl;
	cout << "Node Information in Node List (" << nodeList.size() << ")" << endl;
	cout.flags(std::ios::left);
	int wordCnt = 1;
	std::for_each(nodeList.begin(),nodeList.end(),
		[&wordCnt] (NodePtr elem) {
			cout << std::setw(8) << elem->getName();
			wordCnt %= 10; 
			if(!wordCnt)  cout << endl;
			wordCnt++;
			
		}
	); if(wordCnt != 1) cout << endl;
}

void Ckt::printAllInsts() const
{
	cout << "All Instances (" << instList.size() << ") are listed here." << endl;
	std::for_each(instList.begin(), instList.end(),
		[] (InstPtr elem) {
			elem->printInf();
		}
	);
}

void Ckt::Summarize()
{
    cout << "[Parsing Finished!]" << endl;
    cout << "vsrc=" << nVsrc
         << ", isrc=" << nIsrc << endl;
}
