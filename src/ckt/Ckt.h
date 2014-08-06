#ifndef CKT_H
#define CKT_H

#include <iostream>
using namespace std;

class Ckt
{
	public:
		Ckt();
		~Ckt();

		void ParseRes(char *str, char *nodep, char *noden, double value);
		void ParseCap(char *str, char *nodep, char *noden, double value, double init = 0);
		void ParseInd(char *str, char *nodep, char *noden, double value, double init = 0);
		void ParseVCVS(char *str, char *nodeop, char *nodeon, char *nodeip, char *nodein, double value);
		void ParseCCCS(char *str, char *nodeop, char *nodeon, char *vsens, double value);
		void ParseVCCS(char *str, char *nodeop, char *nodeon, char *nodeip, char *nodein, double value);
		void ParseCCVS(char *str, char *nodeop, char *nodeon, char *vsens, double value);
		void ParseDiode(char *str, char *nodep, char *noden, char *model);
		void ParseMOS(char *str, char *noded, char *nodeg, char *nodes, char *nodeb, char *model, double l, double w);

		void ParseAnaOP();
		void ParseAnaDC(char *source, double start, double end, double step);
		void ParseAnaAC(char *sweepType, double n, double fstart, double fend);
		void ParseAnaTRAN(double tstep, double tend, double tstart = 0);

		void ParseVsrc(char *str, char *nodep, char *noden, double value);
		void ParseIsrc(char *str, char *nodep, char *noden, double value);

		void Summarize();

	private:
		int nRes;
		int nCap;
		int nInd;
		int nVCVS;
		int nCCCS;
		int nVCCS;
		int nCCVS;
		int nDiode;
		int nMOS;

		int nAnaOP;
		int nAnaDC;
		int nAnaAC;
		int nAnaTRAN;

		int nVsrc;
		int nIsrc;
};

#endif
