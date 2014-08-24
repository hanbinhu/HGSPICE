#ifndef  EIGENMATRIX_H
#define  EIGENMATRIX_H

#include "Matrix.h"

#include "Eigen/Sparse"

class EigenMatrix:public Matrix<double> {
private:
	unsigned int dimension;
	double **stampMat;
	double *stampRhs;
	Eigen::SparseMatrix<double> A;
	Eigen::VectorXd b;
	Eigen::VectorXd x;
	Eigen::BiCGSTAB<Eigen::SparseMatrix<double>> solver;
	void SetA();
	
	bool Success;
	
public:
	EigenMatrix(unsigned int dim);
	virtual ~EigenMatrix();
	virtual double* getMatPtr(unsigned int i, unsigned int j) const;
	virtual double* getRhsPtr(unsigned int i) const;
	virtual bool solveVI();
	virtual double getResVal(unsigned int i);
	virtual void reset();
	virtual void printMat() const;
	virtual void printRhs() const;
	virtual void printRes() const;
};

#endif  /*EIGENMATRIX_H*/