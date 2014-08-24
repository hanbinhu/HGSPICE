#include "EigenMatrix.h"

#include <iomanip>
#include <iostream>
using std::cout;
using std::endl;

#include "Eigen/Core"

EigenMatrix::EigenMatrix(unsigned int dim):
	A(dim - 1, dim - 1),
	b(dim - 1),
	//solver(A),
	dimension(dim),
	stampMat(new double*[dim]),
	stampRhs(new double[dim])
{
	for(unsigned int i = 0; i < dimension; i++)
		stampMat[i] = new double[dim];
	reset();
}

EigenMatrix::~EigenMatrix() {
	for(int i = 0; i < dimension; i++)
		delete [] stampMat[i];
	delete [] stampMat;
	delete [] stampRhs;
}

double* EigenMatrix::getMatPtr(unsigned int i, unsigned int j) const {
	return &stampMat[i][j];
}

double* EigenMatrix::getRhsPtr(unsigned int i) const {
	return &stampRhs[i];
}

void EigenMatrix::SetAb() {
	A.setZero();
	for(unsigned int i = 1; i < dimension; i++)
		for(unsigned int j = 1; j < dimension; j++)
			if(stampMat[i][j])
				A.insert(i - 1, j - 1) = stampMat[i][j];
	A.makeCompressed();
	for(unsigned int i = 1; i < dimension; i++)
		b(i - 1) = stampRhs[i];
}

void EigenMatrix::reset() {
	for(unsigned int i = 0; i < dimension; i++)
		memset(stampMat[i], 0, sizeof(stampMat[i][0]) * dimension);
	memset(stampRhs, 0, sizeof(stampRhs[0]) * dimension);
}

bool EigenMatrix::solveVI() {
	SetAb();
	solver.compute(A);
	if(solver.info() != Eigen::Success) return false;
	x = solver.solve(b);
	if(solver.info() != Eigen::Success) return false;
	return true;
}

double EigenMatrix::getResVal(unsigned int i) {
	return (i == 0) ? 0 : x(i - 1);
}

void EigenMatrix::printMat() const {
	PrintMatTitle(dimension);
	cout.flags(std::ios::left);
	cout.setf(std::ios::scientific);
	cout.setf(std::ios::showpos);
	for(unsigned int i = 0; i < dimension; i++) {
		for(unsigned int j = 0; j < dimension; j++)
			cout << std::setw(15) << stampMat[i][j];
		cout << endl;
	}
	cout.unsetf(std::ios::scientific);
	cout.unsetf(std::ios::showpos);
}

void EigenMatrix::printRhs() const {
	PrintRhsTitle(dimension);
	cout.flags(std::ios::left);
	cout.setf(std::ios::scientific);
	cout.setf(std::ios::showpos);
	for(unsigned int i = 0; i < dimension; i++)
		cout << std::setw(15) << stampRhs[i];
	cout << endl;
	cout.unsetf(std::ios::scientific);
	cout.unsetf(std::ios::showpos);
}

void EigenMatrix::printRes() const {
	PrintResTitle(dimension);
	cout.flags(std::ios::left);
	cout.setf(std::ios::scientific);
	cout.setf(std::ios::showpos);
	cout << std::setw(15) << 0.0;
	for(unsigned int i = 1; i < dimension; i++)
		cout << std::setw(15) << x(i - 1);
	cout << endl;
	cout.unsetf(std::ios::scientific);
	cout.unsetf(std::ios::showpos);
}
