#ifndef  MOSMODEL_H
#define  MOSMODEL_H

#include <tuple>

#include "../DevBase.h"

class MosModel : public ModelBase {
public:
	enum MosType {NMOS, PMOS};
	
	MosModel(const string& str, MosModel::MosType type);
	virtual ~MosModel() {}
	virtual void printInf() const;
	
	bool checkSize(double L, double W) const;
	std::tuple<double, double, double, double, double, double, double, double, double> modelCalc(double L, double W, double Vdrain, double Vgate, double Vsource, double Vbulk) const;
	
	virtual void addParam(const string& param, double val);
	
private:
	double invq(double targetV, double q0) const;
	
	static constexpr double EPSILONSI = 104.5e-12;
	static constexpr double VT = 1.3807e-23 * 300.15 / 1.602e-19;
	
	MosType mType;
	static const size_t arraySize = 16;
};

#endif  /*MOSMODEL_H*/
