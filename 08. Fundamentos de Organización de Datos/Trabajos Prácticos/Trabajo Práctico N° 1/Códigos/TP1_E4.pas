{TRABAJO PRÁCTICO N° 1}
{EJERCICIO 4}
{Agregar al menú del programa del Ejercicio 3 opciones para:
(a) Añadir uno o más empleados al final del archivo con sus datos ingresados por teclado.
Tener en cuenta que no se debe agregar al archivo un empleado con un número de empleado ya registrado (control de unicidad).
(b) Modificar la edad de un empleado dado.
(c)) Exportar el contenido del archivo a un archivo de texto llamado “todos_empleados.txt”.
(d) Exportar a un archivo de texto llamado “faltaDNIEmpleado.txt” los empleados que no tengan cargado el DNI (DNI en 00).
Nota: Las búsquedas deben realizarse por número de empleado.}

program TP1_E4;
{$codepage UTF8}
uses crt;
const
  apellido_salida='fin';
  edad_corte=70;
  dni_corte=0;
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
function control_unicidad(var archivo_empleados: t_archivo_empleados; numero: int16): boolean;
var
  registro_empleado: t_registro_empleado;
  ok: boolean;
begin
  ok:=false;
  while ((not eof(archivo_empleados)) and (ok=false)) do
  begin
    read(archivo_empleados,registro_empleado);
    if (registro_empleado.numero=numero) then
      ok:=true;
  end;
  control_unicidad:=ok;
end;
procedure agregar_empleado(var archivo_empleados: t_archivo_empleados);
var
  registro_empleado: t_registro_empleado;
  empleados: int16;
begin
  empleados:=0;
  reset(archivo_empleados);
  leer_empleado(registro_empleado);
  while (registro_empleado.apellido<>apellido_salida) do
  begin
    if (control_unicidad(archivo_empleados,registro_empleado.numero)=false) then
    begin
      seek(archivo_empleados,filesize(archivo_empleados));
      write(archivo_empleados,registro_empleado);
      empleados:=empleados+1;
    end;
    leer_empleado(registro_empleado);
  end;
  close(archivo_empleados);
  textcolor(green); write('Se han agregado '); textcolor(yellow); write(empleados); textcolor(green); writeln(' empleados al final del archivo');
end;
procedure modificar_edad_empleado(var archivo_empleados: t_archivo_empleados);
var
  registro_empleado: t_registro_empleado;
  numero: int16;
  ok: boolean;
begin
  numero:=1+random(1000);
  ok:=false;
  reset(archivo_empleados);
  while ((not eof(archivo_empleados)) and (ok=false)) do
  begin
    read(archivo_empleados,registro_empleado);
    if (registro_empleado.numero=numero) then
    begin
      registro_empleado.edad:=18+random(high(int8)-18);
      seek(archivo_empleados,filepos(archivo_empleados)-1);
      write(archivo_empleados,registro_empleado);
      ok:=true;
    end;
  end;
  close(archivo_empleados);
  if (ok=true) then
  begin
    textcolor(green); write('Se ha modificado la edad del empleado con número '); textcolor(yellow); write(numero); textcolor(green); writeln(' en el archivo');
  end
  else
  begin
    textcolor(green); write('No se ha encontrado el empleado con número '); textcolor(yellow); write(numero); textcolor(green); writeln(' en el archivo');
  end;
end;
procedure exportar_archivo_txt1(var archivo_empleados: t_archivo_empleados);
var
  registro_empleado: t_registro_empleado;
  archivo_txt: text;
begin
  reset(archivo_empleados);
  assign(archivo_txt,'E4_todos_empleados.txt'); rewrite(archivo_txt);
  while (not eof(archivo_empleados)) do
  begin
    read(archivo_empleados,registro_empleado);
    with registro_empleado do
      writeln(archivo_txt,'Número: ',numero,'; Apellido: ',apellido,'; Nombre: ',nombre,'; Edad: ',edad,'; DNI: ',dni);
  end;
  close(archivo_empleados);
  close(archivo_txt);
  textcolor(green); write('Se ha exportado el contenido del archivo al archivo de texto llamado '); textcolor(yellow); writeln('"todos_empleados.txt"');
end;
procedure exportar_archivo_txt2(var archivo_empleados: t_archivo_empleados);
var
  registro_empleado: t_registro_empleado;
  archivo_txt: text;
begin
  reset(archivo_empleados);
  assign(archivo_txt,'E4_faltaDNIEmpleado.txt'); rewrite(archivo_txt);
  while (not eof(archivo_empleados)) do
  begin
    read(archivo_empleados,registro_empleado);
    if (registro_empleado.dni=dni_corte) then
      with registro_empleado do
        writeln(archivo_txt,'Número: ',numero,'; Apellido: ',apellido,'; Nombre: ',nombre,'; Edad: ',edad,'; DNI: ',dni);
  end;
  close(archivo_empleados);
  close(archivo_txt);
  textcolor(green); write('Se ha exportado a un archivo de texto llamado '); textcolor(yellow); write('"faltaDNIEmpleado.txt"'); textcolor(green); writeln(' los empleados que no tienen cargado el DNI (DNI en 00)');
end;
procedure leer_opcion(var opcion: int8);
begin
  textcolor(red); writeln('MENÚ DE OPCIONES');
  textcolor(yellow); write('OPCIÓN 1: '); textcolor(green); writeln('Crear un archivo de registros no ordenados de empleados y completarlo con datos ingresados desde teclado');
  textcolor(yellow); write('OPCIÓN 2: '); textcolor(green); writeln('Listar en pantalla los datos de empleados que tengan un nombre o apellido determinado');
  textcolor(yellow); write('OPCIÓN 3: '); textcolor(green); writeln('Listar en pantalla los empleados de a uno por línea');
  textcolor(yellow); write('OPCIÓN 4: '); textcolor(green); writeln('Listar en pantalla los empleados mayores a 70 años, próximos a jubilarse');
  textcolor(yellow); write('OPCIÓN 5: '); textcolor(green); writeln('Añadir uno o más empleados al final del archivo con sus datos ingresados por teclado');
  textcolor(yellow); write('OPCIÓN 6: '); textcolor(green); writeln('Modificar la edad de un empleado dado');
  textcolor(yellow); write('OPCIÓN 7: '); textcolor(green); writeln('Exportar el contenido del archivo a un archivo de texto llamado “todos_empleados.txt”');
  textcolor(yellow); write('OPCIÓN 8: '); textcolor(green); writeln('Exportar a un archivo de texto llamado “faltaDNIEmpleado.txt” los empleados que no tengan cargado el DNI (DNI en 00)');
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
      5: agregar_empleado(archivo_empleados);
      6: modificar_edad_empleado(archivo_empleados);
      7: exportar_archivo_txt1(archivo_empleados);
      8: exportar_archivo_txt2(archivo_empleados);
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
  assign(archivo_empleados,'E4_empleados');
  menu_opciones(archivo_empleados);
end.