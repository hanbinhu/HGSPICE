#ifndef  CAPINST_H
#define  CAPINST_H

#include "../DevBase.h"
#include "CapModel.h"

class CapInst : public InstBase {
private:
	BranchPtr brPtr;
	
	double capcitance;
	
	bool initial;
	double voltageIC;
	
	std::weak_ptr<CapModel> myModel;
	
public:
	CapInst(const string& str, const string& modelStr);
	CapInst(const CapInst& rhs);
	virtual ~CapInst() {}
	
	inline void specifyCap(double cap) {capcitance = cap;}
	inline virtual void specifyIC(double IC) {voltageIC = IC; initial = true;}
	inline virtual void setBranch(const BranchPtr& mBranch) {brPtr = mBranch;}
	
	virtual std::shared_ptr< InstBase > Clone();
	virtual inline void setModel(const ModelPtr& mModel) {myModel = std::dynamic_pointer_cast<CapModel>(mModel);}
	
	virtual void stamp(const std::shared_ptr< Matrix<double> >& mMat);
	virtual void loadOP();
	virtual void loadDC();
	virtual void loadTRAN(double time, double timeStep, bool flagInitial);
	
	virtual void printFileTitle(ofstream& outF, const string& title) const;
	virtual void printFileValue(ofstream& outF) const;
	
	virtual void printInf() const;
	
private:
	double* pMatpb;
	double* pMatnb;
	double* pMatbp;
	double* pMatbn;
	double* pMatbb;
	double* pRhsb;
	
	double* VTp;
	double* VTn;
};

#endif  /*CAPINST_H*/
