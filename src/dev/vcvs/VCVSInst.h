#ifndef  VCVSINST_H
#define  VCVSINST_H

#include "../DevBase.h"

class VCVSInst : public InstBase {
private:
	BranchPtr brVSPtr;
	
	double e;
	
public:
	VCVSInst(const string& str, const string& modelStr);
	VCVSInst(const VCVSInst& rhs);
	virtual ~VCVSInst() {}
	
	inline void specifyE(double vcvs) {e = vcvs;}
	inline virtual void setBranch(const BranchPtr& mBranch) {brVSPtr = mBranch;}
	
	virtual std::shared_ptr< InstBase > Clone();
	
	virtual void stamp(const std::shared_ptr< Matrix<double> >& mMat);
	virtual void loadDC();
	
	virtual void printInf() const;
	
private:
	double* pMatpb;
	double* pMatnb;
	double* pMatbp;
	double* pMatbn;
	double* pMatbcp;
	double* pMatbcn;
};

#endif  /*VCVSINST_H*/
