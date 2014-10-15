#include <iostream>
#include <iomanip>
using std::cout;
using std::endl;

#include <algorithm>

#include "DevBase.h"
#include "Generic.h"

InstBase::InstBase(const string& str, const string& modelStr):
	name(str), 
	modelName(modelStr),
	nodeTable()
{}

InstBase::InstBase(const InstBase& rhs): 
	name(rhs.name),
	modelName(rhs.modelName),
	nodeTable()
{}

void InstBase::printSeperator(ofstream& outF) const {
	outF << ",";
}

void InstBase::printFileTitleGen(const string& Name, ofstream& outF, const string& title, unsigned int unitType) const {
	printSeperator(outF);
	string unit = "";
	switch(unitType) {
		case 0: unit = "(A)"; break;
		case 1: unit = "(V)"; break;
		case 2: unit = "(S)"; break;
		case 3: unit = "(O)"; break;
		case 4: unit = "(F)"; break;
	}
	outF << title + Name + unit;
}

void InstBase::printNode() const {
	cout << getInstName() << " has " << nodeTable.size() << " nodes. The nodes are listed below:" << endl;
	cout.flags(std::ios::left);
	for(NodePtr mNode: nodeTable)
			cout << std::setw(8) << mNode.lock()->getName();
	cout << endl;
}

void InstBase::printGenInf() const {
	cout << "****************************************" << endl;
	cout << "Inst Name: " << getInstName() << endl;
	cout << "Model Name: " << modelName << endl;
	printNode();
}

ModelBase::ModelBase(const string& str, size_t size):
	name(str),
	modelParamTable(size)
{}

void ModelBase::printGenInf() const {
	cout << "****************************************" << endl;
	cout << "Model Name: " << getName() << endl;
	cout << "Parameter number: " << modelParamTable.size() << endl;
}