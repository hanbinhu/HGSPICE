#ifndef  VCVSINST_H
#define  VCVSINST_H

#include "../DevBase.h"
#include "VCVSModel.h"

class VCVSInst : public InstBase {
private:
	BranchPtr brVSPtr;
	
	double e;
	
	std::weak_ptr<VCVSModel> myModel;
	
public:
	VCVSInst(const string& str, const string& modelStr);
	VCVSInst(const VCVSInst& rhs);
	virtual ~VCVSInst() {}
	
	inline void specifyE(double vcvs) {e = vcvs;}
	inline virtual void setBranch(const BranchPtr& mBranch) {brVSPtr = mBranch;}
	
	virtual std::shared_ptr< InstBase > Clone();
	virtual inline void setModel(const ModelPtr& mModel) {myModel = std::dynamic_pointer_cast<VCVSModel>(mModel);}
	
	virtual void stamp(const std::shared_ptr< Matrix<double> >& mMat);
	virtual void stampAC(const std::shared_ptr< Matrix< std::complex< double > > >& mMat);
	virtual void loadOP();
	virtual void loadDC();
	virtual void loadAC(double freq);
	virtual void loadTRAN(double time, double timeStep, bool flagInitial);
	
	virtual void printFileTitle(ofstream& outF, const string& title) const;
	virtual void printFileValue(ofstream& outF) const;
	
	virtual void printInf() const;
	
private:
	double* pMatpb;
	double* pMatnb;
	double* pMatbp;
	double* pMatbn;
	double* pMatbcp;
	double* pMatbcn;
	
	std::complex< double >* pMatACpb;
	std::complex< double >* pMatACnb;
	std::complex< double >* pMatACbp;
	std::complex< double >* pMatACbn;
	std::complex< double >* pMatACbcp;
	std::complex< double >* pMatACbcn;
	
	void load();
};

#endif  /*VCVSINST_H*/
