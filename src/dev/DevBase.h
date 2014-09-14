#ifndef  DEVBASE_H
#define  DEVBASE_H

#include <complex>

#include <fstream>
using std::ofstream;

#include <vector>
#include <string>
using std::vector;
using std::string;

#include <memory>
#include <unordered_map>

#include "SrcFunc.h"
#include "Generic.h"

class ModelBase {
protected:
	string name;
	vector <double> modelParamTable;
	void printGenInf() const;

public:
	ModelBase(const string& str, size_t size = 0);
	virtual ~ModelBase() {}
	inline string getName() const {return name;}
	virtual void addParam(const string& param, double val) {}
	virtual void printInf() const = 0;
};

template<typename T> class Matrix;

class InstBase {
friend class XSubInst;
	
protected:
	typedef std::weak_ptr< Node > NodePtr;
	typedef std::weak_ptr< Branch > BranchPtr;
	typedef std::shared_ptr< ModelBase > ModelPtr;
	
	string name;
	vector< NodePtr > nodeTable;
	string modelName;

	void printSeperator(ofstream& outF) const;
	void printFileTitleGen(const string& currentName, ofstream& outF, const string& title) const;
	
	void printNode() const;
	void printGenInf() const;
	
public:
	InstBase(const string& str, const string& modelStr);
	InstBase(const InstBase& rhs);
	virtual ~InstBase() {}
	
	void addNode(const NodePtr& mNodePtr) {nodeTable.push_back(mNodePtr);}

	//parser interface
	virtual void specifyIC(double IC) {}
	virtual void specifyDC(double dc) {}
	virtual void specifyAC(double ac, double phase) {}
	virtual void specifyFunc(SrcFunc::TranFuncType mFuncType, const vector<double>& paramTab) {}
	virtual void specifyParam(const string& param, double value) {}
	virtual void specifySubCkt() {}
	virtual void specifyNode(const string& node) {}

	virtual void setModel(const ModelPtr& mModel) = 0;
	virtual void setBranch(const BranchPtr& mBranch) {};

	inline string getInstName() const {return name;}
	inline string getModelName() const {return modelName;}

	virtual void stamp(const std::shared_ptr< Matrix<double> >& mMat) = 0;
	virtual void stampAC(const std::shared_ptr< Matrix<std::complex< double > > >& mMat) = 0;
	virtual void loadOP() = 0;
	virtual void loadDC() = 0;
	virtual void loadAC(double freq) = 0;
	virtual void loadTRAN(double time, double timeStep, bool flagInitial) = 0;
	
	virtual void setSmallParam() {}

	virtual void printFileTitle(ofstream& outF, const string& title) const = 0;
	virtual void printFileValue(ofstream& outF) const = 0;
	
	virtual std::shared_ptr< InstBase > Clone() = 0;
	
	virtual void printInf() const = 0;
	
};

#endif  /*DEVBASE_H*/
