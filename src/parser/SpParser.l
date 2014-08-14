/************************************************************
             Lexer for SPICE Parser Template

Author:
   Chen, Jiajun
   Shi, Guoyong
   Hu, Hanbin
 
Used for the course project of "Introduction to EDA", 2014

   School of Micro-electronics
   Shanghai Jiaotong University
************************************************************/

%option noyywrap case-insensitive
%option yylineno

%{
#include "SpParser.hpp"

#define YY_DECL int yylex(yy::SpParser::semantic_type *yylval, yy::SpParser::location_type *yylloc)

namespace yy {
	int column = 1;
    FILE* curFile = yyin;
}

#define YY_USER_ACTION {if(yy::curFile != yyin) { \
                            yylineno = 1; \
                            yy::curFile = yyin; \
                        } \
                        if(yylineno != yylloc->begin.line) yy::column = 0; \
						yylloc->begin.line = yylineno; \
						yylloc->begin.column = yy::column; \
						yy::column = yy::column+yyleng; \
						yylloc->end.column = yy::column; \
						yylloc->end.line = yylineno;}

typedef yy::SpParser::token token;
%}

/* Defining output file name */
%option outfile="SpScanner.cpp"

/* Defining Regular Expressions of the patterns */
COMMENT		[\*][^\n]+
ALPHA				[A-Za-z_]
DIGIT				[0-9]
ALPHANUM		[A-Za-z_0-9]
EQN 					"="
STRING				{ALPHANUM}+
INTEGER			-?{DIGIT}+
FLOAT				-?{DIGIT}+\.{DIGIT}+([Ee][\+-]?{DIGIT}+)?
UNIT					[Ff]|[Pp]|[Nn]|[Uu]|[Mm]|[Kk]|[Mm][Ee][Gg]|[Gg]|[Tt]
VALUE				({FLOAT}|-?{INTEGER}){UNIT}
EOL					[\n]
DELIMITER		[ \t]+
END					^[\.][Ee][Nn][Dd]

RESISTOR			^[Rr]{ALPHANUM}+
CAPACITOR		^[Cc]{ALPHANUM}+
INDUCTOR		^[Ll]{ALPHANUM}+
CURRENTSRC	^[Ii]{ALPHANUM}+
VOLTAGESRC	^[Vv]{ALPHANUM}+
VCVS				^[Ee]{ALPHANUM}+
CCCS				^[Ff]{ALPHANUM}+
VCCS				^[Gg]{ALPHANUM}+
CCVS				^[Hh]{ALPHANUM}+
DIODE				^[Dd]{ALPHANUM}+
MOSFET			^[Mm]{ALPHANUM}+
XSUB				^[Xx]{ALPHANUM}+

SUBDEF			^[\.][Ss][Uu][Bb][Cc][Kk][Tt]
SUBEND			^[\.][Ee][Nn][Dd][Ss]

OPANALYSIS		^[\.][Oo][Pp]
DCANALYSIS		^[\.][Dd][Cc]
ACANALYSIS		^[\.][Aa][Cc]
TRANANALYSIS	^[\.][Tt][Rr][Aa][Nn]

%%

%{
   // start where previous token ended
   yylloc->step ();
%}

{RESISTOR}		{yylval->s = (char*)malloc((strlen(yytext) + 1) * sizeof(char)); 
				 strcpy(yylval->s, yytext);
				 yylval->s[strlen(yytext)] = '\0';
                 return token::RESISTOR;
				}
{CAPACITOR}		{yylval->s = (char*)malloc((strlen(yytext) + 1) * sizeof(char)); 
				 strcpy(yylval->s, yytext);
				 yylval->s[strlen(yytext)] = '\0';
                 return token::CAPACITOR;
				}
{INDUCTOR}		{yylval->s = (char*)malloc((strlen(yytext) + 1) * sizeof(char)); 
				 strcpy(yylval->s, yytext);
				 yylval->s[strlen(yytext)] = '\0';
                 return token::INDUCTOR;
				}
{CURRENTSRC}	{yylval->s = (char*)malloc((strlen(yytext) + 1) * sizeof(char)); 
				 strcpy(yylval->s, yytext);
				 yylval->s[strlen(yytext)] = '\0';
                 return token::CURRENTSRC;
				}
{VOLTAGESRC}	{yylval->s = (char*)malloc((strlen(yytext) + 1) * sizeof(char)); 
				 strcpy(yylval->s, yytext);
				 yylval->s[strlen(yytext)] = '\0';
                 return token::VOLTAGESRC;
				}
{VCVS}			{yylval->s = (char*)malloc((strlen(yytext) + 1) * sizeof(char)); 
				 strcpy(yylval->s, yytext);
				 yylval->s[strlen(yytext)] = '\0';
                 return token::VCVS;
				}
{VCCS}			{yylval->s = (char*)malloc((strlen(yytext) + 1) * sizeof(char)); 
				 strcpy(yylval->s, yytext);
				 yylval->s[strlen(yytext)] = '\0';
                 return token::VCCS;
				}
{CCCS}			{yylval->s = (char*)malloc((strlen(yytext) + 1) * sizeof(char)); 
				 strcpy(yylval->s, yytext);
				 yylval->s[strlen(yytext)] = '\0';
                 return token::CCCS;
				}
{CCVS}			{yylval->s = (char*)malloc((strlen(yytext) + 1) * sizeof(char)); 
				 strcpy(yylval->s, yytext);
				 yylval->s[strlen(yytext)] = '\0';
                 return token::CCVS;
				}
{DIODE}			{yylval->s = (char*)malloc((strlen(yytext) + 1) * sizeof(char)); 
				 strcpy(yylval->s, yytext);
				 yylval->s[strlen(yytext)] = '\0';
                 return token::DIODE;
				}
{MOSFET}		{yylval->s = (char*)malloc((strlen(yytext) + 1) * sizeof(char)); 
				 strcpy(yylval->s, yytext);
				 yylval->s[strlen(yytext)] = '\0';
                 return token::MOSFET;
				}
{XSUB}			{yylval->s = (char*)malloc((strlen(yytext) + 1) * sizeof(char)); 
				 strcpy(yylval->s, yytext);
				 yylval->s[strlen(yytext)] = '\0';
                 return token::XSUB;
				}

{SUBDEF} {return token::SUBDEF;}
{SUBEND} {return token::SUBEND;}

{OPANALYSIS}		{return token::OPANALYSIS;}
{DCANALYSIS}		{return token::DCANALYSIS;}
{ACANALYSIS}		{return token::ACANALYSIS;}
{TRANANALYSIS}	{return token::TRANANALYSIS;}

{INTEGER}		{yylval->n = atoi(yytext); return token::INTEGER;}
{FLOAT}			{yylval->f = atof(yytext); return token::FLOAT;}
{VALUE}			{double value;
				 value = atof(yytext);
				 int len = strlen(yytext);
				 char u = yytext[len - 1];
				 if (u == 'F' || u == 'f')
					yylval->f = value * 1e-15;
                 else if (u == 'P' || u == 'p')
					yylval->f = value * 1e-12;
				 else if (u == 'N' || u == 'n')
					yylval->f = value * 1e-9;
				 else if (u == 'U' || u == 'u')
					yylval->f = value * 1e-6;
				 else if (u == 'M' || u == 'm')
					yylval->f = value * 1e-3;
				 else if (u == 'K' || u == 'k')
					yylval->f = value * 1e3;
				 else if (u == 'G' || u == 'g')
			     {
					if (yytext[len - 2] == 'E' | yytext[len - 2] == 'e')
						yylval->f = value * 1e6;
					else
						yylval->f = value * 1e9;
				 }
				 else if (u == 'T' | u == 't')
					yylval->f = value * 1e12;
				 else
					yylval->f = value;
				 return token::VALUE;
				}
{STRING}	{yylval->s = (char*)malloc((strlen(yytext) + 1) * sizeof(char)); 
				 strcpy(yylval->s, yytext);
				 yylval->s[strlen(yytext)] = '\0';
                 if(!strcasecmp(yylval->s, "L")) {return token::L;}
                 if(!strcasecmp(yylval->s, "W")) {return token::W;}
                 if(!strcasecmp(yylval->s, "DC")) {return token::DC;}
                 if(!strcasecmp(yylval->s, "AC")) {return token::AC;}
                 if(!strcasecmp(yylval->s, "SIN")) {return token::SIN;}
                 if(!strcasecmp(yylval->s, "EXP")) {return token::EXP;}
                 if(!strcasecmp(yylval->s, "PULSE")) {return token::PULSE;}
                 if(!strcasecmp(yylval->s, "SFFM")) {return token::SFFM;}
                 if(!strcasecmp(yylval->s, "DEC")) {return token::DEC;}
                 if(!strcasecmp(yylval->s, "OCT")) {return token::OCT;}
                 if(!strcasecmp(yylval->s, "LIN")) {return token::LIN;}
                 return token::STRING;
			    }

{EOL}				{return token::EOL;}
{EQN}				{return token::EQN;}
<<EOF>>		{yyterminate();}
{DELIMITER}	{yylloc->step();}
{COMMENT}	{yylloc->step();}
{END}				{return token::END;}

%%
