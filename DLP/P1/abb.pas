unit abb;
{arboles binarios de busqueda }

interface

const
   NULO = nil;
   
type
   tClave     = integer;
   tPosA     = ^tNodoA;
   tNodoA    = record
		  clave	     : tClave;
		  izdo, dcho : tPosA;
	       end;	     
   tABB = tPosA;

procedure arbolVacio(VAR A : tABB);
procedure insertarClave(VAR A : tABB; c:tClave);

function hijoIzquierdo(A : tABB):tABB;
function hijoDerecho(A : tABB):tABB;
function Raiz(A : tABB):tClave;
function esArbolvacio(A	: tABB):boolean;
function buscarClave(A : tABB; c:tClave):tABB;

procedure eliminarClave(VAR A : tABB; c:tClave);



implementation

{****************************************************************}

procedure error(    s	   : string);
begin
   writeln(s);
   halt(1);
end; { error }

procedure crearNodoA(VAR p : tPosA);
begin
   new(p);
   if p=nil then
      error('  *** abb.crearNodoA: no hay memoria');
end; { crearNodo }

{****************************************************************}

procedure arbolVacio(VAR A : tABB);
begin
   A := nil;
end; { arbolvacio }

{****************************************************************}

{insertar recursivo}
procedure insertar_r(VAR A : tABB; c:tClave);
begin
   if (A=nil) then begin
      crearNodoA(A);
      A^.clave := c;
      A^.izdo := nil;
      A^.dcho := nil
   end
   else if (c < A^.clave) then
      insertar_r(A^.izdo, c)
   else if ( c > A^.clave) then
      insertar_r(A^.dcho, c);
   { los duplicados se ignoran }
end; { insertar_r }



{insertar iterativo}
procedure insertar_i(VAR A : tABB; c:tClave);
var nuevo, padre, hijo :  tABB;
begin
   crearNodoA(nuevo);
   nuevo^.clave := c;
   nuevo^.izdo := nil;
   nuevo^.dcho := nil;

   if A=nil then
      A := nuevo
   else begin
      padre := nil;
      hijo := A;
      while (hijo <> nil) and (hijo^.clave <> c) do begin
	 padre := hijo;
	 if c < hijo^.clave then
	    hijo := hijo^.izdo
	 else
	    hijo := hijo^.dcho;
      end;

      if (hijo = nil) then 
	 if c < padre^.clave then
	    padre^.izdo := nuevo
	 else
	    padre^.dcho := nuevo;
	    { los duplicados se ignoran }
   end;
end; { insertar_i }

procedure insertarClave(VAR A : tABB; c:tClave);   
begin
  insertar_r(A, c)
end; { insertar }

{****************************************************************}
      
{buscar recursivo}
function buscar_r(A : tABB; c:tClave):tPosA;
begin
   if (A = nil) then
      buscar_r := nil
   else if (A^.clave = c) then
      buscar_r := A
   else if (c < A^.clave) then
      buscar_r := buscar_r(A^.izdo, c)
   else
      buscar_r := buscar_r(A^.dcho, c)
end; { buscar_r }


{buscar iterativo}
function buscar_i(VAR A : tABB; c:tClave):tPosA;
var  nodo : tPosA;
begin
   nodo := A;
   while (nodo <> nil) and (nodo^.clave <> c) do 
      if c < nodo^.clave then
	 nodo := nodo^.izdo
      else
	 nodo := nodo^.dcho;
   buscar_i := nodo
end; { buscar_i }

function buscarClave(A : tABB; c:tClave):tABB;
begin
   buscarClave := buscar_r(A,c)
end; { buscar }

{****************************************************************}

function hijoIzquierdo(A : tABB):tABB;
begin
   hijoIzquierdo := A^.izdo;
end; { hijoIzquierdo }


{****************************************************************}

function hijoDerecho(A : tABB):tABB;
begin
   hijoDerecho := A^.dcho;
end; { hijoDerecho }

{****************************************************************}

function Raiz(A : tABB):tClave;
begin
   Raiz := A^.clave;
end; { Raiz }


{****************************************************************}

function esArbolvacio(A	: tABB):boolean;
begin
   esArbolvacio := (A = nil);
end; { esArbolvacio }


{****************************************************************}

{eliminar recursivo}
procedure eliminar_r(VAR A : tABB; c:tClave);
var aux	:  tABB;

  // cuando en nodo a eliminar tiene dos hijos se llama a este prodedure
  // para sustirtirlo por el nodo con mayor clave de su subarbol izquierdo
  procedure sup2(var B : tABB);
  begin
     if (B^.dcho <> nil) then
	sup2(B^.dcho)
     else begin
	aux^.clave := B^.clave;
	aux := B;
	B := B^.izdo;
     end;
  end; { sup2 }
  
begin
   if  A <> nil then {si d no esta en A no se hace nada}
      if c < A^.clave then
	 eliminar_r(A^.izdo, c)
      else if c > A^.clave then
	 eliminar_r(A^.dcho, c)
      else begin
	 aux := A;
	 if A^.izdo = nil then
	    A := A^.dcho
	 else if A^.dcho = nil then
	    A := A^.izdo
	 else
	    sup2(A^.izdo);
	 dispose(aux);
      end; {else}
end; { eliminar_r }

   
   
{borrar iterativo}
procedure eliminar_i(VAR A : tABB; c:tClave);
var numHIjos			: integer;
   sup,  {nodo a suprimir}
   pSup, {padre del nodo a suprimir}
   hijoNoVacio, {si el nodo a suprimir solo tiene un hijo, el no vacio}
   SucIzMax {si el nodo a suprimir tiene dos hijos, el nodo con mayor valor del subarbol izquierdo}
             : tABB;
begin
   {busca el nodo a suprimir }
   pSup := nil;
   sup := A;
   while (sup <> nil) and (sup^.clave <> c) do begin
      pSup := sup;
      if (c < sup^.clave) then
	 sup := sup^.izdo
      else sup := sup^.dcho;
   end; { while }

   { si c no esta en A, no se hace nada }
   if (sup <> nil) then begin

      {cuenta el numero de hijos }
      numHijos := 0;
      if sup^.izdo <> nil then
	 numHijos := numHijos + 1;
      if sup^.dcho <> nil then
	 numHijos := numHijos + 1;
      
      case numHijos of
	{suprimir nodo hoja}
	0 : if pSup = nil then 
	       A:= nil {la raiz era el unico nodo del arbol }
	    else if (pSup^.izdo=sup) then
	       pSup^.izdo := nil
	    else
	       pSup^.dcho := nil;

	{suprimir nodo con un solo hijo}
	1 : begin
	       if (sup^.izdo = nil) then
		  hijoNoVacio := sup^.dcho
	       else
		  hijoNoVacio := sup^.izdo;

	       if (pSup = nil) then
		  A := hijoNoVacio {borramos la raiz}
	       else if (pSup^.izdo = sup) then
		  pSup^.izdo := hijoNoVacio
	       else
		  pSup^.dcho := hijoNoVacio;
	    end; {case 1}

	{suprimir nodo con dos hijos}
	2 : begin
	       pSup := sup;
	       sucIzMax := sup^.izdo;
	       while (sucIzMax^.dcho <> nil) do begin
		  pSup := sucIzMax;
		  sucIzMax := sucIzMax^.dcho;
	       end; { while }

	       sup^.clave := sucizMax^.clave;
	       if (pSup = sup) then
		  pSup^.izdo := sucIzMax^.izdo
	       else
		  pSup^.dcho := sucIzMax^.izdo;

	       sup := sucIzMax;
	    end; {case 2}
      end; { case }

      dispose(sup);
   end; {if}   
end; {eliminar_i}


procedure eliminarClave(VAR A : tABB; c:tClave);
begin
   eliminar_r(A, c)
end; { borrar }


  
   
   
		  
   





end.

