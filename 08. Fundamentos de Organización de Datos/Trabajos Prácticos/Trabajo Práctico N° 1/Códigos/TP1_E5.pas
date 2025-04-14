{TRABAJO PRÁCTICO N° 1}
{EJERCICIO 5}
{Realizar un programa para una tienda de celulares, que presente un menú con opciones para:
(a) Crear un archivo de registros no ordenados de celulares y cargarlo con datos ingresados desde un archivo de texto denominado “celulares.txt”.
Los registros correspondientes a los celulares deben contener: código de celular, nombre, descripción, marca, precio, stock mínimo y stock disponible.
(b) Listar en pantalla los datos de aquellos celulares que tengan un stock menor al stock mínimo.
(c) Listar en pantalla los celulares del archivo cuya descripción contenga una cadena de caracteres proporcionada por el usuario.
(d) Exportar el archivo creado en el inciso (a) a un archivo de texto denominado “celulares.txt” con todos los celulares del mismo.
El archivo de texto generado podría ser utilizado en un futuro como archivo de carga (ver inciso (a)), por lo que debería respetar el formato dado para este tipo de archivos en la Nota 2.
Nota 1: El nombre del archivo binario de celulares debe ser proporcionado por el usuario.
Nota 2: El archivo de carga debe editarse de manera que cada celular se especifique en tres líneas consecutivas.
En la primera, se especifica: código de celular, precio y marca; en la segunda, stock disponible, stock mínimo y descripción; y, en la tercera, nombre en ese orden.
Cada celular se carga leyendo tres líneas del archivo “celulares.txt”.}

program TP1_E5;
{$codepage UTF8}
uses crt, sysutils;
const
  codigo_salida=0;
  opcion_salida=0;
type
  t_string10=string[10];
  t_string20=string[20];
  t_registro_celular=record
    codigo: int16;
    nombre: t_string10;
    descripcion: t_string20;
    marca: t_string10;
    precio: real;
    stock_minimo: int16;
    stock_disponible: int16;
  end;
  t_archivo_celulares=file of t_registro_celular;
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
procedure leer_celular(var registro_celular: t_registro_celular);
var
  vector_marcas: array[1..10] of t_string10=('Alcatel', 'Apple', 'Huawei', 'Lenovo', 'LG', 'Motorola', 'Nokia', 'Samsung', 'Sony', 'Xiaomi');
  vector_descripciones: array[1..5] of t_string20=('Gama baja', 'Gama media baja', 'Gama media', 'Gama media alta', 'Gama alta');
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    registro_celular.codigo:=codigo_salida
  else
    registro_celular.codigo:=1+random(1000);
  if (registro_celular.codigo<>codigo_salida) then
  begin
    registro_celular.nombre:=random_string(5+random(5));
    registro_celular.descripcion:=vector_descripciones[1+random(5)];
    registro_celular.marca:=vector_marcas[1+random(10)];
    registro_celular.precio:=100+random(9001)/10;
    registro_celular.stock_minimo:=1+random(10);
    registro_celular.stock_disponible:=random(101);
  end;
end;
procedure cargar_archivo_carga(var archivo_carga: text);
var
  registro_celular: t_registro_celular;
begin
  rewrite(archivo_carga);
  leer_celular(registro_celular);
  while (registro_celular.codigo<>codigo_salida) do
  begin
    with registro_celular do
    begin
      writeln(archivo_carga,codigo,' ',precio:0:2,' ',marca);
      writeln(archivo_carga,stock_disponible,' ',stock_minimo,' ',descripcion);
      writeln(archivo_carga,nombre);
    end;
    leer_celular(registro_celular);
  end;
  close(archivo_carga);
end;
procedure cargar_archivo_celulares(var archivo_celulares: t_archivo_celulares; var archivo_carga: text);
var
  registro_celular: t_registro_celular;
begin
  rewrite(archivo_celulares);
  reset(archivo_carga);
  while (not eof(archivo_carga)) do
    with registro_celular do 
    begin
      readln(archivo_carga,codigo,precio,marca); marca:=trim(marca);
      readln(archivo_carga,stock_disponible,stock_minimo,descripcion); descripcion:=trim(descripcion);
      readln(archivo_carga,nombre);
      write(archivo_celulares,registro_celular);
    end;
  close(archivo_celulares);
  close(archivo_carga);
  textcolor(green); writeln('El archivo binario de celulares fue creado y cargado con éxito');
end;
procedure imprimir_registro_celular(registro_celular: t_registro_celular);
begin
  textcolor(green); write('Código: '); textcolor(yellow); write(registro_celular.codigo);
  textcolor(green); write('; Nombre: '); textcolor(yellow); write(registro_celular.nombre);
  textcolor(green); write('; Descripción: '); textcolor(yellow); write(registro_celular.descripcion);
  textcolor(green); write('; Marca: '); textcolor(yellow); write(registro_celular.marca);
  textcolor(green); write('; Precio: '); textcolor(yellow); write(registro_celular.precio:0:2);
  textcolor(green); write('; Stock mínimo: '); textcolor(yellow); write(registro_celular.stock_minimo);
  textcolor(green); write('; Stock disponible: '); textcolor(yellow); writeln(registro_celular.stock_disponible);
end;
procedure imprimir1_archivo_celulares(var archivo_celulares: t_archivo_celulares);
var
  registro_celular: t_registro_celular;
begin
  reset(archivo_celulares);
  textcolor(green); writeln('Los datos de aquellos celulares que tienen un stock menor al stock mínimo son: ');
  while (not eof(archivo_celulares)) do
  begin
    read(archivo_celulares,registro_celular);
    if (registro_celular.stock_disponible<registro_celular.stock_minimo) then
      imprimir_registro_celular(registro_celular);
  end;
  close(archivo_celulares);
end;
procedure imprimir2_archivo_celulares(var archivo_celulares: t_archivo_celulares);
var
  registro_celular: t_registro_celular;
  vector_descripciones: array[1..5] of t_string20=('Gama baja', 'Gama media baja', 'Gama media', 'Gama media alta', 'Gama alta');
  descripcion: t_string20;
begin
  reset(archivo_celulares);
  descripcion:=vector_descripciones[1+random(5)];
  textcolor(green); write('Los celulares del archivo cuya descripción contiene la cadena de caracteres '); textcolor(yellow); write(descripcion); textcolor(green); writeln(' son: ');
  while (not eof(archivo_celulares)) do
  begin
    read(archivo_celulares,registro_celular);
    if (registro_celular.descripcion=descripcion) then
      imprimir_registro_celular(registro_celular);
  end;
  close(archivo_celulares);
end;
procedure exportar_archivo_txt(var archivo_celulares: t_archivo_celulares);
var
  registro_celular: t_registro_celular;
  archivo_txt: text;
begin
  reset(archivo_celulares);
  assign(archivo_txt,'celulares2.txt');
  rewrite(archivo_txt);
  while (not eof(archivo_celulares)) do
  begin
    read(archivo_celulares,registro_celular);
    with registro_celular do
    begin
      writeln(archivo_txt,codigo,' ',precio:0:2,' ',marca);
      writeln(archivo_txt,stock_disponible,' ',stock_minimo,' ',descripcion);
      writeln(archivo_txt,nombre);
    end;
  end;
  close(archivo_celulares);
  close(archivo_txt);
  textcolor(green); write('Se ha exportado el archivo creado en el inciso (a) a un archivo de texto denominado '); textcolor(yellow); write('"celulares2.txt"'); textcolor(green); writeln(' con todos los celulares del mismo');
end;
procedure leer_opcion(var opcion: int8);
begin
  textcolor(red); writeln('MENÚ DE OPCIONES');
  textcolor(yellow); write('OPCIÓN 1: '); textcolor(green); writeln('Crear un archivo de registros no ordenados de celulares y cargarlo con datos ingresados desde un archivo de texto denominado "celulares1.txt"');
  textcolor(yellow); write('OPCIÓN 2: '); textcolor(green); writeln('Listar en pantalla los datos de aquellos celulares que tengan un stock menor al stock mínimo');
  textcolor(yellow); write('OPCIÓN 3: '); textcolor(green); writeln('Listar en pantalla los celulares del archivo cuya descripción contenga una cadena de caracteres proporcionada por el usuario');
  textcolor(yellow); write('OPCIÓN 4: '); textcolor(green); writeln('Exportar el archivo creado en el inciso (a) a un archivo de texto denominado "celulares2.txt" con todos los celulares del mismo');
  textcolor(yellow); write('OPCIÓN 0: '); textcolor(green); writeln('Salir del menú de opciones');
  textcolor(green); write('Introducir opción elegida: '); textcolor(yellow); readln(opcion);
  writeln();
end;
procedure menu_opciones(var archivo_celulares: t_archivo_celulares; var archivo_carga: text);
var
  opcion: int8;
begin
  leer_opcion(opcion);
  while(opcion<>opcion_salida) do
  begin
    case opcion of
      1: cargar_archivo_celulares(archivo_celulares,archivo_carga);
      2: imprimir1_archivo_celulares(archivo_celulares);
      3: imprimir2_archivo_celulares(archivo_celulares);
      4: exportar_archivo_txt(archivo_celulares);
    else
        textcolor(green); writeln('La opción ingresada no corresponde a ninguna de las mostradas en el menú de opciones');
    end;
    writeln();
    leer_opcion(opcion);
  end;
end;
var
  archivo_celulares: t_archivo_celulares;
  archivo_carga: text;
begin
  randomize;
  assign(archivo_carga,'celulares1.txt');
  cargar_archivo_carga(archivo_carga);
  assign(archivo_celulares,'celulares2');
  menu_opciones(archivo_celulares,archivo_carga);
end.