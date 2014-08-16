#ifndef  CCCSModel_H
#define  CCCSMODEL_H

#include "../DevBase.h"

class CCCSModel : public ModelBase {
public:
	CCCSModel(const string& str);
	virtual ~CCCSModel() {}
	virtual void printInf() const;
};

#endif  /*CCCSMODEL_H*/
