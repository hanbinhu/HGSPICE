#ifndef  ANALYZER_H
#define  ANALYZER_H

#include <string>
#include <vector>
using std::string;
using std::vector;

#include <memory>

#include "Analysis.h"
#include "ACAnalysis.h"

class Ckt;
template<typename T> class Matrix;

class Analyzer {
public:
	Analyzer(const string& str);
	~Analyzer() {}
	
	inline string getInputFile() const {return inputFile;}
	
	void ParseOPAnalysis();
	void ParseDCAnalysis(const string& src, double vs, double ve, double vi);
	void ParseTranAnalysis(double vi, double ve, double vs = 0);
	void ParseACAnalysis(ACAnalysis::SweepType mType, int n, double fs, double fe);
	
	void PrintAllAnalysis() const;
	
	void linkSrc(std::shared_ptr< Ckt > mCkt);
	void initialMat(unsigned int dim);
	inline const std::shared_ptr< Matrix<double> >& getMatPtr() {return cktMatrix;}
	
private:
	enum State {INIT, LINKCKT, COMPLETEANA};
	State processState;
	
	string inputFile;
	
	std::shared_ptr< Matrix<double> > cktMatrix;
	
	typedef std::shared_ptr< Analysis > AnalysisPtr;
	vector< AnalysisPtr > taskList;
};

#endif  /*ANALYZER_H*/
