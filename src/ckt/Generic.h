#ifndef  GENERIC_H
#define  GENERIC_H

#include <string>
using std::string;

class Node {

private:
	string name;
	int index;
	double voltage;

public:
	Node(const string& str);
	inline string getName() const {return name;}

};

class Branch {

private:
	string name;
	int index;
	double current;

public:	
	Branch(const string& str);
	inline string getName() const {return name;}

};

#endif  /*GENERIC_H*/