#include <fstream>
#include <iostream>
#include <stdexcept>
using std::cout;
using std::endl;

#include <complex>
#include <cmath>

#include "ACAnalysis.h"
#include "OPAnalysis.h"

#include "Matrix.h"
#include "EigenMatrix.h"
#include "Ckt.h"

ACAnalysis::ACAnalysis(int id, const string& filename, ACAnalysis::SweepType mType, int n, double fs, double fe):
	Analysis(id, filename),
	mSweepType(mType),
	nPoints(n),
	fStart(fs),
	fStop(fe)
{}

void ACAnalysis::PrintInf() {
	cout << "****************************************" << endl;
	cout << "Analysis Type: AC" << endl;
	cout << "\tSweep Method: ";
	switch(mSweepType) {
		case DEC:
			cout << "DEC" << endl;
			break;
		case OCT:
			cout << "OCT" << endl;
			break;
		case LIN:
			cout << "LIN" << endl;
			break;
		default:
			throw std::runtime_error("No this sweep type in ACAnalysis.");
	}
	cout << "\t# of points: " << nPoints << endl;
	cout << "\tStart Frequency: " << fStart << "Hz" << endl;
	cout << "\tStop Frequency: " << fStop << "Hz" << endl;
}

void ACAnalysis::analyze(const std::shared_ptr< Ckt >& mCkt, std::shared_ptr< Matrix< double > > mMat) {
	OPAnalysis::opAna(mCkt, mMat);
	std::shared_ptr< Matrix<std::complex< double > > > ACMat( new EigenMatrix< std::complex< double > >( mMat->getDim() ) );
	mCkt->stampACInst(ACMat);
	
	std::vector<double> freqTab;
	genFreqTab(freqTab);
		
	std::ofstream outFile(outputFile, std::fstream::out);
	outFile.setf(std::ios::scientific);

	outFile << "Freq(Hz)";
	mCkt->printACTitle(outFile);
	
	unsigned int nNode = mCkt->nodeNum();
	
	for(double f : freqTab) {
		mCkt->LoadAC(f);
		bool SolveSuccess = ACMat->solveVI();
		if(!SolveSuccess) cout << f << " doesn't converge" << endl;
		outFile << f;
		for(unsigned int i = 0; i < ACMat->getDim(); i++) {
			if(i >= nNode) break;
			std::complex<double> tmpV(ACMat->getResVal(i));
			outFile << "," << std::abs(tmpV);
			outFile << "," << std::arg(tmpV) / M_PI * 180;
		}
		outFile << endl;
		ACMat->reset();
	}
	outFile.close();
}

void ACAnalysis::genFreqTab(vector< double >& mVec) {
	mVec.push_back(fStart);
	if(fStart == fStop) return;
	double f = fStart;
	if(mSweepType == LIN) {
		if(nPoints == 1) return;
		double step = (fStop - fStart) / (nPoints - 1);
		for(int i = 0; i < nPoints - 2; i++, f += step) mVec.push_back(f);
	} else {
		double mul = 1;
		if(mSweepType == DEC) mul = pow(10.0, 1.0 / nPoints);
		else mul = pow(2.0, 1.0 / nPoints);
		for(f = fStart * mul; f < fStop; f *= mul) mVec.push_back(f);
	}
	mVec.push_back(fStop);
}