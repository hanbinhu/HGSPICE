#include <iomanip>
#include <iostream>
using std::cout;
using std::endl;

#include "XSubInst.h"
#include "Ckt.h"
#include "SubCkt.h"
#include "../Devices.h"

XSubInst::XSubInst(const string& str): 
	InstBase(str, "__X%"),
	mSubCktDef()
{}

XSubInst::XSubInst(const XSubInst& rhs): 
	InstBase(rhs),
	subCktName(rhs.subCktName),
	paramValueTab(rhs.paramValueTab),
	paramTab(rhs.paramTab),
	exNodeName(rhs.exNodeName)
{}

void XSubInst::specifyParam(const string& param, double value) {
	paramTab.push_back(param);
	paramValueTab.push_back(value);
}

void XSubInst::specifySubCkt() {
	subCktName = exNodeName.back();
	exNodeName.pop_back();
}

void XSubInst::linkSubCktDef(const string& title, CktPtr& mCkt) {
	const std::unordered_map< string, std::shared_ptr< SubCkt > >::const_iterator reVal = mCkt->subCktHashMap.find(subCktName);
	if (reVal == mCkt->subCktHashMap.end()) throw std::runtime_error(string("Doesn't find ") + subCktName);
	else mSubCktDef = reVal->second;
	if (mSubCktDef.lock()->externalNodeList.size() != nodeTable.size())
		throw std::runtime_error(getInstName() + " has the wrong number of nodes.");
}

void XSubInst::linkSubCktInst(const string& title, CktPtr& mCkt) {
	const vector< InstPtr >& instListDef = mSubCktDef.lock()->instList;
	for(InstPtr elem : instListDef) {
		InstPtr newInst = elem->Clone();
		if(newInst->getInstName()[0] == 'X' || newInst->getInstName()[0] == 'x') {
			std::shared_ptr< XSubInst > xInst = std::dynamic_pointer_cast< XSubInst > (newInst);
			for(string nodeName: xInst->exNodeName) {
				linkSubInstNode(newInst, title, mCkt, nodeName, true);
			}
		} else {
			for(NodePtr mNode: elem->nodeTable) {
				const string nodeName = mNode.lock()->getName();
				linkSubInstNode(newInst, title, mCkt, nodeName, false);
			}
		}
		instList.push_back(newInst);
		instHashMap.insert({newInst->getInstName(), newInst});
	}
}

void XSubInst::linkSubInstNode(InstPtr& mInst, const string& title, CktPtr& mCkt, const string& nodeName, bool X) {
	std::unordered_map< string, std::shared_ptr< Node > >::const_iterator reVal = mSubCktDef.lock()->internalNodeHashMap.find(nodeName);
	if(reVal != mSubCktDef.lock()->internalNodeHashMap.end()) {
		//Internal Node Case
		const string newNodeName = title + nodeName;
		mInst->addNode(mCkt->newNode(newNodeName));
	} else {
		//External Node Case
		reVal = mSubCktDef.lock()->externalNodeHashMap.find(nodeName);
		if (reVal != mSubCktDef.lock()->externalNodeHashMap.end()) {
			// Find External Node Index
			int totSize = mSubCktDef.lock()->externalNodeList.size();
			int i = 0;
			while(i < totSize) {
				if (mSubCktDef.lock()->externalNodeList[i]->getName() == nodeName) break;
				i++;
			}
			//Get Corresponding Node in XSubInst;
			mInst->addNode(nodeTable[i]);
		} else if(X) {
			const string newNodeName = title + nodeName;
			mInst->addNode(mCkt->newNode(newNodeName));
		} else throw std::runtime_error(nodeName + " doesn't exist in SubCkt " + mSubCktDef.lock()->getName());
	}
}

void XSubInst::fillNode(CktPtr mCkt) {
	for (string str:exNodeName) {
		const std::unordered_map< string, std::shared_ptr< Node > >::const_iterator reVal = mCkt->nodeHashMap.find(str);
		if(reVal != mCkt->nodeHashMap.find(str)) addNode(reVal->second);
		else addNode(mCkt->newNode(str));
	}
}

void XSubInst::linkCC(InstPtr& mInst) {
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

void XSubInst::link(const string& mStackTitle, CktPtr mCkt) {
	string::size_type p = mStackTitle.find(subCktName + ";");
	if(p != mStackTitle.npos) throw std::runtime_error(string("Recursively add SubCkt ") + subCktName + " in " + mStackTitle);
	linkSubCktDef(mStackTitle, mCkt);
	linkSubCktInst(mStackTitle + getInstName() + "+" + subCktName + ";", mCkt);
	for(InstPtr elem : instList) {
		mCkt->linkModel(elem);
		if(elem->getInstName()[0] == 'X' || elem->getInstName()[0] == 'x') {
			std::shared_ptr< XSubInst > xInst = std::dynamic_pointer_cast< XSubInst > (elem);
			xInst->link(mStackTitle + getInstName() + "+" + subCktName  + ";", mCkt);
		} else {
			mCkt->linkBranch(mStackTitle + getInstName() + "+" + subCktName  + ";", elem);
			linkCC(elem);
		}
	}
}

void XSubInst::printInf() const {
	cout << "****************************************" << endl;
	cout << "Inst Name: " << getInstName() << endl;
	cout << "Sub Circuit Definition name is " << subCktName << endl;
	cout << getInstName() << " has " << exNodeName.size() << " external nodes. The nodes are listed below:" << endl;
	cout.flags(std::ios::left);
	for(const string& mNode: exNodeName)
			cout << std::setw(8) << mNode;
	cout << endl;
	cout << "Parameters (" << paramTab.size() << ") are defined in SubCkt " << getInstName() << endl;
	cout.flags(std::ios::left);
	cout << std::setw(15) << "Parameters" << std::setw(10) << "Values" << endl;
	for(int i = 0; i < paramTab.size(); ++i)
		cout << std::setw(15) << paramTab[i] << std::setw(20) << paramValueTab[i] << endl;
	if(!instList.empty()) {
		cout << "Internal Inst (" << instList.size() << ") for " << getInstName() << " is below:" << endl;
		for(InstPtr elem: instList) elem->printInf();
		cout << "Internal Inst (" << instList.size() << ") for " << getInstName() << " is Completed" << endl;
	}
}

std::shared_ptr< InstBase > XSubInst::Clone() {
	return std::static_pointer_cast< InstBase >( std::shared_ptr< XSubInst >(new XSubInst( *this ) ) );
}

void XSubInst::stamp(const std::shared_ptr< Matrix< double > >& mMat) {
	for(InstPtr elem: instList) elem->stamp(mMat);
}

void XSubInst::loadOP() {
	for(InstPtr elem: instList) elem->loadOP();
}

void XSubInst::loadDC() {
	for(InstPtr elem: instList) elem->loadDC();
}