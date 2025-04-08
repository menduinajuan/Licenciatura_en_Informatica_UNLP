{TRABAJO PRÁCTICO N° 1.1}
{EJERCICIO 8}
{Realizar un programa que lea tres caracteres e informe si los tres eran letras vocales o si, al menos, uno de ellos no lo era.
Por ejemplo, si se leen los caracteres “a e o”, deberá informar “Los tres caracteres son vocales” y, si se leen los caracteres “z a g”, deberá informar “Al menos un caracter no era vocal”.}

program TP1_E8;
{$codepage UTF8}
uses crt;
const
  caracteres_total=3;
  vocales_corte=3;
var
  caracteres, vocales: int8;
  c: char;
begin
  caracteres:=0; vocales:=0;
  while (caracteres<caracteres_total) do
  begin
    textcolor(green); write('Introducir caracter: ');
    textcolor(yellow); readln(c);
    if ((c='A') or (c='E') or (c='I') or (c='O') or (c='U') or (c='a') or (c='e') or (c='i') or (c='o') or (c='u')) then
      vocales:=vocales+1;
    caracteres:=caracteres+1;
  end;
  if (vocales=vocales_corte) then
  begin
    textcolor(red); write('Los tres caracteres son vocales');
  end
  else
  begin
    textcolor(red); write('Al menos un caracter no es vocal');
  end;
end.