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

class Ckt
{
public:
	Ckt();
	Ckt(const string& filename);
	~Ckt();

	const std::shared_ptr<Node> newNode(const string& strNode);
	void addInst(const std::shared_ptr< InstBase >& mInstPtr);
	
	std::shared_ptr< InstBase > getLastInst();
	
	void ParseDiode(char *str, char *nodep, char *noden, char *model);
	void ParseMOS(char *str, char *noded, char *nodeg, char *nodes, char *nodeb, char *model, double l, double w);

	void ParseAnaOP();
	void ParseAnaDC(char *source, double start, double end, double step);
	void ParseAnaAC(char *sweepType, double n, double fstart, double fend);
	void ParseAnaTRAN(double tstep, double tend, double tstart = 0);

	void ParseVsrc(char *str, char *nodep, char *noden, double value);
	void ParseIsrc(char *str, char *nodep, char *noden, double value);

	void Summarize();
	void printAllNodes() const;
	void printAllInsts() const;

private:
	enum State {INIT, PARSING, LINKCKT, COMPLETECKT};
	State processState;
	
	int nDiode;
	int nMOS;

	int nAnaOP;
	int nAnaDC;
	int nAnaAC;
	int nAnaTRAN;

	int nVsrc;
	int nIsrc;
	
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
	vector< ModelPtr > ModelList;
	std::unordered_map< string, ModelPtr > modelHashMap;
};

#endif


