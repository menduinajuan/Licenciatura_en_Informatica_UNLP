{TRABAJO PRÁCTICO N° 4.1}
{EJERCICIO 7}
{Realizar un programa que lea números enteros desde teclado hasta que se ingrese el valor -1 (que no debe procesarse) e informe:
•	La cantidad de ocurrencias de cada dígito procesado.
•	El dígito más leído.
•	Los dígitos que no tuvieron ocurrencias.
Por ejemplo, si la secuencia que se lee es: 63 34 99 94 96 -1, el programa deberá informar:
-	Número 3: 2 veces
-	Número 4: 2 veces
-	Número 6: 2 veces
-	Número 9: 4 veces
-	El dígito más leído fue el 9
-	Los dígitos que no tuvieron ocurrencias son: 0, 1, 2, 5, 7, 8}

program TP4_E7;
{$codepage UTF8}
uses crt;
const
  digitos_total=9;
  num_salida=-1;
  num_corte=0;
type
  t_digito=0..digitos_total;
  t_vector_cantidades=array[t_digito] of int16;
procedure inicializar_vector_cantidades(var vector_cantidades: t_vector_cantidades);
var
  i: t_digito;
begin
  for i:= 1 to digitos_total do
    vector_cantidades[i]:=0;
end;
procedure descomponer_numero(var vector_cantidades: t_vector_cantidades; num: int16);
var
  digito: t_digito;
begin
  if (num=0) then 
    vector_cantidades[0]:=vector_cantidades[0]+1
  else
    while (num<>0) do
    begin
      digito:=num mod 10;
      vector_cantidades[digito]:=vector_cantidades[digito]+1;
      num:=num div 10;
    end;
end;
procedure cargar_vector_cantidades(var vector_cantidades: t_vector_cantidades);
var
  num: int8;
begin
  num:=num_salida+random(high(int8));
  while (num<>num_salida) do
  begin
    descomponer_numero(vector_cantidades,num);
    num:=num_salida+random(102);
  end;
end;
procedure digito_mas_leido(num: int16; digito: int8; var num_max: int16; var digito_max: int8);
begin
  if (num>num_max) then
  begin
    num_max:=num;
    digito_max:=digito;
  end;
end;
procedure digitos_sin_ocurrencias(num: int16; digito: int8; var vector_cantidades2: t_vector_cantidades; var dimL: int8);
begin
  if (num=num_corte) then
  begin
    dimL:=dimL+1;
    vector_cantidades2[dimL]:=digito;
  end;
end;
procedure procesar_vector_cantidades(vector_cantidades: t_vector_cantidades);
var
  i: t_digito;
  digito_max, dimL: int8;
  num_max: int16;
  vector_cantidades2: t_vector_cantidades;
begin
  num_max:=low(int16); digito_max:=-1;
  dimL:=0;
  for i:= 0 to digitos_total do
  begin
    textcolor(green); write('Número ',i,': '); textcolor(red); write(vector_cantidades[i]); textcolor(green); writeln(' veces');
    digito_mas_leido(vector_cantidades[i],i,num_max,digito_max);
    digitos_sin_ocurrencias(vector_cantidades[i],i,vector_cantidades2,dimL);
  end;
  textcolor(green); write('El dígito más leído fue el '); textcolor(red); writeln(digito_max);
  if (dimL>0) then
  begin
  textcolor(green); write('Los dígitos que no tuvieron ocurrencias son: ');
    for i:= 1 to dimL do
    begin
      if (i<dimL) then
      begin
        textcolor(red); write(vector_cantidades2[i]); textcolor(green); write(', ');
      end
      else
      begin
        textcolor(red); write(vector_cantidades2[i]);
      end;
    end;
  end
  else
  begin
    textcolor(red); write('No hay dígitos sin ocurrencias');
  end;
end;
var
  vector_cantidades: t_vector_cantidades;
begin
  randomize;
  inicializar_vector_cantidades(vector_cantidades);
  cargar_vector_cantidades(vector_cantidades);
  procesar_vector_cantidades(vector_cantidades);
end.