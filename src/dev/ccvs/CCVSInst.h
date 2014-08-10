#ifndef  CCVSINST_H
#define  CCVSINST_H

#include "../DevBase.h"

class CCVSInst : public InstBase {
private:
	BranchPtr brCCPtr;
	BranchPtr brVSPtr;
	
	string CCName;
	double h;
	
public:
	CCVSInst(const string& str, const string& modelStr);
	virtual ~CCVSInst() {}
	
	inline void specifyH(double ccvs) {h = ccvs;}
	inline void specifyCCName(const string& str)  {CCName = str;}
	
	virtual void printInf() const;
};

#endif  /*CCVSINST_H*/
