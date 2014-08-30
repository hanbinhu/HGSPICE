#include <iostream>
using std::cout;
using std::endl;

#include "MosModel.h"
#include "regex"

#define Lmin modelParamTable[0]
#define Lmax modelParamTable[1]
#define Wmin modelParamTable[2]
#define Wmax modelParamTable[3]
#define Phi modelParamTable[4]
#define Cox modelParamTable[5]
#define gamma modelParamTable[6]
#define Vth0 modelParamTable[7]
#define kvalue modelParamTable[8]
#define lambda modelParamTable[9]
#define xj modelParamTable[10]
#define Esat modelParamTable[11]

MosModel::MosModel(const string& str, MosType type): 
	ModelBase(str, arraySize),
	mType(type)
{
	Lmin = 1.8e-7;
	Lmax = 20e-6;
	Wmin = 2.2e-7;
	Wmax = 900e-6;
	Phi = 0.9;
	Cox = 8.58e-3;
	gamma = 0.3;
	Vth0 = 0.4;
	kvalue = 390e-6;
	lambda = 0.5;
	xj = 30e-9;
	Esat = 5e6;
}

bool MosModel::checkSize(double L, double W) const {
	if(L < Lmin  || L > Lmax) return false;
	if(W < Wmin  || W > Wmax) return false;
	return true;
}

void MosModel::addParam(const string& param, double val) {
	if(std::regex_match(param, std::regex("Imin", std::regex::icase))) Lmin = val;
	else if(std::regex_match(param, std::regex("Imax", std::regex::icase))) Lmax = val;
	else if(std::regex_match(param, std::regex("wmin", std::regex::icase))) Wmin = val;
	else if(std::regex_match(param, std::regex("wmax", std::regex::icase))) Wmax = val;
	else if(std::regex_match(param, std::regex("phi", std::regex::icase))) Phi = val;
	else if(std::regex_match(param, std::regex("cox", std::regex::icase))) Cox = val;
	else if(std::regex_match(param, std::regex("gamma", std::regex::icase))) gamma = val;
	else if(std::regex_match(param, std::regex("vth0", std::regex::icase))) Vth0 = val;
	else if(std::regex_match(param, std::regex("k", std::regex::icase))) kvalue = val;
	else if(std::regex_match(param, std::regex("lambda", std::regex::icase))) lambda = val;
	else if(std::regex_match(param, std::regex("xj", std::regex::icase))) xj = val;
	else if(std::regex_match(param, std::regex("esat", std::regex::icase))) Esat = val;
	else throw std::runtime_error(string("No parameter ") + param + " for diodes.");
}

std::tuple< double, double, double, double > MosModel::modelCalc(double L, double W, double Vdrain, double Vgate, double Vsource, double Vbulk) const {
    int sign = (mType == NMOS) ? 1 : -1;

    //calc IDS
    //get bulk-ref voltage
    double Vg = (Vgate - Vbulk) * sign;
    double Vd = (Vdrain - Vbulk) * sign;
    double Vs = (Vsource - Vbulk) * sign;

    //calc Vp & n
    double Vgt = Vg - Vth0 + Phi + gamma * sqrt(Phi);
    double Vp = -Phi;
    if(Vgt >= 0) Vp = Vgt - Phi - gamma * (sqrt(Vgt + gamma * gamma / 4) - gamma / 2);
    else cout << "derivative should be 0" << endl;
    double n = 1 + gamma / 2 / sqrt(Vp + Phi + 4 * VT);

    //calc IC
    double qf = invq((Vp - Vs) / VT, 1);
    double icf = qf * (qf + 1);
    double qr = invq((Vp - Vd) / VT, 1);
    double icr = qr * (qr + 1);
    double IC = icf - icr;

    // calc Leq
    double Vc = Esat * L;
    double Vdss =  Vc * (sqrt(0.25 + VT / Vc * sqrt(icf)) - 0.5);
    double deltaV = 4 * VT * sqrt(lambda * (sqrt(icf) - Vdss / VT) + 1.0 / 64);
    double Vds = (Vd - Vs) / 2;
    double Vip = sqrt(Vdss * Vdss + deltaV * deltaV) - sqrt((Vds - Vdss) * (Vds - Vdss)+ deltaV * deltaV);
    double Lc = sqrt(EPSILONSI / Cox * xj);
    double deltaL = lambda * Lc * log(1 + (Vds - Vip) / Lc / Esat);
    double Lt = L - deltaL + (Vds + Vip) / Esat;
    double Lmint = L / 10;
    double Leq = (Lt + sqrt(Lt * Lt + Lmint * Lmint)) / 2;

    // calc id
    double beta = kvalue * W / Leq;
    double Is = 2 * n * beta * VT * VT;
    double Ids = Is * IC;

    // calc gmg
    double gmg;
    {
        double dVpdVg = 1 - gamma / sqrt(4 * Vgt + gamma * gamma);
        double dicfdVg = qf / VT * dVpdVg;
        double dicrdVg = qr / VT * dVpdVg;

        double dndVg = -gamma * dVpdVg / 4 / sqrt(Vp + Phi + 4 * VT) / (Vp + Phi + 4 * VT);

        double dVdssdVg = dicfdVg * Vc * VT / 4 / sqrt(icf) / (2 * Vdss + Vc);
        double ddeltaVdVg = 8 * lambda * VT * VT / deltaV * (dicfdVg / 2 / sqrt(icf) - dVdssdVg / VT);
        double dVipdVg = (Vdss * dVdssdVg + deltaV * ddeltaVdVg) / sqrt(Vdss * Vdss + deltaV * deltaV) - (deltaV * ddeltaVdVg - dVdssdVg * (Vds - Vdss)) / sqrt(deltaV * deltaV + (Vds - Vdss) * (Vds - Vdss));
        double ddeltaLdVg = dVipdVg * lambda * Lc / (Vip - Vds - Lc * Esat);
        double dLtdVg = dVipdVg / Esat - ddeltaLdVg;
        double dLeqdVg = dLtdVg * (1 + Lt / sqrt(Lt * Lt + Lmint * Lmint)) / 2;
        double dbetadVg = -dLeqdVg * kvalue * W / Leq / Leq;

        double dIsdVg = 2 * VT * VT * (beta * dndVg + n * dbetadVg);
        gmg = IC * dIsdVg + Is * (dicfdVg - dicrdVg);
    }


    // calc gmd
    double gmd;
    {
        double dVipdVd = (Vdss - Vds) / 2 / sqrt((Vdss - Vds) * (Vdss - Vds) + deltaV * deltaV);
        double ddeltaLdVd = lambda * Lc / (Lc * Esat + Vds - Vip) * (0.5 - dVipdVd);
        double dLtdVd = (dVipdVd + 0.5) / Esat - ddeltaLdVd;
        double dLeqdVd = dLtdVd * (1 + Lt / sqrt(Lt * Lt + Lmint * Lmint)) / 2;
        double dbetadVd = -kvalue * W / Leq / Leq * dLeqdVd;

        double dIsdVd = 2 * n * VT * VT * dbetadVd;

        double dicrdVd = -qr / VT;
        gmd = dIsdVd * IC - Is * dicrdVd;
    }


    // calc gms
    double gms;
    {
        double dicfdVs = -qf / VT;

        double dVdssdVs = dicfdVs * Vc * VT / (2 * Vdss + Vc) / 2 / sqrt(icf);
        double ddeltaVdVs = 8 * lambda * VT * VT / deltaV * (dicfdVs / 2 / sqrt(icf) - dVdssdVs / VT);
        double dVipdVs = (Vdss * dVdssdVs + deltaV * ddeltaVdVs) / sqrt(Vdss * Vdss + deltaV * deltaV) - (deltaV * ddeltaVdVs - (dVdssdVs + 0.5) * (Vds - Vdss)) / sqrt(deltaV * deltaV + (Vds - Vdss) * (Vds - Vdss));
        double ddeltaLdVs = lambda * Lc / (Vip - Lc * Esat - Vds) * (0.5 + dVipdVs);
        double dLtdVs = (dVipdVs - 0.5) / Esat - ddeltaLdVs;
        double dLeqdVs = dLtdVs * (1 + Lt / sqrt(Lt * Lt + Lmint * Lmint)) / 2;
        double dbetadVs = -kvalue * W / Leq / Leq * dLeqdVs;

        double dIsdVs = 2 * n * VT * VT * dbetadVs;
        gms = -1 * (dIsdVs * IC + Is * dicfdVs);
    }

    double gm = gmg;
    double gds = gmd;
    double gmb = gms - gmg - gmd;
	
	std::tuple<double, double, double, double> reVal(Ids, gm, gds, gmb);
	
	return reVal;
}

double MosModel::invq(double targetV, double q0) const {
	double q = q0;
    int cnt = 0, cntNeg = 0;
    double V, dV, delta;
    double qNeg = 1e-14;
    while(1)
    {
        V = 2 * (q) + log(q) - targetV;
        dV = 2 + 1.0 / q;
        delta = V / dV;
        if(fabs(delta) / q < 1e-9) break;
        if(cnt == 100) {
            cout << "Warning: invq() hasn't converged." << endl;
            break;
        }
        q -= delta;
        if(q < 0) {
            q = qNeg;
            qNeg /= 10;
            cntNeg++;
        }
        cnt++;
    }
    return q;
}

void MosModel::printInf() const {
	printGenInf();
	cout << "Min Length: " << Lmin << "m" << endl;
	cout << "Max Length: " << Lmax << "m" << endl;
	cout << "Min Width: " << Wmin << "m" << endl;
	cout << "Max Width: " << Wmax << "m" << endl;
	cout << "Fermi potential(*2): " << Phi << "V" << endl;
	cout << "Gate oxide capacitance: " << Cox << "F/m^2" << endl;
	cout << "Body Effect: " << gamma << "V^0.5" << endl;
	cout << "Long-channel threshold voltage: " << Vth0 << "V" << endl;
	cout << "Transconductance: " << kvalue << "A/V^2" << endl;
	cout << "Junction depth: " << xj << "m" << endl;
	cout << "Longitudinal critical field: " << Esat << "V/m" << endl;
}

#undef Lmin
#undef Lmax
#undef Wmin
#undef Wmax
#undef Phi
#undef Cox
#undef gamma
#undef Vth0
#undef kvalue
#undef lambda
#undef xj
#undef Esat