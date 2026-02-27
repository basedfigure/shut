unit typutil;  // misc

{$mode ObjFPC}{$H+}
// wiki.freepascal.org/Compiler_Mode
// wiki.freepascal.org/modeswitches

//{$PACKRECORDS n}
// - www.freepascal.org/docs-html/3.0.0/prog/progsu60.html
{$DEFINE DE_PROF}
{$DEFINE CPU64}



interface

  { * Web resources:
    www.freepascal.org/docs-html/current/ref/ref.html
     - www.freepascal.org/docs-html/ref/ref.html
    www.freepascal.org/docs-html/prog/prog.html

    * by Marco van de Voort:
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
    A_FIXD_N = 0;

    // ..(mem)
    MEM_KB = 1024;  // 1 KiB
    MEM_MB = 1024 * MEM_KB;  // 1 MiB

    MEM_64K = 64 * MEM_KB;  // 64 KiB
    MEM_256K = 256 * MEM_KB;  // 256 KiB
    MEM_1MB = MEM_MB;  // 1 MiB

    MEM_PAGE_OS = 4 * MEM_KB;  // 4 KiB

type
  { * Web resources:
    www.freepascal.org/docs-html/prog/progse32.html
    www.freepascal.org/docs-html/rtl/system/qword.html
    www.freepascal.org/docs-html/rtl/system/longword.html
    www.freepascal.org/docs-html/ref/refse15.html
    wiki.freepascal.org/Pointer}

  proj_e = (p_juju, p_dojo, p_hood);
  { * The ecosystem aims to support text, 2d, 3d and their hybridization.
    * By complexity level:
      - TXT/TUI:  juju
      adventure, crpg, roguelike, mud,

      - 2D/2.5D/3D/GUI:  juju, hood
      platformer, hack n' slash, shooter, fighter
  }



  // Type aliasing
  // - wiki.freepascal.org/Memory_Management


  // ..pointers
  {$IFDEF DE_PROF}
    {$IFDEF CPU64}
      mem_p = QWord;
    {$ELSE}
      mem_p = Cardinal;  // 32-bit
    {$ENDIF}
  {$ENDIF}

  int_p  = PInteger;
  str_p  = PString;
  bool_p = PBoolean;
  poi    = pointer;

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
  str_a  = array of string;
  var_a  = array of variant;
  var_af = array [0..A_FIXD_N] of variant;
  poi_a  = array of pointer;

  lang_e = (l_eng, l_fin);



  // Typed subroutines



  proc_str_t = procedure (const arg:  str);
  proc_oo = procedure of object;

  proc_t = procedure ();
  proc_sa_t = procedure (const args: array of str);



  // Records & object types
  // wiki.freepascal.org/Record
  // wiki.freepascal.org/Object



  { mem_t }

  mem_t = record
    foot, at, fin_:  PByte;
    {$IFDEF DE_PROF}
      size, peak, nbump:  mem_p;
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
  proc_af = array [arg_e] of proc_t;

  { url_t }

  url_t = record
    lpart:  str_a;
  end;

  { box_t }

  box_t = record
    w, h:  int;
    rat:  f32;
  end;

  { env_t }

  env_t = record
    user_id, term_id:  str;
  end;


var
  { * Web resources:
    www.freepascal.org/docs-html/current/ref/refse23.html }
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

  g_mem:  mem_t;



  // Routines



  { (mem) arena }
  procedure mem_boot (var m:mem_t;  big:mem_p);
  procedure mem_null (var m:mem_t);
  procedure mem_kill (var m:mem_t);
  procedure mem_zero (var m:mem_t);
  function  mem_bump (var m:mem_t;  big: mem_p):  poi;

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



{ (mem) arena }



procedure mem_boot (var m:mem_t;  big:mem_p);
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

function mem_bump (var m:mem_t;  big:mem_p):  poi;
var
  p:  PByte;
begin
  if m.at + big > m.fin_ then Exit (nil);

  p:=m.at;
  Inc (m.at, big);
  {$IFDEF DE_PROF}
    //
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



procedure proc_at (e:  arg_e;  p:  proc_t);
begin
  procs[e]:=p;
  //  call:  proc_at (a_exec, @bark_hey);
  // ..use procs where and how you want
end;



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

