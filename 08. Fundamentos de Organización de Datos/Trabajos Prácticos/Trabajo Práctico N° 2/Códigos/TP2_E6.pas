{TRABAJO PRÁCTICO N° 2}
{EJERCICIO 6}
{Se desea modelar la información necesaria para un sistema de recuentos de casos de COVID para el Ministerio de Salud de la Provincia de Buenos Aires.
Diariamente, se reciben archivos provenientes de los distintos municipios. La información contenida en los mismos es la siguiente: código de localidad, código cepa, cantidad de casos activos, cantidad de casos nuevos, cantidad de casos recuperados, cantidad de casos fallecidos.
El ministerio cuenta con un archivo maestro con la siguiente información: código localidad, nombre localidad, código cepa, nombre cepa, cantidad de casos activos, cantidad de casos nuevos, cantidad de recuperados y cantidad de fallecidos.
Se debe realizar el procedimiento que permita actualizar el maestro con los detalles recibidos, se reciben 10 detalles. Todos los archivos están ordenados por código de localidad y código de cepa.
Para la actualización, se debe proceder de la siguiente manera:
•	Al número de fallecidos se le suman el valor de fallecidos recibido del detalle.
•	Ídem anterior para los recuperados.
•	Los casos activos se actualizan con el valor recibido en el detalle.
•	Ídem anterior para los casos nuevos hallados.
Realizar las declaraciones necesarias, el programa principal y los procedimientos que se requiera para la actualización solicitada e informar cantidad de localidades con más de 50 casos activos (las localidades pueden o no haber sido actualizadas).}

program TP2_E6;
{$codepage UTF8}
uses crt, sysutils;
const
  detalles_total=3; // detalles_total=10;
  codigo_salida_detalle=999;
  codigo_salida_maestro=9999;
  casos_activos_corte=50;
type
  t_detalle=1..detalles_total;
  t_string20=string[20];
  t_registro_localidad1=record
    codigo: int16;
    nombre: t_string20;
    codigo_cepa: int16;
    nombre_cepa: t_string20;
    casos_activos: int16;
    casos_nuevos: int16;
    casos_recuperados: int16;
    casos_fallecidos: int16;
  end;
  t_registro_localidad2=record
    codigo: int16;
    codigo_cepa: int16;
    casos_activos: int32;
    casos_nuevos: int16;
    casos_recuperados: int16;
    casos_fallecidos: int16;
  end;
  t_archivo_maestro=file of t_registro_localidad1;
  t_archivo_detalle=file of t_registro_localidad2;
  t_vector_localidades=array[t_detalle] of t_registro_localidad2;
  t_vector_detalles=array[t_detalle] of t_archivo_detalle;
  t_vector_carga_detalles=array[t_detalle] of text;
procedure cargar_archivo_maestro(var archivo_maestro: t_archivo_maestro; var archivo_carga_maestro: text);
var
  registro_localidad: t_registro_localidad1;
begin
  rewrite(archivo_maestro);
  reset(archivo_carga_maestro);
  while (not eof(archivo_carga_maestro)) do
    with registro_localidad do
    begin
      readln(archivo_carga_maestro,codigo,codigo_cepa,casos_activos,casos_nuevos,casos_recuperados,casos_fallecidos,nombre_cepa); nombre_cepa:=trim(nombre_cepa);
      readln(archivo_carga_maestro,nombre);
      write(archivo_maestro,registro_localidad);
    end;
  close(archivo_maestro);
  close(archivo_carga_maestro);
end;
procedure cargar_archivo_detalle(var archivo_detalle: t_archivo_detalle; var archivo_carga_detalle: text);
var
  registro_localidad: t_registro_localidad2;
begin
  rewrite(archivo_detalle);
  reset(archivo_carga_detalle);
  while (not eof(archivo_carga_detalle)) do
    with registro_localidad do
    begin
      readln(archivo_carga_detalle,codigo,codigo_cepa,casos_activos,casos_nuevos,casos_recuperados,casos_fallecidos);
      write(archivo_detalle,registro_localidad);
    end;
  close(archivo_detalle);
  close(archivo_carga_detalle);
end;
procedure imprimir_registro_localidad1(registro_localidad: t_registro_localidad1);
begin
  textcolor(green); write('Código de localidad: '); textcolor(yellow); write(registro_localidad.codigo);
  textcolor(green); write('; Nombre de localidad: '); textcolor(yellow); write(registro_localidad.nombre);
  textcolor(green); write('; Código de cepa: '); textcolor(yellow); write(registro_localidad.codigo_cepa);
  textcolor(green); write('; Nombre de cepa: '); textcolor(yellow); write(registro_localidad.nombre_cepa);
  textcolor(green); write('; Casos activos: '); textcolor(yellow); write(registro_localidad.casos_activos);
  textcolor(green); write('; Casos nuevos: '); textcolor(yellow); write(registro_localidad.casos_nuevos);
  textcolor(green); write('; Casos recuperados: '); textcolor(yellow); write(registro_localidad.casos_recuperados);
  textcolor(green); write('; Casos fallecidos: '); textcolor(yellow); writeln(registro_localidad.casos_fallecidos);
end;
procedure imprimir_archivo_maestro(var archivo_maestro: t_archivo_maestro);
var
  registro_localidad: t_registro_localidad1;
begin
  reset(archivo_maestro);
  while (not eof(archivo_maestro)) do
  begin
    read(archivo_maestro,registro_localidad);
    imprimir_registro_localidad1(registro_localidad);
  end;
  close(archivo_maestro);
end;
procedure imprimir_registro_localidad2(registro_localidad: t_registro_localidad2);
begin
  textcolor(green); write('Código de localidad: '); textcolor(yellow); write(registro_localidad.codigo);
  textcolor(green); write('; Código de cepa: '); textcolor(yellow); write(registro_localidad.codigo_cepa);
  textcolor(green); write('; Casos activos: '); textcolor(yellow); write(registro_localidad.casos_activos);
  textcolor(green); write('; Casos nuevos: '); textcolor(yellow); write(registro_localidad.casos_nuevos);
  textcolor(green); write('; Casos recuperados: '); textcolor(yellow); write(registro_localidad.casos_recuperados);
  textcolor(green); write('; Casos fallecidos: '); textcolor(yellow); writeln(registro_localidad.casos_fallecidos);
end;
procedure imprimir_archivo_detalles(var archivo_detalle: t_archivo_detalle);
var
  registro_localidad: t_registro_localidad2;
begin
  reset(archivo_detalle);
  while (not eof(archivo_detalle)) do
  begin
    read(archivo_detalle,registro_localidad);
    imprimir_registro_localidad2(registro_localidad);
  end;
  close(archivo_detalle);
end;
procedure leer_localidad_detalle(var archivo_detalle: t_archivo_detalle; var registro_localidad: t_registro_localidad2);
begin
  if (not eof(archivo_detalle)) then
    read(archivo_detalle,registro_localidad)
  else
    registro_localidad.codigo:=codigo_salida_detalle;
end;
procedure minimo(var vector_detalles: t_vector_detalles; var vector_localidades: t_vector_localidades; var min: t_registro_localidad2);
var
  i, pos: t_detalle;
begin
  min.codigo:=codigo_salida_detalle;
  for i:= 1 to detalles_total do
    if ((vector_localidades[i].codigo<min.codigo) or ((vector_localidades[i].codigo=min.codigo) and (vector_localidades[i].codigo_cepa<min.codigo_cepa))) then
    begin
      min:=vector_localidades[i];
      pos:=i;
    end;
  if (min.codigo<codigo_salida_detalle) then
    leer_localidad_detalle(vector_detalles[pos],vector_localidades[pos]);
end;
procedure actualizar_localidades_corte(casos_activos_localidad: int32; var localidades_corte: int16);
begin
  if (casos_activos_localidad>casos_activos_corte) then
    localidades_corte:=localidades_corte+1;
end;
procedure leer_localidad_maestro(var archivo_maestro: t_archivo_maestro; var registro_localidad: t_registro_localidad1);
begin
  if (not eof(archivo_maestro)) then
    read(archivo_maestro,registro_localidad)
  else
    registro_localidad.codigo:=codigo_salida_maestro;
end;
procedure actualizar1_archivo_maestro(var archivo_maestro: t_archivo_maestro; var vector_detalles: t_vector_detalles);
var
  registro_localidad, registro_localidad_actual: t_registro_localidad1;
  min: t_registro_localidad2;
  vector_localidades: t_vector_localidades;
  i: t_detalle;
  localidades_corte: int16;
  casos_activos_localidad: int32;
  ok: boolean;
begin
  localidades_corte:=0;
  reset(archivo_maestro);
  for i:= 1 to detalles_total do
  begin
    reset(vector_detalles[i]);
    leer_localidad_detalle(vector_detalles[i],vector_localidades[i]);
  end;
  minimo(vector_detalles,vector_localidades,min);
  while (min.codigo<>codigo_salida_detalle) do
  begin
    casos_activos_localidad:=0;
    leer_localidad_maestro(archivo_maestro,registro_localidad);
    while (registro_localidad.codigo<>min.codigo) do
    begin
      registro_localidad_actual:=registro_localidad;
      while (registro_localidad.codigo=registro_localidad_actual.codigo) do
      begin
        casos_activos_localidad:=casos_activos_localidad+registro_localidad.casos_activos;
        leer_localidad_maestro(archivo_maestro,registro_localidad);
      end;
      actualizar_localidades_corte(casos_activos_localidad,localidades_corte);
      casos_activos_localidad:=0;
    end;
    ok:=true;
    registro_localidad_actual:=registro_localidad;
    while (registro_localidad_actual.codigo=min.codigo) do
    begin
      while (registro_localidad.codigo_cepa<>min.codigo_cepa) do
      begin
        if (ok=true) then
          casos_activos_localidad:=casos_activos_localidad+registro_localidad.casos_activos;
        read(archivo_maestro,registro_localidad);
        ok:=true;
      end;
      while ((registro_localidad.codigo=min.codigo) and (registro_localidad.codigo_cepa=min.codigo_cepa)) do
      begin
        registro_localidad.casos_fallecidos:=registro_localidad.casos_fallecidos+min.casos_fallecidos;
        registro_localidad.casos_recuperados:=registro_localidad.casos_recuperados+min.casos_recuperados;
        registro_localidad.casos_activos:=min.casos_activos;
        registro_localidad.casos_nuevos:=min.casos_nuevos;
        minimo(vector_detalles,vector_localidades,min);
      end;
      seek(archivo_maestro,filepos(archivo_maestro)-1);
      write(archivo_maestro,registro_localidad);
      casos_activos_localidad:=casos_activos_localidad+registro_localidad.casos_activos;
      ok:=false;
      if (registro_localidad_actual.codigo<>min.codigo) then
      begin
        leer_localidad_maestro(archivo_maestro,registro_localidad);
        while (registro_localidad.codigo=registro_localidad_actual.codigo) do
        begin
          casos_activos_localidad:=casos_activos_localidad+registro_localidad.casos_activos;
          leer_localidad_maestro(archivo_maestro,registro_localidad);
        end;
        seek(archivo_maestro,filepos(archivo_maestro)-1);
      end;
    end;
    actualizar_localidades_corte(casos_activos_localidad,localidades_corte);
  end;
  casos_activos_localidad:=0;
  leer_localidad_maestro(archivo_maestro,registro_localidad);
  while (registro_localidad.codigo<>codigo_salida_maestro) do
  begin
    registro_localidad_actual.codigo:=registro_localidad.codigo;
    while (registro_localidad.codigo=registro_localidad_actual.codigo) do
    begin
      casos_activos_localidad:=casos_activos_localidad+registro_localidad.casos_activos;
      leer_localidad_maestro(archivo_maestro,registro_localidad);
    end;
    actualizar_localidades_corte(casos_activos_localidad,localidades_corte);
    casos_activos_localidad:=0;
  end;
  close(archivo_maestro);
  for i:= 1 to detalles_total do
    close(vector_detalles[i]);
  textcolor(green); write('La cantidad de localidades con más de '); textcolor(yellow); write(casos_activos_corte); textcolor(green); write(' casos activos es '); textcolor(red); writeln(localidades_corte);
  writeln();
end;
procedure actualizar2_archivo_maestro(var archivo_maestro: t_archivo_maestro; var vector_detalles: t_vector_detalles);
var
  registro_localidad: t_registro_localidad1;
  min: t_registro_localidad2;
  vector_localidades: t_vector_localidades;
  i: t_detalle;
  localidades_corte, codigo: int16;
  casos_activos_localidad: int32;
  ok: boolean;
begin
  localidades_corte:=0;
  reset(archivo_maestro);
  for i:= 1 to detalles_total do
  begin
    reset(vector_detalles[i]);
    leer_localidad_detalle(vector_detalles[i],vector_localidades[i]);
  end;
  minimo(vector_detalles,vector_localidades,min);
  leer_localidad_maestro(archivo_maestro,registro_localidad);
  while (registro_localidad.codigo<>codigo_salida_maestro) do
  begin
    codigo:=registro_localidad.codigo;
    casos_activos_localidad:=0;
    while (registro_localidad.codigo=codigo) do
    begin
      ok:=false;
      while ((registro_localidad.codigo=min.codigo) and (registro_localidad.codigo_cepa=min.codigo_cepa)) do
      begin
        ok:=true;
        registro_localidad.casos_fallecidos:=registro_localidad.casos_fallecidos+min.casos_fallecidos;
        registro_localidad.casos_recuperados:=registro_localidad.casos_recuperados+min.casos_recuperados;
        registro_localidad.casos_activos:=min.casos_activos;
        registro_localidad.casos_nuevos:=min.casos_nuevos;
        minimo(vector_detalles,vector_localidades,min);
      end;
      if (ok=true) then
      begin
        seek(archivo_maestro,filepos(archivo_maestro)-1);
        write(archivo_maestro,registro_localidad);
      end;
      casos_activos_localidad:=casos_activos_localidad+registro_localidad.casos_activos;
      leer_localidad_maestro(archivo_maestro,registro_localidad);
    end;
    actualizar_localidades_corte(casos_activos_localidad,localidades_corte);
  end;
  close(archivo_maestro);
  for i:= 1 to detalles_total do
    close(vector_detalles[i]);
  textcolor(green); write('La cantidad de localidades con más de '); textcolor(yellow); write(casos_activos_corte); textcolor(green); write(' casos activos es '); textcolor(red); writeln(localidades_corte);
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
  assign(archivo_maestro,'E6_localidadesMaestro'); assign(archivo_carga_maestro,'E6_localidadesMaestro.txt');
  cargar_archivo_maestro(archivo_maestro,archivo_carga_maestro);
  imprimir_archivo_maestro(archivo_maestro);
  for i:= 1 to detalles_total do
  begin
    writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO DETALLE ',i,':'); writeln();
    assign(vector_detalles[i],'E6_localidadesDetalle'+inttoStr(i)); assign(vector_carga_detalles[i],'E6_localidadesDetalle'+inttoStr(i)+'.txt');
    cargar_archivo_detalle(vector_detalles[i],vector_carga_detalles[i]);
    imprimir_archivo_detalles(vector_detalles[i]);
  end;
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO MAESTRO ACTUALIZADO:'); writeln();
  //actualizar1_archivo_maestro(archivo_maestro,vector_detalles);
  actualizar2_archivo_maestro(archivo_maestro,vector_detalles);
  imprimir_archivo_maestro(archivo_maestro);
end.