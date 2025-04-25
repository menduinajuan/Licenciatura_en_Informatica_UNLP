{TRABAJO PRÁCTICO N° 2}
{EJERCICIO 11}
{Se tiene información en un archivo de las horas extras realizadas por los empleados de una empresa en un mes.
Para cada empleado, se tiene la siguiente información: departamento, división, número de empleado, categoría y cantidad de horas extras realizadas por el empleado.
Se sabe que el archivo se encuentra ordenado por departamento, luego por división y, por último, por número de empleado.
Presentar en pantalla un listado con el siguiente formato:
Para obtener el valor de la hora, se debe cargar un arreglo desde un archivo de texto al iniciar el programa con el valor de la hora extra para cada categoría. La categoría varía de 1 a 15.
En el archivo de texto, debe haber una línea para cada categoría con el número de categoría y el valor de la hora, pero el arreglo debe ser de valores de horas, con la posición del valor coincidente con el número de categoría.}

program TP2_E11;
{$codepage UTF8}
uses crt;
const
  departamento_salida=999;
  categoria_ini=1; categoria_fin=15;
type
  t_categoria=categoria_ini..categoria_fin;
  t_registro_empleado=record
    departamento: int16;
    division: int16;
    empleado: int16;
    categoria: t_categoria;
    horas: int16;
  end;
  t_vector_horas=array[t_categoria] of real;
  t_archivo_maestro=file of t_registro_empleado;
procedure cargar_vector_horas(var vector_horas: t_vector_horas; var archivo_carga_vector: text);
var
  categoria: t_categoria;
  valor_hora: real;
begin
  reset(archivo_carga_vector);
  while (not eof(archivo_carga_vector)) do
  begin
    readln(archivo_carga_vector,categoria,valor_hora);
    vector_horas[categoria]:=valor_hora;
  end;
  close(archivo_carga_vector);
end;
procedure imprimir_vector_horas(vector_horas: t_vector_horas);
var
  i: t_categoria;
begin
  for i:= categoria_ini to categoria_fin do
  begin
    textcolor(green); write('El valor de la hora de la categoría ',i,' es '); textcolor(yellow); writeln(vector_horas[i]:0:2);
  end;
end;
procedure cargar_archivo_maestro(var archivo_maestro: t_archivo_maestro; var archivo_carga_maestro: text);
var
  registro_empleado: t_registro_empleado;
begin
  rewrite(archivo_maestro);
  reset(archivo_carga_maestro);
  while (not eof(archivo_carga_maestro)) do
  begin
    with registro_empleado do
    begin
      readln(archivo_carga_maestro,departamento,division,empleado,categoria,horas);
      write(archivo_maestro,registro_empleado);
    end;
  end;
  close(archivo_maestro);
  close(archivo_carga_maestro);
end;
procedure imprimir_registro_empleado(registro_empleado: t_registro_empleado);
begin
  textcolor(green); write('Departamento: '); textcolor(yellow); write(registro_empleado.departamento);
  textcolor(green); write('; División: '); textcolor(yellow); write(registro_empleado.division);
  textcolor(green); write('; Número de empleado: '); textcolor(yellow); write(registro_empleado.empleado);
  textcolor(green); write('; Categoría: '); textcolor(yellow); write(registro_empleado.categoria);
  textcolor(green); write('; Horas extras: '); textcolor(yellow); writeln(registro_empleado.horas);
end;
procedure imprimir_archivo_maestro(var archivo_maestro: t_archivo_maestro);
var
  registro_empleado: t_registro_empleado;
begin
  reset(archivo_maestro);
  while (not eof(archivo_maestro)) do
  begin
    read(archivo_maestro,registro_empleado);
    imprimir_registro_empleado(registro_empleado);
  end;
  close(archivo_maestro);
end;
procedure leer_empleado(var archivo_maestro: t_archivo_maestro; var registro_empleado: t_registro_empleado);
begin
  if (not eof(archivo_maestro)) then
    read(archivo_maestro,registro_empleado)
  else
    registro_empleado.departamento:=departamento_salida;
end;
procedure procesar_archivo_maestro(var archivo_maestro: t_archivo_maestro; vector_horas: t_vector_horas);
var
  registro_empleado: t_registro_empleado;
  categoria: t_categoria;
  departamento, division, empleado, horas_departamento, horas_division, horas_empleado: int16;
  monto_departamento, monto_division, monto_empleado: real;
begin
  reset(archivo_maestro);
  leer_empleado(archivo_maestro,registro_empleado);
  while (registro_empleado.departamento<>departamento_salida) do
  begin
    departamento:=registro_empleado.departamento;
    horas_departamento:=0; monto_departamento:=0;
    textcolor(green); write('Departamento: '); textcolor(yellow); writeln(departamento);
    while (registro_empleado.departamento=departamento) do
    begin
      division:=registro_empleado.division;
      horas_division:=0; monto_division:=0;
      textcolor(green); write('División: '); textcolor(yellow); writeln(division);
      textcolor(green); writeln('Número de Empleado          Total de Hs.          Importe a cobrar');
      while ((registro_empleado.departamento=departamento) and (registro_empleado.division=division)) do
      begin
        empleado:=registro_empleado.empleado; categoria:=registro_empleado.categoria;
        horas_empleado:=0; monto_empleado:=0;
        while ((registro_empleado.departamento=departamento) and (registro_empleado.division=division) and (registro_empleado.empleado=empleado)) do
        begin
          horas_empleado:=horas_empleado+registro_empleado.horas;
          leer_empleado(archivo_maestro,registro_empleado);
        end;
        monto_empleado:=horas_empleado*vector_horas[categoria];
        textcolor(yellow); write(empleado); textcolor(green); write('                           '); textcolor(red); write(horas_empleado); textcolor(green); write('                    $'); textcolor(red); writeln(monto_empleado:0:2);
        horas_division:=horas_division+horas_empleado;
        monto_division:=monto_division+monto_empleado;
      end;
      textcolor(green); write('Total horas división: '); textcolor(red); writeln(horas_division);
      textcolor(green); write('Monto total división: $'); textcolor(red); writeln(monto_division:0:2);
      horas_departamento:=horas_departamento+horas_division;
      monto_departamento:=monto_departamento+monto_division;
    end;
    textcolor(green); write('Total horas departamento: '); textcolor(red); writeln(horas_departamento);
    textcolor(green); write('Monto total departamento: $'); textcolor(red); writeln(monto_departamento:0:2); writeln();
  end;
end;
var
  vector_horas: t_vector_horas;
  archivo_maestro: t_archivo_maestro;
  archivo_carga_vector, archivo_carga_maestro: text;
begin
  writeln(); textcolor(red); writeln('IMPRESIÓN VECTOR HORAS:'); writeln();
  assign(archivo_carga_vector,'E11_horasVector.txt');
  cargar_vector_horas(vector_horas,archivo_carga_vector);
  imprimir_vector_horas(vector_horas);
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO MAESTRO:'); writeln();
  assign(archivo_maestro,'E11_empleadosMaestro'); assign(archivo_carga_maestro,'E11_empleadosMaestro.txt');
  cargar_archivo_maestro(archivo_maestro,archivo_carga_maestro);
  imprimir_archivo_maestro(archivo_maestro);
  writeln(); textcolor(red); writeln('PROCESAMIENTO ARCHIVO MAESTRO:'); writeln();
  procesar_archivo_maestro(archivo_maestro,vector_horas);
end.