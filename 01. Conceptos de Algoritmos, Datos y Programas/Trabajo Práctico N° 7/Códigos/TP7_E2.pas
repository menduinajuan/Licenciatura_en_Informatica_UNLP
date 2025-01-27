{TRABAJO PRÁCTICO N° 7}
{EJERCICIO 2}
{Implementar un programa que lea y almacene información de clientes de una empresa aseguradora automotriz.
De cada cliente, se lee: código de cliente, DNI, apellido, nombre, código de póliza contratada (1..6) y monto básico que abona mensualmente.
La lectura finaliza cuando llega el cliente con código 1122, el cual debe procesarse.
La empresa dispone de una tabla donde guarda un valor que representa un monto adicional que el cliente debe abonar en la liquidación mensual de su seguro, de acuerdo al código de póliza que tiene contratada.
Una vez finalizada la lectura de todos los clientes, se pide:
(a) Informar, para cada cliente, DNI, apellido, nombre y el monto completo que paga mensualmente por su seguro automotriz (monto básico + monto adicional).
(b) Informar apellido y nombre de aquellos clientes cuyo DNI contiene, al menos, dos dígitos 9.
(c) Realizar un módulo que reciba un código de cliente, lo busque (seguro existe) y lo elimine de la estructura.}

program TP7_E2;
{$codepage UTF8}
uses crt;
const
  poliza_ini=1; poliza_fin=6;
  codigo_salida=1122;
  digito_corte=9; cantidad_digito_corte=2;
type
  t_poliza=poliza_ini..poliza_fin;
  t_registro_cliente=record
    codigo: int16;
    dni: int32;
    apellido: string;
    nombre: string;
    poliza: t_poliza;
    monto: real;
  end;
  t_lista_clientes=^t_nodo_clientes;
  t_nodo_clientes=record
    ele: t_registro_cliente;
    sig: t_lista_clientes;
  end;
  t_vector_montos=array[t_poliza] of real;
procedure cargar_vector_montos(var vector_montos: t_vector_montos);
var
  i: t_poliza;
begin
  for i:= poliza_ini to poliza_fin do
    vector_montos[i]:=1+random(991)/10;
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
procedure leer_cliente(var registro_cliente: t_registro_cliente);
var
  i: int8;
begin
  i:=random(10);
  if (i=0) then
    registro_cliente.codigo:=codigo_salida
  else
    registro_cliente.codigo:=1+random(high(int16));
  registro_cliente.dni:=10000000+random(40000001);
  registro_cliente.apellido:=random_string(5+random(6));
  registro_cliente.nombre:=random_string(5+random(6));
  registro_cliente.poliza:=poliza_ini+random(poliza_fin);
  registro_cliente.monto:=1+random(991)/10;
end;
procedure agregar_adelante_lista_clientes(var lista_clientes: t_lista_clientes; registro_cliente: t_registro_cliente);
var
  nuevo: t_lista_clientes;
begin
  new(nuevo);
  nuevo^.ele:=registro_cliente;
  nuevo^.sig:=lista_clientes;
  lista_clientes:=nuevo;
end;
procedure cargar_lista_clientes(var lista_clientes: t_lista_clientes);
var
  registro_cliente: t_registro_cliente;
begin
  repeat
    leer_cliente(registro_cliente);
    agregar_adelante_lista_clientes(lista_clientes,registro_cliente);
  until (registro_cliente.codigo=codigo_salida)
end;
procedure imprimir_registro_cliente(registro_cliente: t_registro_cliente; cliente: int16; vector_montos: t_vector_montos);
begin
  textcolor(green); write('El DNI del cliente '); textcolor(yellow); write(cliente); textcolor(green); write(' es '); textcolor(red); writeln(registro_cliente.dni);
  textcolor(green); write('El apellido del cliente '); textcolor(yellow); write(cliente); textcolor(green); write(' es '); textcolor(red); writeln(registro_cliente.apellido);
  textcolor(green); write('El nombre del cliente '); textcolor(yellow); write(cliente); textcolor(green); write(' es '); textcolor(red); writeln(registro_cliente.nombre);
  textcolor(green); write('El monto completo que paga mensualmente el cliente '); textcolor(yellow); write(cliente); textcolor(green); write(' es '); textcolor(red); writeln(registro_cliente.monto+vector_montos[registro_cliente.poliza]:0:2);
end;
function contar_digitos(dni: int32): boolean;
var
  digitos: int8;
begin
  digitos:=0;
  while (dni<>0) do
  begin
    if (dni mod 10=digito_corte) then
      digitos:=digitos+1;
    dni:=dni div 10;
  end;
  contar_digitos:=(digitos>=cantidad_digito_corte);
end;
procedure procesar_lista_clientes(lista_clientes: t_lista_clientes; vector_montos: t_vector_montos);
var
  i: int16;
begin
  i:=0;
  while (lista_clientes<>nil) do
  begin
    i:=i+1;
    textcolor(green); write('La información del cliente '); textcolor(yellow); write(i); textcolor(green); writeln(' es:');
    imprimir_registro_cliente(lista_clientes^.ele,i,vector_montos);
    if (contar_digitos(lista_clientes^.ele.dni)=true) then
    begin
      textcolor(green); write('El apellido y nombre de este cliente cuyo DNI contiene, al menos, '); textcolor(yellow); write(cantidad_digito_corte); textcolor(green); write(' dígitos '); textcolor(yellow); write(digito_corte); textcolor(green); write(' son '); textcolor(red); writeln(lista_clientes^.ele.apellido,' ',lista_clientes^.ele.nombre);
    end;
    writeln();
    lista_clientes:=lista_clientes^.sig;
  end;
end;
procedure eliminar_lista_clientes(var lista_clientes: t_lista_clientes; codigo: int16);
var
  anterior, actual: t_lista_clientes;
begin
  actual:=lista_clientes;
  while ((actual<>nil) and (actual^.ele.codigo<>codigo)) do
  begin
    anterior:=actual;
    actual:=actual^.sig;
  end;
  if (actual=lista_clientes) then
    lista_clientes:=lista_clientes^.sig
  else
    anterior^.sig:=actual^.sig;
  dispose(actual);
end;
var
  vector_montos: t_vector_montos;
  lista_clientes: t_lista_clientes;
  codigo: int16;
begin
  randomize;
  lista_clientes:=nil;
  cargar_vector_montos(vector_montos);
  cargar_lista_clientes(lista_clientes);
  writeln(); textcolor(red); writeln('INCISOS (a) (b):'); writeln();
  procesar_lista_clientes(lista_clientes,vector_montos);
  writeln(); textcolor(red); writeln('INCISO (c):'); writeln();
  codigo:=codigo_salida;
  eliminar_lista_clientes(lista_clientes,codigo);
  procesar_lista_clientes(lista_clientes,vector_montos);
end.