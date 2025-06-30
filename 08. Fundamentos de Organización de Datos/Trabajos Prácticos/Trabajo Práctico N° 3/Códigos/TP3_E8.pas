{TRABAJO PRÁCTICO N° 3}
{EJERCICIO 8}
{Se cuenta con un archivo con información de las diferentes distribuciones de Linux existentes.
De cada distribución, se conoce: nombre, año de lanzamiento, número de versión del kernel, cantidad de desarrolladores y descripción.
El nombre de las distribuciones no puede repetirse. Este archivo debe ser mantenido realizando bajas lógicas y utilizando la técnica de reutilización de espacio libre llamada lista invertida.
Escribir la definición de las estructuras de datos necesarias y los siguientes procedimientos:
(a) BuscarDistribucion: Módulo que recibe por parámetro el archivo, un nombre de distribución y devuelve la posición dentro del archivo donde se encuentra el registro correspondiente a la distribución dada, si existe, o devuelve -1, en caso de que no exista.
(b) AltaDistribucion: Módulo que recibe como parámetro el archivo y el registro que contiene los datos de una nueva distribución, y se encarga de agregar la distribución al archivo reutilizando espacio disponible en caso de que exista.
(El control de unicidad se debe realizar utilizando el módulo anterior). En caso de que la distribución que se quiere agregar ya exista, se debe informar “Ya existe la distribución”.
(c) BajaDistribucion: Módulo que recibe como parámetro el archivo y el nombre de una distribución, y se encarga de dar de baja lógicamente la distribución dada.
Para marcar una distribución como borrada, se debe utilizar el campo cantidad de desarrolladores para mantener actualizada la lista invertida.
Para verificar que la distribución a borrar exista, se debe utilizar el módulo BuscarDistribucion. En caso de no existir, se debe informar “Distribución no existente”.}

program TP3_E8;
{$codepage UTF8}
uses crt;
const
  nombre_salida='ZZZ';
  desarrolladores_cabecera=0;
type
  t_string20=string[20];
  t_registro_distribucion=record
    nombre: t_string20;
    anio: int16;
    kernel: int16;
    desarrolladores: int16;
    descripcion: t_string20;
  end;
  t_archivo_distribuciones=file of t_registro_distribucion;
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
procedure leer_cabecera(var registro_distribucion: t_registro_distribucion);
begin
  registro_distribucion.nombre:='Cabecera';
  registro_distribucion.anio:=desarrolladores_cabecera;
  registro_distribucion.kernel:=desarrolladores_cabecera;
  registro_distribucion.desarrolladores:=desarrolladores_cabecera;
  registro_distribucion.descripcion:='Cabecera';
end;
procedure leer_distribucion(var registro_distribucion: t_registro_distribucion);
var
  i: int8;
begin
  i:=random(10);
  if (i=0) then
    registro_distribucion.nombre:=nombre_salida
  else
    registro_distribucion.nombre:=random_string(5+random(6));
  if (registro_distribucion.nombre<>nombre_salida) then
  begin
    registro_distribucion.anio:=2000+random(26);
    registro_distribucion.kernel:=1+random(10);
    registro_distribucion.desarrolladores:=1+random(100);
    registro_distribucion.descripcion:=random_string(10+random(10));
  end;
end;
procedure cargar_archivo_distribuciones(var archivo_distribuciones: t_archivo_distribuciones);
var
  registro_distribucion: t_registro_distribucion;
begin
  rewrite(archivo_distribuciones);
  leer_cabecera(registro_distribucion);
  while (registro_distribucion.nombre<>nombre_salida) do
  begin
    write(archivo_distribuciones,registro_distribucion);
    leer_distribucion(registro_distribucion);
  end;
  close(archivo_distribuciones);
end;
procedure imprimir_registro_distribucion(registro_distribucion: t_registro_distribucion);
begin
  textcolor(green); write('Nombre: '); textcolor(yellow); write(registro_distribucion.nombre);
  textcolor(green); write('; Año: '); textcolor(yellow); write(registro_distribucion.anio);
  textcolor(green); write('; Kernel: '); textcolor(yellow); write(registro_distribucion.kernel);
  textcolor(green); write('; Desarrolladores: '); textcolor(yellow); write(registro_distribucion.desarrolladores);
  textcolor(green); write('; Descripción: '); textcolor(yellow); writeln(registro_distribucion.descripcion);
end;
procedure imprimir_archivo_distribuciones(var archivo_distribuciones: t_archivo_distribuciones);
var
  registro_distribucion: t_registro_distribucion;
begin
  reset(archivo_distribuciones);
  while (not eof(archivo_distribuciones)) do
  begin
    read(archivo_distribuciones,registro_distribucion);
    imprimir_registro_distribucion(registro_distribucion);
  end;
  textcolor(green); write('Tamaño del archivo distribuciones: '); textcolor(yellow); writeln(filesize(archivo_distribuciones));
  close(archivo_distribuciones);
end;
procedure buscar_distribucion(var archivo_distribuciones: t_archivo_distribuciones; nombre: t_string20; var pos: int16);
var
  registro_distribucion: t_registro_distribucion;
  ok: boolean;
begin
  ok:=false;
  reset(archivo_distribuciones);
  while (not eof(archivo_distribuciones)) and (ok=false) do
  begin
    read(archivo_distribuciones,registro_distribucion);
    if (registro_distribucion.nombre=nombre) then
      ok:=true;
  end;
  if (ok=true) then
    pos:=filepos(archivo_distribuciones)-1
  else
    pos:=-1;
  close(archivo_distribuciones);
end;
procedure alta_distribucion(var archivo_distribuciones: t_archivo_distribuciones; registro_distribucion: t_registro_distribucion);
var
  cabecera: t_registro_distribucion;
  pos: int16;
begin
  buscar_distribucion(archivo_distribuciones,registro_distribucion.nombre,pos);
  if (pos=-1) then
  begin
    reset(archivo_distribuciones);
    read(archivo_distribuciones,cabecera);
    if (cabecera.desarrolladores=desarrolladores_cabecera) then
    begin
      seek(archivo_distribuciones,filesize(archivo_distribuciones));
      write(archivo_distribuciones,registro_distribucion);
    end
    else
    begin
      seek(archivo_distribuciones,cabecera.desarrolladores*(-1));
      read(archivo_distribuciones,cabecera);
      seek(archivo_distribuciones,filepos(archivo_distribuciones)-1);
      write(archivo_distribuciones,registro_distribucion);
      seek(archivo_distribuciones,0);
      write(archivo_distribuciones,cabecera);
    end;
    close(archivo_distribuciones);
    textcolor(green); write('Se ha realizado el alta de la distribución '); textcolor(yellow); write(registro_distribucion.nombre); textcolor(green); writeln(' en el archivo');
  end
  else
  begin
    textcolor(green); write('Ya existe la distribución '); textcolor(yellow); write(registro_distribucion.nombre); textcolor(green); writeln(' en el archivo');
  end;
  writeln();
end;
procedure baja_distribucion(var archivo_distribuciones: t_archivo_distribuciones; nombre: t_string20);
var
  registro_distribucion, cabecera: t_registro_distribucion;
  pos: int16;
begin
  buscar_distribucion(archivo_distribuciones,nombre,pos);
  if (pos<>-1) then
  begin
    reset(archivo_distribuciones);
    read(archivo_distribuciones,cabecera);
    read(archivo_distribuciones,registro_distribucion);
    while (registro_distribucion.nombre<>nombre) do
      read(archivo_distribuciones,registro_distribucion);
    seek(archivo_distribuciones,filepos(archivo_distribuciones)-1);
    write(archivo_distribuciones,cabecera);
    cabecera.desarrolladores:=(filepos(archivo_distribuciones)-1)*(-1);
    seek(archivo_distribuciones,0);
    write(archivo_distribuciones,cabecera);
    close(archivo_distribuciones);
    textcolor(green); write('Se ha realizado la baja de la distribución '); textcolor(yellow); write(nombre); textcolor(green); writeln(' en el archivo');
  end
  else
  begin
    textcolor(green); write('No se ha encontrado la distribución '); textcolor(yellow); write(nombre); textcolor(green); writeln(' en el archivo');
  end;
  writeln();
end;
var
  archivo_distribuciones: t_archivo_distribuciones;
  registro_distribucion: t_registro_distribucion;
  pos: int16;
begin
  randomize;
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO DISTRIBUCIONES:'); writeln();
  assign(archivo_distribuciones,'E8_distribuciones');
  cargar_archivo_distribuciones(archivo_distribuciones);
  imprimir_archivo_distribuciones(archivo_distribuciones);
  writeln(); textcolor(red); writeln('MÓDULO BuscarDistribucion:'); writeln();
  registro_distribucion.nombre:=random_string(5+random(6));
  buscar_distribucion(archivo_distribuciones,registro_distribucion.nombre,pos);
  if (pos<>-1) then
  begin
    textcolor(green); write('Se encontró la distribución '); textcolor(yellow); write(registro_distribucion.nombre); textcolor(green); write(' en la posición '); textcolor(red); write(pos); textcolor(green); writeln(' del archivo');
  end
  else
  begin
    textcolor(green); write('No se encontró la distribución '); textcolor(yellow); write(registro_distribucion.nombre); textcolor(green); writeln(' en el archivo');
  end;
  writeln(); textcolor(red); writeln('MÓDULO AltaDistribucion:'); writeln();
  leer_distribucion(registro_distribucion);
  while (registro_distribucion.nombre=nombre_salida) do
    leer_distribucion(registro_distribucion);
  alta_distribucion(archivo_distribuciones,registro_distribucion);
  imprimir_archivo_distribuciones(archivo_distribuciones);
  writeln(); textcolor(red); writeln('MÓDULO BajaDistribucion:'); writeln();
  registro_distribucion.nombre:=random_string(5+random(6));
  baja_distribucion(archivo_distribuciones,registro_distribucion.nombre);
  imprimir_archivo_distribuciones(archivo_distribuciones);
end.