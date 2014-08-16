#ifndef  VSRCMODEL_H
#define VSRCMODEL_H

#include "../DevBase.h"

class VSrcModel : public ModelBase {
public:
	VSrcModel(const string& str);
	virtual ~VSrcModel() {}
	virtual void printInf() const;
};

#endif  /*VSRCMODEL_H*/
