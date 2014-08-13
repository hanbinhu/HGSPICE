#ifndef  DCANALYSIS_H
#define  DCANALYSIS_H

#include <string>
using std::string;

#include "Analysis.h"

class DCAnalysis : public Analysis {
public:
	DCAnalysis(const string& src, double vs, double ve, double vi);
	virtual ~DCAnalysis() {}
	virtual void PrintInf();
	
private:
	string SrcName;
	double vStart;
	double vStop;
	double vInc;
};

#endif  /*DCANALYSIS_H*/
