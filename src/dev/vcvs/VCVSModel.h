#ifndef  VCVSModel_H
#define  VCVSMODEL_H

#include "../DevBase.h"

class VCVSModel : public ModelBase {
public:
	VCVSModel(const string& str);
	virtual ~VCVSModel() {}
	virtual void printInf() const;
};

#endif  /*VCVSMODEL_H*/
