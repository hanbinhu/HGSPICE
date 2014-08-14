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
	myModel(),
	nodeTable()
{}

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
	cout << "Model Name: " << getModelName() << endl;
	printNode();
}

ModelBase::ModelBase() {
}
