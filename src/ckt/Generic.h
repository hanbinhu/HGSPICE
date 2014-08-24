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
	void setId(unsigned int id);
	unsigned int getId() const;

};

class Branch {

private:
	string name;
	unsigned int index;
	double current;

public:	
	Branch(const string& str);
	inline string getName() const {return name;}
	void setId(unsigned int id);
	unsigned int getId() const;

};

#endif  /*GENERIC_H*/
