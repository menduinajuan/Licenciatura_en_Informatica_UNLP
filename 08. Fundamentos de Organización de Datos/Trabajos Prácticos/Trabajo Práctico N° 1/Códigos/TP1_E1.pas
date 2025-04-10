{TRABAJO PRÁCTICO N° 1}
{EJERCICIO 1}
{Realizar un algoritmo que cree un archivo de números enteros no ordenados y permita incorporar datos al archivo.
Los números son ingresados desde teclado. La carga finaliza cuando se ingresa el número 30000, que no debe incorporarse al archivo.
El nombre del archivo debe ser proporcionado por el usuario desde teclado.}

program TP1_E1;
{$codepage UTF8}
uses crt;
const
  num_salida=30000;
type
  t_string20=string[20];
  t_archivo_int=file of int16;
procedure leer_numero(var num: int16);
var
  i: int8;
begin
  i:=random(10);
  if (i=0) then
    num:=num_salida
  else
    num:=random(high(int16));
end;
procedure cargar_archivo_int(var archivo_int: t_archivo_int);
var
  num: int16;
begin
  rewrite(archivo_int);
  textcolor(green); write('Los números ingresados son: ');
  leer_numero(num);
  while (num<>num_salida) do
  begin
    textcolor(yellow); write(num,' ');
    write(archivo_int,num);
    leer_numero(num);
  end;
  close(archivo_int);
end;
var
  archivo_int: t_archivo_int;
  nombre: t_string20;
begin
  randomize;
  nombre:='archivo_enteros';
  assign(archivo_int,nombre);
  cargar_archivo_int(archivo_int);
end.