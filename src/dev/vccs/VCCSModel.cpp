#include "VCCSModel.h"

VCCSModel::VCCSModel(const string& str): 
	ModelBase(str)
{}

void VCCSModel::printInf() const {
	printGenInf();
}