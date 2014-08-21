#ifndef  DIODEINST_H
#define  DIODEINST_H

#include "../DevBase.h"

class DiodeInst : public InstBase {
public:
	DiodeInst(const string& str, const string& modelStr);
	DiodeInst(const DiodeInst& rhs);
	virtual ~DiodeInst() {}

	virtual std::shared_ptr< InstBase > Clone();

	virtual void printInf() const;
};

#endif  /*DIODEINST_H*/
