#ifndef  XSUBMODEL_H
#define  XSUBMODEL_H

#include "../DevBase.h"

class XSubModel : public ModelBase {
public:
	XSubModel(const string& str);
	virtual ~XSubModel() {}
	virtual void printInf() const;
};

#endif  /*XSUBMODEL_H*/
