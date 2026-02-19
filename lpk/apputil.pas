unit apputil;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, process,
  // Juju:
  typutil, ncutil, ncurses;

const
  UTIL_PATH_R = '../';

  USER_NAME_DE  = 'Shaman';
  TERM_NAME_DE  = 'Hex';



  { Proc }
  procedure run_cli (e: env_t;  const args: array of const);
  procedure run_cli_nc (const args:  arg_a);
  procedure exec_app (const path: str);
  { Func }
  function ask_user_to_confirm (const q: str): bool;

var
  // Global variables
  g_env:  env_t;

implementation


function trunc_bin (const path: str): str;
begin
  result:=LowerCase (ExtractFileName (path));
end;

procedure run_cli (e: env_t;  const args: array of const);
{ du:  magic recipes, pool resources, tissues }
var
  cmd, user, term: str;
  i,  nc_on_ln: int;
  found: bool;
  ch:  smallint;
begin
  user:=e.user_id;
  term:=e.term_id;

  nc_on_ln:=0;
  init_nc;

  while true do begin


   case ch of KEY_DOWN, Ord('j'):  Inc (nc_on_ln);
    end;

   case ch of KEY_UP, Ord('k'):  Dec (nc_on_ln);
    end;

   draw_nc ('', g_vars, nc_on_ln);
   ch:=getch;

   //Write (user + '@' + term + '> ');
   //ReadLn (cmd);
   //cmd:=LowerCase (Trim (cmd));
   //
   //found:=false;

   //for i:=0 to High (args) div 2 do begin
   // if (args[i*2].VType = vtPointer) and
   //    (args[i*2+1].VType = vtAnsiString) and
   //    (cmd = trunc_bin (str (args[i*2+1].VAnsiString))) then
   // begin
   //   proc_str_t (args[i*2].VPointer)
   //    (str (args[i*2+1].VAnsiString));
   //
   //   found:=true;
   //   Break;
   // end;
   //end;

    if not found then WriteLn ('Unknown command.');

  end;

end;

procedure run_cli_nc (const args:  arg_a);
begin

end;

procedure exec_app (const path: str);
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

function ask_user_to_confirm (const q: str): bool;
var
  a: str;
begin
  Write (q, ' [y/n]: ');
  Readln (a);
  result:=(LowerCase (a) = 'y');
end;

end.

