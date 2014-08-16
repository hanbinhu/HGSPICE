#include "ISrcModel.h"

ISrcModel::ISrcModel(const string& str): 
	ModelBase(str)
{}

void ISrcModel::printInf() const {
	printGenInf();
}