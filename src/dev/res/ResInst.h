#ifndef  RESINST_H
#define  RESINST_H

#include "../DevBase.h"

class ResInst : public InstBase {
private:
	double resistance;
	
public:
	ResInst(const string& str, const string& modelStr);
	virtual ~ResInst() {}
	
	inline void specifyRes(double res) {resistance = res;}
	
	virtual void printInf() const;
};

#endif  /*RESINST_H*/
