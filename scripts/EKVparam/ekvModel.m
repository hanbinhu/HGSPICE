function [Ids,G,C]=ekvModel(Type,L,W,V,Param)
% Output Definition
% Ids the current flowing through MOSFET
% G = [gm, gds, gmb]
% C = [Cgs, Cgs, Cgb, Csb, Cdb]

% Sample Size
N = length(Type);

% Constant definition
EPSILONSI = 104.5e-12;
VT = 1.3807e-23 * 300.15 / 1.602e-19;

% Input Parameter Definition
% Param size (N)
phi = Param(:,1);
cox = Param(:,2);
gamma = Param(:,3);
Vth0 = Param(:,4);
kvalue = Param(:,5);
lambda = Param(:,6);
xj = Param(:,7);
Esat = Param(:,8);
Cj = Param(:,9);
Cjsw = Param(:,10);
Ls = Param(:,11);
Cov = Param(:,12);

% Type size (N, 1)
% 'N' for NMOS, 'P' for PMOS
sign = (Type=='N')*2-1;

% V size (N, 4)
% V(:,1) voltage at gate
% V(:,2) voltage at drain
% V(:,3) voltage at source
% V(:,4) voltage at bulk
Vg = (V(:,1)-V(:,4)).*sign;
Vd = (V(:,2)-V(:,4)).*sign;
Vs = (V(:,3)-V(:,4)).*sign;

% Ids calculation
Vgt = Vg-Vth0+phi+gamma.*sqrt(phi);
Vp = -phi+(Vgt-gamma.*(sqrt(Vgt+gamma.^2./4)-gamma/2)).*(Vgt>=0);
n = 1+gamma./2./sqrt(Vp+phi+4*VT);

qf = invq((Vp-Vs)/VT,1);
icf = qf.*(qf+1);
qr = invq((Vp-Vd)/VT,1);
icr = qr.*(qr+1);
IC = icf-icr;

Vc = Esat.*L;
Vdss = Vc.*(sqrt(0.25+VT./Vc.*sqrt(icf))-0.5);
deltaV = 4*VT*sqrt(lambda.*(sqrt(icf)-Vdss/VT) + 1/64);
Vds = (Vd-Vs)/2;
Vip = sqrt(Vdss.^2+deltaV.^2)-sqrt((Vds-Vdss).^2+deltaV.^2);
Lc = sqrt(EPSILONSI./cox.*xj);
deltaL = lambda.*Lc.*log(1+(Vds-Vip)./Lc./Esat);
Lt = L-deltaL+(Vds+Vip)./Esat;
Lmint = L/10;
Leq = (Lt+sqrt(Lt.^2+Lmint.^2))/2;

beta = kvalue.*W./Leq;
Is = 2*n.*beta*VT.^2;
Ids = sign.*Is.*IC;

% Transconductance Calculation
% calc gmg
gmg = zeros(N,1);

dVpdVg = 1-gamma./sqrt(4*Vgt+gamma.^2);
dicfdVg = qf/VT.*dVpdVg;
dicrdVg = qr/VT.*dVpdVg;

dndVg = -gamma.*dVpdVg/4./sqrt(Vp+phi+4*VT)./(Vp+phi+4*VT);

dVdssdVg = dicfdVg.*Vc*VT/4./sqrt(icf)./(2*Vdss+Vc);
ddeltaVdVg = 8*VT^2*lambda./deltaV.*(dicfdVg/2./sqrt(icf)-dVdssdVg/VT);
dVipdVg = (Vdss.*dVdssdVg+deltaV.*ddeltaVdVg)./sqrt(Vdss.^2+deltaV.^2)-(deltaV.*ddeltaVdVg-dVdssdVg.*(Vds-Vdss))./sqrt(deltaV.^2+(Vds-Vdss).^2);
ddeltaLdVg = dVipdVg.*lambda.*Lc./(Vip-Vds-Lc.*Esat);
dLtdVg = dVipdVg./Esat-ddeltaLdVg;
dLeqdVg = dLtdVg.*(1+Lt./sqrt(Lt.^2+Lmint.^2))/2;
dbetadVg = -dLeqdVg.*kvalue.*W./(Leq.^2);

dIsdVg = 2*VT^2*(beta.*dndVg+n.*dbetadVg);
gmg = IC.*dIsdVg+Is.*(dicfdVg-dicrdVg);

% calc gmd
gmd = zeros(N,1);

dVipdVd = (Vdss-Vds)/2./sqrt((Vdss-Vds).^2+deltaV.^2);
ddeltaLdVd = lambda.*Lc./(Lc.*Esat+Vds-Vip).*(0.5-dVipdVd);
dLtdVd = (dVipdVd+0.5)./Esat-ddeltaLdVd;
dLeqdVd = dLtdVd.*(1+Lt./sqrt(Lt.*Lt+Lmint.*Lmint))/2;
dbetadVd = -kvalue.*W./(Leq.^2).*dLeqdVd;

dIsdVd = 2*n*VT^2.*dbetadVd;

dicrdVd = -qr/VT;

gmd = dIsdVd.*IC-Is.*dicrdVd;

% calc gms
gms = zeros(N,1);

dicfdVs = -qf/VT;

dVdssdVs = dicfdVs.*Vc*VT./(2*Vdss+Vc)/2./sqrt(icf);
ddeltaVdVs = 8*lambda*VT^2./deltaV.*(dicfdVs/2./sqrt(icf)-dVdssdVs./VT);
dVipdVs = (Vdss.*dVdssdVs+deltaV.*ddeltaVdVs)./sqrt(Vdss.^2+deltaV.^2)-(deltaV.*ddeltaVdVs-(dVdssdVs+0.5).*(Vds-Vdss))./sqrt(deltaV.^2+(Vds-Vdss).^2);
ddeltaLdVs = lambda.*Lc./(Vip-Lc.*Esat-Vds).*(0.5+dVipdVs);
dLtdVs = (dVipdVs-0.5)./Esat-ddeltaLdVs;
dLeqdVs = dLtdVs.*(1+Lt./sqrt(Lt.^2+Lmint.^2))/2;
dbetadVs = -kvalue.*W./(Leq.^2).*dLeqdVs;

dIsdVs = 2*n*VT^2.*dbetadVs;
gms = -(dIsdVs.*IC+Is.*dicfdVs);

gm = gmg.*(Vgt >= 0);
gds = gmd;
gmb = gms-gmg-gmd;

G = [gm, gds, gmb];

% Capacitance Calculation
nq = 1+gamma/2./sqrt(Vp+phi+1e-6);
c_ox = cox.*W.*L;
c_ov = Cov.*W;
c_jb0 = Cj.*Ls.*W+Cjsw.*(2*Ls+W);

xf = sqrt(icf+0.25);
xr = sqrt(icr+0.25);

cgs = c_ox*2/3.*(1-(xr.^2+xr+xf/2)./((xf+xr).^2));
cgd = c_ox*2/3.*(1-(xf.^2+xf+xr/2)./((xf+xr).^2));
cgb = (nq-1)./(nq).*(c_ox-cgs-cgd);
csb = (nq-1).*cgs;
cdb = (nq-1).*cgd;

cgs += c_ov;
cgd += c_ov;
csb += c_jb0;
cdb += c_jb0;

cgs = cgs.*(cgs>0);
cgd = cgd.*(cgd>0);
cgb = cgb.*(cgb>0);
csb = csb.*(csb>0);
cdb = cdb.*(cdb>0);

C = [cgs, cgd, cgb, csb, cdb];

end
