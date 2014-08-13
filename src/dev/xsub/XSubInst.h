#ifndef  XSUBINST_H
#define  XSUBINST_H

#include "../DevBase.h"

class XSubInst : public InstBase {
private:
	
public:
	XSubInst(const string& str, const string& modelStr);
	virtual ~XSubInst() {}
	
	virtual void printInf() const;
};

#endif  /*XSUBINST_H*/
