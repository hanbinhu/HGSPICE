#ifndef CKT_H
#define CKT_H

#include <string>
#include <vector>
using std::string;
using std::vector;

#include <memory>
#include <unordered_map>

#include "Generic.h"
#include "Devices.h"

class SubCkt;
class Analyzer;

class Ckt : public std::enable_shared_from_this< Ckt >
{
public:
	Ckt();
	~Ckt();

	enum ParseSub {INSUB, OUTSUB};

	void ParseAll(std::shared_ptr< Analyzer > mAnalyzer);

	virtual const std::shared_ptr<Node> newNode(const string& strNode);
	virtual void addInst(const std::shared_ptr< InstBase >& mInstPtr);
	virtual std::shared_ptr< InstBase > getLastInst();
	
	std::shared_ptr< Ckt > CurrentCkt();
	
	void addSubCkt(const std::shared_ptr< SubCkt >& mSubCktPtr);
	void SetSubEnd(); 
	std::shared_ptr< SubCkt > getLastSubCkt();
	
	void ParseDiode(char *str, char *nodep, char *noden, char *model);
	void ParseMOS(char *str, char *noded, char *nodeg, char *nodes, char *nodeb, char *model, double l, double w);

	void printAllNodes() const;
	void printAllInsts() const;
	void printAllSubDef() const;

private:
	enum State {INIT, PARSING, LINKCKT, COMPLETECKT};
	State processState;
	ParseSub subParseState;
	
	int nDiode;
	int nMOS;
	
	typedef std::shared_ptr< Node> NodePtr;
	vector< NodePtr > nodeList;
	std::unordered_map< string, NodePtr > nodeHashMap;
	
	typedef std::shared_ptr< Node> BranchPtr;
	vector< BranchPtr > branchList;
	std::unordered_map< string, BranchPtr > branchHashMap;
	
	typedef std::shared_ptr< InstBase > InstPtr;
	vector< InstPtr > instList;
	std::unordered_map< string, InstPtr > instHashMap;
	
	typedef std::shared_ptr< ModelBase > ModelPtr;
	std::unordered_map< string, ModelPtr > modelHashMap;
	
	typedef std::shared_ptr< SubCkt > SubCktPtr;
	vector< SubCktPtr > subCktList;
	std::unordered_map< string, SubCktPtr > subCktHashMap;
};

#endif


