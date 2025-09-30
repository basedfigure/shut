unit fmtutil;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,
  // Shut:
  typutil;

  procedure scan_fold_paths_in_top_dir(const path:      str; sl: TStrings);
  procedure scan_file_paths_in_subdirs(const path, msk: str; sl: TStrings);
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

procedure scan_file_paths_in_subdirs(const path, msk: str; sl: TStrings);
begin

end;

end.

