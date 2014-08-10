#ifndef  VCVSINST_H
#define  VCVSINST_H

#include "../DevBase.h"

class VCVSInst : public InstBase {
private:
	BranchPtr brVSPtr;
	
	double e;
	
public:
	VCVSInst(const string& str, const string& modelStr);
	virtual ~VCVSInst() {}
	
	inline void specifyE(double vcvs) {e = vcvs;}
	
	virtual void printInf() const;
};

#endif  /*VCVSINST_H*/
