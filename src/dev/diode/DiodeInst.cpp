#include <iostream>
using std::cout;
using std::endl;

#include "DiodeInst.h"

#include "Matrix.h"

DiodeInst::DiodeInst(const string& str, const string& modelStr): 
	InstBase(str, modelStr)
{}

DiodeInst::DiodeInst(const DiodeInst& rhs): 
	InstBase(rhs)
{}

void DiodeInst::printFileTitle(ofstream& outF, const string& title) const {

}

void DiodeInst::printFileValue(ofstream& outF) const {

}

void DiodeInst::printInf() const {
	printGenInf();
}

std::shared_ptr< InstBase > DiodeInst::Clone() {
	return std::static_pointer_cast< InstBase >( std::shared_ptr< DiodeInst >(new DiodeInst( *this ) ) );
}

void DiodeInst::stamp(const std::shared_ptr< Matrix< double > >& mMat) {

}

void DiodeInst::loadOP() {

}

void DiodeInst::loadDC() {

}

void DiodeInst::loadTRAN(double time, double timeStep, bool flagInitial) {

}