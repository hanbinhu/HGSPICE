#ifndef  DIODEINST_H
#define  DIODEINST_H

#include "../DevBase.h"

class DiodeInst : public InstBase {
public:
	DiodeInst(const string& str, const string& modelStr);
	virtual ~DiodeInst() {}

	virtual void printInf() const;
};

#endif  /*DIODEINST_H*/
