{TRABAJO PRÁCTICO N° 2}
{EJERCICIO 9}
{Se cuenta con un archivo que posee información de las ventas que realiza una empresa a los diferentes clientes.
Se necesita obtener un reporte con las ventas organizadas por cliente. Para ello, se deberá informar por pantalla: los datos personales del cliente, el total mensual (mes por mes cuánto compró) y, finalmente, el monto total comprado en el año por el cliente.
Además, al finalizar el reporte, se debe informar el monto total de ventas obtenido por la empresa.
El formato del archivo maestro está dado por: cliente (código cliente, nombre y apellido), año, mes, día y monto de la venta.
El orden del archivo está dado por: código cliente, año y mes.
Nota: Tener en cuenta que puede haber meses en los que los clientes no realizaron compras. No es necesario informar tales meses en el reporte.}

program TP2_E9;
{$codepage UTF8}
uses crt, sysutils;
const
  codigo_salida=999;
  dia_ini=1; dia_fin=31;
  mes_ini=1; mes_fin=12;
  anio_ini=2000; anio_fin=2025;
type
  t_string10=string[10];
  t_dia=dia_ini..dia_fin;
  t_mes=mes_ini..mes_fin;
  t_anio=anio_ini..anio_fin;
  t_registro_cliente=record
    codigo: int16;
    nombre: t_string10;
    apellido: t_string10;
  end;
  t_registro_fecha=record
    anio: t_anio;
    mes: t_mes;
    dia: t_dia;
  end;
  t_registro_venta=record
    cliente: t_registro_cliente;
    fecha: t_registro_fecha;
    monto: real;
  end;
  t_archivo_maestro=file of t_registro_venta;
procedure cargar_archivo_maestro(var archivo_maestro: t_archivo_maestro; var archivo_carga_maestro: text);
var
  registro_venta: t_registro_venta;
begin
  rewrite(archivo_maestro);
  reset(archivo_carga_maestro);
  while (not eof(archivo_carga_maestro)) do
    with registro_venta do
    begin
      readln(archivo_carga_maestro,cliente.codigo,fecha.anio,fecha.mes,fecha.dia,monto,cliente.nombre); cliente.nombre:=trim(cliente.nombre);
      readln(archivo_carga_maestro,cliente.apellido);
      write(archivo_maestro,registro_venta);
    end;
  close(archivo_maestro);
  close(archivo_carga_maestro);
end;
procedure imprimir_registro_cliente(registro_cliente: t_registro_cliente);
begin
  textcolor(green); write('Código: '); textcolor(yellow); write(registro_cliente.codigo);
  textcolor(green); write('; Nombre: '); textcolor(yellow); write(registro_cliente.nombre);
  textcolor(green); write('; Apellido: '); textcolor(yellow); write(registro_cliente.apellido);
end;
procedure imprimir_registro_fecha(registro_fecha: t_registro_fecha);
begin
  textcolor(green); write('; Fecha: '); textcolor(yellow); write(registro_fecha.anio);
  textcolor(green); write('/'); textcolor(yellow); write(registro_fecha.mes);
  textcolor(green); write('/'); textcolor(yellow); write(registro_fecha.dia);
end;
procedure imprimir_registro_venta(registro_venta: t_registro_venta);
begin
  imprimir_registro_cliente(registro_venta.cliente);
  imprimir_registro_fecha(registro_venta.fecha);
  textcolor(green); write('; Monto: $'); textcolor(yellow); writeln(registro_venta.monto:0:2);
end;
procedure imprimir_archivo_maestro(var archivo_maestro: t_archivo_maestro);
var
  registro_venta: t_registro_venta;
begin
  reset(archivo_maestro);
  while (not eof(archivo_maestro)) do
  begin
    read(archivo_maestro,registro_venta);
    imprimir_registro_venta(registro_venta);
  end;
  close(archivo_maestro);
end;
procedure leer_venta(var archivo_maestro: t_archivo_maestro; var registro_venta: t_registro_venta);
begin
  if (not eof(archivo_maestro)) then
    read(archivo_maestro,registro_venta)
  else
    registro_venta.cliente.codigo:=codigo_salida;
end;
procedure procesar_archivo_maestro(var archivo_maestro: t_archivo_maestro);
var
  registro_venta: t_registro_venta;
  monto_total, monto_anio, monto_mes: real;
  codigo, anio, mes: int16;
begin
  monto_total:=0;
  reset(archivo_maestro);
  leer_venta(archivo_maestro,registro_venta);
  while (registro_venta.cliente.codigo<>codigo_salida) do
  begin
    codigo:=registro_venta.cliente.codigo;
    textcolor(green); write('CLIENTE: '); imprimir_registro_cliente(registro_venta.cliente); writeln(); writeln();
    while (registro_venta.cliente.codigo=codigo) do
    begin
      anio:=registro_venta.fecha.anio;
      monto_anio:=0;
      textcolor(green); write('AÑO '); textcolor(yellow); writeln(anio);
      while ((registro_venta.cliente.codigo=codigo) and (registro_venta.fecha.anio=anio)) do
      begin
        mes:=registro_venta.fecha.mes;
        monto_mes:=0;
        while ((registro_venta.cliente.codigo=codigo) and (registro_venta.fecha.anio=anio) and (registro_venta.fecha.mes=mes)) do
        begin
          monto_mes:=monto_mes+registro_venta.monto;
          leer_venta(archivo_maestro,registro_venta);
        end;
        textcolor(green); write('Monto total del mes '); textcolor(yellow); write(mes); textcolor(green); write(': $'); textcolor(red); writeln(monto_mes:0:2);
        monto_anio:=monto_anio+monto_mes;
      end;
      textcolor(green); write('Monto total del año '); textcolor(yellow); write(anio); textcolor(green); write(': $'); textcolor(red); writeln(monto_anio:0:2); writeln();
      monto_total:=monto_total+monto_anio;
    end;
  end;
  textcolor(green); write('Monto total de ventas obtenido por la empresa: $'); textcolor(red); writeln(monto_total:0:2);
  close(archivo_maestro);
end;
var
  archivo_maestro: t_archivo_maestro;
  archivo_carga_maestro: text;
begin
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO MAESTRO:'); writeln();
  assign(archivo_maestro,'E9_ventasMaestro'); assign(archivo_carga_maestro,'E9_ventasMaestro.txt');
  cargar_archivo_maestro(archivo_maestro,archivo_carga_maestro);
  imprimir_archivo_maestro(archivo_maestro);
  writeln(); textcolor(red); writeln('PROCESAMIENTO ARCHIVO MAESTRO:'); writeln();
  procesar_archivo_maestro(archivo_maestro);
end.