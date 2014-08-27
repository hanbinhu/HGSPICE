#ifndef  GENERIC_H
#define  GENERIC_H

#include <string>
using std::string;

class Node {

private:
	string name;
	int index;
	double voltageT;
	double voltageD;

public:
	Node(const string& str);
	inline string getName() const {return name;}
	void setId(unsigned int id);
	unsigned int getId() const;
	
	inline void setTRAN(double V) {voltageT = voltageD = V;}
	inline void setDC(double V) {voltageD = V;}
	inline double* getTPtr() {return &voltageT;}
	inline double* getDPtr() {return &voltageD;}
};

class Branch {

private:
	string name;
	unsigned int index;
	double currentT;
	double currentD;

public:	
	Branch(const string& str);
	inline string getName() const {return name;}
	void setId(unsigned int id);
	unsigned int getId() const;
	
	inline void setTRAN(double I) {currentT = currentD = I;}
	inline void setDC(double I) {currentD = I;}
	inline double* getTPtr() {return &currentT;}
	inline double* getDPtr() {return &currentD;}

};

#endif  /*GENERIC_H*/
