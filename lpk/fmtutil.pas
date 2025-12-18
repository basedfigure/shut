unit fmtutil;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, StrUtils,
  // Juju:
  typutil;


  { Proc }
  procedure scan_fold_paths_fr_top_dir (const path: str; sl: TStrings);
  { Func }
  function combine_paths (const base, v: str):  str;
  function rip_file_or_fold_name (const path:    str):  str;
implementation

procedure scan_fold_paths_fr_top_dir (const path: str; sl: TStrings);
var
  rec: TSearchRec;
  expr: str;
begin
  expr:=IncludeTrailingPathDelimiter(ExpandFileName(path));
  sl.Clear;

  if FindFirst(expr + '*', faDirectory, rec) = 0 then begin repeat

  if (rec.Attr and faDirectory <> 0) and (rec.Name <> '.') and (rec.Name <>
    '..') then sl.Add(rec.Name);

  until FindNext(rec) <> 0;
    FindClose(rec);
  end;
end;

function combine_paths (const base, v: str):  str;
begin
  if (v = '') then  result:=''
  else if (v[1] = '/') then
    result:=IncludeTrailingPathDelimiter (base) + Copy (v, 2, MaxInt)
  else
    result:= '/' + v;
end;

function rip_file_or_fold_name (const path: str): str;
begin
  result:=ExtractFileName (ExcludeTrailingPathDelimiter (path));
end;

end.

