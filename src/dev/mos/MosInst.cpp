#include <iostream>
using std::cout;
using std::endl;

#include "MosInst.h"

MosInst::MosInst(const string& str, const string& modelStr): 
	InstBase(str, modelStr)
{}

MosInst::MosInst(const MosInst& rhs): 
	InstBase(rhs),
	W(rhs.W),
	L(rhs.L)
{}

void MosInst::printInf() const {
	printGenInf();
	cout << "Length of transistor is " << L << "m." << endl;
	cout << "Width of transistor is " << W << "m." << endl;
}

std::shared_ptr< InstBase > MosInst::Clone() {
	return std::static_pointer_cast< InstBase >( std::shared_ptr< MosInst >(new MosInst( *this ) ) );
}