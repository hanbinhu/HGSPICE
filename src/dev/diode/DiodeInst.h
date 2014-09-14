#ifndef  DIODEINST_H
#define  DIODEINST_H

#include "../DevBase.h"
#include "DiodeModel.h"

class DiodeInst : public InstBase {
private:
	std::weak_ptr<DiodeModel> myModel;
public:
	DiodeInst(const string& str, const string& modelStr);
	DiodeInst(const DiodeInst& rhs);
	virtual ~DiodeInst() {}

	virtual std::shared_ptr< InstBase > Clone();
	virtual inline void setModel(const ModelPtr& mModel) {myModel = std::dynamic_pointer_cast<DiodeModel>(mModel);}

	virtual void stamp(const std::shared_ptr< Matrix<double> >& mMat);
	virtual void stampAC(const std::shared_ptr< Matrix< std::complex< double > > >& mMat);
	virtual void loadOP();
	virtual void loadDC();
	virtual void loadAC(double freq);
	virtual void loadTRAN(double time, double timeStep, bool flagInitial);

	virtual void printFileTitle(ofstream& outF, const string& title) const;
	virtual void printFileValue(ofstream& outF) const;
	
	virtual void printInf() const;
};

#endif  /*DIODEINST_H*/
