unit fmtsak;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,
  // Juju:
  typutil, fmtutil;

const
  ROPE_SAK   = IO_PATH_R + 'rope.sak';

type

  { sak_t - structured array of knowledge, format }

  sak_t = object
    id: str;
    f: TStringList;
    inp_fields:  array of str;

    constructor init;
    destructor  kill;
    { Proc }
    procedure save_to_disk (const path: str);
    { Func }
    function  load_fr_disk (const path: str):  bool;
    function  scan_comment_lns (const s:  str):  TStringList;
    function  scan_curly_blks (const s:  str):  TStringList; { + }
  end;

implementation


constructor sak_t.init;
begin
  f:=TStringList.Create;
  f.NameValueSeparator:=':';
end;

destructor sak_t.kill;
begin
  f.Free;
end;

procedure sak_t.save_to_disk (const path: str);
var
  i: int;
  rl: TStringList;
begin
  rl:=TStringList.Create;

  // rope.sak header
  try rl.Add('rope.sak - ties data, paths together');
      rl.Add('');
  //

  for i:=0 to f.Count-1 do
    rl.Add (f.Names[i] + ': ' + f.ValueFromIndex[i]);
    rl.SaveToFile (path);

  finally rl.Free;
  end;
end;

function sak_t.load_fr_disk (const path: str): bool;
var
  rl: TStringList;
  k, v, l, base: str; // Key, value pair on line (k,v,l).
  i, cur: int;
begin

  f.Clear;
  result:=false;
  base:='';

  if not FileExists (path) then Exit;

  rl:=TStringList.Create;
  try
    rl.LoadFromFile (path);

    for i:=0 to rl.Count-1 do begin
      l:= Trim (rl[i]);
      if l = '' then Continue;

      { Base }
      if (l[1] = '/') and (Pos (':', l) = 0) then begin
        base:=l;
        Continue;
      end;

      cur:=Pos (':', l);
      if cur > 0 then begin
        k:=Trim (Copy (l, 1, cur - 1));
        v:=Trim (Copy (l, cur + 1,  Length (l)));
        f.Values [LowerCase (k)]:=combine_paths (base, v);

        de_print_blk (v, 'PROJECT');

      end;
    end;

    result:=true;

  finally
    rl.Free;
  end;

end;

function sak_t.scan_comment_lns (const s:  str):  TStringList;
var
  l:  TStringList;
  i, on_pos: int;
begin
  result:=TStringList.Create;
  l:=TStringList.Create;

  try
    l.Text:=s;

    for i:=0 to l.Count-1 do begin
      on_pos:=Pos ('//', l[i]);
      if on_pos > 0 then
        result.Add (Copy (l[i], on_pos, MaxInt));
    end;

  finally
    l.Free;
  end;

end;

function sak_t.scan_curly_blks (const s:  str):  TStringList;
{ perv%, i love all women }
var
  i:  int;
  is_in:  bool;
  ass:  str;
begin
  result:=TStringList.Create;
  is_in:=false;
  ass:='';

  for i:=1 to Length (s) do begin
    if s[i] = '{' then begin
      is_in:=true;
      ass:='';
      Continue;
    end;

    if (s[i] = '}') and is_in then begin
      result.add (ass);
      is_in:=false;
      Continue;
    end;

    if is_in then ass:=ass + s[i];
  end;
end;

end.

