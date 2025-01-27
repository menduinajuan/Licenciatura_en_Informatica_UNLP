{TRABAJO PRÁCTICO N° 7}
{EJERCICIO 4}
{Una maternidad dispone información sobre sus pacientes.
De cada una, se conoce: nombre, apellido y peso registrado el primer día de cada semana de embarazo (a lo sumo, 42).
La maternidad necesita un programa que analice esta información, determine e informe:
(a) Para cada embarazada, la semana con mayor aumento de peso.
(b) El aumento de peso total de cada embarazada durante el embarazo.}

program TP7_E4;
{$codepage UTF8}
uses crt;
const
  semanas_total=42;
  nombre_salida='XXX';
type
  t_semana=1..semanas_total;
  t_vector_pesos=array[t_semana] of real;
  t_registro_paciente=record
    nombre: string;
    apellido: string;
    pesos: t_vector_pesos;
    semanas: int8;
  end;
  t_lista_pacientes=^t_nodo_pacientes;
  t_nodo_pacientes=record
    ele: t_registro_paciente;
    sig: t_lista_pacientes;
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
procedure cargar_vector_pesos(var vector_pesos: t_vector_pesos; var semanas: int8);
var
  peso: real;
begin
  semanas:=semanas+1;
  vector_pesos[semanas]:=50+random(11)/10;
  peso:=random(11)/10;
  while ((peso<>0) and (semanas<semanas_total)) do
  begin
    semanas:=semanas+1;
    vector_pesos[semanas]:=vector_pesos[semanas-1]+peso;
    if (semanas<semanas_total) then
      peso:=random(11)/10;
  end;
end;
procedure leer_paciente(var registro_paciente: t_registro_paciente);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    registro_paciente.nombre:=nombre_salida
  else
    registro_paciente.nombre:=random_string(5+random(6));
  if (registro_paciente.nombre<>nombre_salida) then
  begin
    registro_paciente.apellido:=random_string(5+random(6));
    registro_paciente.semanas:=0;
    cargar_vector_pesos(registro_paciente.pesos,registro_paciente.semanas);
  end;
end;
procedure agregar_adelante_lista_pacientes(var lista_pacientes: t_lista_pacientes; registro_paciente: t_registro_paciente);
var
  nuevo: t_lista_pacientes;
begin
  new(nuevo);
  nuevo^.ele:=registro_paciente;
  nuevo^.sig:=lista_pacientes;
  lista_pacientes:=nuevo;
end;
procedure cargar_lista_pacientes(var lista_pacientes: t_lista_pacientes);
var
  registro_paciente: t_registro_paciente;
begin
  leer_paciente(registro_paciente);
  while (registro_paciente.nombre<>nombre_salida) do
  begin
    agregar_adelante_lista_pacientes(lista_pacientes,registro_paciente);
    leer_paciente(registro_paciente);
  end;
end;
procedure imprimir_registro_paciente(registro_paciente: t_registro_paciente; paciente: int16);
begin
  textcolor(green); write('El nombre del paciente '); textcolor(yellow); write(paciente); textcolor(green); write(' es '); textcolor(red); writeln(registro_paciente.nombre);
  textcolor(green); write('El apellido del paciente '); textcolor(yellow); write(paciente); textcolor(green); write(' es '); textcolor(red); writeln(registro_paciente.apellido);
  textcolor(green); write('La cantidad de semanas del paciente '); textcolor(yellow); write(paciente); textcolor(green); write(' es '); textcolor(red); writeln(registro_paciente.semanas);
end;
procedure imprimir_lista_pacientes(lista_pacientes: t_lista_pacientes);
var
  i: int16;
begin
  i:=0;
  while (lista_pacientes<>nil) do
  begin
    i:=i+1;
    textcolor(green); write('La información del paciente '); textcolor(yellow); write(i); textcolor(green); writeln(' es:');
    imprimir_registro_paciente(lista_pacientes^.ele,i);
    writeln();
    lista_pacientes:=lista_pacientes^.sig;
  end;
end;
procedure actualizar_maximo(aumento: real; semana: t_semana; var aumento_max: real; var semana_max: t_semana);
begin
  if (aumento>aumento_max) then
  begin
    aumento_max:=aumento;
    semana_max:=semana;
  end;
end;
procedure procesar_vector_pesos(vector_pesos: t_vector_pesos; semanas: int8; var aumento_max: real; var semana_max: t_semana);
var
  i: t_semana;
  aumento: real;
begin
  for i:= 2 to semanas do
  begin
    aumento:=vector_pesos[i]-vector_pesos[i-1];
    actualizar_maximo(aumento,i,aumento_max,semana_max);
  end;
end;
procedure procesar_lista_pacientes(lista_pacientes: t_lista_pacientes);
var
  semana_max: t_semana;
  i: int16;
  aumento_max: real;
begin
  i:=0;
  while (lista_pacientes<>nil) do
  begin
    i:=i+1;
    aumento_max:=-9999999; semana_max:=1;
    procesar_vector_pesos(lista_pacientes^.ele.pesos,lista_pacientes^.ele.semanas,aumento_max,semana_max);
    textcolor(green); write('La semana con mayor aumento de peso de la embarazada '); textcolor(yellow); write(i); textcolor(green); write(' fue la semana '); textcolor(red); write(semana_max); textcolor(green); write(', con un aumento de peso de '); textcolor(red); write(aumento_max:0:2); textcolor(green); writeln(' kilos');
    textcolor(green); write('El aumento de peso total de la embarazada '); textcolor(yellow); write(i); textcolor(green); write(' fue de '); textcolor(red); write(lista_pacientes^.ele.pesos[lista_pacientes^.ele.semanas]-lista_pacientes^.ele.pesos[1]:0:2); textcolor(green); writeln(' kilos');
    writeln();
    lista_pacientes:=lista_pacientes^.sig;
  end;
end;
var
  lista_pacientes: t_lista_pacientes;
begin
  randomize;
  lista_pacientes:=nil;
  cargar_lista_pacientes(lista_pacientes);
  if (lista_pacientes<>nil) then
  begin
    imprimir_lista_pacientes(lista_pacientes);
    writeln(); textcolor(red); writeln('INCISOS (a) (b):'); writeln();
    procesar_lista_pacientes(lista_pacientes);
  end;
end.