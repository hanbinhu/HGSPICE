/************************************************************
             Scanner for SPICE Parser Template

Author:
   Chen, Jiajun
   Shi, Guoyong
   Hu, Hanbin
 
Used for the course project of "Introduction to EDA", 2014

   School of Micro-electronics
   Shanghai Jiaotong University
************************************************************/

%skeleton "lalr1.cc"
%defines
%locations

%define "parser_class_name" "SpParser"

%code requires{
#include <iostream>
#include <exception>
#include <stdio.h>
#include <cstdlib>
#include <cstring>
#include <string>
#include <vector>

using std::cerr;
using std::endl;
using std::vector;
using std::string;
#include "Ckt.h"
#include "SubCkt.h"
#include "Devices.h"
#include "Analyzer.h"

extern FILE* yyin;
}

/* set the output file name */
%output="./SpParser.cpp"
%verbose

%union
{
	double f;
	int n;
	char* s;
};

/* defining parser input variable type */
%parse-param {std::shared_ptr< Ckt > pObj}
%parse-param {std::shared_ptr< Analyzer > mAnalyzer}

/* assigning data type for tokens and patterns */
%token<n> INTEGER
%token<f> FLOAT VALUE
%token<s> STRING
%token<s> RESISTOR CAPACITOR INDUCTOR VCVS CCCS VCCS CCVS DIODE MOSFET XSUB
%token<s> CURRENTSRC VOLTAGESRC
%token<s> PMOS NMOS D
%token<s> DC AC SIN PULSE EXP PWL SFFM
%token<s> L W
%token<s> DEC LIN OCT

%token MODEL SUBDEF SUBEND

%token OPANALYSIS DCANALYSIS ACANALYSIS TRANANALYSIS

%token EQN END EOL

%type<s> resistor capacitor inductor vcvs cccs vccs ccvs diode mosfet xsub
%type<s> currentsrcname voltagesrcname
%type<s> node variable
%type<f> value lpara wpara

%{
extern int yylex(yy::SpParser::semantic_type* yylval,
                 yy::SpParser::location_type* yylloc);
%}

%initial-action {
  // Filename for locations here
  @$.begin.filename = @$.end.filename = new std::string("stdin");
}

%%


spice: netlisttot end
;

opanalysis: OPANALYSIS
				{
				mAnalyzer->ParseOPAnalysis();
				};

dcanalysis: DCANALYSIS variable value value value
				{
				mAnalyzer->ParseDCAnalysis($2, $3, $4, $5);
				};

acanalysis: ACANALYSIS DEC INTEGER value value
				{
				mAnalyzer->ParseACAnalysis(ACAnalysis::DEC,$3, $4, $5);
				}
				| ACANALYSIS OCT INTEGER value value
				{
				mAnalyzer->ParseACAnalysis(ACAnalysis::OCT,$3, $4, $5);
				}
				| ACANALYSIS LIN INTEGER value value
				{
				mAnalyzer->ParseACAnalysis(ACAnalysis::LIN,$3, $4, $5);
				};

trananalysis: TRANANALYSIS value value
				{
				mAnalyzer->ParseTranAnalysis($2, $3);
				}
				| TRANANALYSIS value value value
				{
				mAnalyzer->ParseTranAnalysis($2, $3, $4);
				};

end: end EOL
	| END EOL
	| END;

netlisttot: netlisttot line
				| line;

line: netlist
		| substruct
		| model
		| analysis EOL
		| error EOL
		| EOL;

netlistline: netlistline netlist
				| netlist;

netlist: component EOL
			| EOL;

component: resistor
		| capacitor
		| capacitorIC
		| inductor
		| inductorIC
		| currentsrc
		| voltagesrc
		| vcvs
		| cccs
		| vccs
		| ccvs
		| diode
		| mosfet
		| xsub;

analysis: opanalysis
			| dcanalysis
			| acanalysis
			| trananalysis;

substruct: subdef EOL netlistline SUBEND EOL
				{
				pObj->SetSubEnd();
				};

subdef: subdefname subnodelist subparamlist
				{
				pObj->getLastSubCkt()->SetInnerState();
				};
				
subdefname: SUBDEF variable
				{
				std::shared_ptr< SubCkt > subCktPtr(new SubCkt($2));
				pObj->addSubCkt(subCktPtr);
				};

subnodelist: subnodelist node {pObj->getLastSubCkt()->newNode($2);}
					| node {pObj->getLastSubCkt()->newNode($1);};

subparamlist: subparamlist variable EQN value {pObj->getLastSubCkt()->SetNewParam($2, $4);}
					| variable EQN value {pObj->getLastSubCkt()->SetNewParam($1, $3);}
					| {};

xsub: xsubname xnodelist xparamlist
				{
				pObj->CurrentCkt()->getLastInst()->specifySubCkt();
				};

xnodelist: xnodelist node {pObj->CurrentCkt()->getLastInst()->specifyNode($2);}
				| node {pObj->CurrentCkt()->getLastInst()->specifyNode($1);};

xparamlist: xparamlist variable EQN value {pObj->CurrentCkt()->getLastInst()->specifyParam($2, $4);}
				| variable EQN value {pObj->CurrentCkt()->getLastInst()->specifyParam($1, $3);}
				| {};

xsubname: XSUB
					{
					std::shared_ptr< XSubInst > instPtr(new XSubInst($1));
					pObj->CurrentCkt()->addInst(instPtr);
					};

resistor: RESISTOR node node value
			{
			std::shared_ptr< ResInst > instPtr(new ResInst($1, "__RES%"));
			instPtr->addNode(pObj->CurrentCkt()->newNode($2));
			instPtr->addNode(pObj->CurrentCkt()->newNode($3));
			instPtr->specifyRes($4);
			pObj->CurrentCkt()->addInst(instPtr);
			};

capacitor: CAPACITOR node node value					
			{
			std::shared_ptr< CapInst > instPtr(new CapInst($1, "__CAP%"));
			instPtr->addNode(pObj->CurrentCkt()->newNode($2));
			instPtr->addNode(pObj->CurrentCkt()->newNode($3));
			instPtr->specifyCap($4);
			pObj->CurrentCkt()->addInst(instPtr);
			};

capacitorIC: capacitor value
			{
			pObj->CurrentCkt()->getLastInst()->specifyIC($2);
			};


inductor: INDUCTOR node node value					
			{
			std::shared_ptr< IndInst > instPtr(new IndInst($1, "__IND%"));
			instPtr->addNode(pObj->CurrentCkt()->newNode($2));
			instPtr->addNode(pObj->CurrentCkt()->newNode($3));
			instPtr->specifyInd($4);
			pObj->CurrentCkt()->addInst(instPtr);
			};

inductorIC: inductor value
			{
			pObj->CurrentCkt()->getLastInst()->specifyIC($2);
			};


vcvs: VCVS node node node node value
		{
		std::shared_ptr< VCVSInst > instPtr(new VCVSInst($1, "__VCVS%"));
		instPtr->addNode(pObj->CurrentCkt()->newNode($2));
		instPtr->addNode(pObj->CurrentCkt()->newNode($3));
		instPtr->addNode(pObj->CurrentCkt()->newNode($4));
		instPtr->addNode(pObj->CurrentCkt()->newNode($5));
		instPtr->specifyE($6);
		pObj->CurrentCkt()->addInst(instPtr);
		};

cccs: CCCS node node variable value
		{
		std::shared_ptr< CCCSInst > instPtr(new CCCSInst($1, "__CCCS%"));
		instPtr->addNode(pObj->CurrentCkt()->newNode($2));
		instPtr->addNode(pObj->CurrentCkt()->newNode($3));
		instPtr->specifyCCName($4);
		instPtr->specifyF($5);
		pObj->CurrentCkt()->addInst(instPtr);
		};

vccs: VCCS node node node node value
		{
		std::shared_ptr< VCCSInst > instPtr(new VCCSInst($1, "__VCCS%"));
		instPtr->addNode(pObj->CurrentCkt()->newNode($2));
		instPtr->addNode(pObj->CurrentCkt()->newNode($3));
		instPtr->addNode(pObj->CurrentCkt()->newNode($4));
		instPtr->addNode(pObj->CurrentCkt()->newNode($5));
		instPtr->specifyG($6);
		pObj->CurrentCkt()->addInst(instPtr);
		};

ccvs: CCVS node node variable value
		{
		std::shared_ptr< CCVSInst > instPtr(new CCVSInst($1, "__CCVS%"));
		instPtr->addNode(pObj->CurrentCkt()->newNode($2));
		instPtr->addNode(pObj->CurrentCkt()->newNode($3));
		instPtr->specifyCCName($4);
		instPtr->specifyH($5);
		pObj->CurrentCkt()->addInst(instPtr);
		};

diode: DIODE node node variable
		{
		std::shared_ptr< DiodeInst > instPtr(new DiodeInst($1, $4));
		instPtr->addNode(pObj->CurrentCkt()->newNode($2));
		instPtr->addNode(pObj->CurrentCkt()->newNode($3));
		pObj->CurrentCkt()->addInst(instPtr);
		};

mosfet: MOSFET node node node node variable lpara wpara
		{
		std::shared_ptr< MosInst > instPtr(new MosInst($1, $6));
		instPtr->addNode(pObj->CurrentCkt()->newNode($2));
		instPtr->addNode(pObj->CurrentCkt()->newNode($3));
		instPtr->addNode(pObj->CurrentCkt()->newNode($4));
		instPtr->addNode(pObj->CurrentCkt()->newNode($5));
		instPtr->specifyL($7);
		instPtr->specifyW($8);
		pObj->CurrentCkt()->addInst(instPtr);
		}
		| MOSFET node node node node variable wpara lpara
		{
		std::shared_ptr< MosInst > instPtr(new MosInst($1, $6));
		instPtr->addNode(pObj->CurrentCkt()->newNode($2));
		instPtr->addNode(pObj->CurrentCkt()->newNode($3));
		instPtr->addNode(pObj->CurrentCkt()->newNode($4));
		instPtr->addNode(pObj->CurrentCkt()->newNode($5));
		instPtr->specifyL($8);
		instPtr->specifyW($7);
		pObj->CurrentCkt()->addInst(instPtr);
		};

lpara: L EQN value {$$ = $3;};
wpara: W EQN value {$$ = $3;};

model: modeltype modelparamlist;

modelparamlist: modelparamlist variable EQN value {pObj->getLastModel()->addParam($2, $4);}
						| variable EQN value {pObj->getLastModel()->addParam($1, $3);}
						| {};

modeltype: MODEL variable D
				{
				std::shared_ptr< DiodeModel > modelPtr(new DiodeModel($2));
				pObj->addModel(modelPtr);
				}
				| MODEL variable NMOS
				{
				std::shared_ptr< MosModel > modelPtr(new MosModel($2, MosModel::NMOS));
				pObj->addModel(modelPtr);
				}
				| MODEL variable PMOS
				{
				std::shared_ptr< MosModel > modelPtr(new MosModel($2, MosModel::PMOS));
				pObj->addModel(modelPtr);
				};

voltagesrc: voltagesrcname srcconfig;

voltagesrcname: VOLTAGESRC node node
				{
				std::shared_ptr< VSrcInst > instPtr(new VSrcInst($1, "__VSRC%"));
				instPtr->addNode(pObj->CurrentCkt()->newNode($2));
				instPtr->addNode(pObj->CurrentCkt()->newNode($3));
				pObj->CurrentCkt()->addInst(instPtr);
				};

currentsrc: currentsrcname srcconfig;

currentsrcname: CURRENTSRC node node
				{
				std::shared_ptr< ISrcInst > instPtr(new ISrcInst($1, "__ISRC%"));
				instPtr->addNode(pObj->CurrentCkt()->newNode($2));
				instPtr->addNode(pObj->CurrentCkt()->newNode($3));
				pObj->CurrentCkt()->addInst(instPtr);
				};

srcconfig: dcconfig acconfig tranconfig;

dcconfig: DC value {pObj->CurrentCkt()->getLastInst()->specifyDC($2);}
				| value 	{pObj->CurrentCkt()->getLastInst()->specifyDC($1);}
				| {pObj->CurrentCkt()->getLastInst()->specifyDC(0);};

acconfig: AC value {pObj->CurrentCkt()->getLastInst()->specifyAC($2, 0);}
				| AC value value {pObj->CurrentCkt()->getLastInst()->specifyAC($2, $3);}
				| {pObj->CurrentCkt()->getLastInst()->specifyAC(0, 0);};

tranconfig:	SIN value value value value value
					{
					SrcFunc::TranFuncType type = SrcFunc::Sine;
					vector<double> paramTab(5);
					paramTab[0] = $2; paramTab[1] = $3; paramTab[2] = $4;
					paramTab[3] = $5; paramTab[4] = $6;
					pObj->CurrentCkt()->getLastInst()->specifyFunc(type, paramTab);
					}
					| EXP value value value value value value
					{
					SrcFunc::TranFuncType type = SrcFunc::Exp;
					vector<double> paramTab(6);
					paramTab[0] = $2; paramTab[1] = $3; paramTab[2] = $4;
					paramTab[3] = $5; paramTab[4] = $6; paramTab[5] = $7;
					pObj->CurrentCkt()->getLastInst()->specifyFunc(type, paramTab);
					}
					| PULSE value value value value value value value
					{
					SrcFunc::TranFuncType type = SrcFunc::Pulse;
					vector<double> paramTab(7);
					paramTab[0] = $2; paramTab[1] = $3; paramTab[2] = $4;
					paramTab[3] = $5; paramTab[4] = $6; paramTab[5] = $7;
					paramTab[6] = $8;
					pObj->CurrentCkt()->getLastInst()->specifyFunc(type, paramTab);
					}
					| SFFM value value value value value
					{
					SrcFunc::TranFuncType type = SrcFunc::SFFM;
					vector<double> paramTab(5);
					paramTab[0] = $2; paramTab[1] = $3; paramTab[2] = $4;
					paramTab[3] = $5; paramTab[4] = $6;
					pObj->CurrentCkt()->getLastInst()->specifyFunc(type, paramTab);
					}
					| {};

node: variable
		{
		$$ = new char[strlen($1) + 1];
		strcpy($$, $1); 
		$$[strlen($1)] = '\0';
		}
		| INTEGER
		{
		char s[33];
		sprintf(s, "%d", $1);
		$$ = new char[strlen(s) + 1];
		strcpy($$, s);
		$$[strlen(s)] = '\0';
		};

variable: STRING			{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
	    | W						{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
	    | L							{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
	    | DC						{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
	    | AC						{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
	    | SIN						{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
	    | EXP					{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
	    | PULSE				{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
	    | PWL					{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
	    | SFFM					{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
	    | DEC					{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
	    | LIN						{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
	    | OCT					{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
	    | PMOS					{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
	    | NMOS					{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
	    | D						{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
;

value: VALUE							{$$ = $1;}
	 | FLOAT								{$$ = $1;}
	 | INTEGER							{$$ = $1;};

%%

void yy::SpParser::error(const location &loc, const string &s) 
{
	cerr << "Error at " << loc << ": " << s << endl;
	throw std::runtime_error("Grammar error in netlist.");
}
