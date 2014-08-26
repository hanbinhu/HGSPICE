#ifndef  RESINST_H
#define  RESINST_H

#include "../DevBase.h"

class ResInst : public InstBase {
private:
	double resistance;
	
public:
	ResInst(const string& str, const string& modelStr);
	ResInst(const ResInst& rhs);
	virtual ~ResInst() {}
	
	inline void specifyRes(double res) {resistance = res;}
	
	virtual std::shared_ptr< InstBase > Clone();
	
	virtual void stamp(const std::shared_ptr< Matrix<double> >& mMat);
	virtual void loadOP();
	virtual void loadDC();
	
	virtual void printInf() const;
	
private:
	double* pMatpp;
	double* pMatpn;
	double* pMatnp;
	double* pMatnn;
	
	void load();
};

#endif  /*RESINST_H*/
