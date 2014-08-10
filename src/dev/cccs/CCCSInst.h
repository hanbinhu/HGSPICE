#ifndef  CCCSINST_H
#define  CCCSINST_H

#include "../DevBase.h"

class CCCSInst : public InstBase {
private:
	BranchPtr brCCPtr;
	
	string CCName;
	double f;
	
public:
	CCCSInst(const string& str, const string& modelStr);
	virtual ~CCCSInst() {}
	
	inline void specifyF(double cccs) {f = cccs;}
	inline void specifyCCName(const string& str)  {CCName = str;}
	
	virtual void printInf() const;
};

#endif  /*CCCSINST_H*/
