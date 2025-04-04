{TRABAJO PRÁCTICO N° 7}
{EJERCICIO 14}
{La biblioteca de la Universidad Nacional de La Plata necesita un programa para administrar información de préstamos de libros efectuados en marzo de 2020.
Para ello, se debe leer la información de los préstamos realizados.
De cada préstamo, se lee: nro. de préstamo, ISBN del libro prestado, nro. de socio al que se prestó el libro, día del préstamo (1..31).
La información de los préstamos se lee de manera ordenada por ISBN y finaliza cuando se ingresa el ISBN -1 (que no debe procesarse).
Se pide:
(a) Generar una estructura que contenga, para cada ISBN de libro, la cantidad de veces que fue prestado. Esta estructura debe quedar ordenada por ISBN de libro.
(b) Calcular e informar el día del mes en que se realizaron menos préstamos.
(c) Calcular e informar el porcentaje de préstamos que poseen nro. de préstamo impar y nro. de socio par.}

program TP7_E14;
{$codepage UTF8}
uses crt;
const
  dia_ini=1; dia_fin=31;
  isbn_salida=-1;
type
  t_dia=dia_ini..dia_fin;
  t_registro_prestamo=record
    numero: int16;
    isbn: int32;
    socio: int16;
    dia: t_dia;
  end;
  t_registro_isbn=record
    isbn: int32;
    prestamos: int16;
  end;
  t_lista_isbns=^t_nodo_isbns;
  t_nodo_isbns=record
    ele: t_registro_isbn;
    sig: t_lista_isbns;
  end;
  t_vector_cantidades=array[t_dia] of int16;
procedure inicializar_vector_cantidades(var vector_cantidades: t_vector_cantidades);
var
  i: t_dia;
begin
  for i:= dia_ini to dia_fin do
    vector_cantidades[i]:=0;
end;
procedure leer_prestamo(var registro_prestamo: t_registro_prestamo; isbn: int32);
var
  i: int8;
begin
  i:=random(101);
  if (i=0) then
    registro_prestamo.isbn:=isbn_salida
  else if (i<=50) then
    registro_prestamo.isbn:=isbn
  else
    registro_prestamo.isbn:=isbn+random(high(int32)-(isbn-1));
  if (registro_prestamo.isbn<>isbn_salida) then
  begin
    registro_prestamo.numero:=1+random(high(int16));
    registro_prestamo.socio:=1+random(high(int16));
    registro_prestamo.dia:=dia_ini+random(dia_fin);
  end;
end;
procedure agregar_atras_lista_isbns(var lista_isbns: t_lista_isbns; registro_isbn: t_registro_isbn);
var
  nuevo, ult: t_lista_isbns;
begin
  new(nuevo);
  nuevo^.ele:=registro_isbn;
  nuevo^.sig:=nil;
  if (lista_isbns=nil) then
    lista_isbns:=nuevo
  else
  begin
    ult:=lista_isbns;
    while (ult^.sig<>nil) do
      ult:=ult^.sig;
    ult^.sig:=nuevo;
  end;
end;
procedure cargar_lista_isbns(var lista_isbns: t_lista_isbns; var vector_cantidades: t_vector_cantidades; var porcentaje: real);
var
  registro_prestamo: t_registro_prestamo;
  registro_isbn: t_registro_isbn;
  prestamos_corte, prestamos_total: int16;
begin
  prestamos_corte:=0; prestamos_total:=0;
  leer_prestamo(registro_prestamo,1+random(high(int32)));
  while (registro_prestamo.isbn<>isbn_salida) do
  begin
    registro_isbn.isbn:=registro_prestamo.isbn;
    registro_isbn.prestamos:=0;
    while ((registro_prestamo.isbn<>isbn_salida) and (registro_prestamo.isbn=registro_isbn.isbn)) do
    begin
      registro_isbn.prestamos:=registro_isbn.prestamos+1;
      vector_cantidades[registro_prestamo.dia]:=vector_cantidades[registro_prestamo.dia]+1;
      if ((registro_prestamo.numero mod 2<>0) and (registro_prestamo.socio mod 2=0)) then
        prestamos_corte:=prestamos_corte+1;
      prestamos_total:=prestamos_total+1;
      leer_prestamo(registro_prestamo,registro_isbn.isbn);
    end;
    agregar_atras_lista_isbns(lista_isbns,registro_isbn);
  end;
  if (prestamos_total>0) then
    porcentaje:=prestamos_corte/prestamos_total*100;
end;
procedure imprimir_registro_isbn(registro_isbn: t_registro_isbn; isbn: int32);
begin
  textcolor(green); write('El ISBN del ISBN '); textcolor(yellow); write(isbn); textcolor(green); write(' es '); textcolor(red); writeln(registro_isbn.isbn);
  textcolor(green); write('La cantidad de préstamos del ISBN '); textcolor(yellow); write(isbn); textcolor(green); write(' es '); textcolor(red); writeln(registro_isbn.prestamos);
end;
procedure imprimir_lista_isbns(lista_isbns: t_lista_isbns);
var
  i: int8;
begin
  i:=0;
  while (lista_isbns<>nil) do
  begin
    i:=i+1;
    textcolor(green); write('La información del ISBN '); textcolor(yellow); write(i); textcolor(green); writeln(' es:');
    imprimir_registro_isbn(lista_isbns^.ele,i);
    writeln();
    lista_isbns:=lista_isbns^.sig;
  end;
end;
procedure actualizar_minimo(cantidad: int16; dia: t_dia; var cantidad_min: int16; var dia_min: int8);
begin
  if (cantidad<cantidad_min) then
  begin
    cantidad_min:=cantidad;
    dia_min:=dia;
  end;
end;
procedure procesar_vector_cantidades(var vector_cantidades: t_vector_cantidades; var dia_min: int8);
var
  i: t_dia;
  cantidad_min: int16;
begin
  cantidad_min:=high(int16);
  for i:= dia_ini to dia_fin do
  begin
    actualizar_minimo(vector_cantidades[i],i,cantidad_min,dia_min);
    textcolor(green); write('La cantidad de préstamos que se realizaron el día ',i,' es '); textcolor(red); writeln(vector_cantidades[i]);
  end;
end;
var
  vector_cantidades: t_vector_cantidades;
  lista_isbns: t_lista_isbns;
  dia_min: int8;
  porcentaje: real;
begin
  randomize;
  inicializar_vector_cantidades(vector_cantidades);
  lista_isbns:=nil;
  dia_min:=0;
  porcentaje:=0;
  writeln(); textcolor(red); writeln('INCISO (a):'); writeln();
  cargar_lista_isbns(lista_isbns,vector_cantidades,porcentaje);
  if (lista_isbns<>nil) then
  begin
    imprimir_lista_isbns(lista_isbns);
    writeln(); textcolor(red); writeln('INCISO (b):'); writeln();
    procesar_vector_cantidades(vector_cantidades,dia_min);
    writeln(); textcolor(green); write('El día del mes en que se realizaron menos préstamos fue el día '); textcolor(red); writeln(dia_min);
    writeln(); textcolor(red); writeln('INCISO (c):'); writeln();
    textcolor(green); write('El porcentaje de préstamos que poseen nro. de préstamo impar y nro. de socio par es '); textcolor(red); write(porcentaje:0:2); textcolor(green); write('%');
  end;
end.