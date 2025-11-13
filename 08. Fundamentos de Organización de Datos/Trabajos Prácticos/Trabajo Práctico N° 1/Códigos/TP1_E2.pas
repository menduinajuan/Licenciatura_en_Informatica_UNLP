{TRABAJO PRÁCTICO N° 1}
{EJERCICIO 2}
{Realizar un algoritmo que, utilizando el archivo de números enteros no ordenados creado en el Ejercicio 1, informe por pantalla cantidad de números menores a 1.500 y el promedio de los números ingresados.
El nombre del archivo a procesar debe ser proporcionado por el usuario una única vez. Además, el algoritmo deberá listar el contenido del archivo en pantalla.}

program TP1_E2;
{$codepage UTF8}
uses crt;
const
  num_corte=1500;
type
  t_archivo_enteros=file of int16;
procedure procesar_archivo_enteros(var archivo_enteros: t_archivo_enteros; var nums_corte: int16; var prom: real);
var
  num: int16;
  suma: real;
begin
  reset(archivo_enteros);
  suma:=0;
  textcolor(green); write('El contenido del archivo es: ');
  while (not eof(archivo_enteros)) do
  begin
    read(archivo_enteros,num);
    textcolor(yellow); write(num,' ');
    if (num<num_corte) then
      nums_corte:=nums_corte+1;
    suma:=suma+num;
  end;
  if (filesize(archivo_enteros)>0) then
    prom:=suma/filesize(archivo_enteros);
  writeln();
  close(archivo_enteros);
end;
var
  archivo_enteros: t_archivo_enteros;
  nums_corte: int16;
  prom: real;
begin
  nums_corte:=0; prom:=0;
  assign(archivo_enteros,'E1_enteros');
  procesar_archivo_enteros(archivo_enteros,nums_corte,prom);
  textcolor(green); write('La cantidad de números menores a '); textcolor(yellow); write(num_corte); textcolor(green); write(' es '); textcolor(red); writeln(nums_corte);
  textcolor(green); write('El promedio de los números ingresados es '); textcolor(red); write(prom:0:2);
end.