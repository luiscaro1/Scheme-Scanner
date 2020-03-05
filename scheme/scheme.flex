
%%
%class scheme
%standalone
%line
%column

LineTerminator=\r|\n|\r\n

InputCharacter =[^\r\n]

Whitespace={LineTerminator}|[\s\t\f]

Comment=;.*(.*)?(.*)

Keyword="let-syntax"|"letrec-syntax"|"quote"|"lambda"|"if"|"set!"|"and"|"begin"|"case"|"cond"|"delay"|"do"|"let"|"let*"|"letrec"|"quasiquote"|"null"|"define"|"display"

Identifier={Initial}{Subsequent}*|\+|\-|\.\.\.

Initial={Letter}|"!"|"$"|"%"|"&"|"*"|"/"|":"|"<"|">"|"?"|"~"|"_"|"^"|"="

Subsequent={Initial}|{Digit}|\.|\+|\-

Letter=[a-zA-z0]

Digit=[0-9]

Empty=""

Boolean=#t|f|T|F

Number={Num2}|{Num8}|{Num10}|{Num16}

Character=#\\[^\r\n]

String=\"(([^\"]|\\\")*[^\\])?\"

Num2={Prefix2}{Complex2}

Complex2={Real2}|{Real2}@{Real2}|{Real2}+{Imag2}|{Real2}"-"{Imag2}|"+"{Imag2}|"-"{Imag2}

Imag2=i|{UReal2}i

Real2={Sign}{UReal2}

UReal2={UInteger2}|{UInteger2}"/"{UInteger2}

UInteger2={Digit2}+#*

Prefix2={Radix2}{Exactness}|{Exactness}{Radix2}

Num8={Prefix8}{Complex8}

Complex8={Real8}|{Real8}@{Real8}|{Real8}+{Imag8}|{Real8}"-"{Imag8}|"+"{Imag8}|"-"{Imag8}

Imag8=i|{UReal8}i

Real8={Sign}{UReal8}

UReal8={UInteger8}|{UInteger8}"/"{UInteger8}

UInteger8={Digit8}+#*

Prefix8={Radix8}{Exactness}|{Exactness}{Radix8}

Num10={Prefix10}{Complex10}

Complex10={Real10}|{Real10}@{Real10}|{Real10}+{Imag10}|{Real10}\-{Imag10}|\+{Imag10}|\-{Imag10}
Imag10=i|{UReal10}i

Real10={Sign}{UReal10}

UReal10={UInteger10}|{UInteger10}"/"{UInteger10}|{Decimal10}

UInteger10={Digit10}+#*

Prefix10={Radix10}{Exactness}|{Exactness}{Radix10}

Decimal10={UInteger10}{Exponent}|\.{Digit10}+#*{Suffix}|{Digit10}+\.{Digit10}*#*{Suffix}|{Digit10}+#+}\.#*{Suffix}|{Digit10}+#+\.#*{Suffix}

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




<YYINITIAL> {

  {Number} {
      System.out.println("NUMBER \""+yytext()+"\" at line "+yyline+", column "+yycolumn );
  }

{Keyword} {
    System.out.println("KEYWORD \""+yytext()+"\" at line "+yyline+", column "+yycolumn );
}

  "(" {  System.out.println("LP \""+yytext()+"\" at line "+yyline+", column "+yycolumn );}
  ")" {  System.out.println("RP \""+yytext()+"\" at line "+yyline+", column "+yycolumn );}
  "[" {  System.out.println("LSB \""+yytext()+"\" at line "+yyline+", column "+yycolumn );}
  "]" {  System.out.println("RSB \""+yytext()+"\" at line "+yyline+", column "+yycolumn );}
  "`" {  System.out.println("DIACRITIC \""+yytext()+"\" at line "+yyline+", column "+yycolumn );}
  "#" {}
  "'" {  System.out.println("SQ \""+yytext()+"\" at line "+yyline+", column "+yycolumn );}

{Identifier} {
  System.out.println("IDENTIFIER \""+yytext()+"\" at line "+yyline+", column "+yycolumn );
}

{Comment} {
      System.out.println("COMMENT \""+yytext()+"\" at line "+yyline+", column "+yycolumn );
}

{Whitespace} {}
    //Do nothing
}
{Boolean} {
    System.out.println("BOOL \""+yytext()+"\" at line "+yyline+", column "+yycolumn );
}

{String} {
    System.out.println("STR \""+yytext()+"\" at line "+yyline+", column "+yycolumn );
}

{Character} {
    System.out.println("CHAR \""+yytext()+"\" at line "+yyline+", column "+yycolumn );
}
\. {System.out.println("DOT \""+yytext()+"\" at line "+yyline+", column "+yycolumn); }
"@" {  System.out.println("AT \""+yytext()+"\" at line "+yyline+", column "+yycolumn );}
"," {  System.out.println("COMMA \""+yytext()+"\" at line "+yyline+", column "+yycolumn );}

[^] { throw new RuntimeException("Illegal character \""+yytext()+
                                                                  "\" at line "+yyline+", column "+yycolumn); }
