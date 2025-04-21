{TRABAJO PRÁCTICO N° 1}
{EJERCICIO 6}
{Agregar al menú del programa del Ejercicio 5 opciones para:
(a) Añadir uno o más celulares al final del archivo con sus datos ingresados por teclado.
(b) Modificar el stock de un celular dado.
(c) Exportar el contenido del archivo binario a un archivo de texto denominado ”SinStock.txt” con aquellos celulares que tengan stock 0.}

program TP1_E6;
{$codepage UTF8}
uses crt, sysutils;
const
  codigo_salida=0;
  stock_disponible_corte=0;
  opcion_salida=0;
type
  t_string20=string[20];
  t_registro_celular=record
    codigo: int16;
    nombre: t_string20;
    descripcion: t_string20;
    marca: t_string20;
    precio: real;
    stock_minimo: int16;
    stock_disponible: int16;
  end;
  t_archivo_celulares=file of t_registro_celular;
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
procedure leer_celular(var registro_celular: t_registro_celular);
var
  vector_marcas: array[1..10] of t_string20=('Alcatel', 'Apple', 'Huawei', 'Lenovo', 'LG', 'Motorola', 'Nokia', 'Samsung', 'Sony', 'Xiaomi');
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
procedure exportar_archivo_txt1(var archivo_celulares: t_archivo_celulares);
var
  registro_celular: t_registro_celular;
  archivo_txt: text;
begin
  reset(archivo_celulares);
  assign(archivo_txt,'E6_celulares2.txt'); rewrite(archivo_txt);
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
function control_unicidad(var archivo_celulares: t_archivo_celulares; codigo: int16): boolean;
var
  registro_celular: t_registro_celular;
  ok: boolean;
begin
  ok:=false;
  while ((not eof(archivo_celulares)) and (ok=false)) do
  begin
    read(archivo_celulares,registro_celular);
    if (registro_celular.codigo=codigo) then
      ok:=true;
  end;
  control_unicidad:=ok;
end;
procedure agregar_celular(var archivo_celulares: t_archivo_celulares);
var
  registro_celular: t_registro_celular;
  celulares: int16;
begin
  celulares:=0;
  reset(archivo_celulares);
  leer_celular(registro_celular);
  while (registro_celular.codigo<>codigo_salida) do
  begin
    if (control_unicidad(archivo_celulares,registro_celular.codigo)=false) then
    begin
      seek(archivo_celulares,filesize(archivo_celulares));
      write(archivo_celulares,registro_celular);
      celulares:=celulares+1;
    end;
    leer_celular(registro_celular);
  end;
  close(archivo_celulares);
  textcolor(green); write('Se han agregado '); textcolor(yellow); write(celulares); textcolor(green); writeln(' celulares al final del archivo');
end;
procedure modificar_stock_celular(var archivo_celulares: t_archivo_celulares);
var
  registro_celular: t_registro_celular;
  codigo: int16;
  ok: boolean;
begin
  codigo:=1+random(1000);
  ok:=false;
  reset(archivo_celulares);
  while ((not eof(archivo_celulares)) and (ok=false)) do
  begin
    read(archivo_celulares,registro_celular);
    if (registro_celular.codigo=codigo) then
    begin
      registro_celular.stock_disponible:=random(101);
      seek(archivo_celulares,filepos(archivo_celulares)-1);
      write(archivo_celulares,registro_celular);
      ok:=true;
    end;
  end;
  close(archivo_celulares);
  if (ok=true) then
  begin
    textcolor(green); write('Se ha modificado el stock del celular con código '); textcolor(yellow); write(codigo); textcolor(green); writeln(' en el archivo');
  end
  else
  begin
    textcolor(green); write('No se ha encontrado el celular con código '); textcolor(yellow); write(codigo); textcolor(green); writeln(' en el archivo');
  end;
end;
procedure exportar_archivo_txt2(var archivo_celulares: t_archivo_celulares);
var
  registro_celular: t_registro_celular;
  archivo_txt: text;
begin
  reset(archivo_celulares);
  assign(archivo_txt,'E6_SinStock.txt'); rewrite(archivo_txt);
  while (not eof(archivo_celulares)) do
  begin
    read(archivo_celulares,registro_celular);
    if (registro_celular.stock_disponible=stock_disponible_corte) then
      with registro_celular do
      begin
        writeln(archivo_txt,codigo,' ',precio:0:2,' ',marca);
        writeln(archivo_txt,stock_disponible,' ',stock_minimo,' ',descripcion);
        writeln(archivo_txt,nombre);
      end;
  end;
  close(archivo_celulares);
  close(archivo_txt);
  textcolor(green); write('Se ha exportado el contenido del archivo binario a un archivo de texto denominado '); textcolor(yellow); write('"SinStock.txt"'); textcolor(green); writeln(' con aquellos celulares que tienen stock 0');
end;
procedure leer_opcion(var opcion: int8);
begin
  textcolor(red); writeln('MENÚ DE OPCIONES');
  textcolor(yellow); write('OPCIÓN 1: '); textcolor(green); writeln('Crear un archivo de registros no ordenados de celulares y cargarlo con datos ingresados desde un archivo de texto denominado "celulares1.txt"');
  textcolor(yellow); write('OPCIÓN 2: '); textcolor(green); writeln('Listar en pantalla los datos de aquellos celulares que tengan un stock menor al stock mínimo');
  textcolor(yellow); write('OPCIÓN 3: '); textcolor(green); writeln('Listar en pantalla los celulares del archivo cuya descripción contenga una cadena de caracteres proporcionada por el usuario');
  textcolor(yellow); write('OPCIÓN 4: '); textcolor(green); writeln('Exportar el archivo creado en el inciso (a) a un archivo de texto denominado "celulares2.txt" con todos los celulares del mismo');
  textcolor(yellow); write('OPCIÓN 5: '); textcolor(green); writeln('Añadir uno o más celulares al final del archivo con sus datos ingresados por teclado');
  textcolor(yellow); write('OPCIÓN 6: '); textcolor(green); writeln('Modificar el stock de un celular dado');
  textcolor(yellow); write('OPCIÓN 7: '); textcolor(green); writeln('Exportar el contenido del archivo binario a un archivo de texto denominado "SinStock.txt" con aquellos celulares que tengan stock 0');
  textcolor(yellow); write('OPCIÓN 0: '); textcolor(green); writeln('Salir del menú de opciones');
  textcolor(green); write('Introducir opción elegida: '); textcolor(yellow); readln(opcion);
  writeln();
end;
procedure menu_opciones(var archivo_celulares: t_archivo_celulares; var archivo_carga: text);
var
  opcion: int8;
begin
  leer_opcion(opcion);
  while (opcion<>opcion_salida) do
  begin
    case opcion of
      1: cargar_archivo_celulares(archivo_celulares,archivo_carga);
      2: imprimir1_archivo_celulares(archivo_celulares);
      3: imprimir2_archivo_celulares(archivo_celulares);
      4: exportar_archivo_txt1(archivo_celulares);
      5: agregar_celular(archivo_celulares);
      6: modificar_stock_celular(archivo_celulares);
      7: exportar_archivo_txt2(archivo_celulares);
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
  assign(archivo_carga,'E6_celulares1.txt');
  assign(archivo_celulares,'E6_celulares2');
  cargar_archivo_carga(archivo_carga);
  menu_opciones(archivo_celulares,archivo_carga);
end.