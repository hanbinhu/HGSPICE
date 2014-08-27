#ifndef  TRANANALYSIS_H
#define  TRANANALYSIS_H

#include "Analysis.h"

class TranAnalysis : public Analysis {
public:
	TranAnalysis(int id, const string& filename, double ti, double te, double ts);
	virtual ~TranAnalysis() {}
	virtual void PrintInf();
	
	virtual void analyze(const std::shared_ptr< Ckt >& mCkt, std::shared_ptr< Matrix< double > > mMat);
	
private:
	double tStart;
	double tStop;
	double tStep;
};

#endif  /*TRANANALYSIS_H*/
