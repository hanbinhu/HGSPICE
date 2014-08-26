#include "Analysis.h"

Analysis::Analysis(int id, const string& filename):
	outputFile(filename + std::to_string(id))
{}