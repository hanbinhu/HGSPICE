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
public:
	Analysis(int id, const string& filename);
	virtual ~Analysis() {}
	virtual void PrintInf() = 0;
	virtual void analyze(const std::shared_ptr< Ckt >& mCkt, std::shared_ptr< Matrix<double> > mMat) {}
};

#endif  /*ANALYSIS_H*/
