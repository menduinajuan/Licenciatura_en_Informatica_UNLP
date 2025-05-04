{TRABAJO PRÁCTICO N° 2}
{EJERCICIO 7}
{Se dispone de un archivo maestro con información de los alumnos de la Facultad de Informática.
Cada registro del archivo maestro contiene: código de alumno, apellido, nombre, cantidad de cursadas aprobadas y cantidad de materias con final aprobado.
El archivo maestro está ordenado por código de alumno.
Además, se tienen dos archivos detalle con información sobre el desempeño académico de los alumnos: un archivo de cursadas y un archivo de exámenes finales.
El archivo de cursadas contiene información sobre las materias cursadas por los alumnos.
Cada registro incluye: código de alumno, código de materia, año de cursada y resultado (sólo interesa si la cursada fue aprobada o desaprobada).
Por su parte, el archivo de exámenes finales contiene información sobre los exámenes finales rendidos.
Cada registro incluye: código de alumno, código de materia, fecha del examen y nota obtenida.
Ambos archivos detalle están ordenados por código de alumno y código de materia, y pueden contener 0, 1 o más registros por alumno en el archivo maestro.
Un alumno podría cursar una materia muchas veces, así como también podría rendir el final de una materia en múltiples ocasiones.
Se debe desarrollar un programa que actualice el archivo maestro, ajustando la cantidad de cursadas aprobadas y la cantidad de materias con final aprobado, utilizando la información de los archivos detalle. Las reglas de actualización son las siguientes:
•	Si un alumno aprueba una cursada, se incrementa en uno la cantidad de cursadas aprobadas.
•	Si un alumno aprueba un examen final (nota>=4), se incrementa en uno la cantidad de materias con final aprobado.
Notas:
•	Los archivos deben procesarse en un único recorrido.
•	No es necesario comprobar que no haya inconsistencias en la información de los archivos detalles. Esto es, no puede suceder que un alumno apruebe más de una vez la cursada de una misma materia (a lo sumo, la aprueba una vez), algo similar ocurre con los exámenes finales.}

program TP2_E7;
{$codepage UTF8}
uses crt, sysutils;
const
  codigo_salida=999;
  resultado_corte='Aprobada'; nota_corte=4.0;
  anio_ini=2000; anio_fin=2025;
type
  t_string20=string[20];
  t_anio=anio_ini..anio_fin;
  t_registro_alumno=record
    codigo: int16;
    apellido: t_string20;
    nombre: t_string20;
    cursadas_aprobadas: int16;
    finales_aprobados: int16;
  end;
  t_registro_cursada=record
    codigo: int16;
    codigo_materia: int16;
    anio: t_anio;
    resultado: t_string20;
  end;
  t_registro_final=record
    codigo: int16;
    codigo_materia: int16;
    fecha: t_string20;
    nota: real;
  end;
  t_registro_cursada_final=record
    codigo: int16;
    codigo_materia: int16;
    resultado: t_string20;
    nota: real;
  end;
  t_archivo_maestro=file of t_registro_alumno;
  t_archivo_detalle1=file of t_registro_cursada;
  t_archivo_detalle2=file of t_registro_final;
procedure cargar_archivo_maestro(var archivo_maestro: t_archivo_maestro; var archivo_carga_maestro: text);
var
  registro_alumno: t_registro_alumno;
begin
  rewrite(archivo_maestro);
  reset(archivo_carga_maestro);
  while (not eof(archivo_carga_maestro)) do
    with registro_alumno do
    begin
      readln(archivo_carga_maestro,codigo,cursadas_aprobadas,finales_aprobados,apellido); apellido:=trim(apellido);
      readln(archivo_carga_maestro,nombre);
      write(archivo_maestro,registro_alumno);
    end;
  close(archivo_maestro);
  close(archivo_carga_maestro);
end;
procedure cargar_archivo_detalle1(var archivo_detalle1: t_archivo_detalle1; var archivo_carga_detalle1: text);
var
  registro_cursada: t_registro_cursada;
begin
  rewrite(archivo_detalle1);
  reset(archivo_carga_detalle1);
  while (not eof(archivo_carga_detalle1)) do
    with registro_cursada do
    begin
      readln(archivo_carga_detalle1,codigo,codigo_materia,anio,resultado); resultado:=trim(resultado);
      write(archivo_detalle1,registro_cursada);
    end;
  close(archivo_detalle1);
  close(archivo_carga_detalle1);
end;
procedure cargar_archivo_detalle2(var archivo_detalle2: t_archivo_detalle2; var archivo_carga_detalle2: text);
var
  registro_final: t_registro_final;
begin
  rewrite(archivo_detalle2);
  reset(archivo_carga_detalle2);
  while (not eof(archivo_carga_detalle2)) do
    with registro_final do
    begin
      readln(archivo_carga_detalle2,codigo,codigo_materia,nota,fecha); fecha:=trim(fecha);
      write(archivo_detalle2,registro_final);
    end;
  close(archivo_detalle2);
  close(archivo_carga_detalle2);
end;
procedure imprimir_registro_alumno(registro_alumno: t_registro_alumno);
begin
  textcolor(green); write('Código: '); textcolor(yellow); write(registro_alumno.codigo);
  textcolor(green); write('; Apellido: '); textcolor(yellow); write(registro_alumno.apellido);
  textcolor(green); write('; Nombre: '); textcolor(yellow); write(registro_alumno.nombre);
  textcolor(green); write('; Cursadas aprobadas: '); textcolor(yellow); write(registro_alumno.cursadas_aprobadas);
  textcolor(green); write('; Finales aprobados: '); textcolor(yellow); writeln(registro_alumno.finales_aprobados);
end;
procedure imprimir_archivo_maestro(var archivo_maestro: t_archivo_maestro);
var
  registro_alumno: t_registro_alumno;
begin
  reset(archivo_maestro);
  while (not eof(archivo_maestro)) do
  begin
    read(archivo_maestro,registro_alumno);
    imprimir_registro_alumno(registro_alumno);
  end;
  close(archivo_maestro);
end;
procedure imprimir_registro_cursada(registro_cursada: t_registro_cursada);
begin
  textcolor(green); write('Código de alumno: '); textcolor(yellow); write(registro_cursada.codigo);
  textcolor(green); write('; Código de materia: '); textcolor(yellow); write(registro_cursada.codigo_materia);
  textcolor(green); write('; Año: '); textcolor(yellow); write(registro_cursada.anio);
  textcolor(green); write('; Resultado: '); textcolor(yellow); writeln(registro_cursada.resultado);
end;
procedure imprimir_archivo_detalle1(var archivo_detalle1: t_archivo_detalle1);
var
  registro_cursada: t_registro_cursada;
begin
  reset(archivo_detalle1);
  while (not eof(archivo_detalle1)) do
  begin
    read(archivo_detalle1,registro_cursada);
    imprimir_registro_cursada(registro_cursada);
  end;
  close(archivo_detalle1);
end;
procedure imprimir_registro_final(registro_final: t_registro_final);
begin
  textcolor(green); write('Código de alumno: '); textcolor(yellow); write(registro_final.codigo);
  textcolor(green); write('; Código de materia: '); textcolor(yellow); write(registro_final.codigo_materia);
  textcolor(green); write('; Fecha: '); textcolor(yellow); write(registro_final.fecha);
  textcolor(green); write('; Nota: '); textcolor(yellow); writeln(registro_final.nota:0:2);
end;
procedure imprimir_archivo_detalle2(var archivo_detalle2: t_archivo_detalle2);
var
  registro_final: t_registro_final;
begin
  reset(archivo_detalle2);
  while (not eof(archivo_detalle2)) do
  begin
    read(archivo_detalle2,registro_final);
    imprimir_registro_final(registro_final);
  end;
  close(archivo_detalle2);
end;
procedure leer_cursada(var archivo_detalle1: t_archivo_detalle1; var registro_cursada: t_registro_cursada);
begin
  if (not eof(archivo_detalle1)) then
    read(archivo_detalle1,registro_cursada)
  else
    registro_cursada.codigo:=codigo_salida;
end;
procedure leer_final(var archivo_detalle2: t_archivo_detalle2; var registro_final: t_registro_final);
begin
  if (not eof(archivo_detalle2)) then
    read(archivo_detalle2,registro_final)
  else
    registro_final.codigo:=codigo_salida;
end;
procedure minimo(var archivo_detalle1: t_archivo_detalle1; var archivo_detalle2: t_archivo_detalle2; var registro_cursada: t_registro_cursada; var registro_final: t_registro_final; var min: t_registro_cursada_final);
begin
  if (registro_cursada.codigo<=registro_final.codigo) then
  begin
    min.codigo:=registro_cursada.codigo;
    min.codigo_materia:=registro_cursada.codigo_materia;
    min.resultado:=registro_cursada.resultado;
    min.nota:=0;
    leer_cursada(archivo_detalle1,registro_cursada);
  end
  else
  begin
    min.codigo:=registro_final.codigo;
    min.codigo_materia:=registro_final.codigo_materia;
    min.resultado:='';
    min.nota:=registro_final.nota;
    leer_final(archivo_detalle2,registro_final);
  end;
end;
procedure actualizar_archivo_maestro(var archivo_maestro: t_archivo_maestro; var archivo_detalle1: t_archivo_detalle1; var archivo_detalle2: t_archivo_detalle2);
var
  registro_alumno: t_registro_alumno;
  registro_cursada: t_registro_cursada;
  registro_final: t_registro_final;
  min: t_registro_cursada_final;
begin
  reset(archivo_maestro);
  reset(archivo_detalle1); reset(archivo_detalle2);
  leer_cursada(archivo_detalle1,registro_cursada);
  leer_final(archivo_detalle2,registro_final);
  minimo(archivo_detalle1,archivo_detalle2,registro_cursada,registro_final,min);
  while (min.codigo<>codigo_salida) do
  begin
    read(archivo_maestro,registro_alumno);
    while (registro_alumno.codigo<>min.codigo) do
      read(archivo_maestro,registro_alumno);
    while (registro_alumno.codigo=min.codigo) do
    begin
      if (min.resultado=resultado_corte) then
        registro_alumno.cursadas_aprobadas:=registro_alumno.cursadas_aprobadas+1;
      if (min.nota>=nota_corte) then
        registro_alumno.finales_aprobados:=registro_alumno.finales_aprobados+1;
      minimo(archivo_detalle1,archivo_detalle2,registro_cursada,registro_final,min);
    end;
    seek(archivo_maestro,filepos(archivo_maestro)-1);
    write(archivo_maestro,registro_alumno);
  end;
  close(archivo_maestro);
  close(archivo_detalle1); close(archivo_detalle2);
end;
var
  archivo_maestro: t_archivo_maestro;
  archivo_detalle1: t_archivo_detalle1;
  archivo_detalle2: t_archivo_detalle2;
  archivo_carga_maestro, archivo_carga_detalle1, archivo_carga_detalle2: text;
begin
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO MAESTRO:'); writeln();
  assign(archivo_maestro,'E7_alumnosMaestro'); assign(archivo_carga_maestro,'E7_alumnosMaestro.txt');
  cargar_archivo_maestro(archivo_maestro,archivo_carga_maestro);
  imprimir_archivo_maestro(archivo_maestro);
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO DETALLE 1:'); writeln();
  assign(archivo_detalle1,'E7_cursadasDetalle'); assign(archivo_carga_detalle1,'E7_cursadasDetalle.txt');
  cargar_archivo_detalle1(archivo_detalle1,archivo_carga_detalle1);
  imprimir_archivo_detalle1(archivo_detalle1);
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO DETALLE 2:'); writeln();
  assign(archivo_detalle2,'E7_finalesDetalle'); assign(archivo_carga_detalle2,'E7_finalesDetalle.txt');
  cargar_archivo_detalle2(archivo_detalle2,archivo_carga_detalle2);
  imprimir_archivo_detalle2(archivo_detalle2);
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO MAESTRO ACTUALIZADO:'); writeln();
  actualizar_archivo_maestro(archivo_maestro,archivo_detalle1,archivo_detalle2);
  imprimir_archivo_maestro(archivo_maestro);
end.