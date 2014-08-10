#ifndef  DEVBASE_H
#define  DEVBASE_H

#include <vector>
#include <string>
using std::vector;
using std::string;

#include <memory>

#include "SrcFunc.h"

class Node;
class Branch;

class ModelBase {
private:
	string name;
	vector< double > modelParamTable;

public:
	ModelBase();
	virtual ~ModelBase() {}
	inline string getName() const {return name;}
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
	
	inline string getInstName() const {return name;}
	inline string getModelName() const {return modelName;}

	virtual void printInf() const = 0;
	
};

#endif  /*DEVBASE_H*/
