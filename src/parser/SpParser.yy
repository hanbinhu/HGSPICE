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
%parse-param {Ckt* pObj}

/* assigning data type for tokens and patterns */
%token<n> INTEGER
%token<f> FLOAT VALUE
%token<s> STRING
%token<s> RESISTOR CAPACITOR INDUCTOR VCVS CCCS VCCS CCVS DIODE MOSFET
%token<s> CURRENTSRC VOLTAGESRC
%token<s> DC AC SIN PULSE EXP PWL SFFM
%token<s> L W
%token OPANALYSIS DCANALYSIS ACANALYSIS TRANANALYSIS

%token EQN END EOL

%type<s> resistor capacitor inductor vcvs cccs vccs ccvs diode mosfet
%type<s> currentsrc voltagesrc
%type<s> node model variable
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


spice: netlist end
;

opanalysis: OPANALYSIS
		  {
			pObj -> ParseAnaOP();
		  }
;

dcanalysis: DCANALYSIS variable value value value
	      {
			 pObj -> ParseAnaDC($2,$3,$4,$5);
		  }
;

acanalysis: ACANALYSIS variable INTEGER value value
			{
				pObj -> ParseAnaAC($2,$3,$4,$5);
			}
;

trananalysis: TRANANALYSIS value value
		      {
				pObj -> ParseAnaTRAN($2,$3);
			  }
			| TRANANALYSIS value value value
			  {
				 pObj -> ParseAnaTRAN($2,$3,$4);
			  }
;

end: end EOL
   | END EOL
   | END
;

netlist: netlist line
       | line
;

line: component EOL
	| error EOL
	| EOL
;

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
		| opanalysis
		| dcanalysis
		| acanalysis
		| trananalysis
;


resistor: RESISTOR node node value
			{
			std::shared_ptr< ResInst > instPtr(new ResInst($1, "__RES%"));
			instPtr->addNode(pObj->newNode($2));
			instPtr->addNode(pObj->newNode($3));
			instPtr->specifyRes($4);
			pObj->addInst(instPtr);
			};

capacitor: CAPACITOR node node value					
			{
			std::shared_ptr< CapInst > instPtr(new CapInst($1, "__CAP%"));
			instPtr->addNode(pObj->newNode($2));
			instPtr->addNode(pObj->newNode($3));
			instPtr->specifyCap($4);
			pObj->addInst(instPtr);
			};

capacitorIC: capacitor value
			{
			pObj->getLastInst()->specifyIC($2);
			};


inductor: INDUCTOR node node value					
			{
			std::shared_ptr< IndInst > instPtr(new IndInst($1, "__IND%"));
			instPtr->addNode(pObj->newNode($2));
			instPtr->addNode(pObj->newNode($3));
			instPtr->specifyInd($4);
			pObj->addInst(instPtr);
			};

inductorIC: inductor value
			{
			pObj->getLastInst()->specifyIC($2);
			};


vcvs: VCVS node node node node value
		{
		std::shared_ptr< VCVSInst > instPtr(new VCVSInst($1, "__VCVS%"));
		instPtr->addNode(pObj->newNode($2));
		instPtr->addNode(pObj->newNode($3));
		instPtr->addNode(pObj->newNode($4));
		instPtr->addNode(pObj->newNode($5));
		instPtr->specifyE($6);
		pObj->addInst(instPtr);
		};

cccs: CCCS node node variable value
		{
		std::shared_ptr< CCCSInst > instPtr(new CCCSInst($1, "__CCCS%"));
		instPtr->addNode(pObj->newNode($2));
		instPtr->addNode(pObj->newNode($3));
		instPtr->specifyCCName($4);
		instPtr->specifyF($5);
		pObj->addInst(instPtr);
		};

vccs: VCCS node node node node value
		{
		std::shared_ptr< VCCSInst > instPtr(new VCCSInst($1, "__VCCS%"));
		instPtr->addNode(pObj->newNode($2));
		instPtr->addNode(pObj->newNode($3));
		instPtr->addNode(pObj->newNode($4));
		instPtr->addNode(pObj->newNode($5));
		instPtr->specifyG($6);
		pObj->addInst(instPtr);
		};

ccvs: CCVS node node variable value
		{
		std::shared_ptr< CCVSInst > instPtr(new CCVSInst($1, "__CCVS%"));
		instPtr->addNode(pObj->newNode($2));
		instPtr->addNode(pObj->newNode($3));
		instPtr->specifyCCName($4);
		instPtr->specifyH($5);
		pObj->addInst(instPtr);
		};

diode: DIODE node node model
	   {
		   pObj->ParseDiode($1, $2, $3, $4);
	   }
;

mosfet: MOSFET node node node node model lpara wpara
		{
			pObj -> ParseMOS($1, $2, $3, $4, $5, $6, $7, $8);
	    }
	  | MOSFET node node node node model wpara lpara
	    {
			pObj -> ParseMOS($1, $2, $3, $4, $5, $6, $8, $7);
		}
;

lpara: L EQN value {$$ = $3;};
wpara: W EQN value {$$ = $3;};

voltagesrc: voltagesrcname srcconfig;

voltagesrcname: VOLTAGESRC node node
				{
				std::shared_ptr< ISrcInst > instPtr(new ISrcInst($1, "__VSRC%"));
				instPtr->addNode(pObj->newNode($2));
				instPtr->addNode(pObj->newNode($3));
				pObj->addInst(instPtr);
				};

currentsrc: currentsrcname srcconfig;

currentsrcname: CURRENTSRC node node
				{
				std::shared_ptr< ISrcInst > instPtr(new ISrcInst($1, "__ISRC%"));
				instPtr->addNode(pObj->newNode($2));
				instPtr->addNode(pObj->newNode($3));
				pObj->addInst(instPtr);
				};

srcconfig: dcconfig acconfig tranconfig;

dcconfig: DC value {pObj->getLastInst()->specifyDC($2);}
				| value 	{pObj->getLastInst()->specifyDC($1);}
				| {pObj->getLastInst()->specifyDC(0);};

acconfig: AC value {pObj->getLastInst()->specifyAC($2, 0);}
				| AC value value {pObj->getLastInst()->specifyAC($2, $3);}
				| {pObj->getLastInst()->specifyAC(0, 0);};

tranconfig:	SIN value value value value value
					{
					SrcFunc::TranFuncType type = SrcFunc::Sine;
					vector<double> paramTab(5);
					paramTab[0] = $2; paramTab[1] = $3; paramTab[2] = $4;
					paramTab[3] = $5; paramTab[4] = $6;
					pObj->getLastInst()->specifyFunc(type, paramTab);
					}
					| EXP value value value value value value
					{
					SrcFunc::TranFuncType type = SrcFunc::Exp;
					vector<double> paramTab(6);
					paramTab[0] = $2; paramTab[1] = $3; paramTab[2] = $4;
					paramTab[3] = $5; paramTab[4] = $6; paramTab[5] = $7;
					pObj->getLastInst()->specifyFunc(type, paramTab);
					}
					| PULSE value value value value value value value
					{
					SrcFunc::TranFuncType type = SrcFunc::Pulse;
					vector<double> paramTab(7);
					paramTab[0] = $2; paramTab[1] = $3; paramTab[2] = $4;
					paramTab[3] = $5; paramTab[4] = $6; paramTab[5] = $7;
					paramTab[6] = $8;
					pObj->getLastInst()->specifyFunc(type, paramTab);
					}
					| SFFM value value value value value
					{
					SrcFunc::TranFuncType type = SrcFunc::SFFM;
					vector<double> paramTab(5);
					paramTab[0] = $2; paramTab[1] = $3; paramTab[2] = $4;
					paramTab[3] = $5; paramTab[4] = $6;
					pObj->getLastInst()->specifyFunc(type, paramTab);
					}
					| {};

model: variable;

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
	  }
;

variable: STRING			{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
	    | RESISTOR			{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
	    | CAPACITOR			{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
        | INDUCTOR 			{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
	    | CURRENTSRC  	{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
	    | VOLTAGESRC		{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
	    | VCVS					{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
	    | CCCS					{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
	    | VCCS					{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
	    | CCVS					{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
	    | DIODE				{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
	    | MOSFET				{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
	    | W						{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
	    | L							{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
	    | DC						{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
	    | AC						{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
	    | SIN						{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
	    | EXP					{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
	    | PULSE				{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
	    | PWL					{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
	    | SFFM					{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
;

value: VALUE										{$$ = $1;}
	 | FLOAT										{$$ = $1;}
     | INTEGER										{$$ = $1;}
;

%%

void yy::SpParser::error(const location &loc, const string &s) 
{
	cerr << "Error at " << loc << ": " << s << endl;
	throw std::runtime_error("Grammar error in netlist.");
}
