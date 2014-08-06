#include <iostream>

#include "Ckt.h"
#include "SpParser.hpp"

extern FILE *yyin;

using namespace std;

int main(int argc, char *argv[]) {
	if(argc != 2) cout << "Usage: HGSPICE <Test Circuit>" << endl;
	else {
		if (!(yyin = fopen(argv[1], "r"))) {
			cout << argv[1] << " doesn't exist." << endl;
			exit(1);
		}
		Ckt *pObj = new Ckt();
		yy::SpParser spiceParser(pObj);
		spiceParser.parse();
		pObj->Summarize();
		delete pObj;

	}
	return 0;
}
