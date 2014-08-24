#ifndef  CCVSINST_H
#define  CCVSINST_H

#include "../DevBase.h"

#include <memory>

class VSrcInst;

class CCVSInst : public InstBase {
private:
	std::weak_ptr< VSrcInst > mVPtr;
	BranchPtr brVSPtr;
	
	string CCName;
	double h;
	
public:
	CCVSInst(const string& str, const string& modelStr);
	CCVSInst(const CCVSInst& rhs);	
	virtual ~CCVSInst() {}
	
	inline void specifyH(double ccvs) {h = ccvs;}
	inline void specifyCCName(const string& str)  {CCName = str;}
	inline string getVName() {return CCName;}
	inline virtual void setBranch(const BranchPtr& mBranch) {brVSPtr = mBranch;}
	inline void setVPtr(const std::weak_ptr< VSrcInst >& VPtr) {mVPtr = VPtr;}
	
	virtual std::shared_ptr< InstBase > Clone();
	
	virtual void stamp(const std::shared_ptr< Matrix<double> >& mMat);
	
	virtual void printInf() const;
	
private:
	double* pMatpb;
	double* pMatnb;
	double* pMatbp;
	double* pMatbn;
	double* pMatbcb;
};

#endif  /*CCVSINST_H*/
