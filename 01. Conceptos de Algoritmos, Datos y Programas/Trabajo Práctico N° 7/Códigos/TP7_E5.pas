{TRABAJO PRÁCTICO N° 7}
{EJERCICIO 5}
{Una empresa de transporte de cargas dispone de la información de su flota compuesta por 100 camiones.
De cada camión, se tiene: patente, año de fabricación y capacidad (peso máximo en toneladas que puede transportar).
Realizar un programa que lea y almacene la información de los viajes realizados por la empresa.
De cada viaje, se lee: código de viaje, código del camión que lo realizó (1..100), distancia en kilómetros recorrida, ciudad de destino, año en que se realizó el viaje y DNI del chofer.
La lectura finaliza cuando se lee el código de viaje -1.
Una vez leída y almacenada la información, se pide:
(a) Informar la patente del camión que más kilómetros recorridos posee y la patente del camión que menos kilómetros recorridos posee.
(b) Informar la cantidad de viajes que se han realizado en camiones con capacidad mayor a 30,5 toneladas y que posean una antigüedad mayor a 5 años al momento de realizar el viaje (año en que se realizó el viaje).
(c) Informar los códigos de los viajes realizados por choferes cuyo DNI tenga sólo dígitos impares.
Nota: Los códigos de viaje no se repiten.}

program TP7_E5;
{$codepage UTF8}
uses crt;
const
  anio_ini_camion=2000; anio_fin_camion=2010;
  camion_ini=1; camion_fin=100;
  anio_ini_viaje=2010; anio_fin_viaje=2020;
  codigo_viaje_salida=-1;
  toneladas_corte=30.5; antiguedad_corte=5;
type
  t_camion=camion_ini..camion_fin;
  t_registro_camion=record
    patente: string;
    anio: int16;
    capacidad: real;
  end;
  t_registro_viaje=record
    codigo_viaje: int16;
    codigo_camion: t_camion;
    distancia: real;
    destino: string;
    anio: int16;
    dni: int32;
  end;
  t_vector_camiones=array[t_camion] of t_registro_camion;
  t_lista_viajes=^t_nodo_viajes;
  t_nodo_viajes=record
    ele: t_registro_viaje;
    sig: t_lista_viajes;
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
procedure leer_camion(var registro_camion: t_registro_camion);
begin
  registro_camion.patente:=random_string(2);
  registro_camion.anio:=anio_ini_camion+random(anio_fin_camion-anio_ini_camion+1);
  registro_camion.capacidad:=1+random(991)/10;
end;
procedure cargar_vector_camiones(var vector_camiones: t_vector_camiones);
var
  registro_camion: t_registro_camion;
  i: t_camion;
begin
  for i:= camion_ini to camion_fin do
  begin
    leer_camion(registro_camion);
    vector_camiones[i]:=registro_camion;
  end;
end;
procedure leer_viaje(var registro_viaje: t_registro_viaje);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    registro_viaje.codigo_viaje:=codigo_viaje_salida
  else
    registro_viaje.codigo_viaje:=1+random(high(int16));
  if (registro_viaje.codigo_viaje<>codigo_viaje_salida) then
  begin
    registro_viaje.codigo_camion:=camion_ini+random(camion_fin);
    registro_viaje.distancia:=1+random(9991)/10;
    registro_viaje.destino:=random_string(5+random(6));
    registro_viaje.anio:=anio_ini_viaje+random(anio_fin_viaje-anio_ini_viaje+1);
    registro_viaje.dni:=10000000+random(40000001);
  end;
end;
procedure agregar_adelante_lista_viajes(var lista_viajes: t_lista_viajes; registro_viaje: t_registro_viaje);
var
  nuevo: t_lista_viajes;
begin
  new(nuevo);
  nuevo^.ele:=registro_viaje;
  nuevo^.sig:=lista_viajes;
  lista_viajes:=nuevo;
end;
procedure cargar_lista_viajes(var lista_viajes: t_lista_viajes);
var
  registro_viaje: t_registro_viaje;
begin
  leer_viaje(registro_viaje);
  while (registro_viaje.codigo_viaje<>codigo_viaje_salida) do
  begin
    agregar_adelante_lista_viajes(lista_viajes,registro_viaje);
    leer_viaje(registro_viaje);
  end;
end;
procedure imprimir_registro_viaje(registro_viaje: t_registro_viaje; viaje: int16);
begin
  textcolor(green); write('El código de viaje del viaje '); textcolor(yellow); write(viaje); textcolor(green); write(' es '); textcolor(red); writeln(registro_viaje.codigo_viaje);
  textcolor(green); write('El código de camión del viaje '); textcolor(yellow); write(viaje); textcolor(green); write(' es '); textcolor(red); writeln(registro_viaje.codigo_camion);
  textcolor(green); write('La distancia del viaje '); textcolor(yellow); write(viaje); textcolor(green); write(' es '); textcolor(red); writeln(registro_viaje.distancia:0:2);
  textcolor(green); write('El destino del viaje '); textcolor(yellow); write(viaje); textcolor(green); write(' es '); textcolor(red); writeln(registro_viaje.destino);
  textcolor(green); write('El año del viaje '); textcolor(yellow); write(viaje); textcolor(green); write(' es '); textcolor(red); writeln(registro_viaje.anio);
  textcolor(green); write('El DNI del chofer del viaje '); textcolor(yellow); write(viaje); textcolor(green); write(' es '); textcolor(red); writeln(registro_viaje.dni);
end;
procedure imprimir_lista_viajes(lista_viajes: t_lista_viajes);
var
  i: int16;
begin
  i:=0;
  while (lista_viajes<>nil) do
  begin
    i:=i+1;
    textcolor(green); write('La información del viaje '); textcolor(yellow); write(i); textcolor(green); writeln(' es:');
    imprimir_registro_viaje(lista_viajes^.ele,i);
    writeln();
    lista_viajes:=lista_viajes^.sig;
  end;
end;
procedure actualizar_maximo(distancia: real; patente: string; var distancia_max: real; var patente_max: string);
begin
  if (distancia>distancia_max) then
  begin
    distancia_max:=distancia;
    patente_max:=patente;
  end;
end;
procedure actualizar_minimo(distancia: real; patente: string; var distancia_min: real; var patente_min: string);
begin
  if (distancia<distancia_min) then
  begin
    distancia_min:=distancia;
    patente_min:=patente;
  end;
end;
function contar_pares(dni: int32): boolean;
var
  pares: int8;
begin
  pares:=0;
  while ((dni<>0) and (pares=0)) do
  begin
    if (dni mod 2=0) then
      pares:=pares+1;
    dni:=dni div 10;
  end;
  contar_pares:=(pares=0);
end;
procedure procesar_lista_viajes(lista_viajes: t_lista_viajes; vector_camiones: t_vector_camiones; var patente_max, patente_min: string; var viajes_corte: int16);
var
  distancia_max, distancia_min: real;
begin
  distancia_max:=-9999999; distancia_min:=9999999;
  while (lista_viajes<>nil) do
  begin
    actualizar_maximo(lista_viajes^.ele.distancia,vector_camiones[lista_viajes^.ele.codigo_camion].patente,distancia_max,patente_max);
    actualizar_minimo(lista_viajes^.ele.distancia,vector_camiones[lista_viajes^.ele.codigo_camion].patente,distancia_min,patente_min);
    if ((vector_camiones[lista_viajes^.ele.codigo_camion].capacidad>toneladas_corte) and (lista_viajes^.ele.anio-vector_camiones[lista_viajes^.ele.codigo_camion].anio>antiguedad_corte)) then
      viajes_corte:=viajes_corte+1;
    if (contar_pares(lista_viajes^.ele.dni)=true) then
    begin
      textcolor(green); write('El código de viaje de este viaje realizado por un chofer cuyo DNI tiene sólo dígitos impares es '); textcolor(red); writeln(lista_viajes^.ele.codigo_viaje);
    end;
    lista_viajes:=lista_viajes^.sig;
  end;
end;
var
  vector_camiones: t_vector_camiones;
  lista_viajes: t_lista_viajes;
  viajes_corte: int16;
  patente_max, patente_min: string;
begin
  randomize;
  lista_viajes:=nil;
  patente_max:=''; patente_min:='';
  viajes_corte:=0;
  cargar_vector_camiones(vector_camiones);
  cargar_lista_viajes(lista_viajes);
  if (lista_viajes<>nil) then
  begin
    imprimir_lista_viajes(lista_viajes);
    writeln(); textcolor(red); writeln('INCISO (c):'); writeln();
    procesar_lista_viajes(lista_viajes,vector_camiones,patente_max,patente_min,viajes_corte);
    writeln(); textcolor(red); writeln('INCISO (a):'); writeln();
    textcolor(green); write('La patente del camión que más kilómetros recorridos posee es '); textcolor(red); writeln(patente_max);
    textcolor(green); write('La patente del camión que menos kilómetros recorridos posee es '); textcolor(red); writeln(patente_min);
    writeln(); textcolor(red); writeln('INCISO (b):'); writeln();
    textcolor(green); write('La cantidad de viajes que se han realizado en camiones con capacidad mayor a '); textcolor(yellow); write(toneladas_corte:0:2); textcolor(green); write(' toneladas y que posean una antigüedad mayor a '); textcolor(yellow); write(antiguedad_corte); textcolor(green); write(' años al momento de realizar el viaje es '); textcolor(red); write(viajes_corte);
  end;
end.