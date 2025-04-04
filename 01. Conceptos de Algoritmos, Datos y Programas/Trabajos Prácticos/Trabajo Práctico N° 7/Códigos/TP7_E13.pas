{TRABAJO PRÁCTICO N° 7}
{EJERCICIO 13}
{La tienda de libros Amazon Books está analizando información de algunas editoriales.
Para ello, Amazon cuenta con una tabla con las 35 áreas temáticas utilizadas para clasificar los libros (Arte y Cultura, Historia, Literatura, etc.).
De cada libro, se conoce su título, nombre de la editorial, cantidad de páginas, año de edición, cantidad de veces que fue vendido y código del área temática (1..35).
Realizar un programa que:
(a) Invoque a un módulo que lea la información de los libros hasta ingresar el título “Relato de un náufrago” (que debe procesarse) y devuelva, en una estructura de datos adecuada para la editorial “Planeta Libros”, la siguiente información:
•	Nombre de la editorial.
•	Año de edición del libro más antiguo.
•	Cantidad de libros editados.
•	Cantidad total de ventas entre todos los libros.
•	Detalle con título, nombre del área temática y cantidad de páginas de todos los libros con más de 250 ventas.
(b) Invoque a un módulo que reciba la estructura generada en el inciso (a) e imprima el nombre de la editorial y el título de cada libro con más de 250 ventas.}

program TP7_E13;
{$codepage UTF8}
uses crt;
const
  anio_ini=2000; anio_fin=2020;
  area_ini=1; area_fin=35;
  titulo_salida='Relato de un naufrago';
  editorial_corte='Planeta Libros';
  ventas_corte=250;
  vector_areas: array[area_ini..area_fin] of string=('Arte y Cultura', 'Historia', 'Literatura', 'Ciencia Ficcion', 'Policial', 'Romantica', 'Aventura', 'Infantil', 'Juvenil', 'Terror', 'Fantasia', 'Biografia', 'Autoayuda', 'Cocina', 'Viajes', 'Deportes', 'Salud', 'Economia', 'Politica', 'Sociedad', 'Filosofia', 'Religiin', 'Ciencia', 'Tecnologia', 'Matematicas', 'Fisica', 'Quimica', 'Biologia', 'Geografia', 'Ecologia', 'Astronomia', 'Medicina', 'Derecho', 'Arquitectura', 'Musica');
type
  t_area=area_ini..area_fin;
  t_registro_libro1=record
    titulo: string;
    editorial: string;
    paginas: int16;
    anio: int16;
    ventas: int16;
    area: t_area;
  end;
  t_registro_libro2=record
    titulo: string;
    area: string;
    paginas: int16;
  end;
  t_lista_libros=^t_nodo_libros;
  t_nodo_libros=record
    ele: t_registro_libro2;
    sig: t_lista_libros;
  end;
  t_registro_editorial=record
    editorial: string;
    anio: int16;
    libros: int16;
    ventas: int16;
    lista_libros: t_lista_libros;
  end;
procedure inicializar_registro_editorial(var registro_editorial: t_registro_editorial);
begin
  registro_editorial.editorial:=editorial_corte;
  registro_editorial.anio:=high(int16);
  registro_editorial.libros:=0;
  registro_editorial.ventas:=0;
  registro_editorial.lista_libros:=nil;
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
procedure leer_libro(var registro_libro1: t_registro_libro1);
var
  i: int8;
begin
  i:=random(101);
  if (i=0) then
    registro_libro1.titulo:=titulo_salida
  else
    registro_libro1.titulo:=random_string(5+random(6));
  if (i<=50) then
    registro_libro1.editorial:=editorial_corte
  else
    registro_libro1.editorial:=random_string(5+random(6));
  registro_libro1.paginas:=10+random(491);
  registro_libro1.anio:=anio_ini+random(anio_fin-anio_ini+1);
  registro_libro1.ventas:=1+random(1000);
  registro_libro1.area:=area_ini+random(area_fin);
end;
procedure cargar_registro_libro2(var registro_libro2: t_registro_libro2; registro_libro1: t_registro_libro1);
begin
  registro_libro2.titulo:=registro_libro1.titulo;
  registro_libro2.area:=vector_areas[registro_libro1.area];
  registro_libro2.paginas:=registro_libro1.paginas;
end;
procedure agregar_adelante_lista_libros(var lista_libros: t_lista_libros; registro_libro1: t_registro_libro1);
var
  nuevo: t_lista_libros;
begin
  new(nuevo);
  cargar_registro_libro2(nuevo^.ele,registro_libro1);
  nuevo^.sig:=lista_libros;
  lista_libros:=nuevo;
end;
procedure cargar_registro_editorial(var registro_editorial: t_registro_editorial);
var
  registro_libro1: t_registro_libro1;
begin
  repeat
    leer_libro(registro_libro1);
    if (registro_libro1.editorial=editorial_corte) then
    begin
      if (registro_libro1.anio<registro_editorial.anio) then
        registro_editorial.anio:=registro_libro1.anio;
      registro_editorial.libros:=registro_editorial.libros+1;
      registro_editorial.ventas:=registro_editorial.ventas+registro_libro1.ventas;
      if (registro_libro1.ventas>ventas_corte) then
        agregar_adelante_lista_libros(registro_editorial.lista_libros,registro_libro1);
    end;
  until (registro_libro1.titulo=titulo_salida);
end;
procedure imprimir_registro_libro2(registro_libro2: t_registro_libro2; libro: int16);
begin
  textcolor(green); write('El título del libro '); textcolor(yellow); write(libro); textcolor(green); write(' es '); textcolor(red); writeln(registro_libro2.titulo);
  textcolor(green); write('El nombre del área temática del libro '); textcolor(yellow); write(libro); textcolor(green); write(' es '); textcolor(red); writeln(registro_libro2.area);
  textcolor(green); write('La cantidad de páginas del libro '); textcolor(yellow); write(libro); textcolor(green); write(' es '); textcolor(red); writeln(registro_libro2.paginas);
end;
procedure imprimir_lista_libros(lista_libros: t_lista_libros);
var
  i: int16;
begin
  i:=0;
  while (lista_libros<>nil) do
  begin
    i:=i+1;
    textcolor(green); write('La información del libro '); textcolor(yellow); write(i); textcolor(green); write(' con más de '); textcolor(yellow); write(ventas_corte); textcolor(green); writeln(' ventas es:');
    imprimir_registro_libro2(lista_libros^.ele,i);
    writeln();
    lista_libros:=lista_libros^.sig;
  end;
end;
procedure imprimir_registro_editorial(registro_editorial: t_registro_editorial);
begin
  textcolor(green); write('El nombre de la editorial es '); textcolor(red); writeln(registro_editorial.editorial);
  textcolor(green); write('El año de edición del libro más antiguo es '); textcolor(red); writeln(registro_editorial.anio);
  textcolor(green); write('La cantidad de libros editados es '); textcolor(red); writeln(registro_editorial.libros);
  textcolor(green); write('La cantidad total de ventas entre todos los libros es '); textcolor(red); writeln(registro_editorial.ventas);
  writeln();
  imprimir_lista_libros(registro_editorial.lista_libros);
end;
var
  registro_editorial: t_registro_editorial;
begin
  randomize;
  inicializar_registro_editorial(registro_editorial);
  writeln(); textcolor(red); writeln('INCISO (a):'); writeln();
  cargar_registro_editorial(registro_editorial);
  writeln(); textcolor(red); writeln('INCISO (b):'); writeln();
  imprimir_registro_editorial(registro_editorial);
end.