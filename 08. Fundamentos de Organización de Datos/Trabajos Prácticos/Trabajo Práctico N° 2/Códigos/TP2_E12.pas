{TRABAJO PRÁCTICO N° 2}
{EJERCICIO 12}
{La empresa de software “X” posee un servidor web donde se encuentra alojado el sitio web de la organización.
En dicho servidor, se almacenan, en un archivo, todos los accesos que se realizan al sitio.
La información que se almacena en el archivo es la siguiente: año, mes, día, idUsuario y tiempo de acceso al sitio de la organización.
El archivo se encuentra ordenado por los siguientes criterios: año, mes, día e idUsuario.
Se debe realizar un procedimiento que genere un informe en pantalla. Para ello, se indicará el año calendario sobre el cual debe realizar el informe.
El mismo debe respetar el formato mostrado a continuación:
Se deberá tener en cuenta las siguientes aclaraciones:
•	El año sobre el cual realizará el informe de accesos debe leerse desde el teclado.
•	El año puede no existir en el archivo, en tal caso debe informarse en pantalla “Año no encontrado”.
•	Se debe definir las estructuras de datos necesarias.
•	El recorrido del archivo debe realizarse una única vez, procesando sólo la información necesaria.}

program TP2_E12;
{$codepage UTF8}
uses crt;
const
  usuario_salida=999;
  dia_ini=1; dia_fin=31;
  mes_ini=1; mes_fin=12;
  anio_ini=2020; anio_fin=2025;
type
  t_dia=dia_ini..dia_fin;
  t_mes=mes_ini..mes_fin;
  t_anio=anio_ini..anio_fin;
  t_registro_fecha=record
    anio: t_anio;
    mes: t_mes;
    dia: t_dia;
  end;
  t_registro_usuario=record
    fecha: t_registro_fecha;
    usuario: int16;
    tiempo: real;
  end;
  t_archivo_maestro=file of t_registro_usuario;
procedure cargar_archivo_maestro(var archivo_maestro: t_archivo_maestro; var archivo_carga_maestro: text);
var
  registro_usuario: t_registro_usuario;
begin
  rewrite(archivo_maestro);
  reset(archivo_carga_maestro);
  while (not eof(archivo_carga_maestro)) do
    with registro_usuario do
    begin
      readln(archivo_carga_maestro,fecha.anio,fecha.mes,fecha.dia,usuario,tiempo);
      write(archivo_maestro,registro_usuario);
    end;
  close(archivo_maestro);
  close(archivo_carga_maestro);
end;
procedure imprimir_registro_fecha(registro_fecha: t_registro_fecha);
begin
  textcolor(green); write('Fecha: '); textcolor(yellow); write(registro_fecha.anio);
  textcolor(green); write('/'); textcolor(yellow); write(registro_fecha.mes);
  textcolor(green); write('/'); textcolor(yellow); write(registro_fecha.dia);
end;
procedure imprimir_registro_usuario(registro_usuario: t_registro_usuario);
begin
  imprimir_registro_fecha(registro_usuario.fecha);
  textcolor(green); write('; ID usuario: '); textcolor(yellow); write(registro_usuario.usuario);
  textcolor(green); write('; Tiempo de acceso: '); textcolor(yellow); writeln(registro_usuario.tiempo:0:2);
end;
procedure imprimir_archivo_maestro(var archivo_maestro: t_archivo_maestro);
var
  registro_usuario: t_registro_usuario;
begin
  reset(archivo_maestro);
  while (not eof(archivo_maestro)) do
  begin
    read(archivo_maestro,registro_usuario);
    imprimir_registro_usuario(registro_usuario);
  end;
  close(archivo_maestro);
end;
procedure leer_acceso(var archivo_maestro: t_archivo_maestro; var registro_usuario: t_registro_usuario);
begin
  if (not eof(archivo_maestro)) then
    read(archivo_maestro,registro_usuario)
  else
    registro_usuario.usuario:=usuario_salida;
end;
procedure procesar_archivo_maestro(var archivo_maestro: t_archivo_maestro; anio: t_anio);
var
  registro_usuario: t_registro_usuario;
  mes, dia, usuario: int16;
  tiempo_anio, tiempo_mes, tiempo_dia, tiempo_usuario: real;
begin
  reset(archivo_maestro);
  leer_acceso(archivo_maestro,registro_usuario);
  while ((registro_usuario.usuario<>usuario_salida) and (registro_usuario.fecha.anio<>anio)) do
    leer_acceso(archivo_maestro,registro_usuario);
  if (registro_usuario.usuario<>usuario_salida) then
  begin
    tiempo_anio:=0;
    textcolor(green); write('Año: '); textcolor(yellow); writeln(anio); writeln();
    while (registro_usuario.fecha.anio=anio) do
    begin
      mes:=registro_usuario.fecha.mes;
      tiempo_mes:=0;
      textcolor(green); write('  Mes: '); textcolor(yellow); writeln(mes);
      while ((registro_usuario.fecha.anio=anio) and (registro_usuario.fecha.mes=mes)) do
      begin
        dia:=registro_usuario.fecha.dia;
        tiempo_dia:=0;
        textcolor(green); write('    Día: '); textcolor(yellow); writeln(dia);
        textcolor(green); write('      idUsuario          Tiempo Total de acceso en el día '); textcolor(yellow); write(dia); textcolor(green); write(' mes '); textcolor(yellow); writeln(mes);
        while ((registro_usuario.fecha.anio=anio) and (registro_usuario.fecha.mes=mes) and (registro_usuario.fecha.dia=dia)) do
        begin
          usuario:=registro_usuario.usuario;
          tiempo_usuario:=0;
          while ((registro_usuario.fecha.anio=anio) and (registro_usuario.fecha.mes=mes) and (registro_usuario.fecha.dia=dia) and (registro_usuario.usuario=usuario)) do
          begin
            tiempo_usuario:=tiempo_usuario+registro_usuario.tiempo;
            leer_acceso(archivo_maestro,registro_usuario);
          end;
          textcolor(green); write('      '); textcolor(yellow); write(usuario); textcolor(green); write('                  '); textcolor(red); writeln(tiempo_usuario:0:2);
          tiempo_dia:=tiempo_dia+tiempo_usuario;
        end;
        textcolor(green); write('    Tiempo total acceso día '); textcolor(yellow); write(dia); textcolor(green); write(' mes '); textcolor(yellow); write(mes); textcolor(green); write(': '); textcolor(red); writeln(tiempo_dia:0:2);
        tiempo_mes:=tiempo_mes+tiempo_dia;
      end;
      textcolor(green); write('  Tiempo total acceso mes '); textcolor(yellow); write(mes); textcolor(green); write(': '); textcolor(red); writeln(tiempo_mes:0:2); writeln();
      tiempo_anio:=tiempo_anio+tiempo_mes;
    end;
    textcolor(green); write('Tiempo total acceso año '); textcolor(yellow); write(anio); textcolor(green); write(': '); textcolor(red); writeln(tiempo_anio:0:2);
  end
  else
  begin
    textcolor(green); write('Año '); textcolor(yellow); write(anio); textcolor(green); writeln(' no encontrado');
  end;
  close(archivo_maestro);
end;
var
  archivo_maestro: t_archivo_maestro;
  archivo_carga_maestro: text;
  anio: t_anio;
begin
  randomize;
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO MAESTRO:'); writeln();
  assign(archivo_maestro,'E12_usuariosMaestro'); assign(archivo_carga_maestro,'E12_usuariosMaestro.txt');
  cargar_archivo_maestro(archivo_maestro,archivo_carga_maestro);
  imprimir_archivo_maestro(archivo_maestro);
  writeln(); textcolor(red); writeln('PROCESAMIENTO ARCHIVO MAESTRO:'); writeln();
  anio:=anio_ini+random(anio_fin-anio_ini+1);
  procesar_archivo_maestro(archivo_maestro,anio);
end.