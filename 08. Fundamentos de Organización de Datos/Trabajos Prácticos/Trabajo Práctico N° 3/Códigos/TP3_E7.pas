{TRABAJO PRÁCTICO N° 3}
{EJERCICIO 7}
{Se cuenta con un archivo que almacena información sobre especies de aves en vía de extinción.
Para ello, se almacena: código, nombre de la especie, familia de ave, descripción y zona geográfica.
El archivo no está ordenado por ningún criterio. Realizar un programa que permita borrar especies de aves extintas.
Este programa debe disponer de dos procedimientos:
(a) Un procedimiento que, dada una especie de ave (su código), marque la misma como borrada (en caso de querer borrar múltiples especies de aves, se podría invocar este procedimiento repetidamente).
(b) Un procedimiento que compacte el archivo, quitando, definitivamente, las especies de aves marcadas como borradas.
Para quitar los registros, se deberá copiar el último registro del archivo en la posición del registro a borrar y, luego, eliminar del archivo el último registro de forma tal de evitar registros duplicados.
  (i) Implementar una variante de este procedimiento de compactación del archivo (baja física) donde el archivo se trunque una sola vez.}

program TP3_E7;
{$codepage UTF8}
uses crt;
const
  codigo_salida=-1;
  codigo_baja=-1;
type
  t_string20=string[20];
  t_registro_ave=record
    codigo: int16;
    nombre: t_string20;
    familia: t_string20;
    descripcion: t_string20;
    zona: t_string20;
  end;
  t_archivo_aves=file of t_registro_ave;
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
procedure leer_ave(var registro_ave: t_registro_ave);
var
  i: int8;
begin
  i:=random(10);
  if (i=0) then
    registro_ave.codigo:=codigo_salida
  else
    registro_ave.codigo:=1+random(1000);
  if (registro_ave.codigo<>codigo_salida) then
  begin
    registro_ave.nombre:=random_string(5+random(6));
    registro_ave.familia:=random_string(5+random(6));
    registro_ave.descripcion:=random_string(10+random(10));
    registro_ave.zona:=random_string(5+random(6));
  end;
end;
procedure cargar_archivo_aves(var archivo_aves: t_archivo_aves);
var
  registro_ave: t_registro_ave;
begin
  rewrite(archivo_aves);
  leer_ave(registro_ave);
  while (registro_ave.codigo<>codigo_salida) do
  begin
    write(archivo_aves,registro_ave);
    leer_ave(registro_ave);
  end;
  close(archivo_aves);
end;
procedure imprimir_registro_ave(registro_ave: t_registro_ave);
begin
  textcolor(green); write('Nombre: '); textcolor(yellow); write(registro_ave.nombre);
  textcolor(green); write('; Código: '); textcolor(yellow); write(registro_ave.codigo);
  textcolor(green); write('; Familia: '); textcolor(yellow); write(registro_ave.familia);
  textcolor(green); write('; Descripción: '); textcolor(yellow); write(registro_ave.descripcion);
  textcolor(green); write('; Zona geográfica: '); textcolor(yellow); writeln(registro_ave.zona);
end;
procedure imprimir_archivo_aves(var archivo_aves: t_archivo_aves);
var
  registro_ave: t_registro_ave;
begin
  reset(archivo_aves);
  while (not eof(archivo_aves)) do
  begin
    read(archivo_aves,registro_ave);
    imprimir_registro_ave(registro_ave);
  end;
  textcolor(green); write('Tamaño del archivo aves: '); textcolor(yellow); writeln(filesize(archivo_aves));
  close(archivo_aves);
end;
procedure leer_codigo(var codigo: int16);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    codigo:=codigo_salida
  else
    codigo:=1+random(1000);
end;
procedure baja_logica(var archivo_aves: t_archivo_aves; codigo: int16);
var
  registro_ave: t_registro_ave;
  ok: boolean;
begin
  ok:=false;
  reset(archivo_aves);
  while (not eof(archivo_aves)) and (ok=false) do
  begin
    read(archivo_aves,registro_ave);
    if (registro_ave.codigo=codigo) then
    begin
      ok:=true;
      registro_ave.codigo:=codigo_baja;
      seek(archivo_aves,filepos(archivo_aves)-1);
      write(archivo_aves,registro_ave);
    end;
  end;
  close(archivo_aves);
  if (ok=true) then
  begin
    textcolor(green); write('Se ha realizado la baja de la especie de ave con código '); textcolor(yellow); write(codigo); textcolor(green); writeln(' en el archivo');
  end
  else
  begin
    textcolor(green); write('No se ha encontrado la especie de ave con código '); textcolor(yellow); write(codigo); textcolor(green); writeln(' en el archivo');
  end;
end;
procedure bajas_logicas(var archivo_aves: t_archivo_aves);
var
  codigo: int16;
begin
  leer_codigo(codigo);
  while (codigo<>codigo_salida) do
  begin
    baja_logica(archivo_aves,codigo);
    leer_codigo(codigo);
  end;
  writeln();
end;
procedure bajas_fisicas1(var archivo_aves: t_archivo_aves);
var
  registro_ave, registro_ultima_ave: t_registro_ave;
  pos: int16;
begin
  reset(archivo_aves);
  while (not eof(archivo_aves)) do
  begin
    read(archivo_aves,registro_ave);
    if (registro_ave.codigo=codigo_baja) then
    begin
      pos:=filepos(archivo_aves)-1;
      seek(archivo_aves,filesize(archivo_aves)-1);
      read(archivo_aves,registro_ultima_ave);
      seek(archivo_aves,pos);
      write(archivo_aves,registro_ultima_ave);
      seek(archivo_aves,filesize(archivo_aves)-1);
      truncate(archivo_aves);
      seek(archivo_aves,pos);
    end;
  end;
  close(archivo_aves);
end;
procedure bajas_fisicas2(var archivo_aves: t_archivo_aves);
var
  registro_ave, registro_ultima_ave: t_registro_ave;
  pos_act, pos_ult: int16;
begin
  reset(archivo_aves);
  if (not eof(archivo_aves)) then
  begin
    pos_act:=0; pos_ult:=filesize(archivo_aves)-1;
    while (pos_act<=pos_ult) do
    begin
      seek(archivo_aves,pos_act);
      read(archivo_aves,registro_ave);
      if (registro_ave.codigo=codigo_baja) then
      begin
        seek(archivo_aves,pos_ult);
        read(archivo_aves,registro_ultima_ave);
        seek(archivo_aves,pos_act);
        write(archivo_aves,registro_ultima_ave);
        pos_ult:=pos_ult-1;
      end
      else
        pos_act:=pos_act+1;
    end;
    seek(archivo_aves,pos_ult+1);
    truncate(archivo_aves);
  end;
  close(archivo_aves);
end;
var
  archivo_aves: t_archivo_aves;
begin
  randomize;
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO AVES:'); writeln();
  assign(archivo_aves,'E7_aves');
  cargar_archivo_aves(archivo_aves);
  imprimir_archivo_aves(archivo_aves);
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO AVES CON BAJAS LÓGICAS:'); writeln();
  bajas_logicas(archivo_aves);
  imprimir_archivo_aves(archivo_aves);
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO AVES CON BAJAS FÍSICAS:'); writeln();
  bajas_fisicas1(archivo_aves);
  imprimir_archivo_aves(archivo_aves);
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO AVES CON BAJAS FÍSICAS:'); writeln();
  bajas_fisicas2(archivo_aves);
  imprimir_archivo_aves(archivo_aves);
end.