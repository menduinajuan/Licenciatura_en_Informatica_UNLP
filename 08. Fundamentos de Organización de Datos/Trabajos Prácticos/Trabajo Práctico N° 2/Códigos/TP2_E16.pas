{TRABAJO PRÁCTICO N° 2}
{EJERCICIO 16}
{La editorial X, autora de diversos semanarios, posee un archivo maestro con la información correspondiente a las diferentes emisiones de los mismos.
De cada emisión, se registra: fecha, código de semanario, nombre del semanario, descripción, precio, total de ejemplares y total de ejemplares vendidos.
Mensualmente, se reciben 100 archivos detalles con las ventas de los semanarios en todo el país.
La información que poseen los detalles es la siguiente: fecha, código de semanario y cantidad de ejemplares vendidos.
Realizar las declaraciones necesarias, la llamada al procedimiento y el procedimiento que recibe el archivo maestro y los 100 detalles y realizar la actualización del archivo maestro en función de las ventas registradas.
Además, se deberá informar fecha y semanario que tuvo más ventas y la misma información del semanario con menos ventas.
Nota: Todos los archivos están ordenados por fecha y código de semanario. No se realizan ventas de semanarios si no hay ejemplares para hacerlo.}

program TP2_E16;
{$codepage UTF8}
uses crt, sysutils;
const
  detalles_total=3; // detalles_total=100;
  fecha_salida='ZZZ';
type
  t_detalle=1..detalles_total;
  t_string20=string[20];
  t_registro_semanario=record
    fecha: t_string20;
    codigo: int16;
    nombre: t_string20;
    descripcion: t_string20;
    precio: real;
    total_ejemplares: int16;
    ejemplares_vendidos: int16;
  end;
  t_registro_venta=record
    fecha: t_string20;
    codigo: int16;
    ejemplares_vendidos: int16;
  end;
  t_archivo_maestro=file of t_registro_semanario;
  t_archivo_detalle=file of t_registro_venta;
  t_vector_ventas=array[t_detalle] of t_registro_venta;
  t_vector_detalles=array[t_detalle] of t_archivo_detalle;
  t_vector_carga_detalles=array[t_detalle] of text;
procedure cargar_archivo_maestro(var archivo_maestro: t_archivo_maestro; var archivo_carga_maestro: text);
var
  registro_semanario: t_registro_semanario;
begin
  rewrite(archivo_maestro);
  reset(archivo_carga_maestro);
  while (not eof(archivo_carga_maestro)) do
    with registro_semanario do
    begin
      readln(archivo_carga_maestro,codigo,precio,total_ejemplares,ejemplares_vendidos,fecha); fecha:=trim(fecha);
      readln(archivo_carga_maestro,nombre); nombre:=trim(nombre);
      readln(archivo_carga_maestro,descripcion); descripcion:=trim(descripcion);
      write(archivo_maestro,registro_semanario);
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
      readln(archivo_carga_detalle,codigo,ejemplares_vendidos,fecha); fecha:=trim(fecha);
      write(archivo_detalle,registro_venta);
    end;
  close(archivo_detalle);
  close(archivo_carga_detalle);
end;
procedure imprimir_registro_semanario(registro_semanario: t_registro_semanario);
begin
  textcolor(green); write('Fecha: '); textcolor(yellow); write(registro_semanario.fecha);
  textcolor(green); write('; Código: '); textcolor(yellow); write(registro_semanario.codigo);
  textcolor(green); write('; Nombre: '); textcolor(yellow); write(registro_semanario.nombre);
  textcolor(green); write('; Descripción: '); textcolor(yellow); write(registro_semanario.descripcion);
  textcolor(green); write('; Precio: $'); textcolor(yellow); write(registro_semanario.precio:0:2);
  textcolor(green); write('; Total de ejemplares: '); textcolor(yellow); write(registro_semanario.total_ejemplares);
  textcolor(green); write('; Ejemplares vendidos: '); textcolor(yellow); writeln(registro_semanario.ejemplares_vendidos);
end;
procedure imprimir_archivo_maestro(var archivo_maestro: t_archivo_maestro);
var
  registro_semanario: t_registro_semanario;
begin
  reset(archivo_maestro);
  while (not eof(archivo_maestro)) do
  begin
    read(archivo_maestro,registro_semanario);
    imprimir_registro_semanario(registro_semanario);
  end;
  close(archivo_maestro);
end;
procedure imprimir_registro_venta(registro_venta: t_registro_venta);
begin
  textcolor(green); write('Fecha: '); textcolor(yellow); write(registro_venta.fecha);
  textcolor(green); write('; Código: '); textcolor(yellow); write(registro_venta.codigo);
  textcolor(green); write('; Ejemplares vendidos: '); textcolor(yellow); writeln(registro_venta.ejemplares_vendidos);
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
    registro_venta.fecha:=fecha_salida;
end;
procedure minimo(var vector_detalles: t_vector_detalles; var vector_ventas: t_vector_ventas; var min: t_registro_venta);
var
  i, pos: t_detalle;
begin
  min.fecha:=fecha_salida;
  for i:= 1 to detalles_total do
    if ((vector_ventas[i].fecha<min.fecha) or ((vector_ventas[i].fecha=min.fecha) and (vector_ventas[i].codigo<min.codigo))) then
    begin
      min:=vector_ventas[i];
      pos:=i;
    end;
  if (min.fecha<fecha_salida) then
    leer_venta(vector_detalles[pos],vector_ventas[pos]);
end;
procedure actualizar_maximo_minimo(ventas: int16; fecha: t_string20; codigo: int16; var ventas_max, ventas_min: int16; var fecha_max, fecha_min: t_string20; var codigo_max, codigo_min: int16);
begin
  if (ventas>ventas_max) then
  begin
    ventas_max:=ventas;
    fecha_max:=fecha;
    codigo_max:=codigo;
  end;
  if (ventas<ventas_min) then
  begin
    ventas_min:=ventas;
    fecha_min:=fecha;
    codigo_min:=codigo;
  end;
end;
procedure actualizar_archivo_maestro(var archivo_maestro: t_archivo_maestro; var vector_detalles: t_vector_detalles);
var
  registro_semanario: t_registro_semanario;
  min: t_registro_venta;
  vector_ventas: t_vector_ventas;
  i: t_detalle;
  fecha_max, fecha_min: t_string20;
  ventas, ventas_max, ventas_min, codigo_max, codigo_min: int16;
begin
  ventas_max:=low(int16); fecha_max:=''; codigo_max:=0;
  ventas_min:=high(int16); fecha_min:=''; codigo_min:=0;
  reset(archivo_maestro);
  for i:= 1 to detalles_total do
  begin
    reset(vector_detalles[i]);
    leer_venta(vector_detalles[i],vector_ventas[i]);
  end;
  minimo(vector_detalles,vector_ventas,min);
  while (min.fecha<>fecha_salida) do
  begin
    read(archivo_maestro,registro_semanario);
    while (registro_semanario.fecha<>min.fecha) do
      read(archivo_maestro,registro_semanario);
    while (registro_semanario.fecha=min.fecha) do
    begin
      ventas:=0;
      while (registro_semanario.codigo<>min.codigo) do
        read(archivo_maestro,registro_semanario);
      while ((registro_semanario.fecha=min.fecha) and (registro_semanario.codigo=min.codigo)) do
      begin
        if (registro_semanario.total_ejemplares>=min.ejemplares_vendidos) then
        begin
          registro_semanario.total_ejemplares:=registro_semanario.total_ejemplares-min.ejemplares_vendidos;
          registro_semanario.ejemplares_vendidos:=registro_semanario.ejemplares_vendidos+min.ejemplares_vendidos;
          ventas:=ventas+min.ejemplares_vendidos;
        end;
        minimo(vector_detalles,vector_ventas,min);
      end;
      seek(archivo_maestro,filepos(archivo_maestro)-1);
      write(archivo_maestro,registro_semanario);
      actualizar_maximo_minimo(ventas,registro_semanario.fecha,registro_semanario.codigo,ventas_max,ventas_min,fecha_max,fecha_min,codigo_max,codigo_min);
    end;
  end;
  close(archivo_maestro);
  for i:= 1 to detalles_total do
    close(vector_detalles[i]);
  textcolor(green); write('La fecha y semanario que tuvo más ventas fueron '); textcolor(red); write(fecha_max); textcolor(green); write(' y '); textcolor(red); write(codigo_max); textcolor(green); write(', respectivamente, con un total de '); textcolor(red); write(ventas_max); textcolor(green); writeln(' ventas');
  textcolor(green); write('La fecha y semanario que tuvo menos ventas fueron '); textcolor(red); write(fecha_min); textcolor(green); write(' y '); textcolor(red); write(codigo_min); textcolor(green); write(', respectivamente, con un total de '); textcolor(red); write(ventas_min); textcolor(green); writeln(' ventas');
  writeln();
end;
var
  vector_detalles: t_vector_detalles;
  vector_carga_detalles: t_vector_carga_detalles;
  archivo_maestro: t_archivo_maestro;
  archivo_carga_maestro: text;
  i: t_detalle;
begin
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO MAESTRO:'); writeln();
  assign(archivo_maestro,'E16_semanariosMaestro'); assign(archivo_carga_maestro,'E16_semanariosMaestro.txt');
  cargar_archivo_maestro(archivo_maestro,archivo_carga_maestro);
  imprimir_archivo_maestro(archivo_maestro);
  for i:= 1 to detalles_total do
  begin
    writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO DETALLE ',i,':'); writeln();
    assign(vector_detalles[i],'E16_ventasDetalle'+intToStr(i)); assign(vector_carga_detalles[i],'E16_ventasDetalle'+intToStr(i)+'.txt');
    cargar_archivo_detalle(vector_detalles[i],vector_carga_detalles[i]);
    imprimir_archivo_detalle(vector_detalles[i]);
  end;
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO MAESTRO ACTUALIZADO:'); writeln();
  actualizar_archivo_maestro(archivo_maestro,vector_detalles);
  imprimir_archivo_maestro(archivo_maestro);
end.