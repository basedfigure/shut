program term;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes,
  crt,
  // Juju:
  typutil, apputil;

const
  KLAW_PATH_B = UTIL_PATH_R + 'klaw/laz/';

begin
  de_print_env (USER_NAME_D, TERM_NAME_D);
  de_print_ln ('Console program compile times are quick, oooh!');
   // Ask for options and whether to configure a new user, remember 4 later typa

   // Just write:  klaw, firefox ...
   run_cli([@run_app, KLAW_PATH_B + 'klaw',
            @run_app, '/mnt/dump_dsk/INST/firefox/firefox']);
end.

