{TRABAJO PRÁCTICO N° 2}
{EJERCICIO 5}
{Suponer que se trabaja en una oficina donde está montada una LAN (red local). La misma fue construida sobre una topología de red que conecta 5 máquinas entre sí y todas las máquinas se conectan con un servidor central.
Semanalmente, cada máquina genera un archivo de logs informando las sesiones abiertas por cada usuario en cada terminal y por cuánto tiempo estuvo abierta.
Cada archivo detalle contiene los siguientes campos: cod_usuario, fecha, tiempo_sesion.
Se debe realizar un procedimiento que reciba los archivos detalle y genere un archivo maestro con los siguientes datos: cod_usuario, fecha, tiempo_total_de_sesiones_abiertas.
Notas:
•	Cada archivo detalle está ordenado por cod_usuario y fecha.
•	Un usuario puede iniciar más de una sesión el mismo día en la misma máquina o, inclusive, en diferentes máquinas.
•	El archivo maestro debe crearse en la siguiente ubicación física: /var/log.}

program TP2_E5;
{$codepage UTF8}
uses crt, sysutils;
const
  detalles_total=3; // detalles_total=5;
  codigo_salida=999;
type
  t_detalle=1..detalles_total;
  t_string20=string[20];
  t_registro_sesion=record
    codigo: int16;
    fecha: t_string20;
    tiempo: int16;
  end;
  t_archivo_sesiones=file of t_registro_sesion;
  t_vector_sesiones=array[t_detalle] of t_registro_sesion;
  t_vector_detalles=array[t_detalle] of t_archivo_sesiones;
  t_vector_carga_detalles=array[t_detalle] of text;
procedure cargar_archivo_detalle(var archivo_detalle: t_archivo_sesiones; var archivo_carga: text);
var
  registro_sesion: t_registro_sesion;
begin
  rewrite(archivo_detalle);
  reset(archivo_carga);
  while (not eof(archivo_carga)) do
    with registro_sesion do
    begin
      readln(archivo_carga,codigo,tiempo,fecha); fecha:=trim(fecha);
      write(archivo_detalle,registro_sesion);
    end;
  close(archivo_detalle);
  close(archivo_carga);
end;
procedure imprimir_registro_sesion(registro_sesion: t_registro_sesion);
begin
  textcolor(green); write('Código de usuario: '); textcolor(yellow); write(registro_sesion.codigo);
  textcolor(green); write('; Fecha: '); textcolor(yellow); write(registro_sesion.fecha);
  textcolor(green); write('; Tiempo de sesión: '); textcolor(yellow); writeln(registro_sesion.tiempo);
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
  close(archivo_sesiones);
end;
procedure leer_sesion(var archivo_detalle: t_archivo_sesiones; var registro_sesion: t_registro_sesion);
begin
  if (not eof(archivo_detalle)) then
    read(archivo_detalle,registro_sesion)
  else
    registro_sesion.codigo:=codigo_salida;
end;
procedure minimo(var vector_detalles: t_vector_detalles; var vector_sesiones: t_vector_sesiones; var min: t_registro_sesion);
var
  i, pos: t_detalle;
begin
  min.codigo:=codigo_salida;
  for i:= 1 to detalles_total do
    if ((vector_sesiones[i].codigo<min.codigo) or ((vector_sesiones[i].codigo=min.codigo) and (vector_sesiones[i].fecha<min.fecha))) then
    begin
      min:=vector_sesiones[i];
      pos:=i;
    end;
  if (min.codigo<codigo_salida) then
    leer_sesion(vector_detalles[pos],vector_sesiones[pos]);
end;
procedure cargar_archivo_maestro(var archivo_maestro: t_archivo_sesiones; var vector_detalles: t_vector_detalles);
var
  registro_sesion: t_registro_sesion;
  vector_sesiones: t_vector_sesiones;
  min: t_registro_sesion;
  i: t_detalle;
begin
  rewrite(archivo_maestro);
  for i:= 1 to detalles_total do
  begin
    reset(vector_detalles[i]);
    leer_sesion(vector_detalles[i],vector_sesiones[i]);
  end;
  minimo(vector_detalles,vector_sesiones,min);
  while (min.codigo<>codigo_salida) do
  begin
    registro_sesion.codigo:=min.codigo;
    while (registro_sesion.codigo=min.codigo) do
    begin
      registro_sesion.fecha:=min.fecha;
      registro_sesion.tiempo:=0;
      while ((registro_sesion.codigo=min.codigo) and (registro_sesion.fecha=min.fecha)) do
      begin
        registro_sesion.tiempo:=registro_sesion.tiempo+min.tiempo;
        minimo(vector_detalles,vector_sesiones,min);
      end;
      write(archivo_maestro,registro_sesion);
    end;
  end;
  close(archivo_maestro);
  for i:= 1 to detalles_total do
    close(vector_detalles[i]);
end;
var
  vector_detalles: t_vector_detalles;
  vector_carga_detalles: t_vector_carga_detalles;
  archivo_maestro: t_archivo_sesiones;
  i: t_detalle;
begin
  for i:= 1 to detalles_total do
  begin
    writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO DETALLE ',i,':'); writeln();
    assign(vector_detalles[i],'E5_sesionesDetalle'+inttoStr(i)); assign(vector_carga_detalles[i],'E5_sesionesDetalle'+inttoStr(i)+'.txt');
    cargar_archivo_detalle(vector_detalles[i],vector_carga_detalles[i]);
    imprimir_archivo_sesiones(vector_detalles[i]);
  end;
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO MAESTRO:'); writeln();
  assign(archivo_maestro,'E5_sesionesMaestro');
  cargar_archivo_maestro(archivo_maestro,vector_detalles);
  imprimir_archivo_sesiones(archivo_maestro);
end.