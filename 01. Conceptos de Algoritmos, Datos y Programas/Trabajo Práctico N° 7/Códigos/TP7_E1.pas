{TRABAJO PRÁCTICO N° 7}
{EJERCICIO 1}
{Una productora nacional realiza un casting de personas para la selección de actores extras de una nueva película, para ello se debe leer y almacenar la información de las personas que desean participar de dicho casting.
De cada persona, se lee: DNI, apellido y nombre, edad y el código de género de actuación que prefiere (1: drama, 2: romántico, 3: acción, 4: suspenso, 5: terror).
La lectura finaliza cuando llega una persona con DNI 33555444, la cual debe procesarse.
Una vez finalizada la lectura de todas las personas, se pide:
(a) Informar la cantidad de personas cuyo DNI contiene más dígitos pares que impares.
(b) Informar los dos códigos de género más elegidos.
(c) Realizar un módulo que reciba un DNI, lo busque y lo elimine de la estructura. El DNI puede no existir. Invocar dicho módulo en el programa principal.}

program TP7_E1;
{$codepage UTF8}
uses crt;
const
  genero_ini=1; genero_fin=5;
  dni_salida=33555444;
  digito_ini=0; digito_fin=9;
type
  t_genero=genero_ini..genero_fin;
  t_digito=digito_ini..digito_fin;
  t_registro_persona=record
    dni: int32;
    nombre: string;
    apellido: string;
    edad: int8;
    genero: t_genero;
  end;
  t_lista_personas=^t_nodo_personas;
  t_nodo_personas=record
    ele: t_registro_persona;
    sig: t_lista_personas;
  end;
  t_vector_cantidades=array[t_genero] of int16;
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
procedure leer_persona(var registro_persona: t_registro_persona);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    registro_persona.dni:=dni_salida
  else
    registro_persona.dni:=10000000+random(40000001);
  registro_persona.nombre:=random_string(5+random(6));
  registro_persona.apellido:=random_string(5+random(6));
  registro_persona.edad:=1+random(high(int8));
  registro_persona.genero:=genero_ini+random(genero_fin);
end;
procedure agregar_adelante_lista_personas(var lista_personas: t_lista_personas; registro_persona: t_registro_persona);
var
  nuevo: t_lista_personas;
begin
  new(nuevo);
  nuevo^.ele:=registro_persona;
  nuevo^.sig:=lista_personas;
  lista_personas:=nuevo;
end;
procedure cargar_lista_personas(var lista_personas: t_lista_personas);
var
  registro_persona: t_registro_persona;
begin
  repeat
    leer_persona(registro_persona);
    agregar_adelante_lista_personas(lista_personas,registro_persona);
  until (registro_persona.dni=dni_salida)
end;
procedure imprimir_registro_persona(registro_persona: t_registro_persona; persona: int16);
begin
  textcolor(green); write('El DNI de la persona '); textcolor(yellow); write(persona); textcolor(green); write(' es '); textcolor(red); writeln(registro_persona.dni);
  textcolor(green); write('El nombre de la persona '); textcolor(yellow); write(persona); textcolor(green); write(' es '); textcolor(red); writeln(registro_persona.nombre);
  textcolor(green); write('El apellido de la persona '); textcolor(yellow); write(persona); textcolor(green); write(' es '); textcolor(red); writeln(registro_persona.apellido);
  textcolor(green); write('La edad de la persona '); textcolor(yellow); write(persona); textcolor(green); write(' es '); textcolor(red); writeln(registro_persona.edad);
  textcolor(green); write('El código de género de actuación que prefiere la persona '); textcolor(yellow); write(persona); textcolor(green); write(' es '); textcolor(red); writeln(registro_persona.genero);
end;
procedure imprimir_lista_personas(lista_personas: t_lista_personas);
var
  i: int16;
begin
  i:=0;
  while (lista_personas<>nil) do
  begin
    i:=i+1;
    textcolor(green); write('La información de la persona '); textcolor(yellow); write(i); textcolor(green); writeln(' es:');
    imprimir_registro_persona(lista_personas^.ele,i);
    writeln();
    lista_personas:=lista_personas^.sig;
  end;
end;
procedure inicializar_vector_cantidades(var vector_cantidades: t_vector_cantidades);
var
  i: t_genero;
begin
  for i:= genero_ini to genero_fin do
    vector_cantidades[i]:=0;
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
procedure actualizar_maximos(cantidad: int16; genero: t_genero; var cantidad_max1, cantidad_max2: int16; var genero_max1, genero_max2: int8);
begin
  if (cantidad>cantidad_max1) then
  begin
    cantidad_max2:=cantidad_max1;
    genero_max2:=genero_max1;
    cantidad_max1:=cantidad;
    genero_max1:=genero;
  end
  else
    if (cantidad>cantidad_max2) then
    begin
      cantidad_max2:=cantidad;
      genero_max2:=genero;
    end;
end;
procedure procesar_vector_cantidades(vector_cantidades: t_vector_cantidades; var genero_max1, genero_max2: int8);
var
  i: t_genero;
  cantidad_max1, cantidad_max2: int16;
begin
  cantidad_max1:=low(int16); cantidad_max2:=low(int16);
  for i:= genero_ini to genero_fin do
  begin
    actualizar_maximos(vector_cantidades[i],i,cantidad_max1,cantidad_max2,genero_max1,genero_max2);
    textcolor(green); write('La cantidad de personas que prefieren el código de género de actuación ',i, ' es '); textcolor(red); writeln(vector_cantidades[i]);
  end;
end;
procedure procesar_lista_personas(lista_personas: t_lista_personas; var personas: int16; var genero_max1, genero_max2: int8);
var
  vector_cantidades: t_vector_cantidades;
begin
  inicializar_vector_cantidades(vector_cantidades);
  while (lista_personas<>nil) do
  begin
    if (contar_pares_impares(lista_personas^.ele.dni)=true) then
      personas:=personas+1;
    vector_cantidades[lista_personas^.ele.genero]:=vector_cantidades[lista_personas^.ele.genero]+1;
    lista_personas:=lista_personas^.sig;
  end;
  procesar_vector_cantidades(vector_cantidades,genero_max1,genero_max2);
end;
procedure eliminar_lista_personas(var lista_personas: t_lista_personas; var ok: boolean; dni: int32);
var
  anterior, actual: t_lista_personas;
begin
  actual:=lista_personas;
  while ((actual<>nil) and (actual^.ele.dni<>dni)) do
  begin
    anterior:=actual;
    actual:=actual^.sig;
  end;
  if (actual<>nil) then
  begin
    if (actual=lista_personas) then
      lista_personas:=lista_personas^.sig
    else
      anterior^.sig:=actual^.sig;
    dispose(actual);
    ok:=true;
  end
end;
var
  lista_personas: t_lista_personas;
  genero_max1, genero_max2: int8;
  personas: int16;
  dni: int32;
  ok: boolean;
begin
  randomize;
  lista_personas:=nil;
  personas:=0;
  genero_max1:=0; genero_max2:=0;
  ok:=false;
  cargar_lista_personas(lista_personas);
  imprimir_lista_personas(lista_personas);
  procesar_lista_personas(lista_personas,personas,genero_max1,genero_max2);
  writeln(); textcolor(red); writeln('INCISO (a):'); writeln();
  textcolor(green); write('La cantidad de personas cuyo DNI contiene más dígitos pares que impares es '); textcolor(red); writeln(personas);
  writeln(); textcolor(red); writeln('INCISO (b):'); writeln();
  textcolor(green); write('Los dos códigos de género más elegidos son '); textcolor(red); write(genero_max1); textcolor(green); write(' y '); textcolor(red); writeln(genero_max2);
  writeln(); textcolor(red); writeln('INCISO (c):'); writeln();
  dni:=10000000+random(40000001);
  eliminar_lista_personas(lista_personas,ok,dni);
  if (ok=true) then
  begin
    textcolor(green); write('El DNI '); textcolor(yellow); write(dni); textcolor(red); write(' SÍ'); textcolor(green); write(' fue encontrado y eliminado');
    imprimir_lista_personas(lista_personas);
  end
  else
  begin
    textcolor(green); write('El DNI '); textcolor(yellow); write(dni); textcolor(red); write(' NO'); textcolor(green); write(' fue encontrado');
  end;
end.