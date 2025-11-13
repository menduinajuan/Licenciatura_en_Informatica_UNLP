{TRABAJO PRÁCTICO N° 3}
{EJERCICIO 2}
{Definir un programa que genere un archivo con registros de longitud fija conteniendo información de asistentes a un congreso a partir de la información obtenida por teclado.
Se deberá almacenar la siguiente información: nro. de asistente, apellido y nombre, email, teléfono y DNI.
Implementar un procedimiento que, a partir del archivo de datos generado, elimine, de forma lógica, todos los asistentes con nro. de asistente inferior a 1.000.
Para ello, se podrá utilizar algún carácter especial situándolo delante de algún campo String a elección. Ejemplo: “@Saldaño”.}

program TP3_E2;
{$codepage UTF8}
uses crt;
const
  numero_salida=0;
  numero_corte=1000;
type
  t_string20=string[20];
  t_registro_asistente=record
    numero: int16;
    apellido: t_string20;
    nombre: t_string20;
    email: t_string20;
    telefono: int32;
    dni: int32;
  end;
  t_archivo_asistentes=file of t_registro_asistente;
function random_string(length: int8): t_string20;
var
  i: int8;
  string_aux: string;
begin
  string_aux:='';
  for i:= 1 to length do
    string_aux:=string_aux+chr(ord('A')+random(26));
  random_string:=string_aux;
end;
procedure leer_asistente(var registro_asistente: t_registro_asistente);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    registro_asistente.numero:=numero_salida
  else
    registro_asistente.numero:=1+random(2000);
  if (registro_asistente.numero<>numero_salida) then
  begin
    registro_asistente.apellido:=random_string(5+random(5));
    registro_asistente.nombre:=random_string(5+random(5));
    registro_asistente.email:=random_string(5+random(6))+'@gmail.com';
    registro_asistente.telefono:=1000000000+random(1000000001);
    registro_asistente.dni:=10000000+random(40000001);
  end;
end;
procedure cargar_archivo_asistentes(var archivo_asistentes: t_archivo_asistentes);
var
  registro_asistente: t_registro_asistente;
begin
  rewrite(archivo_asistentes);
  leer_asistente(registro_asistente);
  while (registro_asistente.numero<>numero_salida) do
  begin
    write(archivo_asistentes,registro_asistente);
    leer_asistente(registro_asistente);
  end;
  close(archivo_asistentes);
end;
procedure imprimir_registro_asistente(registro_asistente: t_registro_asistente);
begin
  textcolor(green); write('Número: '); textcolor(yellow); write(registro_asistente.numero);
  textcolor(green); write('; Apellido: '); textcolor(yellow); write(registro_asistente.apellido);
  textcolor(green); write('; Nombre: '); textcolor(yellow); write(registro_asistente.nombre);
  textcolor(green); write('; Email: '); textcolor(yellow); write(registro_asistente.email);
  textcolor(green); write('; Teléfono: '); textcolor(yellow); write(registro_asistente.telefono);
  textcolor(green); write('; DNI: '); textcolor(yellow); writeln(registro_asistente.dni);
end;
procedure imprimir_archivo_asistentes(var archivo_asistentes: t_archivo_asistentes);
var
  registro_asistente: t_registro_asistente;
begin
  reset(archivo_asistentes);
  while (not eof(archivo_asistentes)) do
  begin
    read(archivo_asistentes,registro_asistente);
    imprimir_registro_asistente(registro_asistente);
  end;
  textcolor(green); write('Tamaño del archivo asistentes: '); textcolor(yellow); writeln(filesize(archivo_asistentes));
  close(archivo_asistentes);
end;
procedure eliminar_archivo_asistentes(var archivo_asistentes: t_archivo_asistentes);
var
  registro_asistente: t_registro_asistente;
begin
  reset(archivo_asistentes);
  while (not eof(archivo_asistentes)) do
  begin
    read(archivo_asistentes,registro_asistente);
    if (registro_asistente.numero<numero_corte) then
    begin
      registro_asistente.apellido:='@'+registro_asistente.apellido;
      seek(archivo_asistentes,filepos(archivo_asistentes)-1);
      write(archivo_asistentes,registro_asistente);
    end;
  end;
  close(archivo_asistentes);
end;
var
  archivo_asistentes: t_archivo_asistentes;
begin
  randomize;
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO ASISTENTES:'); writeln();
  assign(archivo_asistentes,'E2_asistentes');
  cargar_archivo_asistentes(archivo_asistentes);
  imprimir_archivo_asistentes(archivo_asistentes);
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO ASISTENTES ACTUALIZADO:'); writeln();
  eliminar_archivo_asistentes(archivo_asistentes);
  imprimir_archivo_asistentes(archivo_asistentes);
end.