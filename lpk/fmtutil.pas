unit fmtutil;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,
  // Juju:
  typutil;

  procedure scan_fold_paths_in_top_dir(const path:      str; sl: TStrings);
implementation

procedure scan_fold_paths_in_top_dir(const path: str; sl: TStrings);
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

end.

