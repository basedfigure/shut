unit apputil;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, process,
  ncurses,
  // Juju:
  typutil, ncutil, barkutil, barkuser;

const
  UTIL_PATH_R = '../';

  USER_NAME_DE  = 'Shaman';
  TERM_NAME_DE  = 'Hex';

type
  cli_mode = (nc_list, nc_read);



  { Proc }
  procedure run_cli (e: env_t;  const args: array of const);
  procedure run_cli_in_mode_nc (mode:  cli_mode;  idx:  int);
  procedure exec_app (const path: str);
  { Func }
  function ask_user_to_confirm (const q: str): bool;

var
  // Global variables
  g_env:  env_t;
  g_view:  virt_view_t;
  // ..instances
  //g_time:  TTimer;

implementation


function trunc_bin (const path: str): str;
begin
  result:=LowerCase (ExtractFileName (path));
end;

procedure run_cli (e: env_t;  const args: array of const);
{ du:  magic recipes, pool resources, tissues }
var
  cmd, user, term: str;
  i,  nc_on_ln, ch: int;
  do_run_cli, found: bool;
begin
  do_run_cli:=true;

  user:=e.user_id;
  term:=e.term_id;

  nc_on_ln:=0;
  init_nc;

  // du:  num keys to jump to any arg, but vi keys are the norm, so not always
  while do_run_cli do begin
    if nc_on_ln < 0 then
      nc_on_ln:=0

    else if nc_on_ln > High (g_vars) then
      nc_on_ln:=High (g_vars);

    draw_nc ('', g_vars, nc_on_ln);
    ch:=getch;

    case ch of
      KEY_DOWN, Ord ('j'):
        if nc_on_ln < High (g_vars) then Inc (nc_on_ln);

      KEY_UP, Ord ('k'):
        if nc_on_ln > 0 then Dec (nc_on_ln);

      10, 13:
      begin
        if (nc_on_ln >= 0) and (nc_on_ln <= High (g_vars)) then begin
          run_cli_in_mode_nc (nc_read, nc_on_ln);

          i:=0;

          repeat
            // double tap esc for instant return
            draw_nc ('[Esc] to go back', g_vars, i,
              bark_proj.lcard[nc_on_ln].tit);

            ch:=getch;

            case ch of
              KEY_DOWN, Ord ('j'):
                if i < High (g_vars) then Inc (i);

              KEY_UP, Ord ('k'):
                if i > 0 then Dec (i);
            end;

          until ch = 27;

          bark_each_card_in_sak_dir_nc_menu ();
        end;
      end;

    end;

    //if not found then WriteLn('Unknown command.');

  end;

end;

procedure run_cli_in_mode_nc (mode: cli_mode; idx: int);
var
  d: str;
  i, ln_zero, ln_end: Integer;
  ln: str;
begin
  case mode of

    nc_read:
    begin
      args_init (g_vars);

      g_vars[0].id:='';
      d:=bark_proj.lcard[idx].blk;

      i:=0;
      while i <= Length (d) do begin
        ln_zero:=i + 1;

        while (i < Length (d)) and (d[i+1] <> #10) do Inc (i);

        ln_end:=i;

        ln:=Copy (d, ln_zero, ln_end - ln_zero + 1);

        arg.id:=ln;
        args_pop_e (g_vars, arg);

        Inc (i);
      end;

      // double tap esc for instant return
      draw_nc ('[Esc] to go back', g_vars, 0);
    end;

  end;
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

