PROGRAM Escurridizo;
USES CRT; {Se inicia la unidad CRT, que nos permite el uso de colores y otras funciones.}
VAR {Se declaran las variables que se usarán.}
   M:ARRAY[0..21,0..21]OF INTEGER; { Matriz de 22x22, el juego es de 20x20 y el resto es para los bordes}
   A,B,C:LONGINT; {Variables auxiliares}
   x,y:Byte;
   D,SW:CHAR;
   XR,YR,CB,XB,YB,XS,YS,XT,YT,LVL:INTEGER; {Variables y coordenadas del juego.}

PROCEDURE CLNM;{SE LIMPIA LA MATRIZ}
BEGIN
     FOR A:=0 TO 21 DO {SE FIJAN LAS MURALLAS}
         FOR B:=0 TO 21 DO
             M[A,B]:=3;
     FOR A:=1 TO 20 DO  {SE LIMPIA LO QUE ESTÁ DENTRO DE LAS MURALLAS}
         FOR B:=1 TO 20 DO
             M[A,B]:=0;
END;

PROCEDURE SHOWM; {SE MUESTRA LO QUE ESTµ DENTRO DE LA MATRIZ}
BEGIN
TEXTCOLOR(CYAN);
     FOR A:=0 TO 21 DO
     BEGIN
         FOR B:=0 TO 21 DO
         WRITE(M[A,B]);
     WRITELN;
     END;
TEXTCOLOR(WHITE);
readln;
CLRSCR;
END;

PROCEDURE OBJ;
BEGIN
REPEAT  {SE FIJAN LAS COORDENADAS DE LA TRAMPA}
A:=RANDOM(20)+1; XT:=A;
B:=RANDOM(20)+1; YT:=B;
UNTIL (XT<>XR) OR (YT<>YR);
M[XT,YT]:=0; {SE PREVEE QUE EL CUADRO TENGA ALGÚN OTRO VALOR AL ASIGNARLE CERO.}
{Writeln('La trampa se encuentra ubicada en ',A,',',B);}
REPEAT {SALIDA/EXIT}
      XS:=RANDOM(20)+1;
      YS:=RANDOM(20)+1;
UNTIL ((XS=20) OR (XS=1) OR (YS=1) OR (YS=20)) and ((XT<>XR) OR (YT<>YR));
M[XS,YS]:=0;
{Writeln('La salida se encuentra en ',XS,',',YS);}
END;

PROCEDURE VAL; {SE INGRESAN Y VALIDAN LOS OBJETOS DEL JUEGO}
BEGIN
ClrScr;
GotoXY(1,1);
Textcolor(White);
WRITELN('INGRESANDO COORDENADAS DE UN NUEVO JUEGO...');
REPEAT
      XR:=RANDOM(20)+1;
      YR:=RANDOM(20)+1;
UNTIL (XR=20) OR (XR=1) OR (YR=1) OR (YR=20); {El juego siempre comenzará en alguna orilla.}
M[XR,YR]:=1;
WRITELN('TE ENCUENTRAS EN ',YR,',',XR);
CB:=RANDOM(99)+1; WRITELN('CANTIDAD DE BLOQUES EN ESTE JUEGO: ',CB);
C:=0;
REPEAT
      XB:=RANDOM(20)+1;
      YB:=RANDOM(20)+1;
      WHILE ((XB=XR) OR (YB=YR))DO
      BEGIN
           XB:=RANDOM(20)+1;
           YB:=RANDOM(20)+1;
      END;
M[XB,YB]:=3;
C:=C+1;
UNTIL (C=CB);
OBJ;
WRITE('PRESIONE LA TECLA '); Textcolor(lightgreen); Write('"ENTER"'); Textcolor(White); Write(' PARA CONTINUAR');
READLN;
END;

PROCEDURE GRAFIK; {SE CONFIGURA LA GRµFICA DEL JUEGO, LOS DETALLES, ETC}
BEGIN
FOR A:=0 TO 21 DO
  BEGIN
    FOR B:=0 TO 21 DO
   { WRITE(M[A,B]);}
    IF (M[A,B]=0) THEN {CAMINO NUNCA RECORRIDO}
       WRITE(' ')
    ELSE IF (M[A,B]=1) THEN  {POSICIO'N ACTUAL}
    BEGIN
         TEXTCOLOR(YELLOW);
         WRITE('#');
    END
    ELSE IF(M[A,B]=2) THEN  {CAMINO RECORRIDO}
    BEGIN
         TEXTCOLOR(WHITE);
         WRITE('.');
    END
    ELSE IF (M[A,B]=3) THEN   {MURALLA}
    BEGIN
         TEXTCOLOR(LIGHTGREEN);
         WRITE('X');
    END;
  WRITELN;
  END;
{IF(M[XT,YT]=0) THEN  //TRAMPA)
    BEGIN
         TEXTCOLOR(LIGHTRED);
         GOTOXY(XT+1,YT+1);
         WRITE('X');
         TEXTCOLOR(LIGHTGREEN);
    END;
IF(M[XS,YS]=0) THEN  //SALIDA
    BEGIN
         TEXTBACKGROUND(CYAN);
         GOTOXY(XS+1,YS+1);
         WRITE(' ');
         TEXTBACKGROUND(BLACK);
    END;  }
END;

PROCEDURE MOV;
VAR
   AUX:BYTE;
   LX,LY,LLX,LLY:INTEGER;
BEGIN
B:=0;
C:=0;
AUX:=0;
     REPEAT
     if (Sw<>'4') then
     begin
     Textcolor(White);
     GOTOXY(1,23); CLREOL;
     WRITELN('TE ENCUENTRAS EN FILA ',XR,' Y EN LA COLUMNA ', YR,', LLEVAS ',C,' PASOS');
     If (Sw='1') then begin
     GOTOXY(1,24); CLREOL;
     WRITE('TRAMPA: ',XT,', ', YT,'.'); end;
     IF (SW<>'3') AND (SW<>'4') THEN
     Write('SALIDA: ',XS,',',YS);
     end;
     GOTOXY(1,1);
     M[XR,YR]:=2;
         IF (SW='0') THEN BEGIN {Condiciones para juego automatico}
            IF (AUX=1) THEN BEGIN B:=B+1; END;
            IF (AUX=1) AND (B=2) THEN BEGIN AUX:=0; B:=0 END;
             LX:=XR; LY:=YR;
            A:=RANDOM(4)+1;
           CASE A OF
                1 :IF (YR<20) AND (M[XR,YR+1]<>3) AND (M[XR,YR+1]<>2) THEN YR:=YR+1
                   ELSE IF (M[XR,YR+1]<>3) AND (AUX=1)THEN YR:=YR+1;
                2 :IF (XR>1) AND (M[XR-1,YR]<>3) AND (M[XR-1,YR]<>2) THEN XR:=XR-1
                   ELSE IF (M[XR-1,YR]<>3) AND (AUX=1) THEN XR:=XR-1;
                3 :IF (XR<20) AND (M[XR+1,YR]<>3) AND (M[XR+1,YR]<>2) THEN XR:=XR+1
                   ELSE IF (M[XR+1,YR]<>3) AND (AUX=1) THEN XR:=XR+1;
                4 :IF (YR>1) AND (M[XR,YR-1]<>3) AND (M[XR,YR-1]<>2) THEN YR:=YR-1
                   ELSE IF (M[XR,YR-1]<>3) AND (AUX=1) THEN YR:=YR-1;
                END;
           END;
 IF (XR=LX) AND (YR=LY) THEN BEGIN C:=C-1; LLX:=LX; LLY:=LY END;
 IF (LLX=XR) AND (LLY=YR) THEN BEGIN AUX:=1; LX:=0; LLX:=0; LY:=0; LLY:=0 END;
IF (SW<>'0') THEN BEGIN
   D:=READKEY;
           CASE ord(D) OF
                68 :IF (YR<20) AND (M[XR,YR+1]<>3) THEN YR:=YR+1;
                100 :IF (YR<20) AND (M[XR,YR+1]<>3) THEN YR:=YR+1;
                87 :IF (XR>1) AND (M[XR-1,YR]<>3) THEN XR:=XR-1;
                119 :IF (XR>1) AND (M[XR-1,YR]<>3) THEN XR:=XR-1;
                83 :IF (XR<20) AND (M[XR+1,YR]<>3) THEN XR:=XR+1;
                115 :IF (XR<20) AND (M[XR+1,YR]<>3) THEN XR:=XR+1;
                65 :IF (YR>1) AND (M[XR,YR-1]<>3) THEN YR:=YR-1;
                97  :IF (YR>1) AND (M[XR,YR-1]<>3) THEN YR:=YR-1;
                END;
   IF ORD(D) = 0 THEN BEGIN
   D := READKEY;
           CASE ORD(D) OF
                77 : IF (YR<20) AND (M[XR,YR+1]<>3) THEN YR:=YR+1; //72 Up W (87 or 119)
                72 : IF (XR>1) AND (M[XR-1,YR]<>3) THEN XR:=XR-1; //77 Right D (68 or 100)
                80 : IF (XR<20) AND (M[XR+1,YR]<>3) THEN XR:=XR+1; //80 Down S (83 or 115)
                75 : IF (YR>1) AND (M[XR,YR-1]<>3) THEN YR:=YR-1;  //75 Left A (65 or 97)
           END;
   END;
END;
     M[XR,YR]:=1;
     GRAFIK;
     DELAY(LVL);
     C:=C+1; {TESTER}
     UNTIL ((XR=XS) AND (YR=YS)) OR ((XR=XT) AND (YR=YT)) OR (C=700) or (ord(D)=27);
END;

PROCEDURE NIVEL;
BEGIN
TEXTCOLOR(WHITE);
WRITELN('INGRESE NIVEL (1-4):'); TEXTCOLOR(LIGHTGREEN);
Writeln;
WRITELN('NIVEL 1 (EASY): COORDENADAS DE TODO');
Writeln;
WRITELN('NIVEL 2 (MEDIUM): COORDENADAS DE FILA/COLUMNA Y SALIDA');
Writeln;
WRITELN('NIVEL 3 (HARD): SOLO COORDENADAS DE FILA/COLUMNA');
Writeln;
WRITELN('NIVEL 4 (EXPERT/ADIVINO): SIN COORDENADAS');
Writeln;
WRITELN('NIVEL 0 (AUTO-GAME): MODO AUTOMATICO');
Writeln;
TEXTCOLOR(WHITE);
{A:=RANDOM(4)+1;}
SW:=READKEY;
{READLN(A);}
{SW:='4';}
 IF (SW='1') THEN  {COORDENADAS DE TODO}
  BEGIN
   LVL:=100;
   END
 ELSE IF (SW='2') THEN {COORDENADAS DE FILA/COLUMNA Y SALIDA}
   LVL:=100
 ELSE IF (SW='3') THEN {COORDENADAS DE FILA/COLUMNA}
   LVL:=100
 ELSE IF (SW='4') THEN {SIN COORDENADAS}
   LVL:=100
 ELSE IF (SW='0') THEN {MODO AUTOMATICO}
   LVL:=100;
WRITELN('NIVEL ',A,' VELOCIDAD: ',LVL div 1000,'SEG.');
END;

Procedure Die;
BEGIN
IF (XR=XT) AND (YR=YT) THEN {TRAMPA, ROJO}
   BEGIN
     TEXTCOLOR(LIGHTRED);
     {CLRSCR;}
     GOTOXY(1,10); CLREOL;
     WRITELN('HAS PISADO LA TRAMPA!, FIN DEL JUEGO');
   END;
IF (C=700) THEN {Cantidad máxima de pasos, AMARILLO}
BEGIN
     TEXTCOLOR(YELLOW);
     {CLRSCR;}
     GOTOXY(1,10); CLREOL;
     WRITELN('HAS DADO 700 PASOS!, FIN DEL JUEGO');
   END;
IF (XR=XS) AND (YR=YS) THEN {Salida, CIAN}
BEGIN
     TEXTCOLOR(CYAN);
     {CLRSCR;}
     GOTOXY(1,10); CLREOL;
     WRITELN('HAS ENCONTRADO LA SALIDA, FELICIDADES!');
     GOTOXY(5,11);
     WRITELN('');
   END;
IF (ORD(D)=27) THEN {TECLA ESCAPE, BLANCO}
BEGIN
     TEXTCOLOR(WHITE);
     {CLRSCR;}
     GOTOXY(1,10); CLREOL;
     WRITELN('HAS PRESIONADO "ESC", IDIOTA!');
     GOTOXY(5,11);
     WRITELN('');
   END;
END;

Procedure Welcome;
BEGIN
Textcolor(lightcyan);
Writeln('Bienvenido al juego de "Escurridizo, la ratita del profesor Dagoberto".');
Writeln;
Writeln('El juego consiste en una rata atrapada dentro de un laberinto. ');
Writeln('(leer libro "Quien se ha llevado mi queso" para mayor detalle.).');
Writeln('El objetivo principal del juego es hacer que "Escurridizo" encuentre');
Writeln('la salida, sin embargo, dentro del laberinto tambien se encuentra un');
Writeln('Queso y una trampa. Otro problema es que solo se pueden dar 700 pasos');
Writeln('ya que luego de eso "Escurridizo" muere de hambre dentro del laberinto.');
Writeln;
Writeln('Juego desarrollado por Frederic Merlot, Estudiante de Pregrado UTFSM.'); textcolor(lightcyan);
WRITE('Presione la tecla '); Textcolor(lightgreen); Write('"ENTER"'); Textcolor(lightcyan); Write(' para continuar.');
Writeln;
Readln;
clrscr;
END;

BEGIN
CLRSCR;
RANDOMIZE;
cursoroff;
CLNM;
SHOWM;
WELCOME;
NIVEL;
REPEAT
CLNM;
VAL; {XR:=10; YR:=10;}
CLRSCR;
GRAFIK;
MOV;
Die;
Readln;
ClrScr;
GotoXY(1,10);
Writeln('Presione una tecla para volver a jugar.');
Writeln('Presione la tecla "ESC" para salir del juego.');
D:=readkey
UNTIL (ORD(d))= 27;
END.
