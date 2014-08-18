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
	
public:
	VSrcInst(const string& str, const string& modelStr);
	virtual ~VSrcInst() {}
	
	inline virtual void specifyDC(double dc) {dcVoltage = dc;}
	inline virtual void  specifyAC(double ac, double phase) {acVoltage = ac; acVoltagePhase = phase;}
	virtual void specifyFunc(SrcFunc::TranFuncType mFuncType, const vector<double>& paramTab);
	inline virtual void setBranch(const BranchPtr& mBranch) {brPtr = mBranch;}
	
	virtual void printInf() const;
};

#endif  /*VSRCINST_H*/
