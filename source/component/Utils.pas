{
  @lastmod(2003-03-29)
  @author(Johannes Berg <johannes@sipsolutions.de>)
  @abstract(Some utility functions)
  This unit contains some utility functions for string handling
}
unit Utils;

interface

{ string empty means it contains only whitespace }
function IsStrEmptyA(const AString: string): boolean;
{ trim compress - only trims right now, TODO: compress whitespace }
procedure TrimCompress(var AString: string);
{ count occurences of AChar in AString }
function StrCountCharA(const AString: string; const AChar: Char): Integer;
{ Position of the ASub in AString. Return 0 if not found }
function StrPosIA(const ASub, AString: string): Integer;
{ loads a file into a string }
function LoadStrFromFileA(const AFile: string; var AStr: string): boolean;
{ creates a "method pointer" }
function MakeMethod(const AObject: Pointer; AMethod: Pointer): TMethod;

implementation
uses
  SysUtils,
  Classes;

function StrSameIA(const A, B: string): boolean;
begin
  Result := AnsiSameText(A, B);
end;

function StrCompIA(const A, B: string): Integer;
begin
  Result := AnsiCompareText(A, B);
end;

function IsStrEmptyA(const AString: string): boolean;
begin
  Result := Length(Trim(AString)) = 0;
end;

procedure TrimCompress(var AString: string);
begin
  AString := Trim(AString);
end;

function StrCountCharA(const AString: string; const AChar: Char): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := Length(AString) downto 1 do begin
    if AString[i] = AChar then Inc(Result);
  end;
end;

function StrPosIA(const ASub, AString: string): Integer;
begin
  Result := AnsiPos(AnsiLowerCase(ASub), AnsiLowerCase(AString))
end;

function LoadStrFromFileA(const AFile: string; var AStr: string): boolean;
var
  str: TFileStream;
  strstr: TStringStream;
begin
  Result := FileExists(AFile);
  strstr := tstringstream.create('');
  str := nil;
  if Result then try
    str := TFileStream.Create(AFile, fmOpenRead);
    strstr.CopyFrom(str, 0);
  except
    Result := false;
  end;
  str.Free;
  AStr := strstr.DataString;
  strstr.free;
end;

function MakeMethod(const AObject: Pointer; AMethod: Pointer): TMethod;
begin
  Result.Code := AMethod;
  Result.Data := AObject;
end;

end.