#ifndef  VCCSINST_H
#define  VCCSINST_H

#include "../DevBase.h"
#include "VCCSModel.h"

class VCCSInst : public InstBase {
private:
	double g;
	
	std::weak_ptr<VCCSModel> myModel;
	
public:
	VCCSInst(const string& str, const string& modelStr);
	VCCSInst(const VCCSInst& rhs);
	virtual ~VCCSInst() {}
	
	inline void specifyG(double vccs) {g = vccs;}
	
	virtual std::shared_ptr< InstBase > Clone();
	virtual inline void setModel(const ModelPtr& mModel) {myModel = std::dynamic_pointer_cast<VCCSModel>(mModel);}
	
	virtual void stamp(const std::shared_ptr< Matrix<double> >& mMat);
	virtual void stampAC(const std::shared_ptr< Matrix< std::complex< double > > >& mMat);
	virtual void loadDC();
	virtual void loadOP();
	virtual void loadAC(double freq);
	virtual void loadTRAN(double time, double timeStep, bool flagInitial);
	
	virtual void printFileTitle(ofstream& outF, const string& title) const;
	virtual void printFileValue(ofstream& outF) const;
	
	virtual void printInf() const;
	
private:
	double* pMatpcp;
	double* pMatpcn;
	double* pMatncp;
	double* pMatncn;
	
	std::complex< double >* pMatACpcp;
	std::complex< double >* pMatACpcn;
	std::complex< double >* pMatACncp;
	std::complex< double >* pMatACncn;
	
	void load();
};

#endif  /*VCCSINST_H*/
