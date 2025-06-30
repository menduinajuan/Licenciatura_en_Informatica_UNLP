{TRABAJO PRÁCTICO N° 3}
{EJERCICIO 3}
{Realizar un programa que genere un archivo de novelas filmadas durante el presente año. De cada novela, se registra: código, género, nombre, duración, director y precio.
El programa debe presentar un menú con las siguientes opciones:
(a) Crear el archivo y cargarlo a partir de datos ingresados por teclado. Se utiliza la técnica de lista invertida para recuperar espacio libre en el archivo.
Para ello, durante la creación del archivo, en el primer registro del mismo, se debe almacenar la cabecera de la lista.
Es decir, un registro ficticio, inicializando con el valor cero (0) el campo correspondiente al código de novela, el cual indica que no hay espacio libre dentro del archivo.
(b) Abrir el archivo existente y permitir su mantenimiento teniendo en cuenta el inciso (a), se utiliza lista invertida para recuperación de espacio.
En particular, para el campo de “enlace” de la lista (utilizar el código de novela como enlace), se debe especificar los números de registro referenciados con signo negativo.
Una vez abierto el archivo, brindar operaciones para:
  (i) Dar de alta una novela leyendo la información desde teclado. Para esta operación, en caso de ser posible, deberá recuperarse el espacio libre. Es decir, si, en el campo correspondiente al código de novela del registro cabecera, hay un valor negativo, por ejemplo -5, se debe leer el registro en la posición 5, copiarlo en la posición 0 (actualizar la lista de espacio libre) y grabar el nuevo registro en la posición 5. Con el valor 0 (cero) en el registro cabecera se indica que no hay espacio libre.
  (ii) Modificar los datos de una novela leyendo la información desde teclado. El código de novela no puede ser modificado.
  (iii) Eliminar una novela cuyo código es ingresado por teclado. Por ejemplo, si se da de baja un registro en la posición 8, en el campo código de novela del registro cabecera, deberá figurar -8 y, en el registro en la posición 8, debe copiarse el antiguo registro cabecera.
(c) Listar, en un archivo de texto, todas las novelas, incluyendo las borradas, que representan la lista de espacio libre. El archivo debe llamarse “novelas.txt”.
Nota: Tanto en la creación como en la apertura, el nombre del archivo debe ser proporcionado por el usuario.}

program TP3_E3;
{$codepage UTF8}
uses crt;
const
  codigo_salida=-1;
  codigo_cabecera=0;
  opcion_salida=0;
type
  t_string10=string[10];
  t_registro_novela=record
    codigo: int16;
    genero: t_string10;
    nombre: t_string10;
    duracion: int16;
    director: t_string10;
    precio: real;
  end;
  t_archivo_novelas=file of t_registro_novela;
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
procedure leer_cabecera(var registro_novela: t_registro_novela);
begin
  registro_novela.codigo:=codigo_cabecera;
  registro_novela.genero:='Cabecera';
  registro_novela.nombre:='Cabecera';
  registro_novela.duracion:=codigo_cabecera;
  registro_novela.director:='Cabecera';
  registro_novela.precio:=codigo_cabecera;
end;
procedure leer_novela(var registro_novela: t_registro_novela);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    registro_novela.codigo:=codigo_salida
  else
    registro_novela.codigo:=1+random(1000);
  if (registro_novela.codigo<>codigo_salida) then
  begin
    registro_novela.genero:=random_string(5+random(5));
    registro_novela.nombre:=random_string(5+random(5));
    registro_novela.duracion:=30+random(121);
    registro_novela.director:=random_string(5+random(5));
    registro_novela.precio:=1+random(100);
  end;
end;
procedure cargar_archivo_novelas(var archivo_novelas: t_archivo_novelas);
var
  registro_novela: t_registro_novela;
begin
  rewrite(archivo_novelas);
  leer_cabecera(registro_novela);
  while (registro_novela.codigo<>codigo_salida) do
  begin
    write(archivo_novelas,registro_novela);
    leer_novela(registro_novela);
  end;
  close(archivo_novelas);
  textcolor(green); writeln('El archivo binario de novelas fue creado y cargado con éxito');
end;
procedure imprimir_registro_novela(registro_novela: t_registro_novela);
begin
  textcolor(green); write('Código: '); textcolor(yellow); write(registro_novela.codigo);
  textcolor(green); write('; Género: '); textcolor(yellow); write(registro_novela.genero);
  textcolor(green); write('; Nombre: '); textcolor(yellow); write(registro_novela.nombre);
  textcolor(green); write('; Duración: '); textcolor(yellow); write(registro_novela.duracion);
  textcolor(green); write('; Director: '); textcolor(yellow); write(registro_novela.director);
  textcolor(green); write('; Precio: $'); textcolor(yellow); writeln(registro_novela.precio:0:2);
end;
procedure imprimir_archivo_novelas(var archivo_novelas: t_archivo_novelas);
var
  registro_novela: t_registro_novela;
begin
  reset(archivo_novelas);
  textcolor(green); writeln('Las novelas del archivo son: ');
  while (not eof(archivo_novelas)) do
  begin
    read(archivo_novelas,registro_novela);
    if (registro_novela.codigo>codigo_cabecera) then
      imprimir_registro_novela(registro_novela);
  end;
  textcolor(green); write('Tamaño del archivo novelas: '); textcolor(yellow); writeln(filesize(archivo_novelas));
  close(archivo_novelas);
end;
procedure agregar_novela(var archivo_novelas: t_archivo_novelas);
var
  registro_novela, cabecera: t_registro_novela;
begin
  reset(archivo_novelas);
  read(archivo_novelas,cabecera);
  leer_novela(registro_novela);
  while (registro_novela.codigo=codigo_salida) do
    leer_novela(registro_novela);
  if (cabecera.codigo=codigo_cabecera) then
  begin
    seek(archivo_novelas,filesize(archivo_novelas));
    write(archivo_novelas,registro_novela);
  end
  else
  begin
    seek(archivo_novelas,cabecera.codigo*(-1));
    read(archivo_novelas,cabecera);
    seek(archivo_novelas,filepos(archivo_novelas)-1);
    write(archivo_novelas,registro_novela);
    seek(archivo_novelas,0);
    write(archivo_novelas,cabecera);
  end;
  close(archivo_novelas);
  textcolor(green); write('Se ha realizado el alta de la novela con código '); textcolor(yellow); write(registro_novela.codigo); textcolor(green); writeln(' en el archivo');
end;
procedure modificar_novela(var archivo_novelas: t_archivo_novelas);
var
  registro_novela: t_registro_novela;
  codigo: int16;
  ok: boolean;
begin
  ok:=false;
  codigo:=1+random(1000);
  reset(archivo_novelas);
  while ((not eof(archivo_novelas)) and (ok=false)) do
  begin
    read(archivo_novelas,registro_novela);
    if (registro_novela.codigo=codigo) then
    begin
      ok:=true;
      leer_novela(registro_novela);
      while (registro_novela.codigo=codigo_salida) do
        leer_novela(registro_novela);
      registro_novela.codigo:=codigo;
      seek(archivo_novelas,filepos(archivo_novelas)-1);
      write(archivo_novelas,registro_novela);
    end;
  end;
  close(archivo_novelas);
  if (ok=true) then
  begin
    textcolor(green); write('Se ha realizado la modificación de la novela con código '); textcolor(yellow); write(codigo); textcolor(green); writeln(' en el archivo'); 
  end
  else
  begin
    textcolor(green); write('No se ha encontrado la novela con código '); textcolor(yellow); write(codigo); textcolor(green); writeln(' en el archivo');
  end;
end;
procedure eliminar_novela(var archivo_novelas: t_archivo_novelas);
var
  registro_novela, cabecera: t_registro_novela;
  codigo: int16;
  ok: boolean;
begin
  ok:=false;
  codigo:=1+random(1000);
  reset(archivo_novelas);
  read(archivo_novelas,cabecera);
  while ((not eof(archivo_novelas)) and (ok=false)) do
  begin
    read(archivo_novelas,registro_novela);
    if (registro_novela.codigo=codigo) then
    begin
      ok:=true;
      seek(archivo_novelas,filepos(archivo_novelas)-1);
      write(archivo_novelas,cabecera);
      cabecera.codigo:=(filepos(archivo_novelas)-1)*(-1);
      seek(archivo_novelas,0);
      write(archivo_novelas,cabecera);
    end;
  end;
  close(archivo_novelas);
  if (ok=true) then
  begin
    textcolor(green); write('Se ha realizado la baja de la novela con código '); textcolor(yellow); write(codigo); textcolor(green); writeln(' en el archivo');
  end
  else
  begin
    textcolor(green); write('No se ha encontrado la novela con código '); textcolor(yellow); write(codigo); textcolor(green); writeln(' en el archivo');
  end;
end;
procedure exportar_archivo_txt(var archivo_novelas: t_archivo_novelas);
var
  registro_novela: t_registro_novela;
  archivo_txt: text;
begin
  reset(archivo_novelas);
  assign(archivo_txt,'E3_novelas.txt'); rewrite(archivo_txt);
  while (not eof(archivo_novelas)) do
  begin
    read(archivo_novelas,registro_novela);
    with registro_novela do
      writeln(archivo_txt,'Código: ',codigo,'; Género: ',genero,'; Nombre: ',nombre,'; Duración: ',duracion,'; Director: ',director,'; Precio: $',precio:0:2);
  end;
  close(archivo_novelas);
  close(archivo_txt);
  textcolor(green); write('Se han exportado todas las novelas, incluyendo las borradas, a un archivo de texto llamado '); textcolor(yellow); writeln('"E3_novelas.txt"');
end;
procedure leer_opcion(var opcion: int8);
begin
  textcolor(red); writeln('MENÚ DE OPCIONES');
  textcolor(yellow); write('OPCIÓN 1: '); textcolor(green); writeln('Crear el archivo y cargarlo a partir de datos ingresados por teclado');
  textcolor(yellow); write('OPCIÓN 2: '); textcolor(green); writeln('Listar en pantalla los datos de las novelas del archivo, sin incluir las borradas');
  textcolor(yellow); write('OPCIÓN 3: '); textcolor(green); writeln('Dar de alta una novela leyendo la información desde teclado');
  textcolor(yellow); write('OPCIÓN 4: '); textcolor(green); writeln('Modificar los datos de una novela leyendo la información desde teclado');
  textcolor(yellow); write('OPCIÓN 5: '); textcolor(green); writeln('Eliminar una novela cuyo código es ingresado por teclado');
  textcolor(yellow); write('OPCIÓN 6: '); textcolor(green); writeln('Exportar a un archivo de texto llamado "novelas.txt" todas las novelas, incluyendo las borradas');
  textcolor(yellow); write('OPCIÓN 0: '); textcolor(green); writeln('Salir del menú de opciones');
  textcolor(green); write('Introducir opción elegida: '); textcolor(yellow); readln(opcion);
  writeln();
end;
procedure menu_opciones(var archivo_novelas: t_archivo_novelas);
var
  opcion: int8;
begin
  leer_opcion(opcion);
  while (opcion<>opcion_salida) do
  begin
    case opcion of
      1: cargar_archivo_novelas(archivo_novelas);
      2: imprimir_archivo_novelas(archivo_novelas);
      3: agregar_novela(archivo_novelas);
      4: modificar_novela(archivo_novelas);
      5: eliminar_novela(archivo_novelas);
      6: exportar_archivo_txt(archivo_novelas);
    else
      writeln('La opción ingresada no corresponde a ninguna del menú de opciones');
    end;
    writeln();
    leer_opcion(opcion);
  end;
end;
var
  archivo_novelas: t_archivo_novelas;
begin
  randomize;
  assign(archivo_novelas,'E3_novelas');
  menu_opciones(archivo_novelas);
end.