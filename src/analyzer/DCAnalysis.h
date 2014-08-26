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
	DCAnalysis(int id, const string& filename, const string& src, double vs, double ve, double vi);
	virtual ~DCAnalysis() {}
	virtual void PrintInf();
	
	inline string SrcName() const {return mSrcName;}
	void linkSrcInst(std::shared_ptr< InstBase > srcInst);
	virtual void analyze(const std::shared_ptr< Ckt >& mCkt, std::shared_ptr< Matrix< double > > mMat);
	
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
