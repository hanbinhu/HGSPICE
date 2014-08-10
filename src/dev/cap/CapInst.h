#ifndef  CAPINST_H
#define  CAPINST_H

#include "../DevBase.h"

class CapInst : public InstBase {
private:
	BranchPtr brPtr;
	
	double capcitance;
	double voltageIC;
	
public:
	CapInst(const string& str, const string& modelStr);
	virtual ~CapInst() {}
	
	inline void specifyCap(double cap) {capcitance = cap;}
	inline virtual void specifyIC(double IC) {voltageIC = IC;}
	
	virtual void printInf() const;
};

#endif  /*CAPINST_H*/
