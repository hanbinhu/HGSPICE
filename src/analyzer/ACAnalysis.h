#ifndef  ACANALYSIS_H
#define  ACANALYSIS_H

#include <vector>

#include "Analysis.h"

class ACAnalysis : public Analysis {
public:
	enum SweepType {DEC, OCT, LIN};
	
	ACAnalysis(int id, const string& filename, SweepType mType, int n, double fs, double fe);
	virtual ~ACAnalysis() {}
	virtual void PrintInf();
	virtual void analyze(const std::shared_ptr< Ckt >& mCkt, std::shared_ptr< Matrix< double > > mMat);
	
private:
	SweepType mSweepType;
	double fStart;
	double fStop;
	int nPoints;
	
	void genFreqTab(std::vector<double>& mVec);
};

#endif  /*ACANALYSIS_H*/
