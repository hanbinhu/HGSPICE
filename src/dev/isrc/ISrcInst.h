#ifndef  ISRCINST_H
#define  ISRCINST_H

#include <vector>
using std::vector;

#include <functional>

#include "../DevBase.h"
#include "../SrcFunc.h"

class ISrcInst : public InstBase {
private:
	double dcCurrent;
	double acCurrent;
	double acCurrentPhase;
	
	std::function< double(const vector<double>&, double) > calFunc;
	std::function< void(const vector<double>&, SrcFunc::SignalType) > printFunc;
	vector< double > paramTable;
	
public:
	ISrcInst(const string& str, const string& modelStr);
	ISrcInst(const ISrcInst& rhs);
	virtual ~ISrcInst() {}
	
	inline virtual void specifyDC(double dc) {dcCurrent = dc;}
	inline virtual void  specifyAC(double ac, double phase) {acCurrent = ac; acCurrentPhase = phase;}
	virtual void specifyFunc(SrcFunc::TranFuncType mFuncType, const vector<double>& paramTab);
	
	virtual std::shared_ptr< InstBase > Clone();
	
	virtual void printInf() const;
};

#endif  /*ISRCINST_H*/
