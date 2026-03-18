unit typutil;  // misc

{$mode ObjFPC}{$H+}
// wiki.freepascal.org/Compiler_Mode
// wiki.freepascal.org/modeswitches

//{$PACKRECORDS n}
// - www.freepascal.org/docs-html/3.0.0/prog/progsu60.html
{$DEFINE DE_PROF}
{$DEFINE CPU64}



interface

  { * Free Pascal contributors:
    https://www.freepascal.org/aboutus.html

    * Web resources:
    www.freepascal.org/docs-html/current/ref/ref.html
     - www.freepascal.org/docs-html/ref/ref.html
    www.freepascal.org/docs-html/prog/prog.html

    - by Marco van de Voort:
    www.stack.nl/~marcov/buildfaq.pdf
    www.stack.nl/~marcov/porting.pdf
    }

uses
  Classes, SysUtils,
  // Juju:
  typmisc;

const
    // Source code (git):
    GIT_URL   = 'https://github.com/basedfigure/juju';
    // Relative paths (juju):
    IO_PATH_R = '../../../io/';
    SH_PATH_R   = '../../../sh/';

    // Conventions:
    // ..arrays
    // www.freepascal.org/docs-html/ref/refsu14.html
    A_FIXD_N = 0; // = 1

type
  { * Web resources:
    www.freepascal.org/docs-html/prog/progse32.html
    www.freepascal.org/docs-html/rtl/system/qword.html
    www.freepascal.org/docs-html/rtl/system/longword.html
    www.freepascal.org/docs-html/ref/refse15.html
    wiki.freepascal.org/Pointer}

  proj_e = (
   p_juju,  // 1)
   p_dojo,  // 2)
   p_hood); // 3)

  { * Roughly,
    1) Juju has the console, so it serves as the engine.

    2) Dojo has the game mechanics, with my demo roguelike named dojoband.pas, t
    o serve as a TUI roguelike/adventure demo, to use with Juju. The reason to d
    o a game like this is to get to the essence of text-based adventure games an
    d roguelikes, both of which use ASCII "graphics", where both marry the stats
    and text -- programming wise and game wise. Here both projects become relati
    vely quick to test, so as to get any chinks out of the way early. I also lov
    e those genres, where they're never really used together. They have a lot of
    untapped potential, especially for the backroom codist.

    3) Hood is a graphics library for developing with 2D/3D graphics, but is aim
    ed at just supporting what you need in your specific game right now, instead
    of any latest formats or rendering techniques. I commend any library authors
    for trying to stay up with everything!

    * Routine style guide:
    dojoband draws the ASCII graphics with ncurses, so they're suffixed with _nc
    and every rogue routine is prefixed band_ so you get "band_draw_nc (glyph)"

    * The ecosystem aims to support text, 2d, 3d and their hybridization.

    * By complexity level:  wiki
    - TXT/TUI:  juju
    puzzle, adventure, crpg, roguelike, mud,

    - 2D/2.5D/3D/GUI:  juju, hood
    platformer, hack n' slash, shooter, fighter

    * wiki, e.g:  by mech/mood
     1. myst:  en.wikipedia.org/wiki/Puzzle_video_game
     2. navi:  en.wikipedia.org/wiki/Adventure_game
     3. crpg:  en.wikipedia.org/wiki/Role-playing_video_game
     4. band:  en.wikipedia.org/wiki/Roguelike
     5. mud:   en.wikipedia.org/wiki/Multi-user_dungeon
     6. tact:  en.wikipedia.org/wiki/Strategy_video_game
     7. jump:  en.wikipedia.org/wiki/Platformer
     8. hack:  en.wikipedia.org/wiki/Hack_and_slash
     9. beat:  en.wikipedia.org/wiki/Beat_'em_up
    10. gun:   en.wikipedia.org/wiki/Shooter_game
    11. hell:  en.wikipedia.org/wiki/Shoot_'em_up
    12. fray:  en.wikipedia.org/wiki/Fighting_game
               en.wikipedia.org/wiki/Platform_fighter
    13. life:  en.wikipedia.org/wiki/Life_simulation_game
    14. rts:   en.wikipedia.org/wiki/Real-time_strategy_game

     1) en.wikipedia.org/wiki/Tetris
     2) en.wikipedia.org/wiki/Deus_Ex_(video_game)
     3) en.wikipedia.org/wiki/The_Elder_Scrolls_III:_Morrowind
     4) en.wikipedia.org/wiki/Cogmind
     5) www.zuggsoft.com/index.php
     6) en.wikipedia.org/wiki/Commandos:_Behind_Enemy_Lines
     7) en.wikipedia.org/wiki/Donkey_Kong_Country_2
     8) en.wikipedia.org/wiki/Diablo_II:_Lord_of_Destruction
     9) en.wikipedia.org/wiki/Ehrgeiz
    10) en.wikipedia.org/wiki/Brothers_in_Arms_(video_game_series)
    11) en.wikipedia.org/wiki/Vampire_Survivors
    12) en.wikipedia.org/wiki/Street_Fighter_Alpha_3
        en.wikipedia.org/wiki/Dynasty_Warriors_5
    13) en.wikipedia.org/wiki/The_Sims
    14) en.wikipedia.org/wiki/StarCraft_(video_game)

    * Special mentions to:
    en.wikipedia.org/wiki/The_Legend_of_Zelda:_A_Link_to_the_Past
    en.wikipedia.org/wiki/The_Legend_of_Zelda:_Ocarina_of_Time
    en.wikipedia.org/wiki/Fallout_2
    en.wikipedia.org/wiki/Final_Fantasy_VII
    en.wikipedia.org/wiki/Final_Fantasy_VIII
    en.wikipedia.org/wiki/Final_Fantasy_IX
    en.wikipedia.org/wiki/Final_Fantasy_X
    en.wikipedia.org/wiki/Tom_Clancy's_Rainbow_Six
    en.wikipedia.org/wiki/Call_of_Duty_4:_Modern_Warfare
    en.wikipedia.org/wiki/Dark_Souls_(video_game)
    en.wikipedia.org/wiki/Darkwood
    en.wikipedia.org/wiki/Quake_(video_game)
    en.wikipedia.org/wiki/Quake_III_Arena
    stoneshard.com/wiki/Stoneshard_Wiki

    * My favorite games (quirkily perfect):
    wrpg:  en.wikipedia.org/wiki/The_Elder_Scrolls_II:_Daggerfall
    trpg:  en.wikipedia.org/wiki/Vagrant_Story
    wrpg:  en.wikipedia.org/wiki/The_Elder_Scrolls_III:_Morrowind

    Demold:  foot
    wrpg = western rpg,  immersive/freeform (also:  crpg)
    trpg = tactical rpg, immersive/systematic (also:  crpg/jrpg)

    immersive = emergent, mood, story
  }



  // Type aliasing
  // - wiki.freepascal.org/Memory_Management



  // ..pointers
  {$IFDEF DE_PROF}
    {$IFDEF CPU64}
      mem_pt = QWord;
    {$ELSE}
      mem_pt = Cardinal;  // 32-bit
    {$ENDIF}
  {$ENDIF}

  poi    = pointer;
  int_p  = PInteger;
  str_p  = PString;
  bool_p = PBoolean;

  bool = boolean;

  // ..integers
  int = integer;
  msec_t = int64;
  sec_t  = int64;
  // GetTickCount64: QWord  // ctrl-lmb to jump

  // ..floats
  // *
  // www.freepascal.org/docs-html/prog/progsu158.html
  // www.freepascal.org/docs-html/ref/refsu5.html
  f32 = single;
  f64 = double;
  f80 = extended;
  TCurrency = Currency;

  {$IFDEF CPUX86_64}
    // *
    // wiki.freepascal.org/Platform_defines
    // wiki.freepascal.org/Compiler_directive
    // www.freepascal.cn/docs-html/current/prog/progsu23.html
    real_t = f64;
  {$ENDIF}

  // For text based games/utils:  myst, rpg
  // ..chars
  az_upp_t = 'A'..'Z';
  az_low_t = 'a'..'z';

  // ..strings
  str  = string;

  // ..arrays
  int_a = array of int;
  f32_a = array of f32;
  f64_a = array of f64;
  ch_a  = array of char;
  ch_af = array [0..A_FIXD_N] of char;
  str_a  = array of string;
  str_af = array [0..A_FIXD_N] of str;
  var_a  = array of variant;
  var_af = array [0..A_FIXD_N] of variant;
  poi_a  = array of pointer;

  lang_e = (l_eng, l_fin);



  // Typed subroutines



  proc_arg_t = procedure (const arg:  str);
  proc_oo = procedure of object;
  proc_arg_oo = procedure (arg:  str) of object;

  proc_t = procedure ();
  proc_args_t = procedure (const args: array of str);



  // Records & object types
  // wiki.freepascal.org/Record
  // wiki.freepascal.org/Object
  // wiki.freepascal.org/Programming_Using_Objects
  // wiki.freepascal.org/Programming_Using_Objects_Page_2



  { mem_t }

  // ..(mem)ory arena
  mem_t = record
    foot, at, fin_:  PByte;
    {$IFDEF DE_PROF}
      size, peak, nbump:  mem_pt;
    {$ENDIF}
  end;

  { (arg)ument }

  arg_t = record
    proc:  proc_t;
    id:  str;
  end;

  { (a)rrays }

  arg_e = (a_none, a_exec, a_help, a_bugrep);
  arg_a = array of arg_t;

  proc_a = array of proc_t;
  proc_af = array [arg_e] of proc_arg_oo;

  { box_t }

  box_t = record
    w, h:  int;
    rat:  f32;
  end;

  { rgba_t }

  rgba_t = record
    r,g,b,a:  f32;
  end;

  { env_t }

  env_t = record
    user_id, term_id:  str;
  end;

  { virt_view_t }

  virt_view_t = record
    win:  box_t;
    bg:  rgba_t;
    // mouse
    curs_has_rmb_look:  bool;
    curs_move_rate:  single;
  end;

  { url_t - move:  netutil }

  http_e = (_http, _https);

  url_t = record
    http:  http_e;
    laddr:  str_a;
  end;


var
  { * Web resources:
    www.freepascal.org/docs-html/current/ref/refse23.html }

  // (mem)ory arena
  g_mem:  mem_t;

  procs:  proc_af;
  arg:  arg_t;

  // ..arrays
  a: arg_a;

  g_vars:  arg_a;
  // ..
  //g_vars:  arg_a = (
  //  (proc: @at_exec;  id: 'exec'));

  g_vars_:  array of record // sh-space:  great for auto complete etc.
    proc:  proc_t;
    id: str;
  end;

  // ..pointers
  pa:  poi_a;


const
    // ..(mem)ory arena
    BITS_PER_BYTE = 8;
    MEM_BYTE = 1;

    MEM_KB = 1024 * MEM_BYTE;  // 1 KiB
    MEM_MB = 1024 * MEM_KB;  // 1 MiB

    MEM_64K = 64 * MEM_KB;  // 64 KiB
    MEM_256K = 256 * MEM_KB;  // 256 KiB
    MEM_1MB = MEM_MB;  // 1 MiB

    MEM_PAGE_OS = 4 * MEM_KB;  // 4 KiB



  // Routines



  { (mem)ory arena }

  procedure mem_boot (var m:mem_t;  big:mem_pt);
  procedure mem_null (var m:mem_t);
  procedure mem_kill (var m:mem_t);
  procedure mem_zero (var m:mem_t);
  function  mem_bump (var m:mem_t;  big: mem_pt):  poi;

  { args - auto create local var by filling in 'a',  ctrl-sh-c }

  procedure args_init (var a:  arg_a);
  procedure args_pop_e (var a:arg_a;  const t:arg_t);

  { procs }

  procedure proc_at (e:  arg_e;  p:  proc_arg_oo);

  { (de)bug }
  procedure de_bark_ln (s: str = '');
  procedure de_bark_blk (s: str;  head: str = 'FILL UP';  sym: str = ':');
  procedure de_bark_env (e:  env_t);
  procedure de_bark_swe_wc (const a:  array of widechar);


implementation



{ (bit)shf }



{ (mem)ory arena }



procedure mem_boot (var m:mem_t;  big:mem_pt);
begin
  GetMem (m.foot, big);
  m.at   :=m.foot;
  m.fin_ :=m.foot + big;
  {$IFDEF DE_PROF}
    m.size :=big;
    m.peak :=0;
    m.nbump:=0;
  {$ENDIF}
end;

procedure mem_null (var m:mem_t);
begin
  m.foot:=nil;
  m.at:=nil;
  m.fin_:=nil;
end;

procedure mem_kill (var m:mem_t);
begin
  if m.foot <> nil then
    Freemem (m.foot);
  mem_null (m);
end;

procedure mem_zero (var m:mem_t);
begin
  m.at:=m.foot;
end;

function mem_bump (var m:mem_t;  big:mem_pt):  poi;
var
  p:  PByte;
begin
  if m.at + big > m.fin_ then Exit (nil);

  p:=m.at;
  Inc (m.at, big);
  {$IFDEF DE_PROF}
    Inc (m.nbump);
    if mem_pt (m.at - m.foot) > m.peak then
      m.peak:=mem_pt (m.at - m.foot);
  {$ENDIF}

  result:=p;
end;



{ args ... }



procedure args_init (var a:  arg_a);
begin
  SetLength (a, 1);
end;

procedure args_pop_e (var a:arg_a;  const t:arg_t);
var n:  int;
begin
  n:=Length (a);
  SetLength (a, n+1);
  a[n]:=t;
end;



{ procs }



procedure proc_at (e:  arg_e;  p:  proc_arg_oo);
begin
  procs[e]:=p;
  { * init, call (e.g):
    proc_at (a_exec, @bark.hey); // no need to pass arg here to hey

    procs[a_exec](g_env.user_id);
  }
end;



{ (de)bug }



procedure de_bark_ln (s: str = '');
begin
  Writeln (s);
end;

procedure de_bark_blk (s: str;  head: str = 'FILL UP';  sym: str = ':');
begin
  Writeln ('');
  Writeln (head + sym);
  Writeln (s);
end;

procedure de_bark_env (e:  env_t);
begin
  Writeln ();
  Writeln ('User: ' + e.user_id);
  Writeln ('Term: ' + e.term_id);
  Writeln ();
end;

procedure de_bark_swe_wc (const a: array of widechar);
var
  i: int;
  s:  UnicodeString;
begin
  Writeln ();
  for i:=Low (a) to High (a) do begin
    s:=a[i]; // remap
    Writeln (' Char: ', UTF8Encode (s), ' Code: ', Ord (a[i]));
  end;
  Writeln ();
end;

end.

