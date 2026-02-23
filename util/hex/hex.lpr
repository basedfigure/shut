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
  typutil, apputil, fmtsak, barkutil;

const

  KLAW_PATH_B = UTIL_PATH_R + 'klaw/laz/';


begin
  bark_wai_fu (HEART_MOJ);

  g_env.user_id:=USER_NAME_DE;
  g_env.term_id:=TERM_NAME_DE;

  de_bark_env (g_env);
  de_bark_ln ('Console program compile times are quick, oooh!');

   // Ask for options and whether to configure a new user, remember 4 later typa
   //
   // Usage (just write):  klaw, firefox ...
   run_cli (g_env,
            [@exec_app, KLAW_PATH_B + 'klaw',
             @exec_app, '/mnt/dump_dsk/INST/firefox/firefox']);


   // Screens @ foot/:
   // codeberg.org/basedfigure/foot/src/branch/main/laz/hex
end.

