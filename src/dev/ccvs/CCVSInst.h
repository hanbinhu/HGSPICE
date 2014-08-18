#ifndef  CCVSINST_H
#define  CCVSINST_H

#include "../DevBase.h"

#include <memory>

class VSrcInst;

class CCVSInst : public InstBase {
private:
	std::weak_ptr< VSrcInst > mVPtr;
	BranchPtr brVSPtr;
	
	string CCName;
	double h;
	
public:
	CCVSInst(const string& str, const string& modelStr);
	virtual ~CCVSInst() {}
	
	inline void specifyH(double ccvs) {h = ccvs;}
	inline void specifyCCName(const string& str)  {CCName = str;}
	inline string getVName() {return CCName;}
	inline virtual void setBranch(const BranchPtr& mBranch) {brVSPtr = mBranch;}
	inline void setVPtr(const std::weak_ptr< VSrcInst >& VPtr) {mVPtr = VPtr;}
	
	virtual void printInf() const;
};

#endif  /*CCVSINST_H*/
