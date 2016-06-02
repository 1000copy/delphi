unit SimpleStream;

interface
Uses

  Windows, Messages, SysUtils,Math,
  {$WARNINGS OFF}FileCtrl,{$WARNINGS ON}
   Classes, Graphics, Controls,
  Forms, Dialogs, Printers, Menus, Db,
   ExtCtrls;
type
 TSimpleFileStream = class(TFileStream)
   public
    procedure ReadIntegerSkip;
     procedure ReadWord(var a : Word);
     procedure ReadInteger(var a: Integer);
     procedure ReadBoolean(var a: Boolean);
     procedure ReadRect(var a:TRect);
     procedure ReadCardinal(var a:Cardinal);
     procedure ReadString(var a:String);
     procedure ReadTLOGFONT(var a:TLOGFONT);
     procedure WriteWord(a: Word);
     procedure WriteInteger(a: Integer);
     procedure WriteBoolean(a: Boolean);
     procedure WriteRect(a:TRect);
     procedure WriteCardinal(a:Cardinal);
     procedure WriteString(a:String);
     procedure WriteTLOGFONT(a:TLOGFONT);

   end;

implementation
procedure TSimpleFileStream.ReadWord(var a: Word);
begin
  Read(a,SizeOf(word))
end;
procedure TSimpleFileStream.WriteWord(a: Word);
begin
  Write(a,SizeOf(word))
end;
procedure TSimpleFileStream.WriteInteger(a: Integer);
begin
  Write(a,SizeOf(Integer))
end;

procedure TSimpleFileStream.WriteBoolean(a: Boolean);
begin
  Write(a,SizeOf(boolean));

end;

procedure TSimpleFileStream.WriteRect( a: TRect);
begin
  Write(a,SizeOf(TRect))
end;

procedure TSimpleFileStream.WriteCardinal(a: Cardinal);
begin
    Write(a,SizeOf(Cardinal))
end;

procedure TSimpleFileStream.WriteString(a: String);
var   TempPChar: Array[0..3000] Of char;count ,k:integer;
begin
    Count := Length(a);
    WriteInteger(Count);
    StrPCopy(TempPChar, a);
    For K := 0 To Count - 1 Do
      Write(TempPChar[K], 1);
end;

procedure TSimpleFileStream.WriteTLOGFONT(a: TLOGFONT);
begin
   Write(a,SizeOf(TLOGFONT))
end;

procedure TSimpleFileStream.ReadBoolean(var a: Boolean);
begin
  Read(a,SizeOf(Boolean))
end;

procedure TSimpleFileStream.ReadCardinal(var a: Cardinal);
begin
    Read(a,SizeOf(Cardinal))
end;

procedure TSimpleFileStream.ReadInteger(var a: Integer);
begin
    Read(a,SizeOf(Integer))
end;
procedure TSimpleFileStream.ReadIntegerSkip;
var a: Integer;
begin
    Read(a,SizeOf(Integer))
end;

procedure TSimpleFileStream.ReadRect(var a: TRect);
begin
      Read(a,SizeOf(TRect))
end;

procedure TSimpleFileStream.ReadString(var a: String);
var count1,k:integer;TempPChar: Array[0..3000] Of char;
begin
    ReadInteger(Count1);
    tempPchar := #0;
    For K := 0 To Count1 - 1 Do
      Read(TempPChar[K], 1);
    TempPChar[Count1] := #0;
    a := StrPas(TempPChar);
end;

procedure TSimpleFileStream.ReadTLOGFONT(var a: TLOGFONT);
begin
      Read(a,SizeOf(TLOGFONT))
end;

end.
 