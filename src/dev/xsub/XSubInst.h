#ifndef  XSUBINST_H
#define  XSUBINST_H

#include <string>
#include <vector>
using std::vector;
using std::string;

#include <unordered_set>

#include "../DevBase.h"

class Ckt;
class SubCkt;

class XSubInst : public InstBase {
private:
	vector<double> paramValueTab;
	vector<string> paramTab;
	
	vector<string> exNodeName;
	
	string subCktName;
	std::weak_ptr< SubCkt > mSubCktDef;
	
	typedef std::shared_ptr< InstBase > InstPtr;
	vector< InstPtr > instList;
	std::unordered_map< string, InstPtr > instHashMap;
	
	typedef std::shared_ptr< Ckt > CktPtr;
	
	void linkSubCktInst(const string& title, CktPtr& mCkt);
	void linkSubCktDef(const string& title, CktPtr& mCkt);
	void linkSubInstNode(InstPtr& mInst, const string& title, CktPtr& mCkt, const string& nodeName, bool X);
	void linkCC(InstPtr& mInst);
	
public:
	XSubInst(const string& str);
	XSubInst(const XSubInst& rhs);
	virtual ~XSubInst() {}
	
	inline string getSubCktName() const {return subCktName;}
	
	inline virtual void specifyNode(const string& node) {exNodeName.push_back(node);}
	
	virtual void specifySubCkt();
	virtual void specifyParam(const string& param, double value);
	
	void link(const string& mStackTitle, CktPtr mCkt);
	void fillNode(CktPtr mCkt);
	
	virtual std::shared_ptr< InstBase > Clone();
	
	virtual void printInf() const;
};

#endif  /*XSUBINST_H*/
