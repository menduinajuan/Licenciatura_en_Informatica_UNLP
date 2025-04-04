{TRABAJO PRÁCTICO N° 7}
{EJERCICIO 7}
{La Facultad de Informática desea procesar la información de los alumnos que finalizaron la carrera de Analista Programador Universitario.
Para ello, se deberá leer la información de cada alumno, a saber: número de alumno, apellido, nombres, dirección de correo electrónico, año de ingreso, año de egreso y las notas obtenidas en cada una de las 24 materias que aprobó (los aplazos no se registran).
(a) Realizar un módulo que lea y almacene la información de los alumnos hasta que se ingrese el alumno con número de alumno -1, el cual no debe procesarse.
Las 24 notas correspondientes a cada alumno deben quedar ordenadas de forma descendente.
(b) Una vez leída y almacenada la información del inciso (a), se solicita calcular e informar:
(i) El promedio de notas obtenido por cada alumno.
(ii) La cantidad de alumnos ingresantes 2012 cuyo número de alumno está compuesto, únicamente, por dígitos impares.
(iii) El apellido, nombres y dirección de correo electrónico de los dos alumnos que más rápido se recibieron (o sea, que tardaron menos años).
(c) Realizar un módulo que, dado un número de alumno leído desde teclado, lo busque y elimine de la estructura generada en el inciso (a). El alumno puede no existir.}

program TP7_E7;
{$codepage UTF8}
uses crt;
const
  anio_ini=2000; anio_fin=2015;
  notas_total=24;
  numero_salida=-1;
  ingreso_corte=2012;
type
  t_nota=1..notas_total;
  t_vector_notas=array[t_nota] of int8;
  t_registro_alumno=record
    numero: int16;
    apellido: string;
    nombres: string;
    email: string;
    ingreso: int16;
    egreso: int16;
    notas: t_vector_notas;
  end;
  t_lista_alumnos=^t_nodo_alumnos;
  t_nodo_alumnos=record
    ele: t_registro_alumno;
    sig: t_lista_alumnos;
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
procedure inicializar_vector_notas(var vector_notas: t_vector_notas);
var
  i: t_nota;
begin
  for i:= 1 to notas_total do
    vector_notas[i]:=0;
end;
procedure agregar_ordenado_vector_notas(var vector_notas: t_vector_notas; notas, nota: int8);
var
  i, j: int8;
begin
  i:=1;
  while ((i<=notas) and (vector_notas[i]>nota)) do
    i:=i+1;
  for j:= notas downto i do
    vector_notas[j+1]:=vector_notas[j];
  vector_notas[i]:=nota;
end;
procedure cargar_vector_notas(var vector_notas: t_vector_notas);
var
  i, nota, notas: int8;
begin
  notas:=0;
  for i:= 1 to notas_total do
  begin
    nota:=4+random(7);
    agregar_ordenado_vector_notas(vector_notas,notas,nota);
    notas:=notas+1;
  end;
end;
procedure leer_alumno(var registro_alumno: t_registro_alumno);
var
  vector_emails: array[1..3] of string=('@gmail.com', '@hotmail.com', '@yahoo.com');
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    registro_alumno.numero:=numero_salida
  else
    registro_alumno.numero:=1+random(high(int16));
  if (registro_alumno.numero<>numero_salida) then
  begin
    registro_alumno.apellido:=random_string(5+random(6));
    registro_alumno.nombres:=random_string(5+random(6))+' '+random_string(5+random(6));
    registro_alumno.email:=random_string(5+random(6))+'@'+vector_emails[1+random(3)];
    registro_alumno.ingreso:=anio_ini+random(anio_fin-anio_ini+1);
    registro_alumno.egreso:=registro_alumno.ingreso+5+random(6);
    inicializar_vector_notas(registro_alumno.notas);
    cargar_vector_notas(registro_alumno.notas);
  end;
end;
procedure agregar_adelante_lista_alumnos(var lista_alumnos: t_lista_alumnos; registro_alumno: t_registro_alumno);
var
  nuevo: t_lista_alumnos;
begin
  new(nuevo);
  nuevo^.ele:=registro_alumno;
  nuevo^.sig:=lista_alumnos;
  lista_alumnos:=nuevo;
end;
procedure cargar_lista_alumnos(var lista_alumnos: t_lista_alumnos);
var
  registro_alumno: t_registro_alumno;
begin
  leer_alumno(registro_alumno);
  while (registro_alumno.numero<>numero_salida) do
  begin
    agregar_adelante_lista_alumnos(lista_alumnos,registro_alumno);
    leer_alumno(registro_alumno);
  end;
end;
procedure imprimir_registro_alumno(registro_alumno: t_registro_alumno; alumno: int16);
begin
  textcolor(green); write('El número de alumno del alumno '); textcolor(yellow); write(alumno); textcolor(green); write(' es '); textcolor(red); writeln(registro_alumno.numero);
  textcolor(green); write('El apellido del alumno '); textcolor(yellow); write(alumno); textcolor(green); write(' es '); textcolor(red); writeln(registro_alumno.apellido);
  textcolor(green); write('Los nombres del alumno '); textcolor(yellow); write(alumno); textcolor(green); write(' son '); textcolor(red); writeln(registro_alumno.nombres);
  textcolor(green); write('La dirección de correo electrónico del alumno '); textcolor(yellow); write(alumno); textcolor(green); write(' es '); textcolor(red); writeln(registro_alumno.email);
  textcolor(green); write('El año de ingreso del alumno '); textcolor(yellow); write(alumno); textcolor(green); write(' es '); textcolor(red); writeln(registro_alumno.ingreso);
  textcolor(green); write('El año de egreso del alumno '); textcolor(yellow); write(alumno); textcolor(green); write(' es '); textcolor(red); writeln(registro_alumno.egreso);
end;
procedure imprimir_lista_alumnos(lista_alumnos: t_lista_alumnos);
var
  i: int16;
begin
  i:=0;
  while (lista_alumnos<>nil) do
  begin
    i:=i+1;
    textcolor(green); write('La información del alumno '); textcolor(yellow); write(i); textcolor(green); writeln(' es:');
    imprimir_registro_alumno(lista_alumnos^.ele,i);
    writeln();
    lista_alumnos:=lista_alumnos^.sig;
  end;
end;
function calcular_promedio_notas(vector_notas: t_vector_notas): real;
var
  i: t_nota;
  suma: int16;
begin
  suma:=0;
  for i:= 1 to notas_total do
    suma:=suma+vector_notas[i];
  calcular_promedio_notas:=suma/notas_total;
end;
function contar_pares(numero: int16): boolean;
var
  pares: int8;
begin
  pares:=0;
  while ((numero<>0) and (pares=0)) do
  begin
    if (numero mod 2=0) then
      pares:=pares+1;
    numero:=numero div 10;
  end;
  contar_pares:=(pares=0);
end;
procedure actualizar_maximos(anios: int8; apellido, nombres, email: string; var anios_max1, anios_max2: int8; var apellido_max1, apellido_max2, nombres_max1, nombres_max2, email_max1, email_max2: string);
begin
  if (anios>anios_max1) then
  begin
    anios_max2:=anios_max1;
    apellido_max2:=apellido_max1;
    nombres_max2:=nombres_max1;
    email_max2:=email_max1;
    anios_max1:=anios;
    apellido_max1:=apellido;
    nombres_max1:=nombres;
    email_max1:=email;
  end
  else
    if (anios>anios_max2) then
    begin
      anios_max2:=anios;
      apellido_max2:=apellido;
      nombres_max2:=nombres;
      email_max2:=email;
    end;
end;
procedure procesar_lista_alumnos(lista_alumnos: t_lista_alumnos; var alumnos_corte: int16; var apellido_max1, apellido_max2, nombres_max1, nombres_max2, email_max1, email_max2: string);
var
  anios, anios_max1, anios_max2: int8;
begin
  anios_max1:=low(int8); anios_max2:=low(int8);
  while (lista_alumnos<>nil) do
  begin
    textcolor(green); write('El promedio de notas obtenido por este alumno es '); textcolor(red); writeln(calcular_promedio_notas(lista_alumnos^.ele.notas):0:2);
    if ((lista_alumnos^.ele.ingreso=ingreso_corte) and (contar_pares(lista_alumnos^.ele.numero)=true)) then
      alumnos_corte:=alumnos_corte+1;
    anios:=lista_alumnos^.ele.egreso-lista_alumnos^.ele.ingreso;
    actualizar_maximos(anios,lista_alumnos^.ele.apellido,lista_alumnos^.ele.nombres,lista_alumnos^.ele.email,anios_max1,anios_max2,apellido_max1,apellido_max2,nombres_max1,nombres_max2,email_max1,email_max2);
    lista_alumnos:=lista_alumnos^.sig;
  end;
end;
procedure eliminar_lista_alumnos(var lista_alumnos: t_lista_alumnos; var ok: boolean; numero: int16);
var
  anterior, actual: t_lista_alumnos;
begin
  actual:=lista_alumnos;
  while ((actual<>nil) and (actual^.ele.numero<>numero)) do
  begin
    anterior:=actual;
    actual:=actual^.sig;
  end;
  if (actual<>nil) then
  begin
    if (actual=lista_alumnos) then
      lista_alumnos:=lista_alumnos^.sig
    else
      anterior^.sig:=actual^.sig;
    dispose(actual);
    ok:=true;
  end
end;
var
  lista_alumnos: t_lista_alumnos;
  alumnos_corte, numero: int16;
  ok: boolean;
  apellido_max1, apellido_max2, nombres_max1, nombres_max2, email_max1, email_max2: string;
begin
  randomize;
  lista_alumnos:=nil;
  alumnos_corte:=0;
  apellido_max1:=''; apellido_max2:=''; nombres_max1:=''; nombres_max2:=''; email_max1:=''; email_max2:='';
  writeln(); textcolor(red); writeln('INCISO (a):'); writeln();
  cargar_lista_alumnos(lista_alumnos);
  if (lista_alumnos<>nil) then
  begin
    imprimir_lista_alumnos(lista_alumnos);
    writeln(); textcolor(red); writeln('INCISO (b) (i):'); writeln();
    procesar_lista_alumnos(lista_alumnos,alumnos_corte,apellido_max1,apellido_max2,nombres_max1,nombres_max2,email_max1,email_max2);
    writeln(); textcolor(red); writeln('INCISO (b) (ii):'); writeln();
    textcolor(green); write('La cantidad de alumnos ingresantes '); textcolor(yellow); write(ingreso_corte); textcolor(green); write(' cuyo número de alumno está compuesto, únicamente, por dígitos impares es '); textcolor(red); writeln(alumnos_corte);
    writeln(); textcolor(red); writeln('INCISO (b) (iii):'); writeln();
    textcolor(green); write('El apellido, nombres y dirección de correo electrónico del alumno que más rápido se recibió son '); textcolor(red); write(apellido_max1); textcolor(green); write(', '); textcolor(red); write(nombres_max1); textcolor(green); write(' y '); textcolor(red); write(email_max1); textcolor(green); writeln(', respectivamente');
    textcolor(green); write('El apellido, nombres y dirección de correo electrónico del segundo alumno que más rápido se recibió son '); textcolor(red); write(apellido_max2); textcolor(green); write(', '); textcolor(red); write(nombres_max2); textcolor(green); write(' y '); textcolor(red); write(email_max2); textcolor(green); writeln(', respectivamente');
    writeln(); textcolor(red); writeln('INCISO (c):'); writeln();
    numero:=1+random(high(int16));
    eliminar_lista_alumnos(lista_alumnos,ok,numero);
    if (ok=true) then
    begin
      textcolor(green); write('El número de alumno '); textcolor(yellow); write(numero); textcolor(red); write(' SÍ'); textcolor(green); write(' fue encontrado y eliminado');
      imprimir_lista_alumnos(lista_alumnos);
    end
    else
    begin
      textcolor(green); write('El número de alumno '); textcolor(yellow); write(numero); textcolor(red); write(' NO'); textcolor(green); write(' fue encontrado');
    end;
  end;
end.