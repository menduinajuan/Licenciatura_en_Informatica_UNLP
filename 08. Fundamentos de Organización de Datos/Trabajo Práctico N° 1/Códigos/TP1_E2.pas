{TRABAJO PRÁCTICO N° 1}
{EJERCICIO 2}
{Realizar un algoritmo que, utilizando el archivo de números enteros no ordenados creado en el Ejercicio 1, informe por pantalla cantidad de números menores a 1500 y el promedio de los números ingresados.
El nombre del archivo a procesar debe ser proporcionado por el usuario una única vez. Además, el algoritmo deberá listar el contenido del archivo en pantalla.}

program TP1_E2;
{$codepage UTF8}
uses crt;
const
  num_corte=1500;
type
  t_archivo=file of int16;
procedure procesar_archivo(var archivo: t_archivo; var nums_corte: int16; var prom: real);
var
  num: int16;
  suma: real;
begin
  reset(archivo);
  suma:=0;
  textcolor(green); write('El contenido del archivo es: ');
  while (not eof(archivo)) do
  begin
    read(archivo,num);
    textcolor(yellow); write(num,' ');
    if (num<num_corte) then
      nums_corte:=nums_corte+1;
    suma:=suma+num;
  end;
  if (fileSize(archivo)>0) then
    prom:=suma/fileSize(archivo);
  writeln();
  close(archivo);
end;
var
  archivo: t_archivo;
  nums_corte: int16;
  prom: real;
  nombre: string;
begin
  nombre:='TP1_E1';
  nums_corte:=0; prom:=0;
  assign(archivo,nombre);
  procesar_archivo(archivo,nums_corte,prom);
  textcolor(green); write('La cantidad de números menores a '); textcolor(yellow); write(num_corte); textcolor(green); write(' es '); textcolor(red); writeln(nums_corte);
  textcolor(green); write('El promedio de los números ingresados es '); textcolor(red); write(prom:0:2);
end.