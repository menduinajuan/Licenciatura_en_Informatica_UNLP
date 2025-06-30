{TRABAJO PRÁCTICO N° 3}
{EJERCICIO 11}
{Suponer que se trabaja en una oficina donde está montada una LAN (red local). La misma fue construida sobre una topología de red que conecta 5 máquinas entre sí y todas las máquinas se conectan con un servidor central.
Semanalmente, cada máquina genera un archivo de logs informando las sesiones abiertas por cada usuario en cada terminal y por cuánto tiempo estuvo abierta.
Cada archivo detalle contiene los siguientes campos: cod_usuario, fecha, tiempo_sesion.
Se debe realizar un procedimiento que reciba los archivos detalle y genere un archivo maestro con los siguientes datos: cod_usuario, fecha, tiempo_total_de_sesiones_abiertas.
Notas:
•	Los archivos detalle no están ordenados por ningún criterio.
•	Un usuario puede iniciar más de una sesión el mismo día en la misma máquina o, inclusive, en diferentes máquinas.}

program TP3_E11;
{$codepage UTF8}
uses crt, sysutils;
const
  detalles_total=5;
  codigo_salida=-1;
type
  t_detalle=1..detalles_total;
  t_string20=string[20];
  t_registro_sesion=record
    codigo: int16;
    fecha: t_string20;
    tiempo: int16;
  end;
  t_archivo_sesiones=file of t_registro_sesion;
  t_vector_detalles=array[t_detalle] of t_archivo_sesiones;
procedure leer_sesion(var registro_sesion: t_registro_sesion);
var
  i: int8;
begin
  i:=random(10);
  if (i=0) then
    registro_sesion.codigo:=codigo_salida
  else
    registro_sesion.codigo:=1+random(10);
  if (registro_sesion.codigo<>codigo_salida) then
  begin
    registro_sesion.fecha:='2025-01-'+inttoStr(1+random(30));
    registro_sesion.tiempo:=1+random(100);
  end;
end;
procedure cargar_archivo_detalle(var archivo_detalle: t_archivo_sesiones);
var
  registro_sesion: t_registro_sesion;
begin
  rewrite(archivo_detalle);
  leer_sesion(registro_sesion);
  while (registro_sesion.codigo<>codigo_salida) do
  begin
    write(archivo_detalle,registro_sesion);
    leer_sesion(registro_sesion);
  end;
  close(archivo_detalle);
end;
procedure imprimir_registro_sesion(registro_sesion: t_registro_sesion);
begin
  textcolor(green); write('Código de usuario: '); textcolor(yellow); write(registro_sesion.codigo);
  textcolor(green); write('; Fecha: '); textcolor(yellow); write(registro_sesion.fecha);
  textcolor(green); write('; Tiempo: '); textcolor(yellow); writeln(registro_sesion.tiempo);
end;
procedure imprimir_archivo_sesiones(var archivo_sesiones: t_archivo_sesiones);
var
  registro_sesion: t_registro_sesion;
begin
  reset(archivo_sesiones);
  while (not eof(archivo_sesiones)) do
  begin
    read(archivo_sesiones,registro_sesion);
    imprimir_registro_sesion(registro_sesion);
  end;
  textcolor(green); write('Tamaño del archivo sesiones: '); textcolor(yellow); writeln(filesize(archivo_sesiones));
  close(archivo_sesiones);
end;
procedure cargar_archivo_maestro(var archivo_maestro: t_archivo_sesiones; var vector_detalles: t_vector_detalles);
var
  registro_sesion_detalle, registro_sesion_maestro: t_registro_sesion;
  i: t_detalle;
  ok: boolean;
begin
  rewrite(archivo_maestro);
  for i:= 1 to detalles_total do
  begin
    reset(vector_detalles[i]);
    while (not eof(vector_detalles[i])) do
    begin
      ok:=false;
      read(vector_detalles[i],registro_sesion_detalle);
      seek(archivo_maestro,0);
      while (not eof(archivo_maestro)) and (ok=false) do
      begin
        read(archivo_maestro,registro_sesion_maestro);
        if ((registro_sesion_maestro.codigo=registro_sesion_detalle.codigo) and (registro_sesion_maestro.fecha=registro_sesion_detalle.fecha)) then
          ok:=true;
      end;
      if (ok=true) then
      begin
        registro_sesion_maestro.tiempo:=registro_sesion_maestro.tiempo+registro_sesion_detalle.tiempo;
        seek(archivo_maestro,filepos(archivo_maestro)-1);
        write(archivo_maestro,registro_sesion_maestro);
      end
      else
        write(archivo_maestro,registro_sesion_detalle);
    end;
    close(vector_detalles[i]);
  end;
  close(archivo_maestro);
end;
var
  vector_detalles: t_vector_detalles;
  archivo_maestro: t_archivo_sesiones;
  i: t_detalle;
begin
  randomize;
  for i:= 1 to detalles_total do
  begin
    writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO DETALLE ',i,':'); writeln();
    assign(vector_detalles[i],'E11_sesionesDetalle'+inttoStr(i));
    cargar_archivo_detalle(vector_detalles[i]);
    imprimir_archivo_sesiones(vector_detalles[i]);
  end;
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO MAESTRO:'); writeln();
  assign(archivo_maestro,'E11_sesionesMaestro');
  cargar_archivo_maestro(archivo_maestro,vector_detalles);
  imprimir_archivo_sesiones(archivo_maestro);
end.