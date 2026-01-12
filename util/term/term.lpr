program term;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes,
  typutil, apputil;

const
  ENV_NAME  = 'Hex';
  UTIL_PATH_R = '../';
  KLAW_PATH_B = UTIL_PATH_R + 'klaw/laz/';

begin
  de_print_blk ('Console program compile times are quick, oooh!', ENV_NAME);
  if  ask_user_to_confirm ('Do you want launch:  Klaw ?') then
   // Ask for options and whether to configure a new user, remember 4 later typa
   run_app (KLAW_PATH_B + 'klaw');
end.

