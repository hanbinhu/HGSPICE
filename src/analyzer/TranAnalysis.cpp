#include <iostream>
using std::cout;
using std::endl;

#include "TranAnalysis.h"

TranAnalysis::TranAnalysis(int id, const string& filename, double ti, double te, double ts):
	Analysis(id, filename),
	tStep(ti),
	tStop(te),
	tStart(ts)
{}

void TranAnalysis::PrintInf() {
	cout << "****************************************" << endl;
	cout << "Analysis Type: Tran" << endl;
	cout << "\tStart Time: " << tStart << "s" << endl;
	cout << "\tStop Time: " << tStop << "s" << endl;
	cout << "\tStep Time: " << tStep << "s" << endl;
}