#ifndef  EIGENMATRIX_H
#define  EIGENMATRIX_H

#include "Matrix.h"

#include "Eigen/Sparse"

template<typename T>
class EigenMatrix:public Matrix<T> {
private:
	unsigned int dimension;
	T **stampMat;
	T *stampRhs;
	Eigen::SparseMatrix<T> A;
	Eigen::VectorXd b;
	Eigen::VectorXd x;
	Eigen::VectorXcd cb;
	Eigen::VectorXcd cx;
	Eigen::SparseLU<Eigen::SparseMatrix<T>> solver;
	void SetAb();
	
	bool Success;
	
public:
	EigenMatrix(unsigned int dim);
	virtual ~EigenMatrix();
	inline virtual unsigned int getDim() const {return dimension;}
	virtual T* getMatPtr(unsigned int i, unsigned int j) const;
	virtual T* getRhsPtr(unsigned int i) const;
	virtual bool solveVI();
	virtual T getResVal(unsigned int i);
	virtual void reset();
	virtual void printMat() const;
	virtual void printRhs() const;
	virtual void printRes() const;
};

#endif  /*EIGENMATRIX_H*/
