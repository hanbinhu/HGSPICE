#ifndef  RESMODEL_H
#define  RESMODEL_H

#include "../DevBase.h"

class ResModel : public ModelBase {
public:
	ResModel(const string& str);
	virtual ~ResModel() {}
	virtual void printInf() const;
};

#endif  /*RESMODEL_H*/
