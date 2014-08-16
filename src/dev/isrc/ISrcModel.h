#ifndef  ISRCMODEL_H
#define ISRCMODEL_H

#include "../DevBase.h"

class ISrcModel : public ModelBase {
public:
	ISrcModel(const string& str);
	virtual ~ISrcModel() {}
	virtual void printInf() const;
};

#endif  /*ISRCMODEL_H*/
