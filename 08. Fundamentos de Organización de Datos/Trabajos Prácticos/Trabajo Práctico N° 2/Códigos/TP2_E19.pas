{TRABAJO PRÁCTICO N° 2}
{EJERCICIO 19}
{A partir de un siniestro ocurrido, se perdieron las actas de nacimiento y fallecimientos de toda la Provincia de Buenos Aires de los últimos diez años.
En pos de recuperar dicha información, se deberá procesar 2 archivos por cada una de las 50 delegaciones distribuidas en la provincia, un archivo de nacimientos y otro de fallecimientos, y crear el archivo maestro reuniendo dicha información.
Los archivos detalles con nacimientos contendrán la siguiente información: nro. partida nacimiento, nombre, apellido, dirección detallada (calle, nro., piso, depto., ciudad), matrícula del médico, nombre y apellido de la madre, DNI madre, nombre y apellido del padre, DNI del padre.
En cambio, los 50 archivos de fallecimientos tendrán: nro. partida nacimiento, DNI, nombre y apellido del fallecido, matrícula del médico que firma el deceso, fecha y hora del deceso y lugar.
Realizar un programa que cree el archivo maestro a partir de toda la información de los archivos detalles.
Se debe almacenar en el maestro: nro. partida nacimiento, nombre, apellido, dirección detallada (calle, nro., piso, depto., ciudad), matrícula del médico, nombre y apellido de la madre, DNI madre, nombre y apellido del padre, DNI del padre y, si falleció, además, matrícula del médico que firma el deceso, fecha y hora del deceso y lugar.
Se deberá, además, listar, en un archivo de texto, la información recolectada de cada persona.
Nota: Todos los archivos están ordenados por nro. partida de nacimiento, que es única.
Tener en cuenta que no necesariamente va a fallecer en el distrito donde nació la persona y, además, puede no haber fallecido.}

program TP2_E19;
{$codepage UTF8}
uses crt, sysutils;
const
  detalles_nacimientos_total=1; // detalles_nacimientos_total=50;
  detalles_fallecimientos_total=1; // detalles_fallecimientos_total=50;
  nro_partida_salida=999;
type
  t_detalle1=1..detalles_nacimientos_total;
  t_detalle2=1..detalles_fallecimientos_total;
  t_string10=string[10];
  t_registro_direccion=record
    calle: int16;
    nro: int16;
    piso: int16;
    depto: int16;
    ciudad: t_string10;
  end;
  t_registro_persona=record
    nombre: t_string10;
    apellido: t_string10;
    dni: int16;
  end;
  t_registro_deceso=record
    fecha: t_string10;
    hora: t_string10;
    lugar: t_string10;
  end;
  t_registro_nacimiento=record
    nro_partida: int16;
    nombre: t_string10;
    apellido: t_string10;
    direccion: t_registro_direccion;
    matricula_medico: int16;
    madre: t_registro_persona;
    padre: t_registro_persona;
  end;
  t_registro_fallecimiento=record
    nro_partida: int16;
    fallecido: t_registro_persona;
    matricula_medico: int16;
    deceso: t_registro_deceso;
  end;
  t_registro_acta=record
    nacimiento: t_registro_nacimiento;
    fallecio: boolean;
    matricula_medico: int16;
    deceso: t_registro_deceso;
  end;
  t_archivo_maestro=file of t_registro_acta;
  t_archivo_detalle_nacimientos=file of t_registro_nacimiento;
  t_archivo_detalle_fallecimientos=file of t_registro_fallecimiento;
  t_vector_nacimientos=array[t_detalle1] of t_registro_nacimiento;
  t_vector_fallecimientos=array[t_detalle2] of t_registro_fallecimiento;
  t_vector_detalles_nacimientos=array[t_detalle1] of t_archivo_detalle_nacimientos;
  t_vector_detalles_fallecimientos=array[t_detalle2] of t_archivo_detalle_fallecimientos;
  t_vector_carga_detalles_nacimientos=array[t_detalle1] of text;
  t_vector_carga_detalles_fallecimientos=array[t_detalle2] of text;
procedure cargar_archivo_detalle_nacimientos(var archivo_detalle: t_archivo_detalle_nacimientos; var archivo_carga_detalle: text);
var
  registro_nacimiento: t_registro_nacimiento;
begin
  rewrite(archivo_detalle);
  reset(archivo_carga_detalle);
  while (not eof(archivo_carga_detalle)) do
    with registro_nacimiento do
    begin
      readln(archivo_carga_detalle,nro_partida,matricula_medico,madre.dni,padre.dni);
      readln(archivo_carga_detalle,nombre); nombre:=trim(nombre);
      readln(archivo_carga_detalle,apellido); apellido:=trim(apellido);
      readln(archivo_carga_detalle,direccion.calle,direccion.nro,direccion.piso,direccion.depto,direccion.ciudad); direccion.ciudad:=trim(direccion.ciudad);
      readln(archivo_carga_detalle,madre.nombre); madre.nombre:=trim(madre.nombre);
      readln(archivo_carga_detalle,madre.apellido); madre.apellido:=trim(madre.apellido);
      readln(archivo_carga_detalle,padre.nombre); padre.nombre:=trim(padre.nombre);
      readln(archivo_carga_detalle,padre.apellido); padre.apellido:=trim(padre.apellido);
      write(archivo_detalle,registro_nacimiento);
    end;
  close(archivo_detalle);
  close(archivo_carga_detalle);
end;
procedure cargar_archivo_detalle_fallecimientos(var archivo_detalle: t_archivo_detalle_fallecimientos; var archivo_carga_detalle: text);
var
  registro_fallecimiento: t_registro_fallecimiento;
begin
  rewrite(archivo_detalle);
  reset(archivo_carga_detalle);
  while (not eof(archivo_carga_detalle)) do
    with registro_fallecimiento do
    begin
      readln(archivo_carga_detalle,nro_partida,matricula_medico,fallecido.dni);
      readln(archivo_carga_detalle,fallecido.nombre); fallecido.nombre:=trim(fallecido.nombre);
      readln(archivo_carga_detalle,fallecido.apellido); fallecido.apellido:=trim(fallecido.apellido);
      readln(archivo_carga_detalle,deceso.fecha); deceso.fecha:=trim(deceso.fecha);
      readln(archivo_carga_detalle,deceso.hora); deceso.hora:=trim(deceso.hora);
      readln(archivo_carga_detalle,deceso.lugar); deceso.lugar:=trim(deceso.lugar);
      write(archivo_detalle,registro_fallecimiento);
    end;
  close(archivo_detalle);
  close(archivo_carga_detalle);
end;
procedure imprimir_registro_direccion(registro_direccion: t_registro_direccion);
begin
  textcolor(green); write('; Calle: '); textcolor(yellow); write(registro_direccion.calle);
  textcolor(green); write('; Nro.: '); textcolor(yellow); write(registro_direccion.nro);
  textcolor(green); write('; Piso: '); textcolor(yellow); write(registro_direccion.piso);
  textcolor(green); write('; Depto.: '); textcolor(yellow); write(registro_direccion.depto);
  textcolor(green); write('; Ciudad: '); textcolor(yellow); write(registro_direccion.ciudad);
end;
procedure imprimir_registro_persona(registro_persona: t_registro_persona; persona: string);
begin
  textcolor(green); write('; Nombre ',persona,': '); textcolor(yellow); write(registro_persona.nombre);
  textcolor(green); write('; Apellido ',persona,': '); textcolor(yellow); write(registro_persona.apellido);
  if (persona<>'padre') then
  begin
    textcolor(green); write('; DNI ',persona,': '); textcolor(yellow); write(registro_persona.dni);
  end
  else
  begin
    textcolor(green); write('; DNI ',persona,': '); textcolor(yellow); writeln(registro_persona.dni);
  end;
end;
procedure imprimir_registro_nacimiento(registro_nacimiento: t_registro_nacimiento);
begin
  textcolor(green); write('Nro. partida nacimiento: '); textcolor(yellow); write(registro_nacimiento.nro_partida);
  textcolor(green); write('; Nombre: '); textcolor(yellow); write(registro_nacimiento.nombre);
  textcolor(green); write('; Apellido: '); textcolor(yellow); write(registro_nacimiento.apellido);
  imprimir_registro_direccion(registro_nacimiento.direccion);
  textcolor(green); write('; Matrícula médico: '); textcolor(yellow); write(registro_nacimiento.matricula_medico);
  imprimir_registro_persona(registro_nacimiento.madre,'madre');
  imprimir_registro_persona(registro_nacimiento.padre,'padre');
end;
procedure imprimir_archivo_detalle_nacimientos(var archivo_detalle: t_archivo_detalle_nacimientos);
var
  registro_nacimiento: t_registro_nacimiento;
begin
  reset(archivo_detalle);
  while (not eof(archivo_detalle)) do
  begin
    read(archivo_detalle,registro_nacimiento);
    imprimir_registro_nacimiento(registro_nacimiento);
  end;
  close(archivo_detalle);
end;
procedure imprimir_registro_deceso(registro_deceso: t_registro_deceso);
begin
  textcolor(green); write('; Fecha deceso: '); textcolor(yellow); write(registro_deceso.fecha);
  textcolor(green); write('; Hora deceso: '); textcolor(yellow); write(registro_deceso.hora);
  textcolor(green); write('; Lugar deceso: '); textcolor(yellow); writeln(registro_deceso.lugar);
end;
procedure imprimir_registro_fallecimiento(registro_fallecimiento: t_registro_fallecimiento);
begin
  textcolor(green); write('Nro. partida nacimiento: '); textcolor(yellow); write(registro_fallecimiento.nro_partida);
  imprimir_registro_persona(registro_fallecimiento.fallecido,'fallecido');
  textcolor(green); write('; Matrícula médico deceso: '); textcolor(yellow); write(registro_fallecimiento.matricula_medico);
  imprimir_registro_deceso(registro_fallecimiento.deceso);
end;
procedure imprimir_archivo_detalle_fallecimientos(var archivo_detalle: t_archivo_detalle_fallecimientos);
var
  registro_fallecimiento: t_registro_fallecimiento;
begin
  reset(archivo_detalle);
  while (not eof(archivo_detalle)) do
  begin
    read(archivo_detalle,registro_fallecimiento);
    imprimir_registro_fallecimiento(registro_fallecimiento);
  end;
  close(archivo_detalle);
end;
procedure leer_nacimiento(var archivo_detalle: t_archivo_detalle_nacimientos; var registro_nacimiento: t_registro_nacimiento);
begin
  if (not eof(archivo_detalle)) then
    read(archivo_detalle,registro_nacimiento)
  else
    registro_nacimiento.nro_partida:=nro_partida_salida;
end;
procedure leer_fallecimiento(var archivo_detalle: t_archivo_detalle_fallecimientos; var registro_fallecimiento: t_registro_fallecimiento);
begin
  if (not eof(archivo_detalle)) then
    read(archivo_detalle,registro_fallecimiento)
  else
    registro_fallecimiento.nro_partida:=nro_partida_salida;
end;
procedure minimo_nacimiento(var vector_detalles_nacimientos: t_vector_detalles_nacimientos; var vector_nacimientos: t_vector_nacimientos; var min_nacimiento: t_registro_nacimiento);
var
  i, pos: t_detalle1;
begin
  min_nacimiento.nro_partida:=nro_partida_salida;
  for i:= 1 to detalles_nacimientos_total do
    if (vector_nacimientos[i].nro_partida<min_nacimiento.nro_partida) then
    begin
      min_nacimiento:=vector_nacimientos[i];
      pos:=i;
    end;
  if (min_nacimiento.nro_partida<nro_partida_salida) then
    leer_nacimiento(vector_detalles_nacimientos[pos],vector_nacimientos[pos]);
end;
procedure minimo_fallecimiento(var vector_detalles_fallecimientos: t_vector_detalles_fallecimientos; var vector_fallecimientos: t_vector_fallecimientos; var min_fallecimiento: t_registro_fallecimiento);
var
  i, pos: t_detalle2;
begin
  min_fallecimiento.nro_partida:=nro_partida_salida;
  for i:= 1 to detalles_fallecimientos_total do
    if (vector_fallecimientos[i].nro_partida<min_fallecimiento.nro_partida) then
    begin
      min_fallecimiento:=vector_fallecimientos[i];
      pos:=i;
    end;
  if (min_fallecimiento.nro_partida<nro_partida_salida) then
    leer_fallecimiento(vector_detalles_fallecimientos[pos],vector_fallecimientos[pos]);
end;
procedure exportar_archivo_txt(var archivo_maestro: t_archivo_maestro);
var
  registro_acta: t_registro_acta;
  archivo_txt: text;
  i: int16;
begin
  i:=1;
  reset(archivo_maestro);
  assign(archivo_txt,'E19_actasMaestro.txt'); rewrite(archivo_txt);
  while (not eof(archivo_maestro)) do
  begin
    read(archivo_maestro,registro_acta);
    with registro_acta do
    begin
      writeln(archivo_txt,'ACTA ',i);
      writeln(archivo_txt,'Nro. partida nacimiento: ',nacimiento.nro_partida);
      writeln(archivo_txt,'Nombre: ',nacimiento.nombre);
      writeln(archivo_txt,'Apellido: ',nacimiento.apellido);
      writeln(archivo_txt,'Dirección: Calle ',nacimiento.direccion.calle,', Nro. ',nacimiento.direccion.nro,', Piso ',nacimiento.direccion.piso,', Depto. ',nacimiento.direccion.depto,', Ciudad ',nacimiento.direccion.ciudad);
      writeln(archivo_txt,'Matrícula médico: ',nacimiento.matricula_medico);
      writeln(archivo_txt,'Madre: Nombre ',nacimiento.madre.nombre,', Apellido ',nacimiento.madre.apellido,', DNI ',nacimiento.madre.dni);
      writeln(archivo_txt,'Padre: Nombre ',nacimiento.padre.nombre,', Apellido ',nacimiento.padre.apellido,', DNI ',nacimiento.padre.dni);
      if (fallecio=true) then
      begin
        writeln(archivo_txt,'Falleció: Sí');
        writeln(archivo_txt,'Matrícula médico deceso: ',matricula_medico);
        writeln(archivo_txt,'Deceso: Fecha ',deceso.fecha,', Hora ',deceso.hora,', Lugar ',deceso.lugar);
      end
      else
      begin
        writeln(archivo_txt,'Falleció: No');
      end;
      writeln(archivo_txt);
    end;
    i:=i+1;
  end;
  close(archivo_txt);
end;
procedure cargar_archivo_maestro(var archivo_maestro: t_archivo_maestro; var vector_detalles_nacimientos: t_vector_detalles_nacimientos; var vector_detalles_fallecimientos: t_vector_detalles_fallecimientos);
var
  registro_acta: t_registro_acta;
  min_nacimiento: t_registro_nacimiento;
  min_fallecimiento: t_registro_fallecimiento;
  vector_nacimientos: t_vector_nacimientos;
  vector_fallecimientos: t_vector_fallecimientos;
  i: t_detalle1;
  j: t_detalle2;
begin
  rewrite(archivo_maestro);
  for i:= 1 to detalles_nacimientos_total do
  begin
    reset(vector_detalles_nacimientos[i]);
    leer_nacimiento(vector_detalles_nacimientos[i],vector_nacimientos[i]);
  end;
  for j:= 1 to detalles_fallecimientos_total do
  begin
    reset(vector_detalles_fallecimientos[j]);
    leer_fallecimiento(vector_detalles_fallecimientos[j],vector_fallecimientos[j]);
  end;
  minimo_nacimiento(vector_detalles_nacimientos,vector_nacimientos,min_nacimiento);
  minimo_fallecimiento(vector_detalles_fallecimientos,vector_fallecimientos,min_fallecimiento);
  while (min_nacimiento.nro_partida<>nro_partida_salida) do
  begin
    registro_acta.nacimiento:=min_nacimiento;
    if (min_nacimiento.nro_partida=min_fallecimiento.nro_partida) then
    begin
      registro_acta.fallecio:=true;
      registro_acta.matricula_medico:=min_fallecimiento.matricula_medico;
      registro_acta.deceso:=min_fallecimiento.deceso;
      minimo_fallecimiento(vector_detalles_fallecimientos,vector_fallecimientos,min_fallecimiento);
    end
    else
      registro_acta.fallecio:=false;
    write(archivo_maestro,registro_acta);
    minimo_nacimiento(vector_detalles_nacimientos,vector_nacimientos,min_nacimiento);
  end;
  exportar_archivo_txt(archivo_maestro);
  close(archivo_maestro);
  for i:= 1 to detalles_nacimientos_total do
    close(vector_detalles_nacimientos[i]);
  for j:= 1 to detalles_fallecimientos_total do
    close(vector_detalles_fallecimientos[j]);
end;
procedure imprimir_registro_acta(registro_acta: t_registro_acta);
begin
  imprimir_registro_nacimiento(registro_acta.nacimiento);
  if (registro_acta.fallecio=true) then
  begin
    textcolor(green); write('; Falleció: '); textcolor(yellow); write('Sí');
    textcolor(green); write('; Matrícula médico deceso: '); textcolor(yellow); write(registro_acta.matricula_medico);
    imprimir_registro_deceso(registro_acta.deceso);
  end
  else
  begin
    textcolor(green); write('; Falleció: '); textcolor(yellow); writeln('No');
  end;
end;
procedure imprimir_archivo_maestro(var archivo_maestro: t_archivo_maestro);
var
  registro_acta: t_registro_acta;
begin
  reset(archivo_maestro);
  while (not eof(archivo_maestro)) do
  begin
    read(archivo_maestro,registro_acta);
    imprimir_registro_acta(registro_acta);
  end;
  close(archivo_maestro);
end;
var
  vector_detalles_nacimientos: t_vector_detalles_nacimientos;
  vector_detalles_fallecimientos: t_vector_detalles_fallecimientos;
  vector_carga_detalles_nacimientos: t_vector_carga_detalles_nacimientos;
  vector_carga_detalles_fallecimientos: t_vector_carga_detalles_fallecimientos;
  archivo_maestro: t_archivo_maestro;
  i: t_detalle1;
  j: t_detalle2;
begin
  for i:= 1 to detalles_nacimientos_total do
  begin
    writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO DETALLE NACIMIENTOS ',i,':'); writeln();
    assign(vector_detalles_nacimientos[i],'E19_nacimientosDetalle'+intToStr(i)); assign(vector_carga_detalles_nacimientos[i],'E19_nacimientosDetalle'+intToStr(i)+'.txt');
    cargar_archivo_detalle_nacimientos(vector_detalles_nacimientos[i],vector_carga_detalles_nacimientos[i]);
    imprimir_archivo_detalle_nacimientos(vector_detalles_nacimientos[i]);
  end;
  for j:= 1 to detalles_fallecimientos_total do
  begin
    writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO DETALLE FALLECIMIENTOS ',j,':'); writeln();
    assign(vector_detalles_fallecimientos[j],'E19_fallecimientosDetalle'+intToStr(j)); assign(vector_carga_detalles_fallecimientos[j],'E19_fallecimientosDetalle'+intToStr(j)+'.txt');
    cargar_archivo_detalle_fallecimientos(vector_detalles_fallecimientos[j],vector_carga_detalles_fallecimientos[j]);
    imprimir_archivo_detalle_fallecimientos(vector_detalles_fallecimientos[j]);
  end;
  writeln(); textcolor(red); writeln('IMPRESIÓN ARCHIVO MAESTRO:'); writeln();
  assign(archivo_maestro,'E19_actasMaestro');
  cargar_archivo_maestro(archivo_maestro,vector_detalles_nacimientos,vector_detalles_fallecimientos);
  imprimir_archivo_maestro(archivo_maestro);
end.