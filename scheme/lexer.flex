%%
%class lexer
%standalone
%line
%column

LineTerminator=\r|\n|\r\n

InputCharacter =[^\r\n]

Whitespace={LineTerminator}|[\s\t\f]

Comment=;.*(.*)?(.*)

Empty=""
Program ={Form}*
/*
Form={Definition}|{Expression} */

Definition={VariableDefinition}|{SyntaxBinding}|\(begin.*\)|\(let-syntax\({SyntaxBinding}*\).*\)|\(letrc-syntax\( {SyntaxBinding}*\).*\)

VariableDefinition=\({Variable}{Expression}\)|\(\({Variable}{Variable}*\).*\)|\(({Variable}{Variable}*"."{Variable}).*\)

Variable={Identifier}

Body={Definition}*{Expression}+

 SyntaxDefinition= \(.*\)

Keyword={Identifier}

SyntaxBinding=\({Keyword}.*\)
/**Expression****************************************************************************************/
Expression={Constant}|{Variable}\(quote{Datum}\)*|'{Datum}|\(lambda{Formals}.*\)|\(if.*\)|\(set!.*\)|.*|\(let-syntax\({SyntaxBinding}*\).*+\)|\(letrecsyntax\({SyntaxBinding}*\).*+\)

Constant={Boolean}|{Numbers}|{Character}|{String}

Formals={Variable}|\({Variable}*\)|\({Variable}+\.{Variable}\)

Application=\({Expression}{Expression}*\)\


/* Identifier ********************************************************************************************************/

Identifier={Initial}{Subsequent}*|[+-...]

Initial={Letter}|"!"|"$"|%|"&"|"*"|"/"|":"|"<"|">"|"?"|"~"|"_"|"^"

Subsequent={Initial}|{Digit}|\.|\+|\-

Letter=[a-zA-z0]

Digit=[0-9]


/* Datum **************************************************************************************************************/

Datum={Boolean}|{Numbers}|{Character}|{String}|{Symbol}


Boolean=#t|#f

Numbers={Num2}|{Num8}|{Num10}|{Num16}

Character=#.|{Whitespace}|\n

String=\"(([^\"]|\\\")*[^\\])?\"

Symbol={Identifier}

List=\(.*\)|\(+".".*\)|{Abbreviation}

Abbreviation='{Datum}|'{Datum}|,{Datum}|,@{Datum}

Vector=#\({Datum}\)




/*** Numberss ***********************************************************************************************************/

/*
Base 2
*/

Num2={Prefix2}{Complex2}

Complex2={Real2}|{Real2}@{Real2}|{Real2}+{Imag2}|{Real2}"-"{Imag2}|"+"{Imag2}|"-"{Imag2}

Imag2=i|{UReal2}i

Real2={Sign}{UReal2}

UReal2={UInteger2}|{UInteger2}"/"{UInteger2}

UInteger2={Digit2}+#*

Prefix2={Radix2}{Exactness}|{Exactness}{Radix2}
/*
Base 8
*/

Num8={Prefix8}{Complex8}

Complex8={Real8}|{Real8}@{Real8}|{Real8}+{Imag8}|{Real8}"-"{Imag8}|"+"{Imag8}|"-"{Imag8}

Imag8=i|{UReal8}i

Real8={Sign}{UReal8}

UReal8={UInteger8}|{UInteger8}"/"{UInteger8}

UInteger8={Digit8}+#*

Prefix8={Radix8}{Exactness}|{Exactness}{Radix8}



/*
Base 10
*/

Num10={Prefix10}{Complex10}

Complex10={Real10}|{Real10}@{Real10}|{Real10}+{Imag10}|{Real10}\-{Imag10}|\+{Imag10}|\-{Imag10}
Imag10=i|{UReal10}i


Real10={Sign}{UReal10}

UReal10={UInteger10}|{UInteger10}"/"{UInteger10}|{Decimal10}

UInteger10={Digit10}+#*

Prefix10={Radix10}{Exactness}|{Exactness}{Radix10}

Decimal10={UInteger10}{Exponent}|\.{Digit10}+#*{Suffix}|{Digit10}+\.{Digit10}*#*{Suffix}|{Digit10}+#+}\.#*{Suffix}|{Digit10}+#+\.#*{Suffix}


/*
Base 16
*/

Num16={Prefix16}{Complex16}

Complex16={Real16}|{Real16}@{Real16}|{Real16}+{Imag16}|{Real16}\-{Imag16}|\+{Imag16}|\-{Imag16}
Imag16=i|{UReal16}i


Real16={Sign}{UReal16}

UReal16={UInteger16}|{UInteger16}"/"{UInteger16}

UInteger16={Digit16}+#*

Prefix16={Radix16}{Exactness}|{Exactness}{Radix16}


Suffix={Empty}|{Exponent}

Exponent={ExponentMarker}{Sign}{Digit10}+

ExponentMarker=e|s|f|d|l

Sign={Empty}|\+|\-

Exactness={Empty}|#i|#e

Radix2=#b

Radix8=#o

Radix10={Empty}|#d

Radix16=#x

Digit2=0|1

Digit8=[0-7]

Digit10={Digit}

Digit16={Digit}|[a-f]

%%

/* {Program} {
  //Do nothing
} */
/*
{Expression} {
  //Do nothing
}

{Identifier} {
  //Do nothing
}
{Datum} {
  //Do nothing
}
{Numbers} {
  //Do nothing
} */

{Definition} {
  System.out.printf("*** found code [%s] at line %d, column %d\n",yytext(),yyline,yycolumn);
}


. {
    System.out.printf("*** Cannot scan code [%s] at line %d, column %d\n",yytext(),yyline,yycolumn);
}
