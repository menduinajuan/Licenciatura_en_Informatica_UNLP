{TRABAJO PRÁCTICO N° 7}
{EJERCICIO 9}
{Un cine posee la lista de películas que proyectará durante el mes de Febrero.
De cada película, se tiene: código de película, título de la película, código de género (1: acción, 2: aventura, 3: drama, 4: suspenso, 5: comedia, 6: bélica, 7: documental y 8: terror) y puntaje promedio otorgado por las críticas.
Dicha estructura no posee orden alguno.
Se pide:
(a) Actualizar (en la lista que se dispone) el puntaje promedio otorgado por las críticas.
Para ello, se debe leer desde teclado las críticas que han realizado críticos de cine.
De cada crítica, se lee: DNI del crítico, apellido y nombre del crítico, código de película y el puntaje otorgado.
La lectura finaliza cuando se lee el código de película -1 y la información viene ordenada por código de película.
(b) Informar el código de género que más puntaje obtuvo entre todas las críticas.
(c) Informar el apellido y nombre de aquellos críticos que posean la misma cantidad de dígitos pares que impares en su DNI.
(d) Realizar un módulo que elimine de la lista que se dispone una película cuyo código se recibe como parámetro (el mismo puede no existir).}

program TP7_E9;
{$codepage UTF8}
uses crt;
const
  genero_ini=1; genero_fin=8;
  codigo_salida=-1;
type
  t_genero=genero_ini..genero_fin;
  t_registro_pelicula=record
    codigo: int16;
    titulo: string;
    genero: t_genero;
    puntaje: real;
  end;
  t_lista_peliculas=^t_nodo_peliculas;
  t_nodo_peliculas=record
    ele: t_registro_pelicula;
    sig: t_lista_peliculas;
  end;
  t_registro_critica=record
    dni: int32;
    apellido: string;
    nombre: string;
    codigo: int16;
    puntaje: real;
  end;
  t_vector_puntajes=array[t_genero] of real;
function random_string(length: int8): string;
var
  i: int8;
  string_aux: string;
begin
  string_aux:='';
  for i:= 1 to length do
    string_aux:=string_aux+chr(ord('A')+random(26));
  random_string:=string_aux;
end;
procedure leer_pelicula(var registro_pelicula: t_registro_pelicula);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    registro_pelicula.codigo:=codigo_salida
  else
    registro_pelicula.codigo:=1+random(high(int16));
  if (registro_pelicula.codigo<>codigo_salida) then
  begin
    registro_pelicula.titulo:=random_string(5+random(6));
    registro_pelicula.genero:=genero_ini+random(genero_fin);
    registro_pelicula.puntaje:=1+random(91)/10;
  end;
end;
procedure agregar_adelante_lista_peliculas(var lista_peliculas: t_lista_peliculas; registro_pelicula: t_registro_pelicula);
var
  nuevo: t_lista_peliculas;
begin
  new(nuevo);
  nuevo^.ele:=registro_pelicula;
  nuevo^.sig:=lista_peliculas;
  lista_peliculas:=nuevo;
end;
procedure cargar_lista_peliculas(var lista_peliculas: t_lista_peliculas);
var
  registro_pelicula: t_registro_pelicula;
begin
  leer_pelicula(registro_pelicula);
  while (registro_pelicula.codigo<>codigo_salida) do
  begin
    agregar_adelante_lista_peliculas(lista_peliculas,registro_pelicula);
    leer_pelicula(registro_pelicula);
  end;
end;
procedure imprimir_registro_pelicula(registro_pelicula: t_registro_pelicula; pelicula: int16);
begin
  textcolor(green); write('El código de película de la película '); textcolor(yellow); write(pelicula); textcolor(green); write(' es '); textcolor(red); writeln(registro_pelicula.codigo);
  textcolor(green); write('El título de la película '); textcolor(yellow); write(pelicula); textcolor(green); write(' es '); textcolor(red); writeln(registro_pelicula.titulo);
  textcolor(green); write('El código de género de la película '); textcolor(yellow); write(pelicula); textcolor(green); write(' es '); textcolor(red); writeln(registro_pelicula.genero);
  textcolor(green); write('El puntaje promedio otorgado por las críticas de la película '); textcolor(yellow); write(pelicula); textcolor(green); write(' es '); textcolor(red); writeln(registro_pelicula.puntaje:0:2);
end;
procedure imprimir_lista_peliculas(lista_peliculas: t_lista_peliculas);
var
  i: int16;
begin
  i:=0;
  while (lista_peliculas<>nil) do
  begin
    i:=i+1;
    textcolor(green); write('La información de la película '); textcolor(yellow); write(i); textcolor(green); writeln(' es:');
    imprimir_registro_pelicula(lista_peliculas^.ele,i);
    writeln();
    lista_peliculas:=lista_peliculas^.sig;
  end;
end;
procedure leer_critica(var registro_critica: t_registro_critica; codigo: int16);
var
  i: int8;
begin
  i:=random(101);
  if (i=0) then
    registro_critica.codigo:=codigo_salida
  else if (i<=50) then
    registro_critica.codigo:=codigo
  else
    registro_critica.codigo:=codigo+random(high(int16)-(codigo-1));
  if (registro_critica.codigo<>codigo_salida) then
  begin
    registro_critica.dni:=10000000+random(40000001);
    registro_critica.apellido:=random_string(5+random(6));
    registro_critica.nombre:=random_string(5+random(6));
    registro_critica.puntaje:=1+random(91)/10;
  end;
end;
function contar_pares_impares(dni: int32): boolean;
var
  pares, impares: int8;
begin
  pares:=0; impares:=0;
  while (dni<>0) do
  begin
    if (dni mod 2=0) then
      pares:=pares+1
    else
      impares:=impares+1;
    dni:=dni div 10;
  end;
  contar_pares_impares:=(pares=impares);
end;
procedure buscar_lista_peliculas(lista_peliculas: t_lista_peliculas; codigo: int16; puntaje: real);
begin
  while ((lista_peliculas<>nil) and (lista_peliculas^.ele.codigo<>codigo)) do
    lista_peliculas:=lista_peliculas^.sig;
  if (lista_peliculas<>nil) then
    lista_peliculas^.ele.puntaje:=puntaje;
end;
procedure actualizar_lista_peliculas(var lista_peliculas: t_lista_peliculas);
var
  registro_critica: t_registro_critica;
  codigo, criticas: int16;
  puntaje: real;
begin
  codigo:=1;
  leer_critica(registro_critica,codigo);
  while (registro_critica.codigo<>codigo_salida) do
  begin
    codigo:=registro_critica.codigo;
    puntaje:=0; criticas:=0;
    while ((registro_critica.codigo<>codigo_salida) and (registro_critica.codigo=codigo)) do
    begin
      puntaje:=puntaje+registro_critica.puntaje;
      criticas:=criticas+1;
      if (contar_pares_impares(registro_critica.dni)=true) then
      begin
        textcolor(green); write('El apellido y nombre de este crítico que posee la misma cantidad de dígitos pares e impares en su DNI son '); textcolor(red); writeln(registro_critica.apellido,' ',registro_critica.nombre);
      end;
      leer_critica(registro_critica,codigo);
    end;
    buscar_lista_peliculas(lista_peliculas,codigo,puntaje/criticas);
  end;
end;
procedure inicializar_vector_puntajes(var vector_puntajes: t_vector_puntajes);
var
  i: t_genero;
begin
  for i:= genero_ini to genero_fin do
    vector_puntajes[i]:=0;
end;
procedure actualizar_maximo(puntaje: real; genero: t_genero; var puntaje_max: real; var genero_max: int8);
begin
  if (puntaje>puntaje_max) then
  begin
    puntaje_max:=puntaje;
    genero_max:=genero;
  end;
end;
procedure procesar_vector_puntajes(vector_puntajes: t_vector_puntajes; var genero_max: int8);
var
  i: t_genero;
  puntaje_max: real;
begin
  puntaje_max:=-9999999;
  for i:= genero_ini+1 to genero_fin do
  begin
    actualizar_maximo(vector_puntajes[i],i,puntaje_max,genero_max);
    textcolor(green); write('El puntaje que obtuvo entre todas las críticas el código de género ',i,' es '); textcolor(red); writeln(vector_puntajes[i]:0:2);
  end;
end;
procedure procesar_lista_peliculas(lista_peliculas: t_lista_peliculas; var genero_max: int8);
var
  vector_puntajes: t_vector_puntajes;
begin
  inicializar_vector_puntajes(vector_puntajes);
  while (lista_peliculas<>nil) do
  begin
    vector_puntajes[lista_peliculas^.ele.genero]:=vector_puntajes[lista_peliculas^.ele.genero]+lista_peliculas^.ele.puntaje;
    lista_peliculas:=lista_peliculas^.sig;
  end;
  procesar_vector_puntajes(vector_puntajes,genero_max);
end;
procedure eliminar_lista_peliculas(var lista_peliculas: t_lista_peliculas; var ok: boolean; codigo: int16);
var
  anterior, actual: t_lista_peliculas;
begin
  actual:=lista_peliculas;
  while ((actual<>nil) and (actual^.ele.codigo<>codigo)) do
  begin
    anterior:=actual;
    actual:=actual^.sig;
  end;
  if (actual<>nil) then
  begin
    if (actual=lista_peliculas) then
      lista_peliculas:=lista_peliculas^.sig
    else
      anterior^.sig:=actual^.sig;
    dispose(actual);
    ok:=true;
  end
end;
var
  lista_peliculas: t_lista_peliculas;
  genero_max: int8;
  codigo: int16;
  ok: boolean;
begin
  randomize;
  lista_peliculas:=nil;
  genero_max:=0;
  cargar_lista_peliculas(lista_peliculas);
  if (lista_peliculas<>nil) then
  begin
    imprimir_lista_peliculas(lista_peliculas);
    writeln(); textcolor(red); writeln('INCISO (a) (c):'); writeln();
    actualizar_lista_peliculas(lista_peliculas);
    imprimir_lista_peliculas(lista_peliculas);
    writeln(); textcolor(red); writeln('INCISO (b):'); writeln();
    procesar_lista_peliculas(lista_peliculas,genero_max);
    writeln(); textcolor(green); write('El código de género que más puntaje obtuvo entre todas las críticas es '); textcolor(red); writeln(genero_max);
    writeln(); textcolor(red); writeln('INCISO (d):'); writeln();
    codigo:=1+random(high(int16));
    eliminar_lista_peliculas(lista_peliculas,ok,codigo);
    if (ok=true) then
    begin
      textcolor(green); write('El código de película '); textcolor(yellow); write(codigo); textcolor(red); write(' SÍ'); textcolor(green); write(' fue encontrado y eliminado');
      imprimir_lista_peliculas(lista_peliculas);
    end
    else
    begin
      textcolor(green); write('El código de película '); textcolor(yellow); write(codigo); textcolor(red); write(' NO'); textcolor(green); write(' fue encontrado');
    end;
  end;
end.