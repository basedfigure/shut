unit typutil;  // main

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
  typmisc, jujuinfo;

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
   { jujuinfo has more on the ecosystem and games, in general.
      - (do):  console print, to informally "formalize" them, to some capacity.}


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

  g_view:  virt_view_t;


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

  { * (Sub)routines (prefixes):  sys, by data, algo, tech
    # unit/code:  id

    root:  message (bark),  dialogue (tree),  container (cont)
    mem:   memory arena (mem),
    run:   instance (ego),  triggers (trig),  projectiles (ammo), effects (fx)

    kit:   keyboard (keeb),  game (pad),  joystick (joy)
    bass:  OpenAL (al),  Vorbis (ogg),  Waveform (wav)

    math:  unit2d, unit3d, unitmod, unitmath, vectors (xyz), matrices (m16) ...
    draw:  OpenGL (gl),  viewport (port),  lighting (lamp),  shadows (dark)
    fmt:   art (mod),  fig (mod)
    bone:  armature (arma),  skinning (skin),  animation (cut)
    sim:   geo (hit), bodies (mass), convex (hull), space (grav), cloth (garb)
    area:  exterior (zone),  indoors (door)
    navi:  fog of war (fog),  culling (cull),  line of sight (los)
    ai:    brain/behavior (psy),  pathfinding (path)
    ;;

    ; code:  by part
    mech_vs_
     or..
    syst_vs_
     and..
    game_vs_


    like..

    band_vs_law_do_give_up_arm_upon (ban:  depo_s)
     and..
    de_band_dump_ego (e:ego_e;  r:role_e;  f:flag_e):  int;
    ;;


    * Utilities & apps (suffixes):
    util:  tui/gui utility (small program)

    tui:  ncurses (nc), command line (cli)
    util:  map editor (area),  instance editor (ego),  exporter (save),
           importer (load)

    * wiki:
    nc:    en.wikipedia.org/wiki/Ncurses

    gui:
    rtl:   en.wikipedia.org/wiki/Free_Pascal_Runtime_Library
    fcl:   en.wikipedia.org/wiki/Free_Component_Library
    lcl:   en.wikipedia.org/wiki/Lazarus_Component_Library

    draw (gpu):
    gl:    en.wikipedia.org/wiki/OpenGL
    vk:    en.wikipedia.org/wiki/Vulkan

    math:
    quat:  quaternion

    sim:
    hit:   en.wikipedia.org/wiki/Bounding_volume
           en.wikipedia.org/wiki/Minimum_bounding_box
    mass:  en.wikipedia.org/wiki/Rigid_body
           en.wikipedia.org/wiki/Rigid_body_dynamics
    hull:  en.wikipedia.org/wiki/Convex_hull

    bass:
    al:    en.wikipedia.org/wiki/OpenAL
    midi:  en.wikipedia.org/wiki/MIDI
    wav:   en.wikipedia.org/wiki/WAV
    ogg:   en.wikipedia.org/wiki/Vorbis
  }


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

  { (rgba) color }

  function rgba_from_hex (const hex:  cardinal):  rgba_t;
implementation



{ (bit)shift }



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



{ (rgba) color }



function rgba_from_hex (const hex:  cardinal):  rgba_t;
begin
  with result do begin
    r:=((hex shr 16) and $FF) / 255.0;
    g:=((hex shr 8) and $FF) / 255.0;
    b:=(hex and $ff) / 255.0;
    a:=0.0;
  end;
end;

end.

