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
	
	virtual void printInf() const;
};

#endif  /*RESINST_H*/
