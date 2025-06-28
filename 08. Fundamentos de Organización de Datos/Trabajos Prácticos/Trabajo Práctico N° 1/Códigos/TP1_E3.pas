{TRABAJO PRÁCTICO N° 1}
{EJERCICIO 3}
{Realizar un programa que presente un menú con opciones para:
(a) Crear un archivo de registros no ordenados de empleados y completarlo con datos ingresados desde teclado.
De cada empleado, se registra: número de empleado, apellido, nombre, edad y DNI. Algunos empleados se ingresan con DNI 00.
La carga finaliza cuando se ingresa el String “fin” como apellido.
(b) Abrir el archivo anteriormente generado y:
  (i) Listar en pantalla los datos de empleados que tengan un nombre o apellido determinado, el cual se proporciona desde el teclado.
  (ii) Listar en pantalla los empleados de a uno por línea.
  (iii) Listar en pantalla los empleados mayores de 70 años, próximos a jubilarse.
Nota: El nombre del archivo a crear o utilizar debe ser proporcionado por el usuario.}

program TP1_E3;
{$codepage UTF8}
uses crt;
const
  apellido_salida='fin';
  edad_corte=70;
  opcion_salida=0;
type
  t_string10=string[10];
  t_registro_empleado=record
    numero: int16;
    apellido: t_string10;
    nombre: t_string10;
    edad: int8;
    dni: int32;
  end;
  t_archivo_empleados=file of t_registro_empleado;
function random_string(length: int8): t_string10;
var
  i: int8;
  string_aux: string;
begin
  string_aux:='';
  for i:= 1 to length do
    string_aux:=string_aux+chr(ord('A')+random(26));
  random_string:=string_aux;
end;
procedure leer_empleado(var registro_empleado: t_registro_empleado);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    registro_empleado.apellido:=apellido_salida
  else
    registro_empleado.apellido:=random_string(5+random(5));
  if (registro_empleado.apellido<>apellido_salida) then
  begin
    registro_empleado.numero:=1+random(1000);
    registro_empleado.nombre:=random_string(5+random(5));
    registro_empleado.edad:=18+random(high(int8)-18);
    if (i<=10) then
      registro_empleado.dni:=0
    else
      registro_empleado.dni:=10000000+random(40000001);
  end;
end;
procedure cargar_archivo_empleados(var archivo_empleados: t_archivo_empleados);
var
  registro_empleado: t_registro_empleado;
begin
  rewrite(archivo_empleados);
  leer_empleado(registro_empleado);
  while (registro_empleado.apellido<>apellido_salida) do
  begin
    write(archivo_empleados,registro_empleado);
    leer_empleado(registro_empleado);
  end;
  close(archivo_empleados);
  textcolor(green); writeln('El archivo binario de empleados fue creado y cargado con éxito');
end;
procedure imprimir_registro_empleado(registro_empleado: t_registro_empleado);
begin
  textcolor(green); write('Número: '); textcolor(yellow); write(registro_empleado.numero);
  textcolor(green); write('; Apellido: '); textcolor(yellow); write(registro_empleado.apellido);
  textcolor(green); write('; Nombre: '); textcolor(yellow); write(registro_empleado.nombre);
  textcolor(green); write('; Edad: '); textcolor(yellow); write(registro_empleado.edad);
  textcolor(green); write('; DNI: '); textcolor(yellow); writeln(registro_empleado.dni);
end;
procedure imprimir1_archivo_empleados(var archivo_empleados: t_archivo_empleados);
var
  registro_empleado: t_registro_empleado;
  texto: t_string10;
begin
  texto:=random_string(5+random(5));
  reset(archivo_empleados);
  textcolor(green); write('Los datos de los empleados con nombre o apellido '); textcolor(yellow); write(texto); textcolor(green); writeln(' son: ');
  while (not eof(archivo_empleados)) do
  begin
    read(archivo_empleados,registro_empleado);
    if ((registro_empleado.nombre=texto) or (registro_empleado.apellido=texto)) then
      imprimir_registro_empleado(registro_empleado);
  end;
  close(archivo_empleados);
end;
procedure imprimir2_archivo_empleados(var archivo_empleados: t_archivo_empleados);
var
  registro_empleado: t_registro_empleado;
begin
  reset(archivo_empleados);
  textcolor(green); writeln('Los empleados del archivo son: ');
  while (not eof(archivo_empleados)) do
  begin
    read(archivo_empleados,registro_empleado);
    imprimir_registro_empleado(registro_empleado);
  end;
  close(archivo_empleados);
end;
procedure imprimir3_archivo_empleados(var archivo_empleados: t_archivo_empleados);
var
  registro_empleado: t_registro_empleado;
begin
  reset(archivo_empleados);
  textcolor(green); write('Los empleados mayores a '); textcolor(yellow); write(edad_corte); textcolor(green); writeln(' años son: ');
  while (not eof(archivo_empleados)) do
  begin
    read(archivo_empleados,registro_empleado);
    if (registro_empleado.edad>edad_corte) then
      imprimir_registro_empleado(registro_empleado);
  end;
  close(archivo_empleados);
end;
procedure leer_opcion(var opcion: int8);
begin
  textcolor(red); writeln('MENÚ DE OPCIONES');
  textcolor(yellow); write('OPCIÓN 1: '); textcolor(green); writeln('Crear un archivo de registros no ordenados de empleados y completarlo con datos ingresados desde teclado');
  textcolor(yellow); write('OPCIÓN 2: '); textcolor(green); writeln('Listar en pantalla los datos de empleados que tengan un nombre o apellido determinado');
  textcolor(yellow); write('OPCIÓN 3: '); textcolor(green); writeln('Listar en pantalla los empleados de a uno por línea');
  textcolor(yellow); write('OPCIÓN 4: '); textcolor(green); writeln('Listar en pantalla los empleados mayores a 70 años, próximos a jubilarse');
  textcolor(yellow); write('OPCIÓN 0: '); textcolor(green); writeln('Salir del menú de opciones');
  textcolor(green); write('Introducir opción elegida: '); textcolor(yellow); readln(opcion);
  writeln();
end;
procedure menu_opciones(var archivo_empleados: t_archivo_empleados);
var
  opcion: int8;
begin
  leer_opcion(opcion);
  while (opcion<>opcion_salida) do
  begin
    case opcion of
      1: cargar_archivo_empleados(archivo_empleados);
      2: imprimir1_archivo_empleados(archivo_empleados);
      3: imprimir2_archivo_empleados(archivo_empleados);
      4: imprimir3_archivo_empleados(archivo_empleados);
    else
        textcolor(green); writeln('La opción ingresada no corresponde a ninguna de las mostradas en el menú de opciones');
    end;
    writeln();
    leer_opcion(opcion);
  end;
end;
var
  archivo_empleados: t_archivo_empleados;
begin
  randomize;
  assign(archivo_empleados,'E3_empleados');
  menu_opciones(archivo_empleados);
end.