#ifndef  SUBCKT_H
#define  SUBCKT_H

#include <string>
#include <vector>
using std::string;
using std::vector;

#include <memory>
#include <unordered_set>
#include <unordered_map>

#include "Generic.h"
#include "Devices.h"
#include "Ckt.h"

class SubCkt : public Ckt {
private:
	string name;

	enum ParseState {INIT, INNER, COMPLETE};
	ParseState mState;

	std::unordered_set<string> paramHashSet;
	vector< string > paramTable;
	vector< double > defaultVaule;

	typedef std::shared_ptr< Node> NodePtr;
	vector< NodePtr > internalNodeList;
	std::unordered_map< string, NodePtr > internalNodeHashMap;
	vector< NodePtr > externalNodeList;
	std::unordered_map< string, NodePtr > externalNodeHashMap;

	typedef std::shared_ptr< InstBase > InstPtr;
	vector< InstPtr > instList;
	std::unordered_map< string, InstPtr > instHashMap;

public:	
	SubCkt(const string& str);
	~SubCkt() {}

	inline string getName() const {return name;}

	void SetInnerState();
	void SetCompState();
	void SetNewParam(const string& param, double value);

	void PrintInf() const;

	virtual const std::shared_ptr<Node> newNode(const string& strNode);
	virtual void addInst(const std::shared_ptr< InstBase >& mInstPtr);
	virtual std::shared_ptr< InstBase > getLastInst();
};

#endif  /*SUBCKT_H*/
