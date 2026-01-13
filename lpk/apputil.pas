unit apputil;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, process,
  // Juju:
  typutil;

const
  USER_NAME_D  = 'Shaman';
  TERM_NAME_D  = 'Hex';
  UTIL_PATH_R = '../';

  procedure run_cli (const args: array of const);
  function ask_user_to_confirm (const q: str): bool;
  procedure run_app (const path: str);

type
  proc_str_t = procedure (const arg: str);

implementation

function trunc_bin (const path: str): str;
begin
  result:=LowerCase (ExtractFileName (path));
end;

procedure run_cli (const args: array of const);
{ du:  magic recipes, pool resources, tissues }
var
  cmd: str;
  i: int;
  found: bool;
begin
  while true do begin
   Write (USER_NAME_D + '@' + TERM_NAME_D + '> ');
   ReadLn (cmd);
   cmd:=LowerCase (Trim (cmd));

   found:=false;

   for i:=0 to High (args) div 2 do begin
    if (args[i*2].VType = vtPointer) and
       (args[i*2+1].VType = vtAnsiString) and
       (cmd = trunc_bin (str (args[i*2+1].VAnsiString))) then
    begin
      proc_str_t (args[i*2].VPointer)
       (str (args[i*2+1].VAnsiString));

      found:=true;
      Break;
    end;
   end;

    if not found then WriteLn ('Unknown command.');

  end;
end;

function ask_user_to_confirm (const q: str): bool;
var
  a: str;
begin
  Write (q, ' [y/n]: ');
  Readln (a);
  result:=(LowerCase (a) = 'y');
end;

procedure run_app (const path: str);
var
  proc: TProcess;
  app_dir: str;
begin
  if not FileExists (path) and (Pos ('/', path) > 0) then raise
   Exception.Create ('App not located: ' + path);

  app_dir:=ExtractFilePath (ExpandFileName (path));

  proc:=TProcess.Create (nil);
   try
     with proc do begin
      Executable:=ExpandFileName (path);
      CurrentDirectory:=app_dir;
      Options:=[poNoConsole];
      Execute;
     end;
   finally
     proc.Free;
   end;
end;

end.

