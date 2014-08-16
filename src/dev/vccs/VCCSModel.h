#ifndef  VCCSModel_H
#define  VCCSMODEL_H

#include "../DevBase.h"

class VCCSModel : public ModelBase {
public:
	VCCSModel(const string& str);
	virtual ~VCCSModel() {}
	virtual void printInf() const;
};

#endif  /*VCCSMODEL_H*/
