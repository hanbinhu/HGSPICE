#ifndef  VCCSINST_H
#define  VCCSINST_H

#include "../DevBase.h"

class VCCSInst : public InstBase {
private:
	double g;
	
public:
	VCCSInst(const string& str, const string& modelStr);
	VCCSInst(const VCCSInst& rhs);
	virtual ~VCCSInst() {}
	
	inline void specifyG(double vccs) {g = vccs;}
	
	virtual std::shared_ptr< InstBase > Clone();
	
	virtual void printInf() const;
};

#endif  /*VCCSINST_H*/
