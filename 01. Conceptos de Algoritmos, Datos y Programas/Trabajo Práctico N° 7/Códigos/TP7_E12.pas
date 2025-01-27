{TRABAJO PRÁCTICO N° 7}
{EJERCICIO 12}
{El centro de deportes Fortaco’s quiere procesar la información de los 4 tipos de suscripciones que ofrece: 1) Musculación, 2) Spinning, 3) CrossFit, 4) Todas las clases.
Para ello, el centro dispone de una tabla con información sobre el costo mensual de cada tipo de suscripción.
(a) Realizar un programa que lea y almacene la información de los clientes del centro.
De cada cliente, se conoce el nombre, DNI, edad y tipo de suscripción contratada (valor entre 1 y 4). Cada cliente tiene una sola suscripción.
La lectura finaliza cuando se lee el cliente con DNI 0, el cual no debe procesarse.
(b) Una vez almacenados todos los datos, procesar la estructura de datos generada, calcular e informar:
(i) La ganancia total de Fortaco’s.
(ii) Las 2 suscripciones con más clientes.
(c) Generar una lista con nombre y DNI de los clientes de más de 40 años que están suscritos a CrossFit o a Todas las clases. Esta lista debe estar ordenada por DNI.}

program TP7_E12;
{$codepage UTF8}
uses crt;
const
  suscripcion_ini=1; suscripcion_fin=4;
  dni_salida=0;
  edad_corte=40; suscripcion_corte1=3; suscripcion_corte2=4;
type
  t_suscripcion=suscripcion_ini..suscripcion_fin;
  t_registro_cliente1=record
    nombre: string;
    dni: int32;
    edad: int8;
    suscripcion: t_suscripcion;
  end;
  t_vector_costos=array[t_suscripcion] of real;
  t_lista_clientes1=^t_nodo_clientes1;
  t_nodo_clientes1=record
    ele: t_registro_cliente1;
    sig: t_lista_clientes1;
  end;
  t_vector_cantidades=array[t_suscripcion] of int16;
  t_registro_cliente2=record
    nombre: string;
    dni: int32;
  end;
  t_lista_clientes2=^t_nodo_clientes2;
  t_nodo_clientes2=record
    ele: t_registro_cliente2;
    sig: t_lista_clientes2;
  end;
procedure cargar_vector_costos(var vector_costos: t_vector_costos);
var
  i: t_suscripcion;
begin
  for i:= suscripcion_ini to suscripcion_fin do
    vector_costos[i]:=1+random(991)/10;
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
procedure leer_cliente(var registro_cliente1: t_registro_cliente1);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    registro_cliente1.dni:=dni_salida
  else
    registro_cliente1.dni:=10000000+random(40000001);
  if (registro_cliente1.dni<>dni_salida) then
  begin
    registro_cliente1.nombre:=random_string(5+random(6));
    registro_cliente1.edad:=18+random(83);
    registro_cliente1.suscripcion:=suscripcion_ini+random(suscripcion_fin);
  end;
end;
procedure agregar_adelante_lista_clientes1(var lista_clientes1: t_lista_clientes1; registro_cliente1: t_registro_cliente1);
var
  nuevo: t_lista_clientes1;
begin
  new(nuevo);
  nuevo^.ele:=registro_cliente1;
  nuevo^.sig:=lista_clientes1;
  lista_clientes1:=nuevo;
end;
procedure cargar_lista_clientes1(var lista_clientes1: t_lista_clientes1);
var
  registro_cliente1: t_registro_cliente1;
begin
  leer_cliente(registro_cliente1);
  while (registro_cliente1.dni<>dni_salida) do
  begin
    agregar_adelante_lista_clientes1(lista_clientes1,registro_cliente1);
    leer_cliente(registro_cliente1);
  end;
end;
procedure imprimir_registro_cliente1(registro_cliente1: t_registro_cliente1; cliente: int16);
begin
  textcolor(green); write('El nombre del cliente '); textcolor(yellow); write(cliente); textcolor(green); write(' es '); textcolor(red); writeln(registro_cliente1.nombre);
  textcolor(green); write('El DNI del cliente '); textcolor(yellow); write(cliente); textcolor(green); write(' es '); textcolor(red); writeln(registro_cliente1.dni);
  textcolor(green); write('La edad del cliente '); textcolor(yellow); write(cliente); textcolor(green); write(' es '); textcolor(red); writeln(registro_cliente1.edad);
  textcolor(green); write('El tipo de suscripción contratada por el cliente '); textcolor(yellow); write(cliente); textcolor(green); write(' es '); textcolor(red); writeln(registro_cliente1.suscripcion);  
end;
procedure imprimir_lista_clientes1(lista_clientes1: t_lista_clientes1);
var
  i: int16;
begin
  i:=0;
  while (lista_clientes1<>nil) do
  begin
    i:=i+1;
    textcolor(green); write('La información del cliente '); textcolor(yellow); write(i); textcolor(green); writeln(' es:');
    imprimir_registro_cliente1(lista_clientes1^.ele,i);
    writeln();
    lista_clientes1:=lista_clientes1^.sig;
  end;
end;
procedure inicializar_vector_cantidades(var vector_cantidades: t_vector_cantidades);
var
  i: t_suscripcion;
begin
  for i:= suscripcion_ini to suscripcion_fin do
    vector_cantidades[i]:=0;
end;
procedure cargar_registro_cliente2(var registro_cliente2: t_registro_cliente2; registro_cliente1: t_registro_cliente1);
begin
  registro_cliente2.nombre:=registro_cliente1.nombre;
  registro_cliente2.dni:=registro_cliente1.dni;
end;
procedure agregar_ordenado_lista_clientes2(var lista_clientes2: t_lista_clientes2; registro_cliente1: t_registro_cliente1);
var
  anterior, actual, nuevo: t_lista_clientes2;
begin
  new(nuevo);
  cargar_registro_cliente2(nuevo^.ele,registro_cliente1);
  nuevo^.sig:=nil;
  anterior:=lista_clientes2; actual:=lista_clientes2;
  while ((actual<>nil) and (actual^.ele.dni<nuevo^.ele.dni)) do
  begin
    anterior:=actual;
    actual:=actual^.sig;
  end;
  if (actual=lista_clientes2) then
    lista_clientes2:=nuevo
  else
    anterior^.sig:=nuevo;
  nuevo^.sig:=actual;
end;
procedure actualizar_maximos(cantidad: int16; suscripcion: t_suscripcion; var cantidad_max1, cantidad_max2: int16; var suscripcion_max1, suscripcion_max2: int8);
begin
  if (cantidad>cantidad_max1) then
  begin
    cantidad_max2:=cantidad_max1;
    suscripcion_max2:=suscripcion_max1;
    cantidad_max1:=cantidad;
    suscripcion_max1:=suscripcion;
  end
  else
    if (cantidad>cantidad_max2) then
    begin
      cantidad_max2:=cantidad;
      suscripcion_max2:=suscripcion;
    end;
end;
procedure procesar_vector_cantidades(vector_cantidades: t_vector_cantidades; var suscripcion_max1, suscripcion_max2: int8);
var
  i: t_suscripcion;
  cantidad_max1, cantidad_max2: int16;
begin
  cantidad_max1:=low(int16); cantidad_max2:=low(int16);
  for i:= suscripcion_ini to suscripcion_fin do
  begin
    actualizar_maximos(vector_cantidades[i],i,cantidad_max1,cantidad_max2,suscripcion_max1,suscripcion_max2);
    textcolor(green); write('La cantidad de clientes con tipo de suscripción contratada ',i,' es '); textcolor(red); writeln(vector_cantidades[i]);
  end;
end;
procedure procesar_lista_clientes1(lista_clientes1: t_lista_clientes1; vector_costos: t_vector_costos; var ganancia: real; var suscripcion_max1, suscripcion_max2: int8; var lista_clientes2: t_lista_clientes2);
var
  vector_cantidades: t_vector_cantidades;
begin
  inicializar_vector_cantidades(vector_cantidades);
  while (lista_clientes1<>nil) do
  begin
    ganancia:=ganancia+vector_costos[lista_clientes1^.ele.suscripcion];
    vector_cantidades[lista_clientes1^.ele.suscripcion]:=vector_cantidades[lista_clientes1^.ele.suscripcion]+1;
    if ((lista_clientes1^.ele.edad>edad_corte) and ((lista_clientes1^.ele.suscripcion=suscripcion_corte1) or (lista_clientes1^.ele.suscripcion=suscripcion_corte2))) then
      agregar_ordenado_lista_clientes2(lista_clientes2,lista_clientes1^.ele);
    lista_clientes1:=lista_clientes1^.sig;
  end;
  procesar_vector_cantidades(vector_cantidades,suscripcion_max1,suscripcion_max2);
end;
procedure imprimir_registro_cliente2(registro_cliente2: t_registro_cliente2; cliente: int16);
begin
  textcolor(green); write('El nombre del cliente '); textcolor(yellow); write(cliente); textcolor(green); write(' es '); textcolor(red); writeln(registro_cliente2.nombre);
  textcolor(green); write('El DNI del cliente '); textcolor(yellow); write(cliente); textcolor(green); write(' es '); textcolor(red); writeln(registro_cliente2.dni);
end;
procedure imprimir_lista_clientes2(lista_clientes2: t_lista_clientes2);
var
  i: int16;
begin
  i:=0;
  while (lista_clientes2<>nil) do
  begin
    i:=i+1;
    textcolor(green); write('La información del cliente '); textcolor(yellow); write(i); textcolor(green); writeln(' es:');
    imprimir_registro_cliente2(lista_clientes2^.ele,i);
    writeln();
    lista_clientes2:=lista_clientes2^.sig;
  end;
end;
var
  vector_costos: t_vector_costos;
  lista_clientes1: t_lista_clientes1;
  lista_clientes2: t_lista_clientes2;
  suscripcion_max1, suscripcion_max2: int8;
  ganancia: real;
begin
  randomize;
  lista_clientes1:=nil;
  ganancia:=0;
  suscripcion_max1:=0; suscripcion_max2:=0;
  lista_clientes2:=nil;
  cargar_vector_costos(vector_costos);
  writeln(); textcolor(red); writeln('INCISO (a):'); writeln();
  cargar_lista_clientes1(lista_clientes1);
  if (lista_clientes1<>nil) then
  begin
    imprimir_lista_clientes1(lista_clientes1);
    writeln(); textcolor(red); writeln('INCISO (b) (i):'); writeln();
    procesar_lista_clientes1(lista_clientes1,vector_costos,ganancia,suscripcion_max1,suscripcion_max2,lista_clientes2);
    writeln(); textcolor(green); write('La ganancia total de Fortaco’s es $'); textcolor(red); writeln(ganancia:0:2);
    writeln(); textcolor(red); writeln('INCISO (b) (ii):'); writeln();
    textcolor(green); write('Las 2 suscripciones con más clientes son '); textcolor(red); write(suscripcion_max1); textcolor(green); write(' y '); textcolor(red); writeln(suscripcion_max2);
    writeln(); textcolor(red); writeln('INCISO (c):'); writeln();
    imprimir_lista_clientes2(lista_clientes2);
  end;
end.