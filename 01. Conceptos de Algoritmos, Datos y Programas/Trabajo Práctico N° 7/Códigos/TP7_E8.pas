{TRABAJO PRÁCTICO N° 7}
{EJERCICIO 8}
{Una entidad bancaria de la ciudad de La Plata solicita realizar un programa destinado a la administración de transferencias de dinero entre cuentas bancarias, efectuadas entre los meses de Enero y Noviembre del año 2018.
El banco dispone de una lista de transferencias realizadas entre Enero y Noviembre del 2018.
De cada transferencia, se conoce: número de cuenta origen, DNI de titular de cuenta origen, número de cuenta destino, DNI de titular de cuenta destino, fecha, hora, monto y el código del motivo de la transferencia (1: alquiler, 2: expensas, 3: facturas, 4: préstamo, 5: seguro, 6: honorarios y 7: varios).
Esta estructura no posee orden alguno.
Se pide:
(a) Generar una nueva estructura que contenga sólo las transferencias a terceros (son aquellas en las que las cuentas origen y destino no pertenecen al mismo titular).
Esta nueva estructura debe estar ordenada por número de cuenta origen.
(b) Una vez generada la estructura del inciso (a), utilizar dicha estructura para:
(i) Calcular e informar, para cada cuenta de origen, el monto total transferido a terceros.
(ii) Calcular e informar cuál es el código de motivo que más transferencias a terceros tuvo.
(iii) Calcular e informar la cantidad de transferencias a terceros realizadas en el mes de Junio en las cuales el número de cuenta destino posea menos dígitos pares que impares.}

program TP7_E8;
{$codepage UTF8}
uses crt;
const
  dia_ini=1; dia_fin=31;
  mes_ini=1; mes_fin=11;
  motivo_ini=1; motivo_fin=7;
  numero_origen_salida=-1;
  mes_corte=6;
  vector_meses: array[mes_ini..mes_fin] of string=('Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre');
type
  t_dia=dia_ini..dia_fin;
  t_mes=mes_ini..mes_fin;
  t_motivo=motivo_ini..motivo_fin;
  t_registro_fecha=record
    dia: t_dia;
    mes: t_mes;
  end;
  t_registro_hora=record
    hora: int8;
    minuto: int8;
  end;
  t_registro_transferencia=record
    numero_origen: int16;
    dni_origen: int32;
    numero_destino: int16;
    dni_destino: int32;
    fecha: t_registro_fecha;
    hora: t_registro_hora;
    monto: real;
    motivo: t_motivo;
  end;
  t_lista_transferencias=^t_nodo_transferencias;
  t_nodo_transferencias=record
    ele: t_registro_transferencia;
    sig: t_lista_transferencias;
  end;
  t_vector_cantidades=array[t_motivo] of int16;
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
procedure leer_transferencia(var registro_transferencia: t_registro_transferencia);
var
  i: int8;
begin
  i:=random(101);
  if (i=0) then
    registro_transferencia.numero_origen:=numero_origen_salida
  else
    registro_transferencia.numero_origen:=1+random(high(int16));
  if (registro_transferencia.numero_origen<>numero_origen_salida) then
  begin
    registro_transferencia.dni_origen:=10000000+random(40000001);
    if (i<=50) then
    begin
      registro_transferencia.numero_destino:=registro_transferencia.numero_origen;
      registro_transferencia.dni_destino:=registro_transferencia.dni_origen;
    end
    else
    begin
      registro_transferencia.numero_destino:=1+random(high(int16));
      registro_transferencia.dni_destino:=10000000+random(40000001);
    end;
    registro_transferencia.fecha.dia:=dia_ini+random(dia_fin);
    registro_transferencia.fecha.mes:=mes_ini+random(mes_fin);
    registro_transferencia.hora.hora:=random(24);
    registro_transferencia.hora.minuto:=random(60);
    registro_transferencia.monto:=1+random(991)/10;
    registro_transferencia.motivo:=motivo_ini+random(motivo_fin);
  end;
end;
procedure agregar_adelante_lista_transferencias1(var lista_transferencias1: t_lista_transferencias; registro_transferencia: t_registro_transferencia);
var
  nuevo: t_lista_transferencias;
begin
  new(nuevo);
  nuevo^.ele:=registro_transferencia;
  nuevo^.sig:=lista_transferencias1;
  lista_transferencias1:=nuevo;
end;
procedure cargar_lista_transferencias1(var lista_transferencias1: t_lista_transferencias);
var
  registro_transferencia: t_registro_transferencia;
begin
  leer_transferencia(registro_transferencia);
  while (registro_transferencia.numero_origen<>numero_origen_salida) do
  begin
    agregar_adelante_lista_transferencias1(lista_transferencias1,registro_transferencia);
    leer_transferencia(registro_transferencia);
  end;
end;
procedure imprimir_registro_transferencia(registro_transferencia: t_registro_transferencia; transferencia: int16);
begin
  textcolor(green); write('El número de cuenta origen de la transferencia '); textcolor(yellow); write(transferencia); textcolor(green); write(' es '); textcolor(red); writeln(registro_transferencia.numero_origen);
  textcolor(green); write('El DNI de titular de la cuenta origen de la transferencia '); textcolor(yellow); write(transferencia); textcolor(green); write(' es '); textcolor(red); writeln(registro_transferencia.dni_origen);
  textcolor(green); write('El número de cuenta destino de la transferencia '); textcolor(yellow); write(transferencia); textcolor(green); write(' es '); textcolor(red); writeln(registro_transferencia.numero_destino);
  textcolor(green); write('El DNI de titular de la cuenta destino de la transferencia '); textcolor(yellow); write(transferencia); textcolor(green); write(' es '); textcolor(red); writeln(registro_transferencia.dni_destino);
  textcolor(green); write('La fecha de la transferencia '); textcolor(yellow); write(transferencia); textcolor(green); write(' es '); textcolor(red); write(registro_transferencia.fecha.dia); textcolor(green); write('/'); textcolor(red); writeln(registro_transferencia.fecha.mes);
  textcolor(green); write('La hora de la transferencia '); textcolor(yellow); write(transferencia); textcolor(green); write(' es '); textcolor(red); write(registro_transferencia.hora.hora); textcolor(green); write(':'); textcolor(red); writeln(registro_transferencia.hora.minuto);
  textcolor(green); write('El monto de la transferencia '); textcolor(yellow); write(transferencia); textcolor(green); write(' es '); textcolor(red); writeln(registro_transferencia.monto:0:2);
  textcolor(green); write('El código del motivo de la transferencia '); textcolor(yellow); write(transferencia); textcolor(green); write(' es '); textcolor(red); writeln(registro_transferencia.motivo);
end;
procedure imprimir_lista_transferencias(lista_transferencias: t_lista_transferencias);
var
  i: int16;
begin
  i:=0;
  while (lista_transferencias<>nil) do
  begin
    i:=i+1;
    textcolor(green); write('La información de la transferencia '); textcolor(yellow); write(i); textcolor(green); writeln(' es:');
    imprimir_registro_transferencia(lista_transferencias^.ele,i);
    writeln();
    lista_transferencias:=lista_transferencias^.sig;
  end;
end;
procedure agregar_ordenado_lista_transferencias2(var lista_transferencias2: t_lista_transferencias; registro_transferencia: t_registro_transferencia);
var
  anterior, actual, nuevo: t_lista_transferencias;
begin
  new(nuevo);
  nuevo^.ele:=registro_transferencia;
  nuevo^.sig:=nil;
  anterior:=lista_transferencias2; actual:=lista_transferencias2;
  while ((actual<>nil) and (actual^.ele.numero_origen<nuevo^.ele.numero_origen)) do
  begin
    anterior:=actual;
    actual:=actual^.sig;
  end;
  if (actual=lista_transferencias2) then
    lista_transferencias2:=nuevo
  else
    anterior^.sig:=nuevo;
  nuevo^.sig:=actual;
end;
procedure procesar_lista_transferencias1(lista_transferencias1: t_lista_transferencias; var lista_transferencias2: t_lista_transferencias);
begin
  while (lista_transferencias1<>nil) do
  begin
    if (lista_transferencias1^.ele.numero_origen<>lista_transferencias1^.ele.numero_destino) then
      agregar_ordenado_lista_transferencias2(lista_transferencias2,lista_transferencias1^.ele);
    lista_transferencias1:=lista_transferencias1^.sig;
  end;
end;
procedure inicializar_vector_cantidades(var vector_cantidades: t_vector_cantidades);
var
  i: t_motivo;
begin
  for i:= motivo_ini to motivo_fin do
    vector_cantidades[i]:=0;
end;
function contar_pares_impares(numero: int16): boolean;
var
  pares, impares: int8;
begin
  pares:=0; impares:=0;
  while (numero<>0) do
  begin
    if (numero mod 2=0) then
      pares:=pares+1
    else
      impares:=impares+1;
    numero:=numero div 10;
  end;
  contar_pares_impares:=(pares<impares);
end;
procedure actualizar_maximo(cantidad: int16; motivo: t_motivo; var cantidad_max: int16; var motivo_max: int8);
begin
  if (cantidad>cantidad_max) then
  begin
    cantidad_max:=cantidad;
    motivo_max:=motivo;
  end;
end;
procedure procesar_vector_cantidades(vector_cantidades: t_vector_cantidades; var motivo_max: int8);
var
  i: t_motivo;
  cantidad_max: int16;
begin
  cantidad_max:=low(int16);
  for i:= motivo_ini to motivo_fin do
  begin
    actualizar_maximo(vector_cantidades[i],i,cantidad_max,motivo_max);
    textcolor(green); write('La cantidad de transferencias a terceros con motivo de la transferencia ',i,' es '); textcolor(red); writeln(vector_cantidades[i]);
  end;
end;
procedure procesar_lista_transferencias2(lista_transferencias2: t_lista_transferencias; var motivo_max: int8; var transferencias_corte: int16);
var
  vector_cantidades: t_vector_cantidades;
  numero_origen: int16;
  monto_total: real;
begin
  inicializar_vector_cantidades(vector_cantidades);
  while (lista_transferencias2<>nil) do
  begin
    numero_origen:=lista_transferencias2^.ele.numero_origen;
    monto_total:=0;
    while ((lista_transferencias2<>nil) and (lista_transferencias2^.ele.numero_origen=numero_origen)) do
    begin
      monto_total:=monto_total+lista_transferencias2^.ele.monto;
      vector_cantidades[lista_transferencias2^.ele.motivo]:=vector_cantidades[lista_transferencias2^.ele.motivo]+1;
      if ((lista_transferencias2^.ele.fecha.mes=mes_corte) and (contar_pares_impares(lista_transferencias2^.ele.numero_destino)=true)) then
        transferencias_corte:=transferencias_corte+1;
      lista_transferencias2:=lista_transferencias2^.sig;
    end;
    textcolor(green); write('El monto total transferido a terceros por la cuenta origen '); textcolor(yellow); write(numero_origen); textcolor(green); write(' es '); textcolor(red); writeln(monto_total:0:2);
  end;
  writeln();
  procesar_vector_cantidades(vector_cantidades,motivo_max);
end;
var
  lista_transferencias1, lista_transferencias2: t_lista_transferencias;
  motivo_max: int8;
  transferencias_corte: int16;
begin
  randomize;
  lista_transferencias1:=nil;
  lista_transferencias2:=nil;
  motivo_max:=0;
  transferencias_corte:=0;
  cargar_lista_transferencias1(lista_transferencias1);
  if (lista_transferencias1<>nil) then
  begin
    imprimir_lista_transferencias(lista_transferencias1);
    writeln(); textcolor(red); writeln('INCISO (a):'); writeln();
    procesar_lista_transferencias1(lista_transferencias1,lista_transferencias2);
    if (lista_transferencias2<>nil) then
    begin
      imprimir_lista_transferencias(lista_transferencias2);
      writeln(); textcolor(red); writeln('INCISO (b) (i):'); writeln();
      procesar_lista_transferencias2(lista_transferencias2,motivo_max,transferencias_corte);
      writeln(); textcolor(red); writeln('INCISO (b) (ii):'); writeln();
      textcolor(green); write('El código de motivo que más transferencias a terceros tuvo es '); textcolor(red); writeln(motivo_max);
      writeln(); textcolor(red); writeln('INCISO (b) (iii):'); writeln();
      textcolor(green); write('La cantidad de transferencias a terceros realizadas en el mes de '); textcolor(yellow); write(vector_meses[mes_corte]); textcolor(green); write(' en las cuales el número de cuenta destino posee menos dígitos pares que impares es '); textcolor(red); write(transferencias_corte);
    end;
  end;
end.