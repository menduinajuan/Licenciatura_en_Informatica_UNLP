{TRABAJO PRÁCTICO N° 7}
{EJERCICIO 11}
{Realizar un programa para una empresa productora que necesita organizar 100 eventos culturales.
De cada evento, se dispone la siguiente información: nombre del evento, tipo de evento (1: música, 2: cine, 3: obra de teatro, 4: unipersonal y 5: monólogo), lugar del evento, cantidad máxima de personas permitidas para el evento y costo de la entrada.
Se pide:
(a) Generar una estructura con las ventas de entradas para tales eventos culturales.
De cada venta, se debe guardar: código de venta, número de evento (1..100), DNI del comprador y cantidad de entradas adquiridas.
La lectura de las ventas finaliza con código de venta -1.
(b) Una vez leída y almacenada la información de las ventas, calcular e informar:
(i) El nombre y lugar de los dos eventos que han tenido menos recaudación.
(ii) La cantidad de entradas vendidas cuyo comprador contiene, en su DNI, más dígitos pares que impares y que sean para el evento de tipo “obra de teatro”.
(iii) Si la cantidad de entradas vendidas para el evento número 50 alcanzó la cantidad máxima de personas permitidas.}

program TP7_E11;
{$codepage UTF8}
uses crt;
const
  eventos_total=100;
  tipo_ini=1; tipo_fin=5;
  codigo_salida=-1;
  tipo_corte=3;
  evento_corte=50;
  vector_tipos: array[tipo_ini..tipo_fin] of string=('musica', 'cine', 'obra de teatro', 'unipersonal', 'monologo');
type
  t_evento=1..eventos_total;
  t_tipo=tipo_ini..tipo_fin;
  t_registro_evento=record
    nombre: string;
    tipo: t_tipo;
    lugar: string;
    personas: int16;
    costo: real;
  end;
  t_registro_venta=record
    codigo: int16;
    evento: t_evento;
    dni: int32;
    entradas: int16;
  end;
  t_vector_eventos=array[t_evento] of t_registro_evento;
  t_vector_entradas=array[t_evento] of int16;
  t_lista_ventas=^t_nodo_ventas;
  t_nodo_ventas=record
    ele: t_registro_venta;
    sig: t_lista_ventas;
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
procedure leer_evento(var registro_evento: t_registro_evento);
begin
  registro_evento.nombre:=random_string(5+random(6));
  registro_evento.tipo:=tipo_ini+random(tipo_fin);
  registro_evento.lugar:=random_string(5+random(6));
  registro_evento.personas:=10+random(11);
  registro_evento.costo:=1+random(991)/10;
end;
procedure cargar_vector_eventos(var vector_eventos: t_vector_eventos);
var
  i: t_evento;
begin
  for i:= 1 to eventos_total do
    leer_evento(vector_eventos[i]);
end;
procedure leer_venta(var registro_venta: t_registro_venta);
var
  i: int8;
begin
  i:=random(1000);
  if (i=0) then
    registro_venta.codigo:=codigo_salida
  else
    registro_venta.codigo:=1+random(high(int16));
  if (registro_venta.codigo<>codigo_salida) then
  begin
    registro_venta.evento:=1+random(eventos_total);
    registro_venta.dni:=10000000+random(40000001);
    registro_venta.entradas:=1+random(10);
  end;
end;
procedure agregar_ordenado_lista_ventas(var lista_ventas: t_lista_ventas; registro_venta: t_registro_venta);
var
  anterior, actual, nuevo: t_lista_ventas;
begin
  new(nuevo);
  nuevo^.ele:=registro_venta;
  nuevo^.sig:=nil;
  actual:=lista_ventas;
  while ((actual<>nil) and (actual^.ele.evento<nuevo^.ele.evento)) do
  begin
    anterior:=actual;
    actual:=actual^.sig;
  end;
  if (actual=lista_ventas) then
    lista_ventas:=nuevo
  else
    anterior^.sig:=nuevo;
  nuevo^.sig:=actual;
end;
procedure inicializar_vector_entradas(var vector_entradas: t_vector_entradas);
var
  i: t_evento;
begin
  for i:= 1 to eventos_total do
    vector_entradas[i]:=0;
end;
procedure cargar_lista_ventas(var lista_ventas: t_lista_ventas; vector_eventos: t_vector_eventos);
var
  registro_venta: t_registro_venta;
  vector_entradas: t_vector_entradas;
begin
  inicializar_vector_entradas(vector_entradas);
  leer_venta(registro_venta);
  while (registro_venta.codigo<>codigo_salida) do
  begin
    if (vector_entradas[registro_venta.evento]+registro_venta.entradas<=vector_eventos[registro_venta.evento].personas) then
    begin
      vector_entradas[registro_venta.evento]:=vector_entradas[registro_venta.evento]+registro_venta.entradas;
      agregar_ordenado_lista_ventas(lista_ventas,registro_venta);
    end
    else if (vector_entradas[registro_venta.evento]<vector_eventos[registro_venta.evento].personas) then
    begin
      registro_venta.entradas:=vector_eventos[registro_venta.evento].personas-vector_entradas[registro_venta.evento];
      vector_entradas[registro_venta.evento]:=vector_entradas[registro_venta.evento]+registro_venta.entradas;
      agregar_ordenado_lista_ventas(lista_ventas,registro_venta);
    end;
    leer_venta(registro_venta);
  end;
end;
procedure imprimir_registro_venta(registro_venta: t_registro_venta; venta: int16);
begin
  textcolor(green); write('El código de venta de la venta '); textcolor(yellow); write(venta); textcolor(green); write(' es '); textcolor(red); writeln(registro_venta.codigo);
  textcolor(green); write('El número de evento de la venta '); textcolor(yellow); write(venta); textcolor(green); write(' es '); textcolor(red); writeln(registro_venta.evento);
  textcolor(green); write('El DNI del comprador de la venta '); textcolor(yellow); write(venta); textcolor(green); write(' es '); textcolor(red); writeln(registro_venta.dni);
  textcolor(green); write('La cantidad de entradas adquiridas de la venta '); textcolor(yellow); write(venta); textcolor(green); write(' es '); textcolor(red); writeln(registro_venta.entradas);
end;
procedure imprimir_lista_ventas(lista_ventas: t_lista_ventas);
var
  i: int16;
begin
  i:=0;
  while (lista_ventas<>nil) do
  begin
    i:=i+1;
    textcolor(green); write('La información de la venta '); textcolor(yellow); write(i); textcolor(green); writeln(' es:');
    imprimir_registro_venta(lista_ventas^.ele,i);
    writeln();
    lista_ventas:=lista_ventas^.sig;
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
  contar_pares_impares:=(pares>impares);
end;
procedure actualizar_minimos(recaudacion_evento: real; nombre, lugar: string; var recaudacion_min1, recaudacion_min2: real; var nombre_min1, nombre_min2, lugar_min1, lugar_min2: string);
begin
  if (recaudacion_evento<recaudacion_min1) then
  begin
    recaudacion_min2:=recaudacion_min1;
    nombre_min2:=nombre_min1;
    lugar_min2:=lugar_min1;
    recaudacion_min1:=recaudacion_evento;
    nombre_min1:=nombre;
    lugar_min1:=lugar;
  end
  else
    if (recaudacion_evento<recaudacion_min2) then
    begin
      recaudacion_min2:=recaudacion_evento;
      nombre_min2:=nombre;
      lugar_min2:=lugar;
    end;
end;
procedure procesar_lista_ventas(lista_ventas: t_lista_ventas; vector_eventos: t_vector_eventos; var nombre_min1, nombre_min2, lugar_min1, lugar_min2: string; var entradas_corte1: int16; var cumple_evento_corte: boolean);
var
  evento: t_evento;
  entradas_corte2: int8;
  recaudacion_evento, recaudacion_min1, recaudacion_min2: real;
begin
  recaudacion_min1:=9999999; recaudacion_min2:=9999999;
  entradas_corte2:=0;
  while (lista_ventas<>nil) do
  begin
    evento:=lista_ventas^.ele.evento;
    recaudacion_evento:=0;
    while ((lista_ventas<>nil) and (lista_ventas^.ele.evento=evento)) do
    begin
      recaudacion_evento:=recaudacion_evento+vector_eventos[evento].costo*lista_ventas^.ele.entradas;
      if ((contar_pares_impares(lista_ventas^.ele.dni)=true) and (vector_eventos[evento].tipo=tipo_corte)) then
        entradas_corte1:=entradas_corte1+lista_ventas^.ele.entradas;
      if (evento=evento_corte) then
        entradas_corte2:=entradas_corte2+lista_ventas^.ele.entradas;
      lista_ventas:=lista_ventas^.sig;
    end;
    actualizar_minimos(recaudacion_evento,vector_eventos[evento].nombre,vector_eventos[evento].lugar,recaudacion_min1,recaudacion_min2,nombre_min1,nombre_min2,lugar_min1,lugar_min2);
  end;
  cumple_evento_corte:=(entradas_corte2=vector_eventos[evento_corte].personas);
end;
var
  vector_eventos: t_vector_eventos;
  lista_ventas: t_lista_ventas;
  entradas_corte1: int16;
  cumple_evento_corte: boolean;
  nombre_min1, nombre_min2, lugar_min1, lugar_min2: string;
begin
  randomize;
  lista_ventas:=nil;
  nombre_min1:=''; nombre_min2:=''; lugar_min1:=''; lugar_min2:='';
  entradas_corte1:=0;
  cumple_evento_corte:=false;
  cargar_vector_eventos(vector_eventos);
  writeln(); textcolor(red); writeln('INCISO (a):'); writeln();
  cargar_lista_ventas(lista_ventas,vector_eventos);
  if (lista_ventas<>nil) then
  begin
    imprimir_lista_ventas(lista_ventas);
    writeln(); textcolor(red); writeln('INCISO (b) (i):'); writeln();
    procesar_lista_ventas(lista_ventas,vector_eventos,nombre_min1,nombre_min2,lugar_min1,lugar_min2,entradas_corte1,cumple_evento_corte);
    textcolor(green); write('El nombre y el lugar del evento que ha tenido menos recaudación son '); textcolor(red); write(nombre_min1); textcolor(green); write(' y '); textcolor(red); write(lugar_min1); textcolor(green); writeln(', respectivamente');
    textcolor(green); write('El nombre y el lugar del segundo evento que ha tenido menos recaudación son '); textcolor(red); write(nombre_min2); textcolor(green); write(' y '); textcolor(red); write(lugar_min2); textcolor(green); writeln(', respectivamente');
    writeln(); textcolor(red); writeln('INCISO (b) (ii):'); writeln();
    textcolor(green); write('La cantidad de entradas vendidas cuyo comprador contiene, en su DNI, más dígitos pares que impares y que son para el evento de tipo '); textcolor(yellow); write(vector_tipos[tipo_corte]); textcolor(green); write(' es '); textcolor(red); writeln(entradas_corte1);
    writeln(); textcolor(red); writeln('INCISO (b) (iii):'); writeln();
    textcolor(green); write('La cantidad de entradas vendidas para el evento número '); textcolor(yellow); write(evento_corte); textcolor(red); if (cumple_evento_corte=true) then write(' SÍ') else write(' NO'); textcolor(green); write(' alcanzó la cantidad máxima de personas permitidas');
  end;
end.