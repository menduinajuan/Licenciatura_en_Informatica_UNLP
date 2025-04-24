{TRABAJO PRÁCTICO N° 2}
{EJERCICIO 10}
{Se necesita contabilizar los votos de las diferentes mesas electorales registradas por provincia y localidad.
Para ello, se posee un archivo con la siguiente información: código de provincia, código de localidad, número de mesa y cantidad de votos en dicha mesa.
Presentar en pantalla un listado como se muestra a continuación:
Nota: La información está ordenada por código de provincia y código de localidad.}

program TP2_E10;
{$codepage UTF8}
uses crt, sysutils;
const
  provincia_salida=999;
type
  t_registro_votos=record
    provincia: int16;
    localidad: int16;
    mesa: int16;
    votos: int32;
  end;
  t_archivo_maestro=file of t_registro_votos;
procedure cargar_archivo_maestro(var archivo_maestro: t_archivo_maestro; var archivo_carga_maestro: text);
var
  registro_votos: t_registro_votos;
begin
  rewrite(archivo_maestro);
  reset(archivo_carga_maestro);
  while (not eof(archivo_carga_maestro)) do
    with registro_votos do
    begin
      readln(archivo_carga_maestro,provincia,localidad,mesa,votos);
      write(archivo_maestro,registro_votos);
    end;
  close(archivo_maestro);
  close(archivo_carga_maestro);
end;
procedure imprimir_registro_votos(registro_votos: t_registro_votos);
begin
  textcolor(green); write('Código de provincia: '); textcolor(yellow); write(registro_votos.provincia);
  textcolor(green); write('; Código de localidad: '); textcolor(yellow); write(registro_votos.localidad);
  textcolor(green); write('; Número de mesa: '); textcolor(yellow); write(registro_votos.mesa);
  textcolor(green); write('; Cantidad de votos: '); textcolor(yellow); writeln(registro_votos.votos);
end;
procedure imprimir_archivo_maestro(var archivo_maestro: t_archivo_maestro);
var
  registro_votos: t_registro_votos;
begin
  reset(archivo_maestro);
  while (not eof(archivo_maestro)) do
  begin
    read(archivo_maestro,registro_votos);
    imprimir_registro_votos(registro_votos);
  end;
  close(archivo_maestro);
end;
procedure leer_votos(var archivo_maestro: t_archivo_maestro; var registro_votos: t_registro_votos);
begin
  if (not eof(archivo_maestro)) then
    read(archivo_maestro,registro_votos)
  else
    registro_votos.provincia:=provincia_salida;
end;
procedure procesar_archivo_maestro(var archivo_maestro: t_archivo_maestro);
var
  registro_votos: t_registro_votos;
  provincia, localidad: int16;
  votos_total, votos_provincia, votos_localidad: int32;
begin
  votos_total:=0;
  reset(archivo_maestro);
  leer_votos(archivo_maestro,registro_votos);
  while (registro_votos.provincia<>provincia_salida) do
  begin
    provincia:=registro_votos.provincia;
    votos_provincia:=0;
    textcolor(green); write('Código de Provincia: '); textcolor(yellow); writeln(provincia);
    textcolor(green); writeln('Código de Localidad          Total de Votos');
    while (registro_votos.provincia=provincia) do
    begin
      localidad:=registro_votos.localidad;
      votos_localidad:=0;
      while ((registro_votos.provincia=provincia) and (registro_votos.localidad=localidad)) do
      begin
        votos_localidad:=votos_localidad+registro_votos.votos;
        leer_votos(archivo_maestro,registro_votos);
      end;
      textcolor(yellow); write(localidad); textcolor(green); write('                            '); textcolor(red); writeln(votos_localidad);
      votos_provincia:=votos_provincia+votos_localidad;
    end;
    textcolor(green); write('Total de Votos Provincia: '); textcolor(red); writeln(votos_provincia); writeln();
    votos_total:=votos_total+votos_provincia;
  end;
  textcolor(green); write('Total General de Votos: '); textcolor(red); writeln(votos_total);
  close(archivo_maestro);
end;
var
  archivo_maestro: t_archivo_maestro;
  archivo_carga_maestro: text;
begin
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO MAESTRO:'); writeln();
  assign(archivo_maestro,'E10_votosMaestro'); assign(archivo_carga_maestro,'E10_votosMaestro.txt');
  cargar_archivo_maestro(archivo_maestro,archivo_carga_maestro);
  imprimir_archivo_maestro(archivo_maestro);
  writeln(); textcolor(red); writeln('PROCESAMIENTO ARCHIVO MAESTRO:'); writeln();
  procesar_archivo_maestro(archivo_maestro);
end.