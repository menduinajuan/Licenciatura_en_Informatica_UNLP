{TRABAJO PRÁCTICO N° 2}
{EJERCICIO 1}
{Una empresa posee un archivo con información de los ingresos percibidos por diferentes empleados en concepto de comisión.
De cada uno de ellos, se conoce: código de empleado, nombre y monto de la comisión.
La información del archivo se encuentra ordenada por código de empleado y cada empleado puede aparecer más de una vez en el archivo de comisiones.
Realizar un procedimiento que reciba el archivo anteriormente descrito y lo compacte.
En consecuencia, deberá generar un nuevo archivo en el cual cada empleado aparezca una única vez con el valor total de sus comisiones.
Nota: No se conoce, a priori, la cantidad de empleados. Además, el archivo debe ser recorrido una única vez.}

program TP2_E1;
{$codepage UTF8}
uses crt, sysutils;
const
  codigo_salida=999;
type
  t_string10=string[10];
  t_registro_empleado=record
    codigo: int16;
    nombre: t_string10;
    comision: real;
  end;
  t_archivo_empleados=file of t_registro_empleado;
procedure cargar_archivo_detalle(var archivo_detalle: t_archivo_empleados; var archivo_carga: text);
var
  registro_empleado: t_registro_empleado;
begin
  rewrite(archivo_detalle);
  reset(archivo_carga);
  while (not eof(archivo_carga)) do
    with registro_empleado do
    begin
      readln(archivo_carga,codigo,comision,nombre); nombre:=trim(nombre);
      write(archivo_detalle,registro_empleado);
    end;
  close(archivo_detalle);
  close(archivo_carga);
end;
procedure imprimir_registro_empleado(registro_empleado: t_registro_empleado);
begin
  textcolor(green); write('Código: '); textcolor(yellow); write(registro_empleado.codigo);
  textcolor(green); write('; Nombre: '); textcolor(yellow); write(registro_empleado.nombre);
  textcolor(green); write('; Comisión: '); textcolor(yellow); writeln(registro_empleado.comision:0:2);
end;
procedure imprimir_archivo_empleados(var archivo_empleados: t_archivo_empleados);
var
  registro_empleado: t_registro_empleado;
begin
  reset(archivo_empleados);
  while (not eof(archivo_empleados)) do
  begin
    read(archivo_empleados,registro_empleado);
    imprimir_registro_empleado(registro_empleado);
  end;
  close(archivo_empleados);
end;
procedure leer_empleado(var archivo_detalle: t_archivo_empleados; var registro_empleado: t_registro_empleado);
begin
  if (not eof(archivo_detalle)) then
    read(archivo_detalle,registro_empleado)
  else
    registro_empleado.codigo:=codigo_salida;
end;
procedure cargar_archivo_maestro(var archivo_maestro, archivo_detalle: t_archivo_empleados);
var
  registro_empleado_detalle, registro_empleado_maestro: t_registro_empleado;
  comision_total: real;
begin
  reset(archivo_detalle);
  rewrite(archivo_maestro);
  leer_empleado(archivo_detalle,registro_empleado_detalle);
  while (registro_empleado_detalle.codigo<>codigo_salida) do
  begin
    registro_empleado_maestro:=registro_empleado_detalle;
    comision_total:=0;
    while (registro_empleado_maestro.codigo=registro_empleado_detalle.codigo) do
    begin
      comision_total:=comision_total+registro_empleado_detalle.comision;
      leer_empleado(archivo_detalle,registro_empleado_detalle);
    end;
    registro_empleado_maestro.comision:=comision_total;
    write(archivo_maestro,registro_empleado_maestro);
  end;
  close(archivo_detalle);
  close(archivo_maestro);
end;
var
  archivo_detalle, archivo_maestro: t_archivo_empleados;
  archivo_carga: text;
begin
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO DETALLE:'); writeln();
  assign(archivo_detalle,'E1_empleadosDetalle'); assign(archivo_carga,'E1_empleadosDetalle.txt');
  cargar_archivo_detalle(archivo_detalle,archivo_carga);
  imprimir_archivo_empleados(archivo_detalle);
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO MAESTRO:'); writeln();
  assign(archivo_maestro,'E1_empleadosMaestro');
  cargar_archivo_maestro(archivo_maestro,archivo_detalle);
  imprimir_archivo_empleados(archivo_maestro);
end.