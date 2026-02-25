unit typutil;  // misc

{$mode ObjFPC}{$H+}
{$DEFINE TWO_CHAR_EMOJI} // fpc -dTWO_CHAR_EMOJI
// Guideposts @ foot/laz/menu/

interface

  { Web resources:
    https://www.freepascal.org/docs-html/ref/ref.html }

uses
  Classes, SysUtils;

const
    GIT_URL   = 'https://github.com/basedfigure/juju';
    IO_PATH_R = '../../../io/';
    SH_PATH_R   = '../../../sh/';

    // Conventions:
    // ..arrays
    A_FIXD_N = 0;
    // Å Ä Ö
    SWE_UPP_A: array[0..2] of widechar =
      (widechar ($00C5), widechar ($00C4), widechar ($00D6));
    SWE_LOW_A: array[0..2] of widechar =
      (widechar ($00E5), widechar ($00E4), widechar ($00F6));

type
  { Web resources:
    www.freepascal.org/docs-html/rtl/system/qword.html
    www.freepascal.org/docs-html/rtl/system/longword.html }

  { * The ecosystem aims to support text, 2d, 3d and their hybridization.
    * By complexity level:
      - TXT:  juju
      adventure, crpg, roguelike, mud,

      - 2D/3D:  juju, hood
      platformer, hack n' slash, shooter, fighter
  }

  // Type aliasing
  bool = boolean;

  int  = integer;
  msec = int64;
  sec  = int64;
  // GetTickCount64: QWord  // ctrl-lmb to jump

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


  // Typed subroutines
  proc_str_t = procedure (const arg:  str);
  proc_oo = procedure of object;

  { (arg)ument }

  arg_t = record
    //proc:  proc_t;
    id:  str;
  end;

  proc_sa_t = procedure (const args: array of str);
  proc_t = procedure ();

  arg_e = (a_none, a_exec, a_help, a_bugrep);

  proc_a = array of proc_t;
  proc_af = array [arg_e] of proc_t;

  arg_a = array of arg_t;

  { env_t }

  env_t = record
    user_id, term_id:  str;
  end;

var
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

const
  // ASCII emojis:  en.wikipedia.org/wiki/List_of_emoticons
  {$IFDEF TWO_CHAR_EMOJI}
    SMILE_MOJ = ':)';
    SMILE2_MOJ = ':]';
    FROWN_MOJ = ':(';
  {$ELSE}
    SMILE_MOJ = ':-)';
    SMILE2_MOJ = ':-]';
    FROWN_MOJ = ':-(';
  {$ENDIF}
    HEART_MOJ = '<3';


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

