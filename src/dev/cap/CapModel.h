#ifndef  CAPMODEL_H
#define  CAPMODEL_H

#include "../DevBase.h"

class CapModel : public ModelBase {
public:
	CapModel(const string& str);
	virtual ~CapModel() {}
	virtual void printInf() const;
};

#endif  /*CAPMODEL_H*/
