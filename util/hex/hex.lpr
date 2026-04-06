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
  typutil, apputil, fmtsak, barkutil, barkuser, appwiz, jujuinfo,
  typmisc, typgame;

const

  KLAW_PATH_B = UTIL_PATH_R + 'klaw/laz/';


var
  d: str;

begin
{
* Console utilities:
I use Eskil Steenberg's (YT) method of leaving code, or comments laying around,
for different reasons. He works solo and doesn't use source control but i'm not
commenting on that. I comment out stuff to structure code and describe it as a
bigger system - which my whole ecosystem relies on. Everything should start from
the console, it makes your GUI thinking better too. Browser and servers are an
afterthought for me - for really shoehorning it in. They're less safe for a user
to be in and a developer to work in. I do remove and clean up stuff on occasion.
}

   with bark_proj do begin
     init();
     {
      * Option 1:
      bark.txt   = edit file, with each bark - easier to read back and edit
      bark/*.sak = save_each_card_as_a_file  - saves barks as separate files

      - The bark sorting order and SAK preamble can differ between the two, so
      it's important to have both.
      - Good for Git and converting to separate HTML files.
     }
     load_fr_disk_to_str('../../io/bark/bark.txt', d);
     scan_tits_and_blks (d);

     save_each_card_as_a_file ('../../io/bark/sak/');
   end;

  { * Ncurses menu/tree (bark):  note that you can mmb-scroll }
  //
  // test:
  // bark_wai_fu_nc_menu (HEART_MOJ);
  //
  bark_each_card_in_sak_dir_nc_menu ();
  {
  { to-do:  + do, - done }
  - enter to open entry
  - esc to close
  + exit button to bottom, or q twice
  + open entry in vim
  + verify entries/tokens
  + create new entry

  // vi-like commands:
   + jump up (gg), jump down (sh-g)
  }
  {
  * wiki:
  en.wikipedia.org/wiki/Abstract_syntax_tree
  }

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

   //proc_at (a_exec, @bark.hey);
   //procs[a_exec](g_env.user_id);

   // Screens @ foot/:
   // codeberg.org/basedfigure/foot/src/branch/main/laz/hex
end.

