#ifndef  MOSINST_H
#define  MOSINST_H

#include "../DevBase.h"
#include "MosModel.h"

class MosInst : public InstBase {
private:
	double L;
	double W;
	
	double gm;
	double gds;
	double gmb;
	
	double cgs;
	double cgd;
	double cgb;
	double csb;
	double cdb;
	
	double Id;
	std::weak_ptr<MosModel> myModel;
	
public:
	MosInst(const string& str, const string& modelStr);
	MosInst(const MosInst& rhs);
	virtual ~MosInst() {}
	
	inline void specifyL(double mL) {L = mL;}
	inline void specifyW(double mW) {W = mW;}
	
	virtual std::shared_ptr< InstBase > Clone();
	virtual void setModel(const ModelPtr& mModel);
	
	virtual void stamp(const std::shared_ptr< Matrix<double> >& mMat);
	virtual void stampAC(const std::shared_ptr< Matrix< std::complex< double > > >& mMat);
	virtual void loadOP();
	virtual void loadDC();
	virtual void loadAC(double freq);
	virtual void loadTRAN(double time, double timeStep, bool flagInitial);
	
	virtual void setSmallParam();
	
	virtual void printFileTitle(ofstream& outF, const string& title) const;
	virtual void printFileValue(ofstream& outF) const;
	
	virtual void printInf() const;
	
private:
	double* pMatdd;
	double* pMatdg;
	double* pMatds;
	double* pMatdb;
	double* pMatsd;
	double* pMatsg;
	double* pMatss;
	double* pMatsb;
	double* pRhsd;
	double* pRhss;
	
	std::complex< double >* pMatACdd;
	std::complex< double >* pMatACdg;
	std::complex< double >* pMatACds;
	std::complex< double >* pMatACdb;
	std::complex< double >* pMatACsd;
	std::complex< double >* pMatACsg;
	std::complex< double >* pMatACss;
	std::complex< double >* pMatACsb;
	std::complex< double >* pMatACgg;
	std::complex< double >* pMatACgs;
	std::complex< double >* pMatACgd;
	std::complex< double >* pMatACgb;
	std::complex< double >* pMatACbb;
	std::complex< double >* pMatACbg;
	std::complex< double >* pMatACbs;
	std::complex< double >* pMatACbd;
	
	double *VDd;
	double *VDg;
	double *VDs;
	double *VDb;
	void load();
};

#endif  /*MOSINST_H*/
