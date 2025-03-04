{TRABAJO PRÁCTICO N° 2.2}
{EJERCICIO 11}
{Realizar un programa modularizado que lea una secuencia de caracteres y verifique si cumple con el patrón A%B*, donde:
•	A es una secuencia de caracteres en la que no existe el carácter ‘$’.
•	B es una secuencia con la misma cantidad de caracteres que aparecen en A y en la que aparece, a lo sumo, 3 veces el carácter ‘@’.
•	Los caracteres % y * seguro existen.
Nota: En caso de no cumplir, informar que parte del patrón no se cumplió.}

program TP2_E11;
{$codepage UTF8}
uses crt;
const
  caracter_corte1='%'; caracter_corte2='*';
  caracter_corte3='$';
  caracter_corte4='@'; cantidad_caracter_corte4=3;
procedure cumple_secuenciaA(var cumple: boolean; var caracteresA: int8);
var
  c: char;
begin
  textcolor(green); writeln('Introducir caracter de la secuencia A:');
  textcolor(yellow); readln(c);
  while ((c<>caracter_corte1) and (cumple=true)) do
  begin
    if (c=caracter_corte3) then
      cumple:=false
    else
    begin
      caracteresA:=caracteresA+1;
      textcolor(yellow); readln(c);
    end;
  end;
end;
procedure cumple_secuenciaB(var cumple: boolean; caracteresA: int8);
var
  caracteresB, caracteres_corte4: int8;
  c: char;
begin
  caracteresB:=0; caracteres_corte4:=0;
  textcolor(green); writeln('Introducir caracter de la secuencia B:');
  textcolor(yellow); readln(c);
  while ((c<>caracter_corte2) and (cumple=true)) do
  begin
    caracteresB:=caracteresB+1; 
    if (c=caracter_corte4) then
      caracteres_corte4:=caracteres_corte4+1;
    if ((caracteresB>caracteresA) or (caracteres_corte4>cantidad_caracter_corte4)) then
      cumple:=false
    else
    begin
      textcolor(yellow); readln(c);
    end;
  end;
end;
var
  cumple: boolean;
  caracteresA: int8;
begin
  cumple:=true; caracteresA:=0;
  cumple_secuenciaA(cumple,caracteresA);
  if (cumple=true) then
  begin
    cumple_secuenciaB(cumple,caracteresA);
    if (cumple=true) then
    begin
      textcolor(red); write('La secuencia cumple con el patrón A%B*');
    end
    else
    begin
      textcolor(red); write('La secuencia no cumple con la parte B del patrón A%B*');
    end;
  end
  else
  begin
    textcolor(red); write('La secuencia no cumple con la parte A del patrón A%B*');
  end;
end.

{program TP2_E11;}
{$codepage UTF8}
{uses crt;
const
  caracter_corte1='%'; caracter_corte2='*';
  caracter_corte3='$';
  caracter_corte4='@'; cantidad_caracter_corte4=3;
function leer_secuencia(secuencia: string): string;
begin
  textcolor(green); write('Introducir secuencia de caracteres: ');
  textcolor(yellow); readln(secuencia);
  leer_secuencia:=secuencia;
end;
procedure parseo_string(var cumple_A, cumple_B: boolean);
var
  i, j, caracteres: int8;
  secuencia: string;
begin
  secuencia:='';
  secuencia:=leer_secuencia(secuencia);
  caracteres:=0;
  i:=1;
  while (secuencia[i]<>caracter_corte1) do
  begin
    cumple_A:=cumple_A and (secuencia[i]<>caracter_corte3);
    i:=i+1;
  end;
  j:=i+1;
  while (secuencia[j]<>caracter_corte2) do
  begin
    if (secuencia[j]=caracter_corte4) then
      caracteres:=caracteres+1;
    cumple_B:=cumple_B and (caracteres<=cantidad_caracter_corte4);
    j:=j+1;
  end;
  cumple_B:=cumple_B and (j/2=i);
end;
var
  cumple_A, cumple_B: boolean;
begin
  cumple_A:=true; cumple_B:=true;
  parseo_string(cumple_A,cumple_B);
  if ((cumple_A=true) and (cumple_B=true)) then
  begin
    textcolor(red); write('La secuencia cumple con el patrón A%B*');
  end
  else if ((cumple_A=false) and (cumple_B=true)) then
  begin
    textcolor(red); write('La secuencia no cumple con la parte A del patrón A%B*');
  end
  else if ((cumple_A=true) and (cumple_B=false)) then
  begin
    textcolor(red); write('La secuencia no cumple con la parte B del patrón A%B*');
  end
  else
  begin
    textcolor(red); write('La secuencia no cumple con las partes A y B del patrón A%B*');
  end;
end.}