{TRABAJO PRÁCTICO N° 2}
{EJERCICIO 18}
{Se cuenta con un archivo con información de los casos de COVID-19 registrados en los diferentes hospitales de la Provincia de Buenos Aires cada día.
Dicho archivo contiene: código de localidad, nombre de localidad, código de municipio, nombre de municipio, código de hospital, nombre de hospital, fecha y cantidad de casos positivos detectados.
El archivo está ordenado por localidad, luego por municipio y luego por hospital.
Escribir la definición de las estructuras de datos necesarias y un procedimiento que haga un listado con el siguiente formato:
Además del informe en pantalla anterior, es necesario exportar a un archivo de texto la siguiente información: nombre de localidad, nombre de municipio y cantidad de casos del municipio para aquellos municipios cuya cantidad de casos supere los 1500.
El formato del archivo de texto deberá ser el adecuado para recuperar la información con la menor cantidad de lecturas posibles.
Nota: El archivo debe recorrerse sólo una vez.}

program TP2_E18;
{$codepage UTF8}
uses crt, sysutils;
const
  codigo_salida=999;
  casos_municipio_corte=1500;
type
  t_string20=string[20];
  t_registro_hospital=record
    codigo_localidad: int16;
    nombre_localidad: t_string20;
    codigo_municipio: int16;
    nombre_municipio: t_string20;
    codigo_hospital: int16;
    nombre_hospital: t_string20;
    fecha: t_string20;
    casos_positivos: int16;
  end;
  t_archivo_maestro=file of t_registro_hospital;
procedure cargar_archivo_maestro(var archivo_maestro: t_archivo_maestro; var archivo_carga_maestro: text);
var
  registro_hospital: t_registro_hospital;
begin
  rewrite(archivo_maestro);
  reset(archivo_carga_maestro);
  while (not eof(archivo_carga_maestro)) do
  begin
    with registro_hospital do
    begin
      readln(archivo_carga_maestro,codigo_localidad,codigo_municipio,codigo_hospital,casos_positivos,fecha); fecha:=trim(fecha);
      readln(archivo_carga_maestro,nombre_localidad); nombre_localidad:=trim(nombre_localidad);
      readln(archivo_carga_maestro,nombre_municipio); nombre_municipio:=trim(nombre_municipio);
      readln(archivo_carga_maestro,nombre_hospital); nombre_hospital:=trim(nombre_hospital);
      write(archivo_maestro,registro_hospital);
    end;
  end;
  close(archivo_maestro);
  close(archivo_carga_maestro);
end;
procedure imprimir_registro_hospital(registro_hospital: t_registro_hospital);
begin
  textcolor(green); write('Código de localidad: '); textcolor(yellow); write(registro_hospital.codigo_localidad);
  textcolor(green); write('; Nombre de localidad: '); textcolor(yellow); write(registro_hospital.nombre_localidad);
  textcolor(green); write('; Código de municipio: '); textcolor(yellow); write(registro_hospital.codigo_municipio);
  textcolor(green); write('; Nombre de municipio: '); textcolor(yellow); write(registro_hospital.nombre_municipio);
  textcolor(green); write('; Código de hospital: '); textcolor(yellow); write(registro_hospital.codigo_hospital);
  textcolor(green); write('; Nombre de hospital: '); textcolor(yellow); write(registro_hospital.nombre_hospital);
  textcolor(green); write('; Fecha: '); textcolor(yellow); write(registro_hospital.fecha);
  textcolor(green); write('; Casos positivos: '); textcolor(yellow); writeln(registro_hospital.casos_positivos);
end;
procedure imprimir_archivo_maestro(var archivo_maestro: t_archivo_maestro);
var
  registro_hospital: t_registro_hospital;
begin
  reset(archivo_maestro);
  while (not eof(archivo_maestro)) do
  begin
    read(archivo_maestro,registro_hospital);
    imprimir_registro_hospital(registro_hospital);
  end;
  close(archivo_maestro);
end;
procedure leer_hospital(var archivo_maestro: t_archivo_maestro; var registro_hospital: t_registro_hospital);
begin
  if (not eof(archivo_maestro)) then
    read(archivo_maestro,registro_hospital)
  else
    registro_hospital.codigo_localidad:=codigo_salida;
end;
procedure procesar_archivo_maestro(var archivo_maestro: t_archivo_maestro);
var
  registro_hospital: t_registro_hospital;
  archivo_txt: text;
  codigo_localidad, codigo_municipio, codigo_hospital, casos_total, casos_localidad, casos_municipio, casos_hospital: int16;
  nombre_localidad, nombre_municipio, nombre_hospital: t_string20;
begin
  assign(archivo_txt,'E18_municipiosCasosCorte.txt'); rewrite(archivo_txt);
  casos_total:=0;
  reset(archivo_maestro);
  leer_hospital(archivo_maestro,registro_hospital);
  while (registro_hospital.codigo_localidad<>codigo_salida) do
  begin
    codigo_localidad:=registro_hospital.codigo_localidad;
    nombre_localidad:=registro_hospital.nombre_localidad;
    casos_localidad:=0;
    textcolor(green); write('Localidad: '); textcolor(yellow); writeln(nombre_localidad);
    while (registro_hospital.codigo_localidad=codigo_localidad) do
    begin
      codigo_municipio:=registro_hospital.codigo_municipio;
      nombre_municipio:=registro_hospital.nombre_municipio;
      casos_municipio:=0;
      textcolor(green); write('  Municipio: '); textcolor(yellow); writeln(nombre_municipio);
      textcolor(green); writeln('    Hospital          Cantidad de casos');
      while ((registro_hospital.codigo_localidad=codigo_localidad) and (registro_hospital.codigo_municipio=codigo_municipio)) do
      begin
        codigo_hospital:=registro_hospital.codigo_hospital;
        nombre_hospital:=registro_hospital.nombre_hospital;
        casos_hospital:=0;
        while ((registro_hospital.codigo_localidad=codigo_localidad) and (registro_hospital.codigo_municipio=codigo_municipio) and (registro_hospital.codigo_hospital=codigo_hospital)) do
        begin
          casos_hospital:=casos_hospital+registro_hospital.casos_positivos;
          leer_hospital(archivo_maestro,registro_hospital);
        end;
        textcolor(green); write('    '); textcolor(yellow); write(nombre_hospital); textcolor(green); write('         '); textcolor(red); writeln(casos_hospital);
        casos_municipio:=casos_municipio+casos_hospital;
      end;
      textcolor(green); write('  Cantidad de casos Municipio: '); textcolor(red); writeln(casos_municipio);
      casos_localidad:=casos_localidad+casos_municipio;
      if (casos_municipio>casos_municipio_corte) then
      begin
        writeln(archivo_txt,casos_municipio,' ',nombre_localidad);
        writeln(archivo_txt,nombre_municipio);
      end;
    end;
    textcolor(green); write('Cantidad de casos Localidad: '); textcolor(red); writeln(casos_localidad); writeln();
    casos_total:=casos_total+casos_localidad;
  end;
  textcolor(green); write('Cantidad de casos Totales: '); textcolor(red); writeln(casos_total);
  close(archivo_maestro);
  close(archivo_txt);
end;
var
  archivo_maestro: t_archivo_maestro;
  archivo_carga_maestro: text;
begin
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO MAESTRO:'); writeln();
  assign(archivo_maestro,'E18_hospitalesMaestro'); assign(archivo_carga_maestro,'E18_hospitalesMaestro.txt');
  cargar_archivo_maestro(archivo_maestro,archivo_carga_maestro);
  imprimir_archivo_maestro(archivo_maestro);
  writeln(); textcolor(red); writeln('PROCESAMIENTO ARCHIVO MAESTRO:'); writeln();
  procesar_archivo_maestro(archivo_maestro);
end.