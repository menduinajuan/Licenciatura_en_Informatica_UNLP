{TRABAJO PRÁCTICO N° 7}
{EJERCICIO 6}
{El Observatorio Astronómico de La Plata ha realizado un relevamiento sobre los distintos objetos astronómicos observados durante el año 2015.
Los objetos se clasifican en 7 categorías: 1: estrellas, 2: planetas, 3: satélites, 4: galaxias, 5: asteroides, 6: cometas y 7: nebulosas.
Al observar un objeto, se registran los siguientes datos: código del objeto, categoría del objeto (1..7), nombre del objeto, distancia a la Tierra (medida en años luz), nombre del descubridor y año de su descubrimiento.
(a) Desarrollar un programa que lea y almacene la información de los objetos que han sido observados.
Dicha información se lee hasta encontrar un objeto con código -1 (el cual no debe procesarse).
La estructura generada debe mantener el orden en que fueron leídos los datos.
(b) Una vez leídos y almacenados todos los datos, se pide realizar un reporte con la siguiente información:
(i) Los códigos de los dos objetos más lejanos de la tierra que se hayan observado.
(ii) La cantidad de planetas descubiertos por “Galileo Galilei” antes del año 1600.
(iii) La cantidad de objetos observados por cada categoría.
(iv) Los nombres de las estrellas cuyos códigos de objeto poseen más dígitos pares que impares.}

program TP7_E6;
{$codepage UTF8}
uses crt;
const
  categoria_ini=1; categoria_fin=7;
  anio_ini=1500; anio_fin=2020;
  codigo_salida=-1;
  categoria_corte1=2; descubridor_corte='Galileo Galilei'; anio_corte=1600;
  categoria_corte2=1;
  vector_categorias: array[categoria_ini..categoria_fin] of string=('estrella', 'planeta', 'satelite', 'galaxia', 'asteroide', 'cometa', 'nebulosa');
type
  t_categoria=categoria_ini..categoria_fin;
  t_registro_objeto=record
    codigo: int16;
    categoria: t_categoria;
    nombre: string;
    distancia: real;
    descubridor: string;
    anio: int16;
  end;
  t_lista_objetos=^t_nodo_objetos;
  t_nodo_objetos=record
    ele: t_registro_objeto;
    sig: t_lista_objetos;
  end;
  t_vector_cantidades=array[t_categoria] of int16;
procedure inicializar_vector_cantidades(var vector_cantidades: t_vector_cantidades);
var
  i: t_categoria;
begin
  for i:= categoria_ini to categoria_fin do
    vector_cantidades[i]:=0;
end;
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
procedure leer_objeto(var registro_objeto: t_registro_objeto);
var
  i: int8;
begin
  i:=random(101);
  if (i=0) then
    registro_objeto.codigo:=codigo_salida
  else
    registro_objeto.codigo:=1+random(high(int16));
  if (registro_objeto.codigo<>codigo_salida) then
  begin
    registro_objeto.categoria:=categoria_ini+random(categoria_fin);
    registro_objeto.nombre:=random_string(5+random(6));
    registro_objeto.distancia:=1+random(991)/10;
    if (i<=50) then
      registro_objeto.descubridor:=descubridor_corte
    else
      registro_objeto.descubridor:=random_string(5+random(6));
    registro_objeto.anio:=anio_ini+random(anio_fin-anio_ini+1);
  end;
end;
procedure agregar_atras_lista_objetos(var lista_objetos: t_lista_objetos; registro_objeto: t_registro_objeto);
var
  nuevo, ult: t_lista_objetos;
begin
  new(nuevo);
  nuevo^.ele:=registro_objeto;
  nuevo^.sig:=nil;
  if (lista_objetos=nil) then
    lista_objetos:=nuevo
  else
  begin
    ult:=lista_objetos;
    while (ult^.sig<>nil) do
      ult:=ult^.sig;
    ult^.sig:=nuevo;
  end;
end;
procedure cargar_lista_objetos(var lista_objetos: t_lista_objetos);
var
  registro_objeto: t_registro_objeto;
begin
  leer_objeto(registro_objeto);
  while (registro_objeto.codigo<>codigo_salida) do
  begin
    agregar_atras_lista_objetos(lista_objetos,registro_objeto);
    leer_objeto(registro_objeto);
  end;
end;
procedure imprimir_registro_objeto(registro_objeto: t_registro_objeto; objeto: int16);
begin
  textcolor(green); write('El código de objeto del objeto '); textcolor(yellow); write(objeto); textcolor(green); write(' es '); textcolor(red); writeln(registro_objeto.codigo);
  textcolor(green); write('La categoría del objeto '); textcolor(yellow); write(objeto); textcolor(green); write(' es '); textcolor(red); writeln(registro_objeto.categoria);
  textcolor(green); write('El nombre del objeto '); textcolor(yellow); write(objeto); textcolor(green); write(' es '); textcolor(red); writeln(registro_objeto.nombre);
  textcolor(green); write('La distancia a la Tierra (medida en años luz) del objeto '); textcolor(yellow); write(objeto); textcolor(green); write(' es '); textcolor(red); writeln(registro_objeto.distancia:0:2);
  textcolor(green); write('El nombre del descubridor del objeto '); textcolor(yellow); write(objeto); textcolor(green); write(' es '); textcolor(red); writeln(registro_objeto.descubridor);
  textcolor(green); write('El año de descubrimiento del objeto '); textcolor(yellow); write(objeto); textcolor(green); write(' es '); textcolor(red); writeln(registro_objeto.anio);
end;
procedure imprimir_lista_objetos(lista_objetos: t_lista_objetos);
var
  i: int16;
begin
  i:=0;
  while (lista_objetos<>nil) do
  begin
    i:=i+1;
    textcolor(green); write('La información del objeto '); textcolor(yellow); write(i); textcolor(green); writeln(' es:');
    imprimir_registro_objeto(lista_objetos^.ele,i);
    writeln();
    lista_objetos:=lista_objetos^.sig;
  end;
end;
procedure actualizar_maximos(distancia: real; codigo: int16; var distancia_max1, distancia_max2: real; var codigo_max1, codigo_max2: int16);
begin
  if (distancia>distancia_max1) then
  begin
    distancia_max2:=distancia_max1;
    codigo_max2:=codigo_max1;
    distancia_max1:=distancia;
    codigo_max1:=codigo;
  end
  else
    if (distancia>distancia_max2) then
    begin
      distancia_max2:=distancia;
      codigo_max2:=codigo;
    end;
end;
function contar_pares_impares(codigo: int16): boolean;
var
  pares, impares: int8;
begin
  pares:=0; impares:=0;
  while (codigo<>0) do
  begin
    if (codigo mod 2=0) then
      pares:=pares+1
    else
      impares:=impares+1;
    codigo:=codigo div 10;
  end;
  contar_pares_impares:=(pares>impares);
end;
procedure procesar_lista_objetos(lista_objetos: t_lista_objetos; var codigo_max1, codigo_max2, objetos_corte: int16; var vector_cantidades: t_vector_cantidades);
var
  distancia_max1, distancia_max2: real;
begin
  distancia_max1:=-9999999; distancia_max2:=-9999999;
  while (lista_objetos<>nil) do
  begin
    actualizar_maximos(lista_objetos^.ele.distancia,lista_objetos^.ele.codigo,distancia_max1,distancia_max2,codigo_max1,codigo_max2);
    if ((lista_objetos^.ele.categoria=categoria_corte1) and (lista_objetos^.ele.descubridor=descubridor_corte) and (lista_objetos^.ele.anio<anio_corte)) then
      objetos_corte:=objetos_corte+1;
    vector_cantidades[lista_objetos^.ele.categoria]:=vector_cantidades[lista_objetos^.ele.categoria]+1;
    if ((lista_objetos^.ele.categoria=categoria_corte2) and (contar_pares_impares(lista_objetos^.ele.codigo)=true)) then
    begin
      textcolor(green); write('El nombre de este objeto '); textcolor(yellow); write(vector_categorias[categoria_corte2]); textcolor(green); write(' cuyo código de objeto posee más dígitos pares que impares es '); textcolor(red); writeln(lista_objetos^.ele.nombre);
    end;
    lista_objetos:=lista_objetos^.sig;
  end;
end;
procedure imprimir_vector_cantidades(vector_cantidades: t_vector_cantidades);
var
  i: t_categoria;
begin
  for i:= categoria_ini to categoria_fin do
  begin
    textcolor(green); write('La cantidad de objetos observados por la categoría '); textcolor(yellow); write(i); textcolor(green); write(' es '); textcolor(red); writeln(vector_cantidades[i]);
  end;
end;
var
  vector_cantidades: t_vector_cantidades;
  lista_objetos: t_lista_objetos;
  codigo_max1, codigo_max2, objetos_corte: int16;
begin
  randomize;
  lista_objetos:=nil;
  codigo_max1:=0; codigo_max2:=0;
  objetos_corte:=0;
  inicializar_vector_cantidades(vector_cantidades);
  writeln(); textcolor(red); writeln('INCISO (a):'); writeln();
  cargar_lista_objetos(lista_objetos);
  if (lista_objetos<>nil) then
  begin
    imprimir_lista_objetos(lista_objetos);
    writeln(); textcolor(red); writeln('INCISO (b) (iv):'); writeln();
    procesar_lista_objetos(lista_objetos,codigo_max1,codigo_max2,objetos_corte,vector_cantidades);
    writeln(); textcolor(red); writeln('INCISO (b) (i):'); writeln();
    textcolor(green); write('Los códigos de los dos objetos más lejanos de la tierra que se hayan observado son '); textcolor(red); write(codigo_max1); textcolor(green); write(' y '); textcolor(red); writeln(codigo_max2);
    writeln(); textcolor(red); writeln('INCISO (b) (ii):'); writeln();
    textcolor(green); write('La cantidad de '); textcolor(yellow); write(vector_categorias[categoria_corte1]); write('s'); textcolor(green); write(' descubiertos por '); textcolor(yellow); write(descubridor_corte); textcolor(green); write(' antes del año '); textcolor(yellow); write(anio_corte); textcolor(green); write(' es '); textcolor(red); writeln(objetos_corte);
    writeln(); textcolor(red); writeln('INCISO (b) (iii):'); writeln();
    imprimir_vector_cantidades(vector_cantidades);
  end;
end.