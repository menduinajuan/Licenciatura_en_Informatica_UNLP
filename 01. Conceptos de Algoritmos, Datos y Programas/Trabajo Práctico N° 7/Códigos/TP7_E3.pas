{TRABAJO PRÁCTICO N° 7}
{EJERCICIO 3}
{Una remisería dispone de información acerca de los viajes realizados durante el mes de mayo de 2020.
De cada viaje, se conoce: número de viaje, código de auto, dirección de origen, dirección de destino y kilómetros recorridos durante el viaje.
Esta información se encuentra ordenada por código de auto y, para un mismo código de auto, pueden existir 1 o más viajes.
Se pide:
(a) Informar los dos códigos de auto que más kilómetros recorrieron.
(b) Generar una lista nueva con los viajes de más de 5 kilómetros recorridos, ordenada por número de viaje.}

program TP7_E3;
{$codepage UTF8}
uses crt;
const
  km_corte=5;
  numero_salida=0;
type
  t_registro_viaje=record
    numero: int16;
    auto: int8;
    origen: string;
    destino: string;
    km: real;
  end;
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
procedure leer_viaje(var registro_viaje: t_registro_viaje);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    registro_viaje.numero:=numero_salida
  else
    registro_viaje.numero:=1+random(high(int16));
  if (registro_viaje.numero<>numero_salida) then
  begin
    registro_viaje.auto:=1+random(high(int8));
    registro_viaje.origen:=random_string(5+random(6));
    registro_viaje.destino:=random_string(5+random(6));
    registro_viaje.km:=1+random(991)/10;
  end;
end;
procedure agregar_ordenado_lista_viajes1(var lista_viajes1: t_lista_viajes; registro_viaje: t_registro_viaje);
var
  anterior, actual, nuevo: t_lista_viajes;
begin
  new(nuevo);
  nuevo^.ele:=registro_viaje;
  nuevo^.sig:=nil;
  actual:=lista_viajes1;
  while ((actual<>nil) and (actual^.ele.auto<nuevo^.ele.auto)) do
  begin
    anterior:=actual;
    actual:=actual^.sig;
  end;
  if (actual=lista_viajes1) then
    lista_viajes1:=nuevo
  else
    anterior^.sig:=nuevo;
  nuevo^.sig:=actual;
end;
procedure cargar_lista_viajes1(var lista_viajes1: t_lista_viajes);
var
  registro_viaje: t_registro_viaje;
begin
  leer_viaje(registro_viaje);
  while (registro_viaje.numero<>numero_salida) do
  begin
    agregar_ordenado_lista_viajes1(lista_viajes1,registro_viaje);
    leer_viaje(registro_viaje);
  end;
end;
procedure imprimir_registro_viaje(registro_viaje: t_registro_viaje; viaje: int16);
begin
  textcolor(green); write('El número de viaje del viaje '); textcolor(yellow); write(viaje); textcolor(green); write(' es '); textcolor(red); writeln(registro_viaje.numero);
  textcolor(green); write('El código de auto del viaje '); textcolor(yellow); write(viaje); textcolor(green); write(' es '); textcolor(red); writeln(registro_viaje.auto);
  textcolor(green); write('La dirección de origen del viaje '); textcolor(yellow); write(viaje); textcolor(green); write(' es '); textcolor(red); writeln(registro_viaje.origen);
  textcolor(green); write('La dirección de destino del viaje '); textcolor(yellow); write(viaje); textcolor(green); write(' es '); textcolor(red); writeln(registro_viaje.destino);
  textcolor(green); write('Los kilómetros recorridos durante el viaje '); textcolor(yellow); write(viaje); textcolor(green); write(' son '); textcolor(red); writeln(registro_viaje.km:0:2);
end;
procedure imprimir_lista_viajes(lista_viajes1: t_lista_viajes);
var
  i: int16;
begin
  i:=0;
  while (lista_viajes1<>nil) do
  begin
    i:=i+1;
    textcolor(green); write('La información del viaje '); textcolor(yellow); write(i); textcolor(green); writeln(' es:');
    imprimir_registro_viaje(lista_viajes1^.ele,i);
    writeln();
    lista_viajes1:=lista_viajes1^.sig;
  end;
end;
procedure agregar_ordenado_lista_viajes2(var lista_viajes2: t_lista_viajes; registro_viaje: t_registro_viaje);
var
  anterior, actual, nuevo: t_lista_viajes;
begin
  new(nuevo);
  nuevo^.ele:=registro_viaje;
  nuevo^.sig:=nil;
  actual:=lista_viajes2;
  while ((actual<>nil) and (actual^.ele.numero<nuevo^.ele.numero)) do
  begin
    anterior:=actual;
    actual:=actual^.sig;
  end;
  if (actual=lista_viajes2) then
    lista_viajes2:=nuevo
  else
    anterior^.sig:=nuevo;
  nuevo^.sig:=actual;
end;
procedure actualizar_maximos(km_auto: real; auto: int8; var km_max1, km_max2: real; var auto_max1, auto_max2: int8);
begin
  if (km_auto>km_max1) then
  begin
    km_max2:=km_max1;
    auto_max2:=auto_max1;
    km_max1:=km_auto;
    auto_max1:=auto;
  end
  else
    if (km_auto>km_max2) then
    begin
      km_max2:=km_auto;
      auto_max2:=auto;
    end;
end;
procedure procesar_lista_viajes1(lista_viajes1: t_lista_viajes; var auto_max1, auto_max2: int8; var lista_viajes2: t_lista_viajes);
var
  auto: int8;
  km_auto, km_max1, km_max2: real;
begin
  km_max1:=-9999999; km_max2:=-9999999;
  while (lista_viajes1<>nil) do
  begin
    auto:=lista_viajes1^.ele.auto;
    km_auto:=0;
    while ((lista_viajes1<>nil) and (lista_viajes1^.ele.auto=auto)) do
    begin
      km_auto:=km_auto+lista_viajes1^.ele.km;
      if (lista_viajes1^.ele.km>km_corte) then
        agregar_ordenado_lista_viajes2(lista_viajes2,lista_viajes1^.ele);
      lista_viajes1:=lista_viajes1^.sig;
    end;
    actualizar_maximos(km_auto,auto,km_max1,km_max2,auto_max1,auto_max2);
  end;
end;
var
  lista_viajes1, lista_viajes2: t_lista_viajes;
  auto_max1, auto_max2: int8;
begin
  randomize;
  lista_viajes1:=nil;
  auto_max1:=0; auto_max2:=0;
  lista_viajes2:=nil;
  cargar_lista_viajes1(lista_viajes1);
  if (lista_viajes1<>nil) then
  begin
    imprimir_lista_viajes(lista_viajes1);
    procesar_lista_viajes1(lista_viajes1,auto_max1,auto_max2,lista_viajes2);
    writeln(); textcolor(red); writeln('INCISO (a):'); writeln();
    textcolor(green); write('Los dos códigos de auto que más kilómetros recorrieron son '); textcolor(red); write(auto_max1); textcolor(green); write(' y '); textcolor(red); writeln(auto_max2);
    writeln(); textcolor(red); writeln('INCISO (b):'); writeln();
    imprimir_lista_viajes(lista_viajes2);
  end;
end.