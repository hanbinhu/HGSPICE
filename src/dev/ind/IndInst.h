#ifndef  INDINST_H
#define  INDINST_H

#include "../DevBase.h"

class IndInst : public InstBase {
private:
	BranchPtr brPtr;
	
	double inductance;
	double currentIC;
	
public:
	IndInst(const string& str, const string& modelStr);
	virtual ~IndInst() {}
	
	inline void specifyInd(double ind) {inductance = ind;}
	inline virtual void specifyIC(double IC) {currentIC = IC;}
	
	virtual void printInf() const;
};

#endif  /*INDINST_H*/
