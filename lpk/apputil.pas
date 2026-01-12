unit apputil;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, process,
  // Juju:
  typutil;

  function ask_user_to_confirm (const msg: str): bool;
  procedure run_app (const path: str);
implementation


function ask_user_to_confirm (const msg: str): bool;
var
  repl: str;
begin
  Write (msg, ' [y/n]: ');
  Readln (repl);
  result:=(LowerCase (repl) = 'y');
end;

procedure run_app (const path: str);
var
  proc: TProcess;
  app_dir: str;
begin
  if not FileExists (path) and (Pos ('/', path) > 0) then raise
   Exception.Create ('App not located: ' + path);

  app_dir:=ExtractFilePath(ExpandFileName(path));

  proc:=TProcess.Create (nil);
   try
     with proc do begin
      Executable:=ExpandFileName(path);
      CurrentDirectory:=app_dir;
      Options:=[poNoConsole];
      Execute;
     end;
   finally
     proc.Free;
   end;
end;

end.

