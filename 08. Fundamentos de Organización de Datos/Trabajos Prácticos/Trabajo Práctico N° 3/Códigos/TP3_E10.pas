{TRABAJO PRÁCTICO N° 3}
{EJERCICIO 10}
{Se necesita contabilizar los votos de las diferentes mesas electorales registradas por localidad en la Provincia de Buenos Aires.
Para ello, se posee un archivo con la siguiente información: código de localidad, número de mesa y cantidad de votos en dicha mesa.
Presentar en pantalla un listado como se muestra a continuación:
Notas:
•	La información en el archivo no está ordenada por ningún criterio.
•	Tratar de resolver el problema sin modificar el contenido del archivo dado.
•	Se puede utilizar una estructura auxiliar, como por ejemplo otro archivo, para llevar el control de las localidades que han sido procesadas.}

program TP3_E10;
{$codepage UTF8}
uses crt;
const
  localidad_salida=-1;
type
  t_registro_mesa=record
    localidad: int16;
    numero: int16;
    votos: int32;
  end;
  t_archivo_mesas=file of t_registro_mesa;
procedure leer_mesa(var registro_mesa: t_registro_mesa);
var
  i: int8;
begin
  i:=random(10);
  if (i=0) then
    registro_mesa.localidad:=localidad_salida
  else
    registro_mesa.localidad:=1+random(100);
  if (registro_mesa.localidad<>localidad_salida) then
  begin
    registro_mesa.numero:=1+random(100);
    registro_mesa.votos:=10+random(991);
  end;
end;
procedure cargar_archivo_mesas(var archivo_mesas: t_archivo_mesas);
var
  registro_mesa: t_registro_mesa;
begin
  rewrite(archivo_mesas);
  leer_mesa(registro_mesa);
  while (registro_mesa.localidad<>localidad_salida) do
  begin
    write(archivo_mesas, registro_mesa);
    leer_mesa(registro_mesa);
  end;
  close(archivo_mesas);
end;
procedure imprimir_registro_mesa(registro_mesa: t_registro_mesa);
begin
  textcolor(green); write('Código de localidad: '); textcolor(yellow); write(registro_mesa.localidad);
  textcolor(green); write('; Número de mesa: '); textcolor(yellow); write(registro_mesa.numero);
  textcolor(green); write('; Votos: '); textcolor(yellow); writeln(registro_mesa.votos);
end;
procedure imprimir_archivo_mesas(var archivo_mesas: t_archivo_mesas);
var
  registro_mesa: t_registro_mesa;
begin
  reset(archivo_mesas);
  while (not eof(archivo_mesas)) do
  begin
    read(archivo_mesas,registro_mesa);
    imprimir_registro_mesa(registro_mesa);
  end;
  textcolor(green); write('Tamaño del archivo mesas: '); textcolor(yellow); writeln(filesize(archivo_mesas));
  close(archivo_mesas);
end;
procedure cargar_archivo_mesas_aux(var archivo_mesas: t_archivo_mesas; var archivo_mesas_aux: t_archivo_mesas);
var
  registro_mesa, registro_mesa_aux: t_registro_mesa;
  ok: boolean;
begin
  reset(archivo_mesas);
  rewrite(archivo_mesas_aux);
  while (not eof(archivo_mesas)) do
  begin
    ok:=false;
    read(archivo_mesas,registro_mesa);
    seek(archivo_mesas_aux,0);
    while (not eof(archivo_mesas_aux)) and (ok=false) do
    begin
      read(archivo_mesas_aux,registro_mesa_aux);
      if (registro_mesa_aux.localidad=registro_mesa.localidad) then
        ok:=true;
    end;
    if (ok=true) then
    begin
      registro_mesa_aux.votos:=registro_mesa_aux.votos+registro_mesa.votos;
      seek(archivo_mesas_aux,filepos(archivo_mesas_aux)-1);
      write(archivo_mesas_aux,registro_mesa_aux);
    end
    else
      write(archivo_mesas_aux,registro_mesa);
  end;
  close(archivo_mesas);
  close(archivo_mesas_aux);
end;
procedure imprimir_archivo_mesas_aux(var archivo_mesas: t_archivo_mesas);
var
  registro_mesa: t_registro_mesa;
  votos_total: int32;
begin
  votos_total:=0;
  reset(archivo_mesas);
  textcolor(green); writeln('Código de Localidad          Total de Votos');
  while (not eof(archivo_mesas)) do
  begin
    read(archivo_mesas,registro_mesa);
    textcolor(yellow); write(registro_mesa.localidad); textcolor(green); write('                           '); textcolor(red); writeln(registro_mesa.votos);
    votos_total:=votos_total+registro_mesa.votos;
  end;
  textcolor(green); write('Total General de Votos:      '); textcolor(red); writeln(votos_total);
  close(archivo_mesas);
end;
var
  archivo_mesas, archivo_mesas_aux: t_archivo_mesas;
begin
  randomize;
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO MESAS:'); writeln();
  assign(archivo_mesas,'E10_mesas');
  cargar_archivo_mesas(archivo_mesas);
  imprimir_archivo_mesas(archivo_mesas);
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO MESAS AUXILIAR:'); writeln();
  assign(archivo_mesas_aux,'E10_mesas_aux');
  cargar_archivo_mesas_aux(archivo_mesas,archivo_mesas_aux);
  imprimir_archivo_mesas(archivo_mesas_aux);
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO MESAS AUXILIAR:'); writeln();
  imprimir_archivo_mesas_aux(archivo_mesas_aux);
end.