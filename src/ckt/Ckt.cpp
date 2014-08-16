#include <iostream>
#include <iomanip>
#include <exception>
using std::cout;
using std::cerr;
using std::endl;

#include <algorithm>

#include "Ckt.h"
#include "SubCkt.h"

#include "SpParser.hpp"
extern FILE* yyin;

Ckt::Ckt():
	processState(INIT),
	subParseState(OUTSUB)
{
	addModel(ModelPtr(new ResModel("__RES%")));
	addModel(ModelPtr(new CapModel("__CAP%")));
	addModel(ModelPtr(new IndModel("__IND%")));
	addModel(ModelPtr(new VCVSModel("__VCVS%")));
	addModel(ModelPtr(new VCCSModel("__VCCS%")));
	addModel(ModelPtr(new CCVSModel("__CCVS%")));
	addModel(ModelPtr(new CCCSModel("__CCCS%")));
	addModel(ModelPtr(new ISrcModel("__ISRC%")));
	addModel(ModelPtr(new VSrcModel("__VSRC%")));
	addModel(ModelPtr(new XSubModel("__X%")));
}

void Ckt::ParseAll(std::shared_ptr< Analyzer > mAnalyzer) {
	if(processState != INIT) throw std::runtime_error("Already Initialized");
	string filename = mAnalyzer->getInputFile();
	if (!(yyin = fopen(filename.c_str(), "r"))) {
		throw std::ios_base::failure(filename + " doesn't exist.");
	}
	processState = PARSING;
	yy::SpParser spiceParser(shared_from_this(), mAnalyzer);
	spiceParser.parse();
	processState = LINKCKT;
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
	} else throw std::runtime_error(string("Find Duplicate Instance Name ") + mInstPtr->getInstName() + ".");
}

void Ckt::addModel(const std::shared_ptr< ModelBase >& mModelPtr) {
	const std::unordered_map< string, ModelPtr >::const_iterator reVal = modelHashMap.find(mModelPtr->getName());
	if(reVal == modelHashMap.end()) {
		modelList.push_back(mModelPtr);
		modelHashMap.insert({mModelPtr->getName(), mModelPtr});
	} else throw std::runtime_error(string("Find Duplicate Model Name ") + mModelPtr->getName() + ".");
}

void Ckt::addSubCkt(const std::shared_ptr< SubCkt >& mSubCktPtr) {
	const std::unordered_map< string, SubCktPtr >::const_iterator reVal = subCktHashMap.find(mSubCktPtr->getName());
	if(reVal == subCktHashMap.end()) {
		subCktList.push_back(mSubCktPtr);
		subCktHashMap.insert({mSubCktPtr->getName(), mSubCktPtr});
		subParseState = INSUB;
	} else throw std::runtime_error(string("Find Duplicate Instance Name ") + mSubCktPtr->getName() + ".");
}

void Ckt::SetSubEnd() {
	subParseState = OUTSUB; 
	subCktList.back()->SetCompState();
}

std::shared_ptr< InstBase > Ckt::getLastInst() {
	if(processState != PARSING) throw std::runtime_error("Attempt to getLastInst when not parsing.");
	return instList.back();
}

std::shared_ptr< SubCkt > Ckt::getLastSubCkt() {
	if(subParseState != INSUB) throw std::runtime_error("Attempt to getLastInst when not parsing.");
	return subCktList.back();
}

std::shared_ptr< ModelBase > Ckt::getLastModel(){
	if(processState != PARSING) throw std::runtime_error("Attempt to getLastModel when not parsing.");
	return modelList.back();
}

std::shared_ptr< Ckt > Ckt::CurrentCkt() {
	if(subParseState == OUTSUB) return shared_from_this();
	else return subCktList.back();
}

void Ckt::printAllNodes() const {
	cout << "****************************************" << endl;
	cout << "Node Information in Node List (" << nodeList.size() << ")" << endl;
	cout.flags(std::ios::left);
	int wordCnt = 1;
	for(NodePtr elem : nodeList) {
		cout << std::setw(8) << elem->getName();
		wordCnt %= 10; 
		if(!wordCnt)  cout << endl;
		wordCnt++;
	}
	if(wordCnt != 1) cout << endl;
}

void Ckt::printAllInsts() const
{
	cout << "All Instances (" << instList.size() << ") are listed here." << endl;
	for(InstPtr elem : instList) elem->printInf();
}

void Ckt::printAllModels() const{
	cout << "All Models (" << modelList.size() << ") are listed here." << endl;
	for(ModelPtr elem : modelList) elem->printInf();
}

void Ckt::printAllSubDef() const {
	cout << "All SubCkts (" << subCktList.size() << ") are listed here." << endl;
	for(SubCktPtr elem : subCktList) 	elem->PrintInf();
}
