#include "EigenMatrix.h"

#include <iomanip>
#include <iostream>
using std::cout;
using std::endl;

#include "Eigen/Core"

template<typename T>
EigenMatrix<T>::EigenMatrix(unsigned int dim):
	A(dim - 1, dim - 1),
	b(dim - 1),
	cb(dim - 1),
	//solver(A),
	dimension(dim),
	stampMat(new T*[dim]),
	stampRhs(new T[dim])
{
	for(unsigned int i = 0; i < dimension; i++)
		stampMat[i] = new T[dim];
	reset();
}

template<typename T>
EigenMatrix<T>::~EigenMatrix() {
	for(int i = 0; i < dimension; i++)
		delete [] stampMat[i];
	delete [] stampMat;
	delete [] stampRhs;
}

template<typename T>
T* EigenMatrix<T>::getMatPtr(unsigned int i, unsigned int j) const {
	return &stampMat[i][j];
}

template<typename T>
T* EigenMatrix<T>::getRhsPtr(unsigned int i) const {
	return &stampRhs[i];
}

template<>
void EigenMatrix<double>::SetAb() {
	A.setZero();
	for(unsigned int i = 1; i < dimension; i++)
		for(unsigned int j = 1; j < dimension; j++)
			if(stampMat[i][j] != 0.0)
				A.insert(i - 1, j - 1) = stampMat[i][j];
	A.makeCompressed();
	for(unsigned int i = 1; i < dimension; i++)
		b(i - 1) = stampRhs[i];
}

template<>
void EigenMatrix<std::complex<double>>::SetAb() {
	A.setZero();
	for(unsigned int i = 1; i < dimension; i++)
		for(unsigned int j = 1; j < dimension; j++)
			if(stampMat[i][j] != 0.0)
				A.insert(i - 1, j - 1) = stampMat[i][j];
	A.makeCompressed();
	for(unsigned int i = 1; i < dimension; i++)
		cb(i - 1) = stampRhs[i];
}

template<typename T>
void EigenMatrix<T>::reset() {
	for(unsigned int i = 0; i < dimension; i++)
		memset(stampMat[i], 0, sizeof(stampMat[i][0]) * dimension);
	memset(stampRhs, 0, sizeof(stampRhs[0]) * dimension);
}

template<>
bool EigenMatrix<double>::solveVI() {
	SetAb();
	solver.compute(A);
	if(solver.info() != Eigen::Success) return false;
	x = solver.solve(b);
	if(solver.info() != Eigen::Success) return false;
	return true;
}

template<>
bool EigenMatrix< std::complex<double> >::solveVI() {
	SetAb();
	solver.compute(A);
	if(solver.info() != Eigen::Success) return false;
	cx = solver.solve(cb);
	if(solver.info() != Eigen::Success) return false;
	return true;
}

template<>
double EigenMatrix<double>::getResVal(unsigned int i) {
	return (i == 0) ? 0 : x(i - 1);
}

template<>
std::complex<double> EigenMatrix< std::complex<double> >::getResVal(unsigned int i) {
	return (i == 0) ? 0 : cx(i - 1);
}

template<typename T>
void EigenMatrix<T>::printMat() const {
	Matrix<T>::PrintMatTitle(dimension);
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

template<typename T>
void EigenMatrix<T>::printRhs() const {
	Matrix<T>::PrintRhsTitle(dimension);
	cout.flags(std::ios::left);
	cout.setf(std::ios::scientific);
	cout.setf(std::ios::showpos);
	for(unsigned int i = 0; i < dimension; i++)
		cout << std::setw(15) << stampRhs[i];
	cout << endl;
	cout.unsetf(std::ios::scientific);
	cout.unsetf(std::ios::showpos);
}

template<typename T>
void EigenMatrix<T>::printRes() const {
	Matrix<T>::PrintResTitle(dimension);
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

void TemporaryFunction() {
	EigenMatrix<double> tempObj1(1);
	EigenMatrix< std::complex< double > > tempObj2(1);
}