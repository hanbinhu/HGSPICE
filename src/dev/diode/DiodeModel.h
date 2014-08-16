#ifndef  DIODEMODEL_H
#define  DIODEMODEL_H

#include "../DevBase.h"

class DiodeModel : public ModelBase {
private:
	static const size_t arraySize = 1;
public:
	DiodeModel(const string& str);
	virtual ~DiodeModel() {}
	virtual void printInf() const;
	
	virtual void addParam(const string& param, double val);
};

#endif  /*DIODEMODEL_H*/
