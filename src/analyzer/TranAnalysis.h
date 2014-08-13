#ifndef  TRANANALYSIS_H
#define  TRANANALYSIS_H

#include "Analysis.h"

class TranAnalysis : public Analysis {
public:
	TranAnalysis(double ti, double te, double ts);
	virtual ~TranAnalysis() {}
	virtual void PrintInf();
	
private:
	double tStart;
	double tStop;
	double tStep;
};

#endif  /*TRANANALYSIS_H*/
