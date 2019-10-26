Program Ascii;
Uses Crt;

Const Tope = 2;

VAR A:CHAR;
    C,X,Y:BYTE;
    M:String;

Procedure HellGruen(); 
	Begin Textcolor(LightGreen); 
	end; {//Hellgrün means Light Green in German.\\}
Procedure Weiss(); 
	Begin Textcolor(White); 
	end; {//Weiß means White in German.\\}
Procedure Gelb(); 
	Begin Textcolor(Yellow); 
	end; {//Gelb means Yellow in German.\\}

BEGIN
C:=1;X:=1;Y:=tope; M:='Marfull';
GotoXY(1,1); 
Weiss(); 
Writeln('Ascii Table / Tabla Ascii':50); 
HellGruen();

WHILE C<>254 DO
   begin
	if C=24 then 
	   Begin 
		X:=7; 
		Y:=Tope; 
		gotoxy(X,Y); 
		Gelb(); 
	   end;
	if C=48 then Begin X:=14; Y:=Tope; gotoxy(X,Y); HellGruen(); end;
	if C=72 then Begin X:=21; Y:=Tope; gotoxy(X,Y); Gelb(); end;
	if C=96 then Begin X:=28; Y:=Tope; gotoxy(X,Y); HellGruen(); end;
	if C=120 then Begin X:=36; Y:=Tope; gotoxy(X,Y); Gelb(); end;
	if C=144 then Begin X:=43; Y:=Tope; gotoxy(X,Y); HellGruen(); end;
	if C=168 then Begin X:=50; Y:=Tope; gotoxy(X,Y); Gelb(); end;
	if C=192 then Begin X:=57; Y:=Tope; gotoxy(X,Y); HellGruen(); end;
	if C=216 then Begin X:=65; Y:=Tope; gotoxy(X,Y); Gelb(); end;
	if C=240 then Begin X:=73; Y:=Tope; gotoxy(X,Y); HellGruen(); end;
	GotoXY(X,Y);
	Writeln(CHR(C),' = ',C);
	c:=c+1;Y:=Y+1;
   end;
Repeat
TextColor(random(9)+7); GotoXY(74,17); Writeln('By'); c:=1; Y:=18;
While y<>25 Do
      Begin GotoXY(77,Y); Write(M[c]); y:=Y+1; C:=c+1; End;
GotoXY(1,1); Delay(100);
IF Keypressed Then 
	Begin 
	ClrEol; 
	A:=Readkey; 
	Weiss(); 
	Write('Ascii Table / Tabla Ascii':50);
	GotoXY(5,1); 
	TextColor(random(9)+7); 
	Write('*** ',A,'=',Ord(a),' ***'); 
	end;
Until Ord(A)=27;
a:=readkey;
end.
