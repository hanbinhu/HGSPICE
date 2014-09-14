#ifndef  CCCSINST_H
#define  CCCSINST_H

#include "../DevBase.h"
#include "CCCSModel.h"

#include <memory>

class VSrcInst;

class CCCSInst : public InstBase {
private:
	std::weak_ptr< VSrcInst > mVPtr;
	string CCName;
	double f;
	
	std::weak_ptr<CCCSModel> myModel;
	
public:
	CCCSInst(const string& str, const string& modelStr);
	CCCSInst(const CCCSInst& rhs);
	virtual ~CCCSInst() {}
	
	inline void specifyF(double cccs) {f = cccs;}
	inline void specifyCCName(const string& str)  {CCName = str;}
	inline string getVName() {return CCName;}
	inline void setVPtr(const std::weak_ptr< VSrcInst >& VPtr) {mVPtr = VPtr;}
	
	virtual std::shared_ptr< InstBase > Clone();
	virtual inline void setModel(const ModelPtr& mModel) {myModel = std::dynamic_pointer_cast<CCCSModel>(mModel);}
	
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
	double* pMatpcb;
	double* pMatncb;
	
	std::complex< double >* pMatACpcb;
	std::complex< double >* pMatACncb;
	
	void load();
};

#endif  /*CCCSINST_H*/
