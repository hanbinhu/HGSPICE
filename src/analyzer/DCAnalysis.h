#ifndef  DCANALYSIS_H
#define  DCANALYSIS_H

#include <string>
#include <memory>
using std::string;

#include "Analysis.h"

class InstBase;
class VSrcInst;
class ISrcInst;

class DCAnalysis : public Analysis {
public:
	DCAnalysis(const string& src, double vs, double ve, double vi);
	virtual ~DCAnalysis() {}
	virtual void PrintInf();
	
	inline string SrcName() const {return mSrcName;}
	void linkSrcInst(std::shared_ptr< InstBase > srcInst);
	
private:
	string mSrcName;
	enum SrcType {V, I};
	SrcType mType;
	
	std::weak_ptr< VSrcInst > mVSrcInst;
	std::weak_ptr< ISrcInst > mISrcInst;
	
	double vStart;
	double vStop;
	double vInc;
};

#endif  /*DCANALYSIS_H*/
