#ifndef  DEVBASE_H
#define  DEVBASE_H

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

class InstBase {
protected:
	typedef std::weak_ptr< Node > NodePtr;
	typedef std::weak_ptr< Branch > BranchPtr;
	typedef std::weak_ptr< ModelBase > ModelPtr;
	
	string name;
	vector< NodePtr > nodeTable;
	ModelPtr myModel;
	string modelName;

	void printNode() const;
	void printGenInf() const;
	
public:
	InstBase(const string& str, const string& modelStr);
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
	
	inline void setModel(const ModelPtr& mModel) {myModel = mModel;}
	virtual void setBranch(const BranchPtr& mBranch) {};
	
	inline string getInstName() const {return name;}
	inline string getModelName() const {return modelName;}

	virtual void printInf() const = 0;
	
};

#endif  /*DEVBASE_H*/
