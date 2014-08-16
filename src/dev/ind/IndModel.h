#ifndef  INDMODEL_H
#define  INDMODEL_H

#include "../DevBase.h"

class IndModel : public ModelBase {
public:
	IndModel(const string& str);
	virtual ~IndModel() {}
	virtual void printInf() const;
};

#endif  /*INDMODEL_H*/
