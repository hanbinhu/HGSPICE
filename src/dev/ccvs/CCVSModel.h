#ifndef  CCVSModel_H
#define  CCVSMODEL_H

#include "../DevBase.h"

class CCVSModel : public ModelBase {
public:
	CCVSModel(const string& str);
	virtual ~CCVSModel() {}
	virtual void printInf() const;
};

#endif  /*CCVSMODEL_H*/
