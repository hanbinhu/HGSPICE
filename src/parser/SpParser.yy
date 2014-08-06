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
#include <stdio.h>
#include <cstdlib>
#include <cstring>
#include <string>

using std::cerr;
using std::endl;
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
%token OPANALYSIS DCANALYSIS ACANALYSIS TRANANALYSIS
%token L W
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

dcanalysis: DCANALYSIS VOLTAGESRC value value value
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
		 | inductor
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
			 pObj->ParseRes($1, $2, $3, $4);
		  }
;

capacitor: CAPACITOR node node value					
           {
              pObj->ParseCap($1, $2, $3, $4);
		   }
		 | CAPACITOR node node value value
		   {
		   	  pObj->ParseCap($1, $2, $3, $4, $5);
		   }
;		
	
inductor: INDUCTOR node node value  				
		  {
			  pObj->ParseInd($1, $2, $3, $4);
		  }
		| INDUCTOR node node value value
		  {
		  	  pObj->ParseInd($1, $2, $3, $4, $5);
		  }
;

vcvs: VCVS node node node node value
	  {
		  pObj->ParseVCVS($1, $2, $3, $4, $5, $6);
	  }
;
cccs: CCCS node node VOLTAGESRC value
	  {
		  pObj->ParseCCCS($1, $2, $3, $4, $5);
	  }
;
vccs: VCCS node node node node value
	  {
		  pObj->ParseVCCS($1, $2, $3, $4, $5, $6);
	  }
;
ccvs: CCVS node node VOLTAGESRC value
	  {
		  pObj->ParseCCVS($1, $2, $3, $4, $5);
	  }
;
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

voltagesrc: VOLTAGESRC node node value						
            {
		    	pObj->ParseVsrc($1, $2, $3, $4);
			}
;

currentsrc: CURRENTSRC node node value						
            {
				pObj->ParseIsrc($1, $2, $3, $4);
			}
;

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

variable: STRING				{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
	    | RESISTOR				{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
	    | CAPACITOR				{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
        | INDUCTOR 				{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
	    | CURRENTSRC  			{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
	    | VOLTAGESRC			{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
	    | VCVS					{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
	    | CCCS					{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
	    | VCCS					{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
	    | CCVS					{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
	    | DIODE					{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
	    | MOSFET				{$$ = new char[strlen($1) + 1]; strcpy($$, $1); $$[strlen($1)] = '\0';}
;

value: VALUE										{$$ = $1;}
	 | FLOAT										{$$ = $1;}
     | INTEGER										{$$ = $1;}
;

%%

void yy::SpParser::error(const location &loc, const string &s) 
{
	cerr << "error at " << loc << ": " << s << endl;
}
