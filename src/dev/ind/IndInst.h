#ifndef  INDINST_H
#define  INDINST_H

#include "../DevBase.h"

class IndInst : public InstBase {
private:
	BranchPtr brPtr;
	
	double inductance;
	
	bool initial;
	double currentIC;
	
public:
	IndInst(const string& str, const string& modelStr);
	IndInst(const IndInst& rhs);
	virtual ~IndInst() {}
	
	inline void specifyInd(double ind) {inductance = ind;}
	inline virtual void specifyIC(double IC) {currentIC = IC; initial = true;}
	inline virtual void setBranch(const BranchPtr& mBranch) {brPtr = mBranch;}
	
	virtual std::shared_ptr< InstBase > Clone();
	
	virtual void stamp(const std::shared_ptr< Matrix<double> >& mMat);
	virtual void loadOP();
	virtual void loadDC();
	virtual void loadTRAN(double time, double timeStep, bool flagInitial);
	
	virtual void printInf() const;
	
private:
	double* pMatpb;
	double* pMatnb;
	double* pMatbp;
	double* pMatbn;
	double* pMatbb;
	double* pRhsb;
	
	double* IT;
};

#endif  /*INDINST_H*/
