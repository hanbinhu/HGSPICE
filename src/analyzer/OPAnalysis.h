#ifndef  OPANALYSIS_H
#define  OPANALYSIS_H

#include "Analysis.h"

class OPAnalysis : public Analysis {
public:
	OPAnalysis(int id, const string& filename);
	virtual ~OPAnalysis() {}
	virtual void PrintInf();
	
	virtual void analyze(const std::shared_ptr< Ckt >& mCkt, std::shared_ptr< Matrix< double > > mMat);
	
};

#endif  /*OPANALYSIS_H*/
