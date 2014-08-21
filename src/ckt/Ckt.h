#ifndef CKT_H
#define CKT_H

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

class Ckt : public std::enable_shared_from_this< Ckt >
{

friend class XSubInst;

public:
	Ckt();
	~Ckt();

	enum ParseSub {INSUB, OUTSUB};

	void ParseAll(std::shared_ptr< Analyzer > mAnalyzer);

	std::shared_ptr< Ckt > CurrentCkt();

	virtual const std::shared_ptr<Node> newNode(const string& strNode);

	virtual void addInst(const std::shared_ptr< InstBase >& mInstPtr);
	virtual std::shared_ptr< InstBase > getLastInst();

	void addModel(const std::shared_ptr< ModelBase >& mModelPtr);
	std::shared_ptr< ModelBase > getLastModel();

	void addSubCkt(const std::shared_ptr< SubCkt >& mSubCktPtr);
	void SetSubEnd(); 
	std::shared_ptr< SubCkt > getLastSubCkt();

	void printAllNodes() const;
	void printAllBranches() const;
	void printAllInsts() const;
	void printAllModels() const;
	void printAllSubDef() const;

private:
	enum State {INIT, PARSING, LINKCKT, COMPLETECKT};
	State processState;
	ParseSub subParseState;
		
	typedef std::shared_ptr< Node> NodePtr;
	vector< NodePtr > nodeList;
	std::unordered_map< string, NodePtr > nodeHashMap;
	
	typedef std::shared_ptr< Branch> BranchPtr;
	vector< BranchPtr > branchList;
	std::unordered_map< string, BranchPtr > branchHashMap;
	
	typedef std::shared_ptr< InstBase > InstPtr;
	vector< InstPtr > instList;
	std::unordered_map< string, InstPtr > instHashMap;
	
	typedef std::shared_ptr< ModelBase > ModelPtr;
	vector< ModelPtr > modelList;
	std::unordered_map< string, ModelPtr > modelHashMap;
	
	typedef std::shared_ptr< SubCkt > SubCktPtr;
	vector< SubCktPtr > subCktList;
	std::unordered_map< string, SubCktPtr > subCktHashMap;
	
	void linkAll();
	void linkBranch(const string& title, InstPtr& mInst);
	void linkCC(InstPtr& mInst);
	void linkModel(InstPtr& mInst);
	const std::shared_ptr< Branch > newBranch(const string& strBranch);
};

#endif