{TRABAJO PRÁCTICO N° 2}
{EJERCICIO 13}
{Suponer que se es administrador de un servidor de correo electrónico.
En los logs del mismo (información guardada acerca de los movimientos que ocurren en el server) que se encuentran en la ruta /var/log/logmail.dat, se guarda la siguiente información: nro_usuario, nombreUsuario, nombre, apellido, cantidadMailEnviados.
Diariamente, el servidor de correo genera un archivo con la siguiente información: nro_usuario, cuentaDestino, cuerpoMensaje.
Este archivo representa todos los correos enviados por los usuarios en un día determinado.
Ambos archivos están ordenados por nro_usuario y se sabe que un usuario puede enviar cero, uno o más mails por día.
(a) Realizar el procedimiento necesario para actualizar la información del log en un día particular. Definir las estructuras de datos que utilice el procedimiento.
(b) Generar un archivo de texto que contenga el siguiente informe dado un archivo detalle de un día determinado:
Nota: Tener en cuenta que, en el listado, deberán aparecer todos los usuarios que existen en el sistema.
Considerar la implementación de esta opción de las siguientes maneras:
•	Como un procedimiento separado del inciso (a).
•	En el mismo procedimiento de actualización del inciso (a). ¿Qué cambios se requieren en el procedimiento del inciso (a) para realizar el informe en el mismo recorrido?}

program TP2_E13;
{$codepage UTF8}
uses crt, sysutils;
const
  usuario_salida=999;
type
  t_string20=string[20];
  t_registro_usuario1=record
    usuario: int16;
    nombre_usuario: t_string20;
    nombre: t_string20;
    apellido: t_string20;
    mails: int16;
  end;
  t_registro_usuario2=record
    usuario: int16;
    destino: t_string20;
    mensaje: t_string20;
  end;
  t_archivo_maestro=file of t_registro_usuario1;
  t_archivo_detalle=file of t_registro_usuario2;
procedure cargar_archivo_maestro(var archivo_maestro: t_archivo_maestro; var archivo_carga_maestro: text);
var
  registro_usuario: t_registro_usuario1;
begin
  rewrite(archivo_maestro);
  reset(archivo_carga_maestro);
  while (not eof(archivo_carga_maestro)) do
    with registro_usuario do
    begin
      readln(archivo_carga_maestro,usuario,mails,nombre_usuario); nombre_usuario:=trim(nombre_usuario);
      readln(archivo_carga_maestro,nombre);
      readln(archivo_carga_maestro,apellido);
      write(archivo_maestro,registro_usuario);
    end;
  close(archivo_maestro);
  close(archivo_carga_maestro);
end;
procedure cargar_archivo_detalle(var archivo_detalle: t_archivo_detalle; var archivo_carga_detalle: text);
var
  registro_usuario: t_registro_usuario2;
begin
  rewrite(archivo_detalle);
  reset(archivo_carga_detalle);
  while (not eof(archivo_carga_detalle)) do
    with registro_usuario do
    begin
      readln(archivo_carga_detalle,usuario,destino); destino:=trim(destino);
      readln(archivo_carga_detalle,mensaje);
      write(archivo_detalle,registro_usuario);
    end;
  close(archivo_detalle);
  close(archivo_carga_detalle);
end;
procedure imprimir_registro_usuario1(registro_usuario: t_registro_usuario1);
begin
  textcolor(green); write('Número de usuario: '); textcolor(yellow); write(registro_usuario.usuario);
  textcolor(green); write('; Nombre de usuario: '); textcolor(yellow); write(registro_usuario.nombre_usuario);
  textcolor(green); write('; Nombre: '); textcolor(yellow); write(registro_usuario.nombre);
  textcolor(green); write('; Apellido: '); textcolor(yellow); write(registro_usuario.apellido);
  textcolor(green); write('; Mails enviados: '); textcolor(yellow); writeln(registro_usuario.mails);
end;
procedure imprimir_archivo_maestro(var archivo_maestro: t_archivo_maestro);
var
  registro_usuario: t_registro_usuario1;
begin
  reset(archivo_maestro);
  while (not eof(archivo_maestro)) do
  begin
    read(archivo_maestro,registro_usuario);
    imprimir_registro_usuario1(registro_usuario);
  end;
  close(archivo_maestro);
end;
procedure imprimir_registro_usuario2(registro_usuario: t_registro_usuario2);
begin
  textcolor(green); write('Número de usuario: '); textcolor(yellow); write(registro_usuario.usuario);
  textcolor(green); write('; Cuenta destino: '); textcolor(yellow); write(registro_usuario.destino);
  textcolor(green); write('; Cuerpo del mensaje: '); textcolor(yellow); writeln(registro_usuario.mensaje);
end;
procedure imprimir_archivo_detalle(var archivo_detalle: t_archivo_detalle);
var
  registro_usuario: t_registro_usuario2;
begin
  reset(archivo_detalle);
  while (not eof(archivo_detalle)) do
  begin
    read(archivo_detalle,registro_usuario);
    imprimir_registro_usuario2(registro_usuario);
  end;
  close(archivo_detalle);
end;
procedure leer_usuario(var archivo_detalle: t_archivo_detalle; var registro_usuario: t_registro_usuario2);
begin
  if (not eof(archivo_detalle)) then
    read(archivo_detalle,registro_usuario)
  else
    registro_usuario.usuario:=usuario_salida;
end;
procedure actualizar_archivo_maestro(var archivo_maestro: t_archivo_maestro; var archivo_detalle: t_archivo_detalle);
var
  registro_maestro: t_registro_usuario1;
  registro_detalle: t_registro_usuario2;
begin
  reset(archivo_maestro);
  reset(archivo_detalle);
  leer_usuario(archivo_detalle,registro_detalle);
  while (registro_detalle.usuario<>usuario_salida) do
  begin
    read(archivo_maestro,registro_maestro);
    while (registro_maestro.usuario<>registro_detalle.usuario) do
      read(archivo_maestro,registro_maestro);
    while (registro_maestro.usuario=registro_detalle.usuario) do
    begin
      registro_maestro.mails:=registro_maestro.mails+1;
      leer_usuario(archivo_detalle,registro_detalle);
    end;
    textcolor(green); write('Número de usuario: '); textcolor(yellow); write(registro_maestro.usuario); textcolor(green); write(' .......... Cantidad de Mensajes Enviados: '); textcolor(red); writeln(registro_maestro.mails);
    seek(archivo_maestro,filepos(archivo_maestro)-1);
    write(archivo_maestro,registro_maestro);
  end;
  close(archivo_maestro);
  close(archivo_detalle);
  writeln();
end;
procedure exportar_archivo_txt(var archivo_maestro: t_archivo_maestro);
var
  registro_usuario: t_registro_usuario1;
  archivo_txt: text;
begin
  reset(archivo_maestro);
  assign(archivo_txt,'E13_usuarios.txt'); rewrite(archivo_txt);
  while (not eof(archivo_maestro)) do
  begin
    read(archivo_maestro,registro_usuario);
    writeln(archivo_txt,registro_usuario.usuario,' ',registro_usuario.mails);
  end;
  close(archivo_maestro);
  close(archivo_txt);
end;
var
  archivo_maestro: t_archivo_maestro;
  archivo_detalle: t_archivo_detalle;
  archivo_carga_maestro, archivo_carga_detalle: text;
begin
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO MAESTRO:'); writeln();
  assign(archivo_maestro,'E13_usuariosMaestro'); assign(archivo_carga_maestro,'E13_usuariosMaestro.txt');
  cargar_archivo_maestro(archivo_maestro,archivo_carga_maestro);
  imprimir_archivo_maestro(archivo_maestro);
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO DETALLE:'); writeln();
  assign(archivo_detalle,'E13_usuariosDetalle'); assign(archivo_carga_detalle,'E13_usuariosDetalle.txt');
  cargar_archivo_detalle(archivo_detalle,archivo_carga_detalle);
  imprimir_archivo_detalle(archivo_detalle);
  writeln(); textcolor(red); writeln('IMRESIÓN ARCHIVO MAESTRO ACTUALIZADO:'); writeln();
  actualizar_archivo_maestro(archivo_maestro,archivo_detalle);
  imprimir_archivo_maestro(archivo_maestro);
  exportar_archivo_txt(archivo_maestro);
end.