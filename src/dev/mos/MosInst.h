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
	virtual void loadOP();
	virtual void loadDC();
	virtual void loadTRAN(double time, double timeStep, bool flagInitial);
	
	virtual void printFileTitle(ofstream& outF, const string& title) const;
	virtual void printFileValue(ofstream& outF) const;
	
	virtual void printInf() const;
	
private:
	double *pMatdd;
	double *pMatdg;
	double *pMatds;
	double *pMatdb;
	double *pMatsd;
	double *pMatsg;
	double *pMatss;
	double *pMatsb;
	double *pRhsd;
	double *pRhss;
	
	double *VDd;
	double *VDg;
	double *VDs;
	double *VDb;
	void load();
};

#endif  /*MOSINST_H*/
