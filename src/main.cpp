#include <iostream>
#include <exception>

#include <memory>

#include "Ckt.h"
#include "Analyzer.h"

using namespace std;

int main(int argc, char *argv[]) {
	if(argc != 2) cout << "Usage: HGSPICE <Test Circuit>" << endl;
	else {
		try{
			std::shared_ptr< Analyzer > mAnalyzer(new Analyzer(argv[1]));
			std::shared_ptr< Ckt > pObj(new Ckt);
			pObj->ParseAll(mAnalyzer);
			pObj->printAllInsts();
			pObj->printAllBranches();
		} catch (const std::ios::failure& error) {
			cerr << "I/O exception: " << error.what() << endl;
			return 1;
		} catch (const std::runtime_error& error) {
			cerr << "Runtime error: " << error.what() << endl;
			return 1;
		}
	}
	return 0;
}
