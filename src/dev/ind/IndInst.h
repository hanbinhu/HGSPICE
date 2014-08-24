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
	IndInst(const IndInst& rhs);
	virtual ~IndInst() {}
	
	inline void specifyInd(double ind) {inductance = ind;}
	inline virtual void specifyIC(double IC) {currentIC = IC;}
	inline virtual void setBranch(const BranchPtr& mBranch) {brPtr = mBranch;}
	
	virtual std::shared_ptr< InstBase > Clone();
	
	virtual void stamp(const std::shared_ptr< Matrix<double> >& mMat);
	
	virtual void printInf() const;
	
private:
	double* pMatpb;
	double* pMatnb;
	double* pMatbp;
	double* pMatbn;
	double* pMatbb;
	double* pRhsb;
};

#endif  /*INDINST_H*/
