#ifndef  CCCSINST_H
#define  CCCSINST_H

#include "../DevBase.h"

#include <memory>

class VSrcInst;

class CCCSInst : public InstBase {
private:
	std::weak_ptr< VSrcInst > mVPtr;
	string CCName;
	double f;
	
public:
	CCCSInst(const string& str, const string& modelStr);
	CCCSInst(const CCCSInst& rhs);
	virtual ~CCCSInst() {}
	
	inline void specifyF(double cccs) {f = cccs;}
	inline void specifyCCName(const string& str)  {CCName = str;}
	inline string getVName() {return CCName;}
	inline void setVPtr(const std::weak_ptr< VSrcInst >& VPtr) {mVPtr = VPtr;}
	
	virtual std::shared_ptr< InstBase > Clone();
	
	virtual void printInf() const;
};

#endif  /*CCCSINST_H*/