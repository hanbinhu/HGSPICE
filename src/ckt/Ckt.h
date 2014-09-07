#ifndef CKT_H
#define CKT_H

#include <fstream>

#include <string>
#include <vector>
using std::string;
using std::vector;

#include <memory>
#include <unordered_map>

#include "Generic.h"

class InstBase;
class ModelBase;

class SubCkt;
class Analyzer;

template<typename T> class Matrix;

class Ckt : public std::enable_shared_from_this< Ckt >
{

friend class XSubInst;

private:
	typedef std::shared_ptr< Node> NodePtr;
	typedef std::shared_ptr< Branch> BranchPtr;
	typedef std::shared_ptr< InstBase > InstPtr;
	typedef std::shared_ptr< ModelBase > ModelPtr;
	typedef std::shared_ptr< SubCkt > SubCktPtr;

public:
	Ckt();
	~Ckt();

	enum ParseSub {INSUB, OUTSUB};

	void Initialize(std::shared_ptr< Analyzer > mAnalyzer);

	std::shared_ptr< Ckt > CurrentCkt();

	virtual const std::shared_ptr<Node> newNode(const string& strNode);

	virtual void addInst(const std::shared_ptr< InstBase >& mInstPtr);
	virtual std::shared_ptr< InstBase > getLastInst();

	void addModel(const std::shared_ptr< ModelBase >& mModelPtr);
	std::shared_ptr< ModelBase > getLastModel();

	void addSubCkt(const std::shared_ptr< SubCkt >& mSubCktPtr);
	void SetSubEnd(); 
	std::shared_ptr< SubCkt > getLastSubCkt();
	
	InstPtr findInst(const string& instName);
	
	void LoadOP() const;
	void LoadDC() const;
	void LoadTRAN(double time, double timeStep, bool flagInitial) const;
	
	void SetTForNAB(const vector<double>& vTable);
	bool SetDForNAB(const vector<double>& vTable, double ea, double er);
	void SmallSignalSet();
	
	void randInitial();

	void printFile(double sweep, bool initial, std::ofstream& outF) const;
	
	void printAllNodes() const;
	void printAllBranches() const;
	void printAllInsts() const;
	void printAllModels() const;
	void printAllSubDef() const;

private:
	enum State {INIT, PARSING, LINKCKT, COMPLETECKT};
	State processState;
	ParseSub subParseState;

	vector< NodePtr > nodeList;
	std::unordered_map< string, NodePtr > nodeHashMap;	
	
	vector< BranchPtr > branchList;
	std::unordered_map< string, BranchPtr > branchHashMap;
	
	vector< InstPtr > instList;
	std::unordered_map< string, InstPtr > instHashMap;
	
	vector< ModelPtr > modelList;
	std::unordered_map< string, ModelPtr > modelHashMap;
	
	vector< SubCktPtr > subCktList;
	std::unordered_map< string, SubCktPtr > subCktHashMap;
	
	void linkAll();
	void linkBranch(const string& title, InstPtr& mInst);
	void linkCC(InstPtr& mInst);
	void linkModel(InstPtr& mInst);
	const std::shared_ptr< Branch > newBranch(const string& strBranch);
	
	void numberNodeBranch();
	void stampInst(const std::shared_ptr< Matrix<double> >& mMat);
};

#endif