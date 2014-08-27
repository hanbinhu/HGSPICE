#ifndef  MATRIX_H
#define  MATRIX_H

#include <iostream>
#include <vector>

template <typename T>
class Matrix {
protected:
	void PrintMatTitle(unsigned int dim) const {std::cout << "MNA Matrix (" << dim << "," << dim << ") looks like:" << std::endl;}
	void PrintRhsTitle(unsigned int dim) const {std::cout << "MNA Right hand side vector (" << dim << ") looks like:" << std::endl;}
	void PrintResTitle(unsigned int dim) const {std::cout << "MNA Result vector (" << dim << ") looks like:" << std::endl;}
public:
	virtual ~Matrix() {}
	virtual unsigned int getDim() const = 0;
	virtual T* getMatPtr(unsigned int i, unsigned int j) const = 0;
	virtual T* getRhsPtr(unsigned int i) const = 0;
	virtual bool solveVI() = 0;
	virtual T getResVal(unsigned int i) = 0;
	virtual void reset() = 0;
	virtual void printMat() const = 0;
	virtual void printRhs() const = 0;
	virtual void printRes() const = 0;
};

#endif  /*MATRIX_H*/
