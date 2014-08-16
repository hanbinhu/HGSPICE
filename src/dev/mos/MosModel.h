#ifndef  MOSMODEL_H
#define  MOSMODEL_H

#include "../DevBase.h"

class MosModel : public ModelBase {
public:
	enum MosType {NMOS, PMOS};
	
	MosModel(const string& str, MosModel::MosType type);
	virtual ~MosModel() {}
	virtual void printInf() const;
	
	virtual void addParam(const string& param, double val);
	
private:
	MosType mType;
	static const size_t arraySize = 12;
};

#endif  /*MOSMODEL_H*/
