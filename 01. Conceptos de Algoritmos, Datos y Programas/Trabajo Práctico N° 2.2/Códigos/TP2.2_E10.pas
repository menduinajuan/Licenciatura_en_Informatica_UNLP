{TRABAJO PRÁCTICO N° 2.2}
{EJERCICIO 10}
{Realizar un programa modularizado que lea una secuencia de caracteres y verifique si cumple con el patrón A$B#, donde:
•	A es una secuencia de sólo letras vocales.
•	B es una secuencia de sólo caracteres alfabéticos sin letras vocales.
•	Los caracteres $ y # seguro existen.
Nota: En caso de no cumplir, informar qué parte del patrón no se cumplió.}

program TP2_E10;
{$codepage UTF8}
uses crt;
const
  caracter_corte1='$'; caracter_corte2='#';
function es_vocal(c: char): boolean;
begin
  es_vocal:=(c='A') or (c='E') or (c='I') or (c='O') or (c='U') or (c='a') or (c='e') or (c='i') or (c='o') or (c='u');
end;
function cumple_secuenciaA(cumple: boolean): boolean;
var
  c: char;
begin
  textcolor(green); writeln('Introducir caracter de la secuencia A:');
  textcolor(yellow); readln(c);
  while ((c<>caracter_corte1) and (cumple=true)) do
  begin
    if (es_vocal(c)=false) then
      cumple:=false
    else
    begin
      textcolor(yellow); readln(c);
    end;
  end;
  cumple_secuenciaA:=cumple;
end;
function cumple_secuenciaB(cumple: boolean): boolean;
var
  c: char;
begin
  textcolor(green); writeln('Introducir caracter de la secuencia B:');
  textcolor(yellow); readln(c);
  while ((c<>caracter_corte2) and (cumple=true)) do
  begin
    if (es_vocal(c)=true) then
      cumple:=false
    else
    begin
      textcolor(yellow); readln(c);
    end;
  end;
  cumple_secuenciaB:=cumple;
end;
var
  cumple: boolean;
begin
  cumple:=true;
  cumple:=cumple_secuenciaA(cumple);
  if (cumple=true) then
  begin
    cumple:=cumple_secuenciaB(cumple);
    if (cumple=true) then
    begin
      textcolor(red); write('La secuencia cumple con el patrón A$B#');
    end
    else
    begin
      textcolor(red); write('La secuencia no cumple con la parte B del patrón A$B#');
    end;
  end
  else
  begin
    textcolor(red); write('La secuencia no cumple con la parte A del patrón A$B#');
  end;
end.

{program TP2_E10;}
{$codepage UTF8}
{uses crt;
const
  caracter_corte1='$'; caracter_corte2='#';
function leer_secuencia(secuencia: string): string;
begin
  textcolor(green); write('Introducir secuencia de caracteres: ');
  textcolor(yellow); readln(secuencia);
  leer_secuencia:=secuencia;
end;
function es_vocal(c: char): boolean;
begin
  es_vocal:=(c='A') or (c='E') or (c='I') or (c='O') or (c='U') or (c='a') or (c='e') or (c='i') or (c='o') or (c='u');
end;
procedure parseo_string(var cumple_A, cumple_B: boolean);
var
  i: int8;
  secuencia: string;
begin
  secuencia:='';
  secuencia:=leer_secuencia(secuencia);
  i:=1;
  while (secuencia[i]<>caracter_corte1) do
  begin
    cumple_A:=cumple_A and (es_vocal(secuencia[i])=true);
    i:=i+1;
  end;
  i:=i+1;
  while (secuencia[i]<>caracter_corte2) do
  begin
    cumple_B:=cumple_B and (es_vocal(secuencia[i])=false);
    i:=i+1;
  end;
end;
var
  cumple_A, cumple_B: boolean;
begin
  cumple_A:=true; cumple_B:=true;
  parseo_string(cumple_A,cumple_B);
  if ((cumple_A=true) and (cumple_B=true)) then
  begin
    textcolor(red); write('La secuencia cumple con el patrón A$B#');
  end
  else if ((cumple_A=false) and (cumple_B=true)) then
  begin
    textcolor(red); write('La secuencia no cumple con la parte A del patrón A$B#');
  end
  else if ((cumple_A=true) and (cumple_B=false)) then
  begin
    textcolor(red); write('La secuencia no cumple con la parte B del patrón A$B#');
  end
  else
  begin
    textcolor(red); write('La secuencia no cumple con las partes A y B del patrón A$B#');
  end;
end.}