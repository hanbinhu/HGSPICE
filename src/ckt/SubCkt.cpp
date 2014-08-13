#include <iostream>
#include <iomanip>
#include <stdexcept>

using std::cout;
using std::endl;

#include "SubCkt.h"

SubCkt::SubCkt(const string& str):
	name(str),
	mState(INIT)
{}

void SubCkt::addInst(const std::shared_ptr< InstBase >& mInstPtr) {
	if (mState != INNER) throw std::runtime_error(getName() + " should not parse element " + mInstPtr->getInstName() + " now");
	const std::unordered_map< string, InstPtr >::const_iterator reVal = instHashMap.find(mInstPtr->getInstName());
	if(reVal == instHashMap.end()) {
		instList.push_back(mInstPtr);
		instHashMap.insert({mInstPtr->getInstName(), mInstPtr});
	} else {
		throw std::runtime_error(string("Find Duplicate Instance Name ") + mInstPtr->getInstName() + " in " + getName());
	}
}

const std::shared_ptr< Node > SubCkt::newNode(const string& strNode) {
	if (mState == INIT) {
		const std::unordered_map< string, NodePtr >::const_iterator reVal = externalNodeHashMap.find(strNode);
		if(reVal == externalNodeHashMap.end()) {
			const NodePtr mNodePtr(new Node(strNode));
			externalNodeList.push_back( mNodePtr);
			externalNodeHashMap.insert({strNode, mNodePtr});
			return mNodePtr;
		} else throw std::runtime_error(string("Two same nodes ") + strNode + " in subckt " + getName() + " definition.");
	} else if (mState == INNER) {
		std::unordered_map< string, NodePtr >::const_iterator reVal = externalNodeHashMap.find(strNode);
		if(reVal == externalNodeHashMap.end()) {
			reVal = internalNodeHashMap.find(strNode);
			if(reVal == internalNodeHashMap.end()) {
				const NodePtr mNodePtr(new Node(strNode));
				internalNodeList.push_back(mNodePtr);
				internalNodeHashMap.insert({strNode, mNodePtr});
				return mNodePtr;
			}
		}
		return reVal->second;
	} else throw std::runtime_error(getName() + " add node " + strNode + " too late!");
}

std::shared_ptr< InstBase > SubCkt::getLastInst() {
	if(mState != INNER) throw std::runtime_error(string("Attempt to getLastInst when not in subckt ") + getName());
	return instList.back();
}

void SubCkt::SetNewParam(const string& param, double value) {
	if (mState != INIT) throw std::runtime_error(getName() + " add parameter " + param + " too late!");
	if (paramHashSet.find(param) == paramHashSet.end()) {
		paramTable.push_back(param);
		paramHashSet.insert(param);
		defaultVaule.push_back(value);
	} else throw std::runtime_error(getName() + " has two same parameter " + param);
}

void SubCkt::SetCompState() {
	if (mState == INNER) mState = COMPLETE;
	else if (mState == INIT) throw std::runtime_error(getName()+ " early complete!");
	else throw std::runtime_error(getName() + " already completed!");
}

void SubCkt::SetInnerState() {
	if (mState == INIT) mState = INNER;
	else throw std::runtime_error(getName() + " already initialized.");
}

void SubCkt::PrintInf() const {
	cout << "****************************************" << endl;
	cout << "SubCkt " << getName() << " Information" << endl;
	
	if(!internalNodeList.empty()) {
		cout << "****************************************" << endl;
		cout << "Internal Nodes (" << internalNodeList.size() << ") in SubCkt " << getName() << endl;
		cout.flags(std::ios::left);
		int wordCnt = 1;
		for(NodePtr elem : internalNodeList) {
			cout << std::setw(8) << elem->getName();
			wordCnt %= 10; 
			if(!wordCnt)  cout << endl;
			wordCnt++;
		}
		if(wordCnt != 1) cout << endl;
	}

	if(!externalNodeList.empty()) {
		cout << "****************************************" << endl;
		cout << "External Nodes (" << externalNodeList.size() << ") in SubCkt " << getName() << endl;
		cout.flags(std::ios::left);
		int wordCnt = 1;
		for(NodePtr elem : externalNodeList) {
			cout << std::setw(8) << elem->getName();
			wordCnt %= 10; 
			if(!wordCnt)  cout << endl;
			wordCnt++;
		}
		if(wordCnt != 1) cout << endl;
	}
	
	if(!instList.empty()) {
		cout << "****************************************" << endl;
		cout << "Instances (" << instList.size() << ") in SubCkt " << getName() << endl;
		for(InstPtr elem : instList) elem->printInf();
	}
	
	if(!paramTable.empty()) {
		cout << "****************************************" << endl;
		cout << "Parameters (" << paramTable.size() << ") are defined in SubCkt " << getName() << endl;
		cout.flags(std::ios::left);
		cout << std::setw(15) << "Parameters" << std::setw(20) << "Default Values" << endl;
		for(int i = 0; i < paramTable.size(); ++i)
			cout << std::setw(15) << paramTable[i] << std::setw(20) << defaultVaule[i] << endl;
	}
	cout << endl;
}