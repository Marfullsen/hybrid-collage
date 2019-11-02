PROGRAM BioRain;
uses CRT;
var
Surface: array[1..20, 1..20] of integer;
Redness: array[1..20, 1..20] of char;
BacCount, EmptyCount, bac, Energy, T: integer;
F, C, J, I {aux} :Byte;
BEGIN
CLRSCR;
TextColor(LightRed);
WRITELN('EN/ WELCOME TO THE BIOLOGICAL RAIN SIMULATOR.');
WRITELN('EN/ This program simulates a biological rain.');
WRITELN('EN/ The values are predeterminated by system.');
WRITE('EN/ Please press '); TextColor(White);
WRITE('"ENTER"'); TextColor(LightRed); WRITELN(' to start.');
WRITELN;
TextColor(LightGreen);
WRITELN('ES/ BIENVENIDO AL SIMULADOR DE LLUVIA DE BACTERIAS.');
WRITELN('ES/ El simulador consiste en una lluvia ficticia de bacterias.');
WRITELN('ES/ Los valores son predeterminados por el sistema.');
WRITE('ES/ Presione la tecla '); TextColor(White);
WRITE('"ENTER"'); TextColor(LightGreen);
Writeln(' para iniciar el programa.');
Readln;
TextColor(White);
F:=0;
C:=0;
ENERGY:=0;
clrscr;

{REPEAT}
randomize;
{ Se busca comprobar que "Energy" esté entre 1 y 100 }
{WRITELN('ORIGINAL E IS', '(',ENERGY, ')');}
WRITELN('Comprobando que los datos sean correctos...');
Delay(500);
           REPEAT
           ENERGY:=RANDOM(100)+1;
           {WRITE('TEMP E IS:', '(',ENERGY, ')');}
           UNTIL (ENERGY=1);
           WRITELN('MIN ENERGY = 1');
Delay(500);
           REPEAT
           ENERGY:=RANDOM(100)+1;
           {WRITE('TEMP E IS:', '(',ENERGY, ')');}
           UNTIL(Energy=100);
WRITELN('MAX ENERGY = 100');
Delay(500);
           {WRITELN('FINAL E IS:', '(',ENERGY, ')');}
WriteLN('Datos correctos');
Delay(500);

WriteLN('Comprobando matriz...');
Delay(500);
for f:=1 to 20 do
    for c:=1 to 20 do
        Surface[c,f] := 0;
for f:=1 to 20 do
begin
     for c:=1 to 20 do write( '[', Surface[c,f], ']' );
     writeln;
end;
Delay(700);
CLRSCR;

{ Se verifica la matriz roja }
TextColor(Red);
for f:=1 to 20 do
    for c:=1 to 20 do
        Redness[c,f] := 'M';
for f:=1 to 20 do
begin
     for c:=1 to 20 do write( '[', Redness[c,f], ']' );
     writeln;
end;

TextColor(White);
Delay(200);
CLRSCR;
WriteLN('Matriz comprobada correctamente.');
Delay(500);
CLRSCR;
WriteLN('Iniciando procesos...');
Delay(1500);

{ Rellena la matriz con numeros al azar }
{for f:=1 to 20 do
    for c:=1 to 20 do
        Surface[c,f] := RANDOM(100)+1;}
bac:=0;

Repeat
      {Repeat
      aux:=0;}
      bac:=bac+1;
      I:=RANDOM(20)+1;
      J:=RANDOM(20)+1;
      {WRITE(I, ',', J,'. ');}
      DELAY(1);
      ENERGY:=RANDOM(100)+1;
      SURFACE[I,J]:=ENERGY;
      {for f:=1 to 20 do
    for c:=1 to 20 do
        if Surface[c,f]<>0 then aux:=1 else aux:=0;
       Until (bac=400);}

     { DEVORAR; (Módulo que consta de 8 casos, donde F(I) es Fila y C(J) es Columna)}
     IF (I>1) and (J>1) and (Surface[I-1,J-1]<Energy) THEN {Caso 1: [F-1,C-1]}
        BEGIN
        Surface[I,J]:=Surface[I,J]+Surface[I-1,J-1];
        Surface[I-1,J-1]:=0; {Write(Bac); bac:=bac-1; Write(Bac);}
        End;
     IF (J>1) AND (Surface[I,J-1]<Energy) THEN {Caso 2: [F,C-1]}
        BEGIN
        Surface[I,J]:=Surface[I,J]+Surface[I,J-1];
        Surface[I,J-1]:=0; {bac:=bac-1;}
        END;
     IF (I<20) AND (J>1) AND (Surface[I+1,J-1]<Energy) THEN {Caso 3: [F+1,C-1]}
        BEGIN
        Surface[I,J]:=Surface[I,J]+Surface[I+1,J-1];
        Surface[I+1,J-1]:=0; {bac:=bac-1;}
        END;
     IF (I>1) AND(Surface[I-1,J]<Energy) THEN {Caso 4: [F-1,C]}
        BEGIN
        Surface[I,J]:=Surface[I,J]+Surface[I-1,J];
        Surface[I-1,J]:=0; {bac:=bac-1;}
        END;
     IF (I<20) AND (Surface[I+1,J]<Energy) THEN {Caso 5: [F+1,C]}
        BEGIN
        Surface[I,J]:=Surface[I,J]+Surface[I+1,J];
        Surface[I+1,J]:=0; {bac:=bac-1;}
        END;
     IF (I>1) AND (J<20)AND (Surface[I-1,J+1]<Energy) THEN {Caso 6: [F-1,C+1]}
        BEGIN
        Surface[I,J]:=Surface[I,J]+Surface[I-1,J+1];
        Surface[I-1,J+1]:=0; {bac:=bac-1;}
        END;
     IF (J<20) AND (Surface[I,J+1]<Energy) THEN {Caso 7: [F,C+1]}
        BEGIN
        Surface[I,J]:=Surface[I,J]+Surface[I,J+1];
        Surface[I,J+1]:=0; {bac:=bac-1;}
        END;
     IF (I<20) AND (J<20) AND (Surface[I+1,J+1]<Energy) THEN {Caso 8: [F+1,C+1]}
        BEGIN
        Surface[I,J]:=Surface[I,J]+Surface[I+1,J+1];
        Surface[I+1,J+1]:=0; {bac:=bac-1;}
        END;



     {IF BAC<0 THEN BAC:=0;}
      T:=T+1;
      Write(' T:', T, '. ');
      Write(' Bac:', Bac, '. ');
      Writeln(' Energy:', Energy, '. ');
UNTIL (T=1000);

{for f:1 to 20 do
    for c:=1 to 20 do
        Surface[c,f] := RANDOM(100)+1;}
Delay(1);
CLRSCR;
TEXTCOLOR(WHITE);

{ Imprime la matriz }
{for F:=1 to 20 do
begin
for C:=1 to 20 do
write( '[', Surface[F,C], ']' );
writeln;
end;}
for f:=1 to 20 do
begin
for c:=1 to 20 do
begin
Textcolor(LightGreen);
if Surface[f,c]<>0 then Write('[', Surface[f,c], ']') else
if Surface[f,c]=0 then begin textcolor(lightred); Write('[',surface[f,c],']'); end;
end;
writeln;
end;

{BacCount:=BacCount+1;
UNTIL (Baccount=1);}

bacCount:=0;
EmptyCount:=0;
FOR F:=1 TO 20 DO
    Begin
    FOR C:=1 TO 20 DO
        Begin
        IF SURFACE[F,C]=0 THEN
        EmptyCount:=EmptyCount+1
        ELSE
        BacCount:=BacCount+1;
    END;
END;
TextColor(White);
Writeln('Espanglish/ Total de bacterias in the simulation: ', bac);
Writeln('Espanglish/ Total de bacterias vivas in the end of the simulation: ', bacCount);
Writeln('Espanglish/ Total de empty espacios in the simulation: ', EmptyCount);

Writeln('EN/ Simulation ended, the biological rain simulator were made by Merlot');
Writeln('ES/ Simulador finalizado, Simulador hecho por Merlot, UTFSM 2016');
{
for f:=1 to 20 do
begin
for c:=1 to 20 do
if Surface[f,c]<>0 then Write('[', Surface[f,c], ']') else
if Surface[f,c]=0 then Write('[',Redness[f,c],']');
writeln;
end;
 }
Readln;
end.
