#ifndef  CCVSINST_H
#define  CCVSINST_H

#include "../DevBase.h"
#include "CCVSModel.h"

#include <memory>

class VSrcInst;

class CCVSInst : public InstBase {
private:
	std::weak_ptr< VSrcInst > mVPtr;
	BranchPtr brVSPtr;
	
	string CCName;
	double h;
	
	std::weak_ptr<CCVSModel> myModel;
	
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
	virtual inline void setModel(const ModelPtr& mModel) {myModel = std::dynamic_pointer_cast<CCVSModel>(mModel);}
	
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
	double* pMatbcb;
	
	std::complex<double>* pMatACpb;
	std::complex<double>* pMatACnb;
	std::complex<double>* pMatACbp;
	std::complex<double>* pMatACbn;
	std::complex<double>* pMatACbcb;
	
	void load();
};

#endif  /*CCVSINST_H*/
