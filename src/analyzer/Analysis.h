#ifndef  ANALYSIS_H
#define  ANALYSIS_H

#include <string>
using std::string;
#include <memory>

class Ckt;
template<typename T> class Matrix;

class Analysis {
protected:
	string outputFile;

	static constexpr double epsilonA = 1e-6;
	static constexpr double epsilonR = 1e-3;

public:
	Analysis(int id, const string& filename);
	virtual ~Analysis() {}
	virtual void PrintInf() = 0;
	virtual void analyze(const std::shared_ptr< Ckt >& mCkt, std::shared_ptr< Matrix<double> > mMat) {}
};

#endif  /*ANALYSIS_H*/
