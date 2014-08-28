#include <iostream>
#include <iomanip>
#include <exception>
using std::cout;
using std::cerr;
using std::endl;

#include <algorithm>

#include "Analyzer.h"
#include "Ckt.h"
#include "SubCkt.h"

#include "Matrix.h"

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

void Ckt::Initialize(std::shared_ptr< Analyzer > mAnalyzer) {
	if(processState != INIT) throw std::runtime_error("Already Initialized");
	string filename = mAnalyzer->getInputFile();
	if (!(yyin = fopen(filename.c_str(), "r"))) {
		throw std::ios_base::failure(filename + " doesn't exist.");
	}
	processState = PARSING;
	yy::SpParser spiceParser(shared_from_this(), mAnalyzer);
	spiceParser.parse();
	processState = LINKCKT;
	linkAll();
	numberNodeBranch();
	mAnalyzer->linkSrc(shared_from_this());
	mAnalyzer->initialMat(nodeList.size() + branchList.size());
	stampInst(mAnalyzer->getMatPtr());
	processState = COMPLETECKT;
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

void Ckt::linkAll() {
	for(InstPtr elem : instList) {
		linkModel(elem);
		if(elem->getInstName()[0] == 'X' || elem->getInstName()[0] == 'x') {
			std::shared_ptr< XSubInst > xInst = std::dynamic_pointer_cast< XSubInst > (elem);
			xInst->fillNode( shared_from_this() );
			xInst->link("", shared_from_this());
		} else {
			linkBranch("", elem);
			linkCC(elem);
		}
	}
}

void Ckt::linkModel(InstPtr& mInst) {
	const std::unordered_map< string, ModelPtr >::const_iterator reVal = modelHashMap.find(mInst->getModelName());
	if (reVal == modelHashMap.end()) throw std::runtime_error(string("Doesn't find ") + mInst->getModelName());
	else mInst->setModel(reVal->second);
}

void Ckt::linkCC(InstPtr& mInst) {
	char instType = mInst->getInstName()[0];
	if(instType >= 'a') instType -= ('a' - 'A');
	switch(instType) {
		case 'F': {
			std::shared_ptr< CCCSInst > mCCCS = std::dynamic_pointer_cast< CCCSInst > (mInst);
			const string VName = mCCCS->getVName();
			if(VName[0] == 'V' || VName[0] == 'v') {
				const std::unordered_map< string, InstPtr >::const_iterator reVal = instHashMap.find(VName);
				if(reVal != instHashMap.end()) {
					std::shared_ptr< VSrcInst > tmp = std::dynamic_pointer_cast< VSrcInst > (reVal->second);
					if(tmp == nullptr) throw std::runtime_error("Dynamic cast wrong for VSrcInst");
					mCCCS->setVPtr(tmp);
				}else throw std::runtime_error(VName + " doesn't exist in Instance list");
			} else throw std::runtime_error(VName + " is not a voltage source for " + mCCCS->getInstName());
		} break;
		case 'H': {
			std::shared_ptr< CCVSInst > mCCVS = std::dynamic_pointer_cast< CCVSInst > (mInst);
			const string VName = mCCVS->getVName();
			if(VName[0] == 'V' || VName[0] == 'v') {
				const std::unordered_map< string, InstPtr >::const_iterator reVal = instHashMap.find(VName);
				if(reVal != instHashMap.end()) {
					std::shared_ptr< VSrcInst > tmp = std::dynamic_pointer_cast< VSrcInst > (reVal->second);
					if(tmp == nullptr) throw std::runtime_error("Dynamic cast wrong for VSrcInst");
					mCCVS->setVPtr(tmp);
				} else throw std::runtime_error(VName + " doesn't exist in Instance list");
			} else throw std::runtime_error(VName + " is not a voltage source for " + mCCVS->getInstName());
		} break;
	}
}

void Ckt::linkBranch(const string& title, InstPtr& mInst) {
	char instType = mInst->getInstName()[0];
	if(instType >= 'a') instType -= ('a' - 'A');
	switch(instType) {
		case 'V':
		case 'E':
		case 'H':
		case 'C':
		case 'L': {
			const string brName(title + mInst->getInstName() + ":br");
			mInst->setBranch(newBranch(brName));
		} break;
		case 'M': {
		} break;
		default: {
		} break;
	}
}

const std::shared_ptr< Branch > Ckt::newBranch(const string& strBranch) {
	const std::unordered_map< string, BranchPtr >::const_iterator reVal = branchHashMap.find(strBranch);
	if(reVal == branchHashMap.end()) {
		const BranchPtr mBranchPtr(new Branch(strBranch));
		branchList.push_back(mBranchPtr);
		branchHashMap.insert({strBranch, mBranchPtr});
		return mBranchPtr;
	} else throw std::runtime_error(string("Already has one branch named as ") + strBranch);
}

void Ckt::numberNodeBranch() {
	unsigned int i = 0;
	if(nodeList[0]->getName() != "0") throw std::runtime_error("No gnd in this Circuit.");
	for(NodePtr elem : nodeList) elem->setId(i++);
	for(BranchPtr elem : branchList) elem->setId(i++);
}

void Ckt::stampInst(const std::shared_ptr< Matrix< double > >& mMat) {
	for(InstPtr elem : instList) elem->stamp(mMat);
}

void Ckt::LoadOP() const {
	for(InstPtr elem : instList) elem->loadOP();
}

void Ckt::LoadDC() const {
	for(InstPtr elem : instList) elem->loadDC();
}

void Ckt::LoadTRAN(double time, double timeStep, bool flagInitial) const {
	for(InstPtr elem : instList) elem->loadTRAN(time, timeStep, flagInitial);
}

void Ckt::SetDForNAB(const vector< double >& vTable) {
	unsigned int i = 0;
	for(NodePtr elem : nodeList) elem->setDC(vTable[i++]);
	for(BranchPtr elem : branchList) elem->setDC(vTable[i++]);
}

void Ckt::SetTForNAB(const vector< double >& vTable) {
	unsigned int i = 0;
	for(NodePtr elem : nodeList) elem->setTRAN(vTable[i++]);
	for(BranchPtr elem : branchList) elem->setTRAN(vTable[i++]);
}

std::shared_ptr< InstBase > Ckt::findInst(const string& instName) {
	const std::unordered_map< string, InstPtr >::const_iterator reVal = instHashMap.find(instName);
	if(reVal == instHashMap.end()) return nullptr;
	else return reVal->second;
}

void Ckt::printFile(double sweep, bool initial, std::ofstream& outF) const {
	if(initial) {
		for(NodePtr elem: nodeList) outF << "," << elem->getName() << "(V)";
		for(InstPtr elem: instList) elem->printFileTitle(outF, "");
	}
	outF << endl << sweep;
	for(NodePtr elem: nodeList) outF << "," << *(elem->getTPtr());
	for(InstPtr elem: instList) elem->printFileValue(outF);
	outF << endl;
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

void Ckt::printAllBranches() const {
	cout << "****************************************" << endl;
	cout << "Branch Information in Branch List (" << branchList.size() << ")" << endl;
	cout.flags(std::ios::left);
	int wordCnt = 1;
	for(BranchPtr elem : branchList) {
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
