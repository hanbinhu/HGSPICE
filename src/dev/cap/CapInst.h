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
	CapInst(const CapInst& rhs);
	virtual ~CapInst() {}
	
	inline void specifyCap(double cap) {capcitance = cap;}
	inline virtual void specifyIC(double IC) {voltageIC = IC;}
	inline virtual void setBranch(const BranchPtr& mBranch) {brPtr = mBranch;}
	
	virtual std::shared_ptr< InstBase > Clone();
	
	virtual void printInf() const;
};

#endif  /*CAPINST_H*/