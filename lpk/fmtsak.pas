unit fmtsak;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,
  // Juju:
  typutil, fmtutil;

const
  ROPE_SAK   = IO_PATH_R + 'rope.sak';

  // syntax routine, that prints all basic rules for sak. should tie together
  // with certain posts, with some tokens

type

  { sak_t - structured array of knowledge, format }

  sak_t = object
    id: str;
    lf: TStringList;
    inp_fields:  array of str;

    constructor init;
    destructor  done;
    { Proc }
    procedure save_to_disk (const path: str);
    { Func }

    function load_fr_disk_to_str (const path:str;  out d:str;
      const is_dir_for_only_sak:  bool=false): bool;
    function load_fr_disk (const path: str; out d: str):  bool;  {//}

    function scan_tit_lns (const s: str): TStringList;
    function scan_text_blks (const s: str): TStringList; { + }
    function skip_nest_of_curl_blks (const d: string): TStringList;
  end;

implementation


constructor sak_t.init;
begin
  lf:=TStringList.Create;
  lf.NameValueSeparator:=':';
end;

destructor sak_t.done;
begin
  lf.Free;
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

  for i:=0 to lf.Count-1 do
    rl.Add (lf.Names[i] + ': ' + lf.ValueFromIndex[i]);
    rl.SaveToFile (path);

  finally rl.Free;
  end;
end;

function sak_t.load_fr_disk_to_str (const path: str;  out d: str;
  const is_dir_for_only_sak:  bool = false):  bool;
var
  rl:  TStringList;
begin
  d:='';
  result:=false;

  if not FileExists (path) then Exit;
  rl:=TStringList.Create;
  try
    rl.LoadFromFile (path);
    d:=rl.Text;
    result:=true;
  finally
    rl.Free;
  end;
end;

function sak_t.load_fr_disk (const path: str;  out d:  str): bool;
// this was for rope.sak initially
var
  rl: TStringList;
  k, v, l, base: str; // Key, value pair on line (k,v,l).
  i, cur: int;
begin
  d:='';

  lf.Clear;
  result:=false;
  base:='';

  if not FileExists (path) then Exit;

  rl:=TStringList.Create;
  try
    rl.LoadFromFile (path);

    d:=rl.Text;
    result:=true;

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
        lf.Values [LowerCase (k)]:=combine_paths (base, v);

        de_bark_blk (v, 'PROJECT');

      end;
    end;

    result:=true;

  finally
    rl.Free;
  end;

end;

function sak_t.scan_tit_lns (const s:  str):  TStringList;
{  scans // single line comment lines }
var
  i, on_pos:  int;
  ls:  TStringList;
  ln:  str;
  in_blk:  bool;
begin
  result:=TStringList.Create ();
  ls:=TStringList.Create ();
  in_blk:=false;

  try
    ls.Text:=s;

    for i:=0 to ls.Count - 1 do begin
      ln:=ls[i];

      if Pos ('{', ln) > 0 then begin
        in_blk:=true;
        continue;
      end;

      if Pos ('}', ln) > 0 then begin
        in_blk:=false;
        continue;
      end;

      if in_blk then continue;

      on_pos:=Pos ('//', ln);
      if on_pos > 0 then
        result.Add (Copy (ln, on_pos, MaxInt));

    end;

  finally
    ls.Free ();
  end;
end;

function sak_t.scan_text_blks (const s:  str):  TStringList;
{  scans multiline comment blocks }
var
  i:  int;
  ass:  str;
  is_in:  bool;
begin
  result:=TStringList.Create ();
  is_in:=false;
  ass:='';

  for i:=1 to Length (s) do begin

    if s[i] = '{' then begin
      is_in:=true;
      ass:='';
      continue;
    end;

    if (s[i] = '}') and is_in then begin
      ass:=Trim (ass);
      if ass <> '' then
        result.Add (ass);
      is_in:=false;
      continue;
    end;

    if is_in then
      ass:=ass + s[i];

  end;
end;

function sak_t.skip_nest_of_curl_blks (const d:  string):  TStringList;
var
  i:  int;
  blk:  str;
  nest:  int;
begin
  result:=TStringList.Create ();
  blk:='';
  nest:=0;

  for i:=1 to Length (d) do
    case d[i] of
      '{':
      begin
        Inc (nest);
        if nest = 1 then blk:='';
      end;

      '}':
      begin
        if nest = 1 then begin
          blk:=Trim (blk);
          result.Add (blk);
          Writeln ('', blk);
        end;
        if nest > 0 then Dec (nest);
      end;

    else
      if nest >= 1 then blk:=blk + d[i];
    end;
end;


end.

