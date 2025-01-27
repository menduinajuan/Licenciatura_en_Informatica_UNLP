{TRABAJO PRÁCTICO N° 7}
{EJERCICIO 10}
{Una compañía de venta de insumos agrícolas desea procesar la información de las empresas a las que les provee sus productos.
De cada empresa, se conoce su código, nombre, si es estatal o privada, nombre de la ciudad donde está radicada y los cultivos que realiza (a lo sumo, 20).
Para cada cultivo de la empresa, se registra: tipo de cultivo (trigo, maíz, soja, girasol, etc.), cantidad de hectáreas dedicadas y la cantidad de meses que lleva el ciclo de cultivo.
(a) Realizar un programa que lea la información de las empresas y sus cultivos.
Dicha información se ingresa hasta que llegue una empresa con código -1 (la cual no debe procesarse).
Para cada empresa se leen todos sus cultivos, hasta que se ingrese un cultivo con 0 hectáreas (que no debe procesarse).
(b) Una vez leída y almacenada la información, calcular e informar:
(i) Nombres de las empresas radicadas en “San Miguel del Monte” que cultivan trigo y cuyo código de empresa posee, al menos, dos ceros.
(ii) La cantidad de hectáreas dedicadas al cultivo de soja y qué porcentaje representa con respecto al total de hectáreas.
(iii) La empresa que dedica más tiempo al cultivo de maíz.
(c) Realizar un módulo que incremente en un mes los tiempos de cultivos de girasol de menos de 5 hectáreas de todas las empresas que no son estatales.}

program TP7_E10;
{$codepage UTF8}
uses crt;
const
  cultivos_total=20;
  codigo_salida=-1; hectareas_salida=0;
  ciudad_corte='San Miguel del Monte'; tipo_corte1='trigo'; digito_corte=0; cantidad_digito_corte=2;
  tipo_corte2='soja';
  tipo_corte3='maiz';
  tipo_corte4='girasol'; hectareas_corte4=5;
type
  t_cultivo=1..cultivos_total;
  t_registro_cultivo=record
    tipo: string;
    hectareas: real;
    meses: int8;
  end;
  t_vector_cultivos=array[t_cultivo] of t_registro_cultivo;
  t_registro_empresa=record
    codigo: int16;
    nombre: string;
    estatal: boolean;
    ciudad: string;
    cultivos: t_vector_cultivos;
    cantidad_cultivos: int8;
  end;
  t_lista_empresas=^t_nodo_empresas;
  t_nodo_empresas=record
    ele: t_registro_empresa;
    sig: t_lista_empresas;
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
procedure leer_cultivo(var registro_cultivo: t_registro_cultivo);
var
  vector_tipo: array[1..4] of string=('trigo', 'maiz', 'soja', 'girasol');
  i: int8;
begin
  i:=random(cultivos_total);
  if (i=0) then
    registro_cultivo.hectareas:=hectareas_salida
  else
    registro_cultivo.hectareas:=1+random(991)/10;
  if (registro_cultivo.hectareas<>hectareas_salida) then
  begin
    registro_cultivo.tipo:=vector_tipo[1+random(4)];
    registro_cultivo.meses:=1+random(12);
  end;
end;
procedure cargar_vector_cultivos(var vector_cultivos: t_vector_cultivos; var cultivos: int8);
var
  registro_cultivo: t_registro_cultivo;
begin
  leer_cultivo(registro_cultivo);
  while ((registro_cultivo.hectareas<>hectareas_salida) and (cultivos<cultivos_total)) do
  begin
    cultivos:=cultivos+1;
    vector_cultivos[cultivos]:=registro_cultivo;
    if (cultivos<cultivos_total) then
      leer_cultivo(registro_cultivo);
  end;
end;
procedure leer_empresa(var registro_empresa: t_registro_empresa);
var
  i: int8;
begin
  i:=random(101);
  if (i=0) then
    registro_empresa.codigo:=codigo_salida
  else
    registro_empresa.codigo:=1+random(high(int16));
  if (registro_empresa.codigo<>codigo_salida) then
  begin
    registro_empresa.nombre:=random_string(5+random(6));
    registro_empresa.estatal:=(random(2)=0);
    if (i<=50) then
      registro_empresa.ciudad:=ciudad_corte
    else
      registro_empresa.ciudad:=random_string(5+random(6));
    registro_empresa.cantidad_cultivos:=0;
    cargar_vector_cultivos(registro_empresa.cultivos,registro_empresa.cantidad_cultivos);
  end;
end;
procedure agregar_adelante_lista_empresas(var lista_empresas: t_lista_empresas; registro_empresa: t_registro_empresa);
var
  nuevo: t_lista_empresas;
begin
  new(nuevo);
  nuevo^.ele:=registro_empresa;
  nuevo^.sig:=lista_empresas;
  lista_empresas:=nuevo;
end;
procedure cargar_lista_empresas(var lista_empresas: t_lista_empresas);
var
  registro_empresa: t_registro_empresa;
begin
  leer_empresa(registro_empresa);
  while (registro_empresa.codigo<>codigo_salida) do
  begin
    agregar_adelante_lista_empresas(lista_empresas,registro_empresa);
    leer_empresa(registro_empresa);
  end;
end;
procedure imprimir_registro_cultivo(registro_cultivo: t_registro_cultivo; cultivo: int8; empresa: int16);
begin
  textcolor(green); write('El tipo de cultivo del cultivo '); textcolor(yellow); write(cultivo); textcolor(green); write(' de la empresa '); textcolor(yellow); write(empresa); textcolor(green); write(' es '); textcolor(red); writeln(registro_cultivo.tipo);
  textcolor(green); write('La cantidad de hectáreas del cultivo '); textcolor(yellow); write(cultivo); textcolor(green); write(' de la empresa '); textcolor(yellow); write(empresa); textcolor(green); write(' es '); textcolor(red); writeln(registro_cultivo.hectareas:0:2);
  textcolor(green); write('La cantidad de meses del cultivo '); textcolor(yellow); write(cultivo); textcolor(green); write(' de la empresa '); textcolor(yellow); write(empresa); textcolor(green); write(' es '); textcolor(red); writeln(registro_cultivo.meses);
end;
procedure imprimir_vector_cultivos(vector_cultivos: t_vector_cultivos; cultivos: int8; empresa: int16);
var
  i: int8;
begin
  for i:= 1 to cultivos do
    imprimir_registro_cultivo(vector_cultivos[i],i,empresa);
end;
procedure imprimir_registro_empresa(registro_empresa: t_registro_empresa; empresa: int16);
begin
  textcolor(green); write('El código de la empresa '); textcolor(yellow); write(empresa); textcolor(green); write(' es '); textcolor(red); writeln(registro_empresa.codigo);
  textcolor(green); write('El nombre de la empresa '); textcolor(yellow); write(empresa); textcolor(green); write(' es '); textcolor(red); writeln(registro_empresa.nombre);
  textcolor(green); write('La empresa '); textcolor(yellow); write(empresa); textcolor(green); write(' es '); textcolor(red); if (registro_empresa.estatal=true) then writeln('estatal') else writeln('privada');
  textcolor(green); write('La ciudad de la empresa '); textcolor(yellow); write(empresa); textcolor(green); write(' es '); textcolor(red); writeln(registro_empresa.ciudad);
  textcolor(green); write('La cantidad de cultivos de la empresa '); textcolor(yellow); write(empresa); textcolor(green); write(' es '); textcolor(red); writeln(registro_empresa.cantidad_cultivos);
  imprimir_vector_cultivos(registro_empresa.cultivos,registro_empresa.cantidad_cultivos,empresa);
end;
procedure imprimir_lista_empresas(lista_empresas: t_lista_empresas);
var
  i: int16;
begin
  i:=0;
  while (lista_empresas<>nil) do
  begin
    i:=i+1;
    textcolor(green); write('La información de la empresa '); textcolor(yellow); write(i); textcolor(green); writeln(' es:');
    imprimir_registro_empresa(lista_empresas^.ele,i);
    writeln();
    lista_empresas:=lista_empresas^.sig;
  end;
end;
procedure procesar_vector_cultivos(var vector_cultivos: t_vector_cultivos; cultivos: int8; var cumple_tipo_corte1: boolean; var hectareas_corte2, hectareas_total: real; var meses_corte3: int8; estatal: boolean);
var
  i: int8;
begin
  for i:= 1 to cultivos do
  begin
    hectareas_total:=hectareas_total+vector_cultivos[i].hectareas;
    if ((vector_cultivos[i].tipo=tipo_corte1) and (cumple_tipo_corte1=false)) then
      cumple_tipo_corte1:=true
    else if (vector_cultivos[i].tipo=tipo_corte2) then
      hectareas_corte2:=hectareas_corte2+vector_cultivos[i].hectareas
    else if (vector_cultivos[i].tipo=tipo_corte3) then
      meses_corte3:=meses_corte3+vector_cultivos[i].meses
    else if ((vector_cultivos[i].tipo=tipo_corte4) and (vector_cultivos[i].hectareas<hectareas_corte4) and (estatal=false)) then
      vector_cultivos[i].meses:=vector_cultivos[i].meses+1;
  end;
end;
function contar_digitos(codigo: int16): boolean;
var
  digitos: int8;
begin
  digitos:=0;
  while (codigo<>0) do
  begin
    if (codigo mod 10=digito_corte) then
      digitos:=digitos+1;
    codigo:=codigo div 10;
  end;
  contar_digitos:=(digitos>=cantidad_digito_corte);
end;
procedure actualizar_maximo(meses_corte3: int8; nombre: string; var meses_corte3_max: int8; var nombre_corte3: string);
begin
  if (meses_corte3>meses_corte3_max) then
  begin
    meses_corte3_max:=meses_corte3;
    nombre_corte3:=nombre;
  end;
end;
procedure procesar_lista_empresas(lista_empresas: t_lista_empresas; var hectareas_corte2, porcentaje_corte2: real; var nombre_corte3: string);
var
  meses_corte3, meses_corte3_max: int8;
  hectareas_total: real;
  cumple_tipo_corte1: boolean;
begin
  cumple_tipo_corte1:=false;
  hectareas_total:=0;
  meses_corte3_max:=low(int8);
  while (lista_empresas<>nil) do
  begin
    meses_corte3:=0;
    procesar_vector_cultivos(lista_empresas^.ele.cultivos,lista_empresas^.ele.cantidad_cultivos,cumple_tipo_corte1,hectareas_corte2,hectareas_total,meses_corte3,lista_empresas^.ele.estatal);
    if ((lista_empresas^.ele.ciudad=ciudad_corte) and (cumple_tipo_corte1=true) and (contar_digitos(lista_empresas^.ele.codigo)=true)) then
    begin
      textcolor(green); write('El nombre de esta empresa radicada en '); textcolor(yellow); write(ciudad_corte); textcolor(green); write(' que cultiva '); textcolor(yellow); write(tipo_corte1); textcolor(green); write(' y cuyo código de empresa posee, al menos, '); textcolor(yellow); write(cantidad_digito_corte); textcolor(green); write(' dígitos '); textcolor(yellow); write(digito_corte); textcolor(green); write(' es '); textcolor(red); writeln(lista_empresas^.ele.nombre);
    end;
    actualizar_maximo(meses_corte3,lista_empresas^.ele.nombre,meses_corte3_max,nombre_corte3);
    lista_empresas:=lista_empresas^.sig;
  end;
  if (hectareas_total>0) then
    porcentaje_corte2:=hectareas_corte2/hectareas_total*100;
end;
var
  lista_empresas: t_lista_empresas;
  hectareas_corte2, porcentaje_corte2: real;
  nombre_corte3: string;
begin
  randomize;
  lista_empresas:=nil;
  hectareas_corte2:=0; porcentaje_corte2:=0;
  nombre_corte3:='';
  writeln(); textcolor(red); writeln('INCISO (a):'); writeln();
  cargar_lista_empresas(lista_empresas);
  if (lista_empresas<>nil) then
  begin
    imprimir_lista_empresas(lista_empresas);
    writeln(); textcolor(red); writeln('INCISO (b) (i):'); writeln();
    procesar_lista_empresas(lista_empresas,hectareas_corte2,porcentaje_corte2,nombre_corte3);
    writeln(); textcolor(red); writeln('INCISO (b) (ii):'); writeln();
    textcolor(green); write('La cantidad de hectáreas dedicadas al cultivo de '); textcolor(yellow); write(tipo_corte2); textcolor(green); write(' y el que porcentaje representa con respecto al total de hectáreas son '); textcolor(red); write(hectareas_corte2:0:2); textcolor(green); write(' y '); textcolor(red); write(porcentaje_corte2:0:2); textcolor(green); writeln('%, respectivamente');
    writeln(); textcolor(red); writeln('INCISO (b) (iii):'); writeln();
    textcolor(green); write('La empresa que dedica más tiempo al cultivo de '); textcolor(yellow); write(tipo_corte3); textcolor(green); write(' es '); textcolor(red); writeln(nombre_corte3);
    writeln(); textcolor(red); writeln('INCISO (c):'); writeln();
    imprimir_lista_empresas(lista_empresas);
  end;
end.