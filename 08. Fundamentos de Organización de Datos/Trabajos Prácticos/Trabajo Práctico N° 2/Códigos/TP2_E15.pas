{TRABAJO PRÁCTICO N° 2}
{EJERCICIO 15}
{Se desea modelar la información de una ONG dedicada a la asistencia de personas con carencias habitacionales.
La ONG cuenta con un archivo maestro conteniendo información como se indica a continuación: código provincia, nombre provincia, código de localidad, nombre de localidad, #viviendas sin luz, #viviendas sin gas, #viviendas de chapa, #viviendas sin agua, #viviendas sin sanitarios.
Mensualmente, reciben detalles de las diferentes provincias indicando avances en las obras de ayuda en la edificación y equipamientos de viviendas en cada provincia.
La información de los detalles es la siguiente: código provincia, código localidad, #viviendas con luz, #viviendas construidas, #viviendas con agua, #viviendas con gas, #entrega sanitarios.
Se debe realizar el procedimiento que permita actualizar el maestro con los detalles recibidos, se reciben 10 detalles.
Todos los archivos están ordenados por código de provincia y código de localidad.
Para la actualización del archivo maestro, se debe proceder de la siguiente manera:
•	Al valor de viviendas sin luz se le resta el valor recibido en el detalle.
•	Ídem para viviendas sin agua, sin gas y sin sanitarios.
•	A las viviendas de chapa se le resta el valor recibido de viviendas construidas.
La misma combinación de provincia y localidad aparecen, a lo sumo, una única vez.
Realizar las declaraciones necesarias, el programa principal y los procedimientos que se requiera para la actualización solicitada e informar cantidad de localidades sin viviendas de chapa (las localidades pueden o no haber sido actualizadas).}

program TP2_E15;
{$codepage UTF8}
uses crt, sysutils;
const
  detalles_total=3; // detalles_total=10;
  codigo_salida=999;
  viviendas_de_chapa_corte=0;
type
  t_detalle=1..detalles_total;
  t_string20=string[20];
  t_registro_provincia1=record
    codigo: int16;
    nombre: t_string20;
    codigo_localidad: int16;
    nombre_localidad: t_string20;
    viviendas_sin_luz: int16;
    viviendas_sin_gas: int16;
    viviendas_de_chapa: int16;
    viviendas_sin_agua: int16;
    viviendas_sin_sanitarios: int16;
  end;
  t_registro_provincia2=record
    codigo: int16;
    codigo_localidad: int16;
    viviendas_con_luz: int16;
    viviendas_construidas: int16;
    viviendas_con_agua: int16;
    viviendas_con_gas: int16;
    entrega_sanitarios: int16;
  end;
  t_archivo_maestro=file of t_registro_provincia1;
  t_archivo_detalle=file of t_registro_provincia2;
  t_vector_provincias=array[t_detalle] of t_registro_provincia2;
  t_vector_detalles=array[t_detalle] of t_archivo_detalle;
  t_vector_carga_detalles=array[t_detalle] of text;
procedure cargar_archivo_maestro(var archivo_maestro: t_archivo_maestro; var archivo_carga_maestro: text);
var
  registro_provincia: t_registro_provincia1;
begin
  rewrite(archivo_maestro);
  reset(archivo_carga_maestro);
  while (not eof(archivo_carga_maestro)) do
    with registro_provincia do
    begin
      readln(archivo_carga_maestro,codigo,codigo_localidad,viviendas_sin_luz,viviendas_sin_gas,viviendas_de_chapa,viviendas_sin_agua,viviendas_sin_sanitarios,nombre); nombre:=trim(nombre);
      readln(archivo_carga_maestro,nombre_localidad); nombre_localidad:=trim(nombre_localidad);
      write(archivo_maestro,registro_provincia);
    end;
  close(archivo_maestro);
  close(archivo_carga_maestro);
end;
procedure cargar_archivo_detalle(var archivo_detalle: t_archivo_detalle; var archivo_carga_detalle: text);
var
  registro_provincia: t_registro_provincia2;
begin
  rewrite(archivo_detalle);
  reset(archivo_carga_detalle);
  while (not eof(archivo_carga_detalle)) do
    with registro_provincia do
    begin
      readln(archivo_carga_detalle,codigo,codigo_localidad,viviendas_con_luz,viviendas_construidas,viviendas_con_agua,viviendas_con_gas,entrega_sanitarios);
      write(archivo_detalle,registro_provincia);
    end;
  close(archivo_detalle);
  close(archivo_carga_detalle);
end;
procedure imprimir_registro_provincia1(registro_provincia: t_registro_provincia1);
begin
  textcolor(green); write('Código de provincia: '); textcolor(yellow); write(registro_provincia.codigo);
  textcolor(green); write('; Nombre de provincia: '); textcolor(yellow); write(registro_provincia.nombre);
  textcolor(green); write('; Código de localidad: '); textcolor(yellow); write(registro_provincia.codigo_localidad);
  textcolor(green); write('; Nombre de localidad: '); textcolor(yellow); write(registro_provincia.nombre_localidad);
  textcolor(green); write('; Viviendas sin luz: '); textcolor(yellow); write(registro_provincia.viviendas_sin_luz);
  textcolor(green); write('; Viviendas sin gas: '); textcolor(yellow); write(registro_provincia.viviendas_sin_gas);
  textcolor(green); write('; Viviendas de chapa: '); textcolor(yellow); write(registro_provincia.viviendas_de_chapa);
  textcolor(green); write('; Viviendas sin agua: '); textcolor(yellow); write(registro_provincia.viviendas_sin_agua);
  textcolor(green); write('; Viviendas sin sanitarios: '); textcolor(yellow); writeln(registro_provincia.viviendas_sin_sanitarios);
end;
procedure imprimir_archivo_maestro(var archivo_maestro: t_archivo_maestro);
var
  registro_provincia: t_registro_provincia1;
begin
  reset(archivo_maestro);
  while (not eof(archivo_maestro)) do
  begin
    read(archivo_maestro,registro_provincia);
    imprimir_registro_provincia1(registro_provincia);
  end;
  close(archivo_maestro);
end;
procedure imprimir_registro_provincia2(registro_provincia: t_registro_provincia2);
begin
  textcolor(green); write('Código de provincia: '); textcolor(yellow); write(registro_provincia.codigo);
  textcolor(green); write('; Código de localidad: '); textcolor(yellow); write(registro_provincia.codigo_localidad);
  textcolor(green); write('; Viviendas con luz: '); textcolor(yellow); write(registro_provincia.viviendas_con_luz);
  textcolor(green); write('; Viviendas construidas: '); textcolor(yellow); write(registro_provincia.viviendas_construidas);
  textcolor(green); write('; Viviendas con agua: '); textcolor(yellow); write(registro_provincia.viviendas_con_agua);
  textcolor(green); write('; Viviendas con gas: '); textcolor(yellow); write(registro_provincia.viviendas_con_gas);
  textcolor(green); write('; Entrega sanitarios: '); textcolor(yellow); writeln(registro_provincia.entrega_sanitarios);
end;
procedure imprimir_archivo_detalle(var archivo_detalle: t_archivo_detalle);
var
  registro_provincia: t_registro_provincia2;
begin
  reset(archivo_detalle);
  while (not eof(archivo_detalle)) do
  begin
    read(archivo_detalle,registro_provincia);
    imprimir_registro_provincia2(registro_provincia);
  end;
  close(archivo_detalle);
end;
procedure leer_provincia(var archivo_detalle: t_archivo_detalle; var registro_provincia: t_registro_provincia2);
begin
  if (not eof(archivo_detalle)) then
    read(archivo_detalle,registro_provincia)
  else
    registro_provincia.codigo:=codigo_salida;
end;
procedure minimo(var vector_detalles: t_vector_detalles; var vector_provincias: t_vector_provincias; var min: t_registro_provincia2);
var
  i, pos: t_detalle;
begin
  min.codigo:=codigo_salida;
  for i:= 1 to detalles_total do
    if ((vector_provincias[i].codigo<min.codigo) or ((vector_provincias[i].codigo=min.codigo) and (vector_provincias[i].codigo_localidad<min.codigo_localidad))) then
    begin
      min:=vector_provincias[i];
      pos:=i;
    end;
  if (min.codigo<codigo_salida) then
    leer_provincia(vector_detalles[pos],vector_provincias[pos]);
end;
procedure actualizar_localidades_corte(viviendas_de_chapa_localidad: int16; var localidades_corte: int16);
begin
  if (viviendas_de_chapa_localidad=viviendas_de_chapa_corte) then
    localidades_corte:=localidades_corte+1;
end;
procedure actualizar_archivo_maestro(var archivo_maestro: t_archivo_maestro; var vector_detalles: t_vector_detalles);
var
  registro_provincia: t_registro_provincia1;
  min: t_registro_provincia2;
  vector_provincias: t_vector_provincias;
  i: t_detalle;
  localidades_corte: int16;
  ok: boolean;
begin
  ok:=true;
  localidades_corte:=0;
  reset(archivo_maestro);
  for i:= 1 to detalles_total do
  begin
    reset(vector_detalles[i]);
    leer_provincia(vector_detalles[i],vector_provincias[i]);
  end;
  minimo(vector_detalles,vector_provincias,min);
  while (min.codigo<>codigo_salida) do
  begin
    read(archivo_maestro,registro_provincia);
    while (registro_provincia.codigo<>min.codigo) do
    begin
      actualizar_localidades_corte(registro_provincia.viviendas_de_chapa,localidades_corte);
      read(archivo_maestro,registro_provincia);
    end;
    while (registro_provincia.codigo=min.codigo) do
    begin
      while (registro_provincia.codigo_localidad<>min.codigo_localidad) do
      begin
        if (ok=true) then
          actualizar_localidades_corte(registro_provincia.viviendas_de_chapa,localidades_corte);
        read(archivo_maestro,registro_provincia);
        ok:=true;
      end;
      while ((registro_provincia.codigo=min.codigo) and (registro_provincia.codigo_localidad=min.codigo_localidad)) do
      begin
        registro_provincia.viviendas_sin_luz:=registro_provincia.viviendas_sin_luz-min.viviendas_con_luz;
        registro_provincia.viviendas_sin_agua:=registro_provincia.viviendas_sin_agua-min.viviendas_con_agua;
        registro_provincia.viviendas_sin_gas:=registro_provincia.viviendas_sin_gas-min.viviendas_con_gas;
        registro_provincia.viviendas_sin_sanitarios:=registro_provincia.viviendas_sin_sanitarios-min.entrega_sanitarios;
        registro_provincia.viviendas_de_chapa:=registro_provincia.viviendas_de_chapa-min.viviendas_construidas;
        minimo(vector_detalles,vector_provincias,min);
      end;
      seek(archivo_maestro,filepos(archivo_maestro)-1);
      write(archivo_maestro,registro_provincia);
      actualizar_localidades_corte(registro_provincia.viviendas_de_chapa,localidades_corte);
      ok:=false;
    end;
  end;
  while (not eof(archivo_maestro)) do
  begin
    read(archivo_maestro,registro_provincia);
    actualizar_localidades_corte(registro_provincia.viviendas_de_chapa,localidades_corte);
  end;
  close(archivo_maestro);
  for i:= 1 to detalles_total do
    close(vector_detalles[i]);
  textcolor(green); write('La cantidad de localidades con '); textcolor(yellow); write(viviendas_de_chapa_corte); textcolor(green); write(' viviendas de chapa es '); textcolor(red); writeln(localidades_corte);
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
  assign(archivo_maestro,'E15_provinciasMaestro'); assign(archivo_carga_maestro,'E15_provinciasMaestro.txt');
  cargar_archivo_maestro(archivo_maestro,archivo_carga_maestro);
  imprimir_archivo_maestro(archivo_maestro);
  for i:= 1 to detalles_total do
  begin
    writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO DETALLE ',i,':'); writeln();
    assign(vector_detalles[i],'E15_provinciasDetalle'+intToStr(i)); assign(vector_carga_detalles[i],'E15_provinciasDetalle'+intToStr(i)+'.txt');
    cargar_archivo_detalle(vector_detalles[i],vector_carga_detalles[i]);
    imprimir_archivo_detalle(vector_detalles[i]);
  end;
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO MAESTRO ACTUALIZADO:'); writeln();
  actualizar_archivo_maestro(archivo_maestro,vector_detalles);
  imprimir_archivo_maestro(archivo_maestro);
end.