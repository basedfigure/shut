unit typutil;  // misc

{$mode ObjFPC}{$H+}
{$DEFINE TWO_CHAR_EMOJI} // fpc -dTWO_CHAR_EMOJI
// Guideposts @ foot/laz/menu/

interface


  { * Style guide (e.g):
  Abbreviate block to blk, when you don't mean a memory block (mem), but to mean
  something more disambiguous without context, like a comment block (str) Pascal
  vs. C stylistically and in code: I use a mixed style of C and Pascal in my nam
  ing schemes, but not just as a preference, but because to my mind the order th
  at things appear in a coding style matters,  especially when reading code back
  later on. Also, many Pascal users forego prefixing arrays, as an example. I do
  n't like other prefixes other than the TClass for solely class names. Typicall
  y people mix and match prefixes and omissions, so i just switched to a differe
  nt style altogether. My style lends itself to C portability. I don't use class
  based structures, unless i need to use them for something specifically and whe
  n i've exhausted all other options at my disposal, but it's never that cut and
  dry. I prefer Free Pascal for how many options it still gives you, off the get
  go, with just the common tooling and native libraries. I don't mind the verbos
  ity in Pascal and i like that it's not case sensitive and you might like my st
  yle better if you prefer a case sensitive language.  I like that it's widely u
  sed due to early adoption, but is not popular, among certain types of programm
  ers, so there is nothing special to it, like there is not in C. By paraphrasin
  g Linus Torvalds who once said that he prefers C so C++ programmers are not in
  clined to overcomplicate his creations, whereas i prefer Pascal to overcomplic
  ate the transition to C to C++ :P, because nothing is magic, as all three of u
  s would agree. It was the first programming language i got into. Finally there
  are a lot more C compilers that have annoying licensing restrictions,  such as
  Watcom or OpenWatcom, with a lot of splintering in who understands what, about
  each project, so there is less room for interpretation, when it comes to stayi
  ng under one official compiler, with a RAD IDE, that i can confidently say has
  no equal:  Lazarus

  Auto completion:
  By using underscores you can utilize those by writing "mem_" or "_nc" and by h
  itting ctrl-space, to see just your specific results, instead of a long list o
  f them, which would happen if you just wrote "mem" or "nc" instead, so it tigh
  tens and delims the scope of your namespaces in length and symbols

  * Dojo:
  More on Pascal, C binding, porting and other stuff included in Dojo (url):
  codeberg.org/basedfigure/dojo
  I want to make it a programmer's retreat,  that has all the tricks right at yo
  ur fingertips and a place to spin up any concept into life, for anyone, from b
  eginners to vets, so i'll always have that one happy place to write to and fro
  m.

  All my projects are living projects and i've done a lot of shit in my life, wh
  ich i'm not going to info dump or share as is,  without distilling it into its
  essence. I'm a philosophical writer & programmer, not a production programmer,
  so it may not be the kind of library you might be looking for, hihi. As for an
  y retrocoding stuff, i won't do it purely out of novelty, but to keep the prac
  tice & skillset alive in general, without sinistrality. Note that i'm fairly a
  nti-competetive,  but i still keep things close to my chest,  should i want to
  or need to, but everything i work on has a rhyme or reason, as is human nature
  but i'm also the god of my own universe. So, Dojo's essence is dualistic in na
  ture on the how and why of building universes. I don't do any one thing just b
  ecause i want to do it better or differently, from someone else,  because many
  of those "someone else's" don't even exist, in what i do. As the villainous Ir
  enicus would put it in the opening scene of Baldur's Gate 2:  "You have much u
  ntapped power.", as he tortures your character, with his spells, which i first
  heard when i beat the game as a kid, and later on found out that said line cap
  tures the essence of everyone's coexistence very well, in the equation of what
  we call:  Life.

  Do your own things in order & chaos.

  * Git commit message style guide:  wip
  1) Routine, description
  or..
  2) resync with muh batches


  * Coding paces:  noob <-> pro
   - time yourself or not
  1) learning code, technique, library
  2) cozy home night
  3) happy hour
  4) crunch (hit list)
  5) baby wife 'bout to pop
  6) slave cave labor, before cave in


  * Programming styles:
  X) Librarian
  X) Preservative
  X) Productionista

  Some of this may set you on the right path, some may set me on the right path.
  Picking up the pace.

  Ffortless
  }

uses
  Classes, SysUtils;

const
    GIT_URL   = 'https://github.com/basedfigure/juju';
    IO_PATH_R = '../../../io/';
    SH_PATH_R   = '../../../sh/';

    // Conventions:
    FIXD_N_A = 0;


type

  // Type aliasing
  int  = integer;
  str  = string;
  bool = boolean;
  // ..arrays
  str_a  = array of string;
  var_a  = array of variant;
  var_af = array [0..FIXD_N_A] of variant;
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

  proc_af = array [arg_e] of proc_t;

  arg_a = array of arg_t;

  { env_t }

  env_t = record
    user_id, term_id:  str;
  end;

var
  proc_a:  proc_af;  // directives to use fixed or non

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
  proc_a[e]:=p;
  //  call:  proc_at (a_exec, @bark_hey);
end;


{ (poi)nter }


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
  Writeln ('');
  Writeln ('User: ' + e.user_id);
  Writeln ('Term: ' + e.term_id);
  Writeln ('');
end;

end.

