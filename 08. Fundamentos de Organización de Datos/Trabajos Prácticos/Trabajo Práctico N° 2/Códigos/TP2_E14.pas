{TRABAJO PRÁCTICO N° 2}
{EJERCICIO 14}
{Una compañía aérea dispone de un archivo maestro donde guarda información sobre sus próximos vuelos.
En dicho archivo, se tiene almacenado el destino, fecha, hora de salida y la cantidad de asientos disponibles.
La empresa recibe todos los días dos archivos detalles para actualizar el archivo maestro.
En dichos archivos, se tiene destino, fecha, hora de salida y cantidad de asientos comprados.
Se sabe que los archivos están ordenados por destino más fecha y hora de salida, y que, en los detalles, pueden venir 0, 1 o más registros por cada uno del maestro.
Se pide realizar los módulos necesarios para:
(a) Actualizar el archivo maestro sabiendo que no se registró ninguna venta de pasaje sin asiento disponible.
(b) Generar una lista con aquellos vuelos (destino, fecha y hora de salida) que tengan menos de una cantidad específica de asientos disponibles. La misma debe ser ingresada por teclado.
Nota: El archivo maestro y los archivos detalles sólo pueden recorrerse una vez.}

program TP2_E14;
{$codepage UTF8}
uses crt, sysutils;
const
  detalles_total=2;
  destino_salida='ZZZ';
type
  t_detalle=1..detalles_total;
  t_string20=string[20];
  t_registro_vuelo=record
    destino: t_string20;
    fecha: t_string20;
    hora: t_string20;
    asientos_disponibles: int16;
  end;
  t_registro_venta=record
    destino: t_string20;
    fecha: t_string20;
    hora: t_string20;
    asientos_vendidos: int16;
  end;
  t_archivo_maestro=file of t_registro_vuelo;
  t_archivo_detalle=file of t_registro_venta;
  t_vector_ventas=array[t_detalle] of t_registro_venta;
  t_vector_detalles=array[t_detalle] of t_archivo_detalle;
  t_vector_carga_detalles=array[t_detalle] of text;
procedure cargar_archivo_maestro(var archivo_maestro: t_archivo_maestro; var archivo_carga_maestro: text);
var
  registro_vuelo: t_registro_vuelo;
begin
  rewrite(archivo_maestro);
  reset(archivo_carga_maestro);
  while (not eof(archivo_carga_maestro)) do
    with registro_vuelo do
    begin
      readln(archivo_carga_maestro,asientos_disponibles,destino); destino:=trim(destino);
      readln(archivo_carga_maestro,fecha);
      readln(archivo_carga_maestro,hora);
      write(archivo_maestro,registro_vuelo);
    end;
  close(archivo_maestro);
  close(archivo_carga_maestro);
end;
procedure cargar_archivo_detalle(var archivo_detalle: t_archivo_detalle; var archivo_carga_detalle: text);
var
  registro_venta: t_registro_venta;
begin
  rewrite(archivo_detalle);
  reset(archivo_carga_detalle);
  while (not eof(archivo_carga_detalle)) do
    with registro_venta do
    begin
      readln(archivo_carga_detalle,asientos_vendidos,destino); destino:=trim(destino);
      readln(archivo_carga_detalle,fecha);
      readln(archivo_carga_detalle,hora);
      write(archivo_detalle,registro_venta);
    end;
  close(archivo_detalle);
  close(archivo_carga_detalle);
end;
procedure imprimir_registro_vuelo(registro_vuelo: t_registro_vuelo);
begin
  textcolor(green); write('Destino: '); textcolor(yellow); write(registro_vuelo.destino);
  textcolor(green); write('; Fecha: '); textcolor(yellow); write(registro_vuelo.fecha);
  textcolor(green); write('; Hora: '); textcolor(yellow); write(registro_vuelo.hora);
  textcolor(green); write('; Asientos disponibles: '); textcolor(yellow); writeln(registro_vuelo.asientos_disponibles);
end;
procedure imprimir_archivo_maestro(var archivo_maestro: t_archivo_maestro);
var
  registro_vuelo: t_registro_vuelo;
begin
  reset(archivo_maestro);
  while (not eof(archivo_maestro)) do
  begin
    read(archivo_maestro,registro_vuelo);
    imprimir_registro_vuelo(registro_vuelo);
  end;
  close(archivo_maestro);
end;
procedure imprimir_registro_venta(registro_venta: t_registro_venta);
begin
  textcolor(green); write('Destino: '); textcolor(yellow); write(registro_venta.destino);
  textcolor(green); write('; Fecha: '); textcolor(yellow); write(registro_venta.fecha);
  textcolor(green); write('; Hora: '); textcolor(yellow); write(registro_venta.hora);
  textcolor(green); write('; Asientos vendidos: '); textcolor(yellow); writeln(registro_venta.asientos_vendidos);
end;
procedure imprimir_archivo_detalle(var archivo_detalle: t_archivo_detalle);
var
  registro_venta: t_registro_venta;
begin
  reset(archivo_detalle);
  while (not eof(archivo_detalle)) do
  begin
    read(archivo_detalle,registro_venta);
    imprimir_registro_venta(registro_venta);
  end;
  close(archivo_detalle);
end;
procedure leer_venta(var archivo_detalle: t_archivo_detalle; var registro_venta: t_registro_venta);
begin
  if (not eof(archivo_detalle)) then
    read(archivo_detalle,registro_venta)
  else
    registro_venta.destino:=destino_salida;
end;
procedure minimo(var vector_detalles: t_vector_detalles; var vector_ventas: t_vector_ventas; var min: t_registro_venta);
var
  i, pos: t_detalle;
begin
  min.destino:=destino_salida;
  for i:= 1 to detalles_total do
    if ((vector_ventas[i].destino<min.destino) or ((vector_ventas[i].destino=min.destino) and (vector_ventas[i].fecha<min.fecha)) or ((vector_ventas[i].destino=min.destino) and (vector_ventas[i].fecha=min.fecha) and (vector_ventas[i].hora<min.hora))) then
    begin
      min:=vector_ventas[i];
      pos:=i;
    end;
  if (min.destino<destino_salida) then
    leer_venta(vector_detalles[pos],vector_ventas[pos]);
end;
procedure actualizar_archivo_maestro(var archivo_maestro: t_archivo_maestro; var vector_detalles: t_vector_detalles; asientos: int16);
var
  registro_vuelo: t_registro_vuelo;
  min: t_registro_venta;
  vector_ventas: t_vector_ventas;
  i: t_detalle;
begin
  reset(archivo_maestro);
  for i:= 1 to detalles_total do
  begin
    reset(vector_detalles[i]);
    leer_venta(vector_detalles[i],vector_ventas[i]);
  end;
  minimo(vector_detalles,vector_ventas,min);
  while (min.destino<>destino_salida) do
  begin
    read(archivo_maestro,registro_vuelo);
    while (registro_vuelo.destino<>min.destino) do
      read(archivo_maestro,registro_vuelo);
    while (registro_vuelo.destino=min.destino) do
    begin
      while (registro_vuelo.fecha<>min.fecha) do
        read(archivo_maestro,registro_vuelo);
      while ((registro_vuelo.destino=min.destino) and (registro_vuelo.fecha=min.fecha)) do
      begin
        while (registro_vuelo.hora<>min.hora) do
          read(archivo_maestro,registro_vuelo);
        while ((registro_vuelo.destino=min.destino) and (registro_vuelo.fecha=min.fecha) and (registro_vuelo.hora=min.hora)) do
        begin
          registro_vuelo.asientos_disponibles:=registro_vuelo.asientos_disponibles-min.asientos_vendidos;
          minimo(vector_detalles,vector_ventas,min);
        end;
        seek(archivo_maestro,filepos(archivo_maestro)-1);
        write(archivo_maestro,registro_vuelo);
        if (registro_vuelo.asientos_disponibles<asientos) then
        begin
          textcolor(green); write('El vuelo con destino a '); textcolor(yellow); write(registro_vuelo.destino); textcolor(green); write(' del '); textcolor(yellow); write(registro_vuelo.fecha); textcolor(green); write(' a las '); textcolor(yellow); write(registro_vuelo.hora); textcolor(green); write(' tiene menos de '); textcolor(yellow); write(asientos); textcolor(green); writeln(' asientos disponibles');
        end;
      end;
    end;
  end;
  close(archivo_maestro);
  for i:= 1 to detalles_total do
    close(vector_detalles[i]);
  writeln();
end;
var
  vector_detalles: t_vector_detalles;
  vector_carga_detalles: t_vector_carga_detalles;
  archivo_maestro: t_archivo_maestro;
  archivo_carga_maestro: text;
  i: t_detalle;
  asientos: int16;
begin
  randomize;
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO MAESTRO:'); writeln();
  assign(archivo_maestro,'E14_vuelosMaestro'); assign(archivo_carga_maestro,'E14_vuelosMaestro.txt');
  cargar_archivo_maestro(archivo_maestro,archivo_carga_maestro);
  imprimir_archivo_maestro(archivo_maestro);
  for i:= 1 to detalles_total do
  begin
    writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO DETALLE ',i,':'); writeln();
    assign(vector_detalles[i],'E14_ventasDetalle'+inttoStr(i)); assign(vector_carga_detalles[i],'E14_ventasDetalle'+inttoStr(i)+'.txt');
    cargar_archivo_detalle(vector_detalles[i],vector_carga_detalles[i]);
    imprimir_archivo_detalle(vector_detalles[i]);
  end;
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO MAESTRO ACTUALIZADO:'); writeln();
  asientos:=10+random(291);
  actualizar_archivo_maestro(archivo_maestro,vector_detalles,asientos);
  imprimir_archivo_maestro(archivo_maestro);
end.