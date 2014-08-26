#ifndef  ACANALYSIS_H
#define  ACANALYSIS_H

#include "Analysis.h"

class ACAnalysis : public Analysis {
public:
	enum SweepType {DEC, OCT, LIN};
	
	ACAnalysis(int id, const string& filename, SweepType mType, int n, double fs, double fe);
	virtual ~ACAnalysis() {}
	virtual void PrintInf();
	
private:
	SweepType mSweepType;
	double fStart;
	double fStop;
	int nPoints;
};

#endif  /*ACANALYSIS_H*/
