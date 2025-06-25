{TRABAJO PRÁCTICO N° 4}
{EJERCICIO 4}
{Dado el siguiente algoritmo de búsqueda en un árbol B:
Asumir que el archivo se encuentra abierto y que, para la primera llamada, el parámetro NRR contiene la posición de la raíz del árbol.
Responder detalladamente:
(a) PosicionarYLeerNodo(): Indicar qué hace y la forma en que deben ser enviados los parámetros (valor o referencia). Implementar este módulo en Pascal.
(b) claveEncontrada(): Indicar qué hace y la forma en que deben ser enviados los parámetros (valor o referencia). ¿Cómo se implementaría?
(c) ¿Existe algún error en este código? En caso afirmativo, modificar lo que se considere necesario.
(d) ¿Qué cambios son necesarios en el procedimiento de búsqueda implementado sobre un árbol B para que funcione en un árbol B+?}

program TP4_E4;
const
  M=10;
type
  t_registro=record
    id: int16;
    anio: int16;
  end;
  t_registro_nodo=record
    cantClaves: int16;
    claves: array[0..M-1] of t_registro;
    hijos: array[0..M] of int16;
  end;
  t_archivo_datos=file of t_registro_nodo;
procedure PosicionarYLeerNodo(NRR: int16; var A: t_archivo_datos; var nodo: t_registro_nodo);
begin
  seek(A,NRR);
  read(A,nodo);
end;
procedure claveEncontrada(nodo: t_registro_nodo; clave: int16; var pos: int16; var clave_encontrada: boolean);
var
  i: int16;
begin
  i:=1;
  while ((i<=nodo.cantClaves) and (clave>nodo.claves[i].id)) do
    i:=i+1;
  if ((i<=nodo.cantClaves) and (clave=nodo.claves[i].id)) then
  begin
    clave_encontrada:=true;
    pos:=i;
  end
  else
  begin
    clave_encontrada:=false;
    pos:=i;
  end;
end;
procedure buscar(NRR, clave: int16; var A: t_archivo_datos; var NRR_encontrado, pos_encontrada: int16; var resultado: boolean);
var
  nodo: t_registro_nodo;
  pos: int16;
  clave_encontrada: boolean;
begin
  if (NRR=-1) then
    resultado:=false
  else
  begin
    posicionarYLeerNodo(NRR,A,nodo);
    claveEncontrada(nodo,clave,pos,clave_encontrada);
    if (clave_encontrada) then
    begin
      NRR_encontrado:=NRR;
      pos_encontrada:=pos;
      resultado:=true;
    end
    else
      buscar(nodo.hijos[pos],clave,A,NRR_encontrado,pos_encontrada,resultado)
  end;
end;
var
  archivo_datos: t_archivo_datos;
begin

end.