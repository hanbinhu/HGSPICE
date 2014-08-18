#ifndef  XSUBINST_H
#define  XSUBINST_H

#include <string>
#include <vector>
using std::vector;
using std::string;

#include "../DevBase.h"

class SubCkt;

class XSubInst : public InstBase {
private:
	vector<double> paramValueTab;
	vector<string> paramTab;
	
	vector<string> exNodeName;
	
	string subCktName;
	std::weak_ptr< SubCkt > mSubCktDef;
	
public:
	XSubInst(const string& str);
	virtual ~XSubInst() {}
	
	inline string getSubCktName() const {return subCktName;}
	
	inline virtual void specifyNode(const string& node) {exNodeName.push_back(node);}
	virtual void specifySubCkt();
	virtual void specifyParam(const string& param, double value);
	
	virtual void printInf() const;
};

#endif  /*XSUBINST_H*/
