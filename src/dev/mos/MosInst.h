#ifndef  MOSINST_H
#define  MOSINST_H

#include "../DevBase.h"

class MosInst : public InstBase {
private:
	double L;
	double W;
	
public:
	MosInst(const string& str, const string& modelStr);
	virtual ~MosInst() {}
	
	inline void specifyL(double mL) {L = mL;}
	inline void specifyW(double mW) {W = mW;}
	
	virtual void printInf() const;
};

#endif  /*MOSINST_H*/
