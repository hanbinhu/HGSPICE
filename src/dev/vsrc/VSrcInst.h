#ifndef  VSRCINST_H
#define  VSRCINST_H

#include <vector>
using std::vector;

#include <functional>

#include "../DevBase.h"
#include "../SrcFunc.h"

class VSrcInst : public InstBase {
private:
	BranchPtr brPtr;
	
	double dcVoltage;
	double acVoltage;
	double acVoltagePhase;
	
	std::function< double(const vector<double>&, double) > calFunc;
	std::function< void(const vector<double>&, SrcFunc::SignalType) > printFunc;
	vector< double > paramTable;
	
	double loadV;
	bool compDCLoad;
	
public:
	VSrcInst(const string& str, const string& modelStr);
	VSrcInst(const VSrcInst& rhs);
	virtual ~VSrcInst() {}
	
	inline virtual void specifyDC(double dc) {dcVoltage = dc;}
	inline virtual void  specifyAC(double ac, double phase) {acVoltage = ac; acVoltagePhase = phase;}
	virtual void specifyFunc(SrcFunc::TranFuncType mFuncType, const vector<double>& paramTab);
	inline virtual void setBranch(const BranchPtr& mBranch) {brPtr = mBranch;}
	
	virtual std::shared_ptr< InstBase > Clone();
	
	inline unsigned int getBrId() const {return brPtr.lock()->getId();}
	virtual void stamp(const std::shared_ptr< Matrix<double> >& mMat);
	virtual void loadOP();
	virtual void loadDC();
	virtual void loadTRAN(double time, double timeStep, bool flagInitial);
	
	inline void setLoad(double V) {loadV = V; compDCLoad = true;}
	
	virtual void printInf() const;
	
private:
	double* pMatpb;
	double* pMatnb;
	double* pMatbp;
	double* pMatbn;
	double* pRhsb;
	
	void load();
};

#endif  /*VSRCINST_H*/
