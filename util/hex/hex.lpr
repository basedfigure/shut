program hex;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes,
  crt,
  ncurses,
  // Juju:
  typutil, apputil, ncutil, fmtsak;

const

  KLAW_PATH_B = UTIL_PATH_R + 'klaw/laz/';
var
  arg: arg_t;
  a: arg_a;

procedure bark_wai_fu (const emoji:  str = '<3');
{ Wrap her in a gift box }
begin
  // Lily padding (dojo):  step

  args_init (g_vars);
  g_vars[0].id:='Unromance +6';

  arg.id:='ncurses is my bitch';
  args_pop_e (g_vars, arg);

  arg.id:='scull size -13 in.';
  args_pop_e (g_vars, arg);

  arg.id:=
    'The basics are sometimes all you need to look good, in bitchcraft <3';
  args_pop_e (g_vars, arg);

  arg.id:=emoji;
  args_pop_e (g_vars, arg);
end;

begin
  bark_wai_fu (HEART_MOJ);

  g_env.user_id:=USER_NAME_DE;
  g_env.term_id:=TERM_NAME_DE;

  de_print_env (g_env);
  de_print_ln ('Console program compile times are quick, oooh!');
   // Ask for options and whether to configure a new user, remember 4 later typa
   //
   // Usage (just write):  klaw, firefox ...
   run_cli (g_env,
            [@exec_app, KLAW_PATH_B + 'klaw',
             @exec_app, '/mnt/dump_dsk/INST/firefox/firefox']);


   // Screens @ foot/:
   // codeberg.org/basedfigure/foot/src/branch/main/laz/hex
end.

