unit typutil;  // misc

{$mode ObjFPC}{$H+}
// Guideposts @ foot/laz/menu/

interface

  { * Web resources:
    www.freepascal.org/docs-html/ref/ref.html
    www.freepascal.org/docs-html/prog/prog.html }

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
    A_FIXD_N = 0;

type
  { * Web resources:
    www.freepascal.org/docs-html/prog/progse32.html#progsu158.html
    www.freepascal.org/docs-html/rtl/system/qword.html
    www.freepascal.org/docs-html/rtl/system/longword.html }

  proj_e = (p_juju, p_dojo);
  { * The ecosystem aims to support text, 2d, 3d and their hybridization.
    * By complexity level:
      - TXT/TUI:  juju
      adventure, crpg, roguelike, mud,

      - 2D/2.5D/3D/GUI:  juju, hood
      platformer, hack n' slash, shooter, fighter
  }

  // Type aliasing
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
    //
    real_t = double;
  {$ENDIF}

  // For text based games/utils:  myst, rpg
  // ..chars
  az_upp_t = 'A'..'Z';
  az_low_t = 'a'..'z';
  // ..strings
  str  = string;
  // ..arrays
  str_a  = array of string;
  var_a  = array of variant;
  var_af = array [0..A_FIXD_N] of variant;
  poi_a  = array of pointer;
  // ..pointers
  int_p  = PInteger;
  str_p  = PString;
  bool_p = PBoolean;

  lang_e = (l_eng, l_fin);

  // Typed subroutines
  proc_str_t = procedure (const arg:  str);
  proc_oo = procedure of object;

  { (arg)ument }

  proc_t = procedure ();

  arg_t = record
    proc:  proc_t;
    id:  str;
  end;

  arg_e = (a_none, a_exec, a_help, a_bugrep);
  arg_a = array of arg_t;

  proc_sa_a = procedure (const args: array of str);
  proc_a = array of proc_t;
  proc_af = array [arg_e] of proc_t;

  { env_t }

  env_t = record
    user_id, term_id:  str;
  end;

  { url_t }

  url_t = record
    lpart:  str_a;
  end;

  { box_t }

  box_t = record
    w, h:  int;
    rat:  f32;
  end;

var
  { * Web resources:
    www.freepascal.org/docs-html/current/ref/refse23.html#x54-740004.3 }
  procs:  proc_af;


  arg: arg_t;
  a: arg_a;

  // ..arrays
  pa:  poi_a;

  g_vars:  arg_a;
  // ..
  //g_vars:  arg_a = (
  //  (proc: @at_exec;  id: 'exec'));

  g_vars_:  array of record // sh-space:  great for auto complete etc.
    proc:  proc_t;
    id: str;
  end;


  { (poi)nter }


  { args - auto create local var by filling in 'a',  ctrl-sh-c }

  procedure args_init (var a:  arg_a);
  procedure args_pop_e (var a:arg_a;  const t:arg_t);

  { procs }

  procedure proc_at (e:  arg_e;  p:  proc_t);

  { (de)bug }
  procedure de_bark_swe_wc (const a:  array of widechar);
  procedure de_bark_ln (s: str = '');
  procedure de_bark_blk (s: str;  head: str = 'FILL UP';  sym: str = ':');
  procedure de_bark_env (e:  env_t);

implementation


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

procedure proc_at (e:  arg_e;  p:  proc_t);
begin
  procs[e]:=p;
  //  call:  proc_at (a_exec, @bark_hey);
  // ..use procs where and how you want
end;


{ (poi)nter }


{ (de)bug }

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

end.

