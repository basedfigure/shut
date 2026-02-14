unit typutil;

{$mode ObjFPC}{$H+}
{$DEFINE TWO_CHAR_EMOJI} // fpc -dTWO_CHAR_EMOJI
// Guideposts @ foot/laz/menu/

interface

uses
  Classes, SysUtils;

const
  GIT_URL   = 'https://github.com/basedfigure/juju';
  IO_PATH_R = '../../../io/';
  SH_PATH_R   = '../../../sh/';

type
  // * Style guide (e.g):
  // Abbreviate block to blk, when you don't mean a memory block (mem), but to m
  // ean something more disambiguous without context, like a comment block (str)
  //
  // Pascal vs. C stylistically and in code:
  // I use a mixed style of C and Pascal in my naming schemes, but not just as a
  // preference, but because to my mind the order that things appear in a coding
  // style matters, especially when reading code back later on. Also, many Pasca
  // l users forego prefixing arrays, as an example. I don't like other prefixes
  // other than the TClass for solely class names. Typically people mix and matc
  // h prefixes and omissions, so i just switched to a different style altogethe
  // r. My style lends itself to C portability. I don't use class based structur
  // es, unless i need to use them for something specifically and when i've exha
  // usted all other options at my disposal, but it's never that cut and dry.  I
  // prefer Free Pascal for how many options it still gives you, off the get go,
  // with just the common tooling and native libraries.
  // I don't mind the verbosity in Pascal and i like that it's not case sensitiv
  // e and you might like my style better, if you prefer a case sensitive langua
  // ge. I like that it's widely used due to early adoption, but is not popular,
  // among certain types of programmers, so there is nothing special to it, like
  // there is not in C. By paraphrasing Linus Torvalds who once said that he pre
  // fers C so C++ programmers are not inclined to overcomplicate his creations,
  // whereas i prefer Pascal to overcomplicate the transition to C to C++ :P, be
  // cause nothing is magic, as all three of us would agree.
  // It was the first programming language i got into. Finally there are a lot m
  // ore C compilers that have annoying licensing restrictions, such as Watcom o
  // r OpenWatcom, with a lot of splintering in who understands what, about each
  // project, so there is less room for interpretation, when it comes to staying
  // under one official compiler, with a RAD IDE, that i can confidently say has
  // no equal:  Lazarus
  //
  // Auto completion:
  // By using underscores you can utilize those by writing "mem_" or "_nc" and b
  // y hitting ctrl-space, to see just your specific results,  instead of a long
  // list of them, which would happen if you just wrote "mem" or "nc" instead, s
  // o it tightens and delims the scope of your namespaces in length and symbols
  //
  // * Dojo:
  // More on Pascal, C binding, porting and other stuff included in Dojo (url):
  // codeberg.org/basedfigure/dojo
  //
  // I want to make it a programmer's retreat,  that has all the tricks right at
  // your fingertips and a place to spin up any concept into life, for anyone fr
  // om beginners to vets, so i'll always have that one happy place to write to
  // and from. All my projects are living projects and i've done a lot of shit i
  // n my life, which i'm not going to info dump or share as is, without distill
  // ing it into its essence. I'm a philosophical writer & programmer, not a pro
  // duction programmer, so it may not be the kind of library you might be looki
  // ng for, hihi. As for any retrocoding stuff, i won't do it purely out of nov
  // elty, but to keep the practice & skillset alive in general, without sinistr
  // ality.
  //
  // Note that i'm fairly anti-competetive,  but i still keep things close to my
  // chest, should i want to or need to, but everything i work on has a rhyme or
  // reason, as is human nature, but i'm also the god of my own universe. So, Do
  // jo's essence is dualistic in nature on the how and why of building universe
  // s. I don't do any one thing just because i want to do it better or differen
  // tly, from someone else, because many of those "someone else's" don't even e
  // xist, in what i do.
  //
  // As the villainous Irenicus would put it in the opening scene of Baldur's Ga
  // te 2:  "You have much untapped power.", as he tortures your character, with
  // his spells, which i first heard when i beat the game as a kid, and later on
  // found out that said line captures the essence of everyone's coexistence ver
  // y well, in the equation of what we call:  Life.
  //
  // Do your own things.
  //
  // * Git commit message style guide:  wip
  // 1) Routine, description
  // or..
  // 2) resync with muh batches
  //
  // Ffortless


  // Type aliasing
  int  = integer;
  str  = string;
  bool = boolean;
  // ..arrays
  str_a  = array of string;
  var_a  = array of variant;
  poi_a  = array of pointer;
  // ..pointers
  int_p  = PInteger;
  str_p  = PString;
  bool_p = PBoolean;

  // Typed subroutines
  proc_str_t = procedure (const arg:  str);


  { (arg)ument }

  arg_t = record
    proc:  proc_str_t;
    id:  str;
  end;

  arg_a = array of arg_t;

  { env_t }

  env_t = record
    user_id, term_id:  str;
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

var
  // Global variables
  pa:  poi_a;
  // ..arrays
  g_vars:  arg_a; // = (
    //(proc: @cmd_exec;  id: 'exec';  group:  g_exec);

  { (poi)nter }


  { (de)bug }
  procedure de_print_ln (s: str = '');
  procedure de_print_blk (s: str;  head: str = 'FILL UP';  sym: str = ':');
  procedure de_print_env (e:  env_t);
implementation


{ (poi)nter }



{ (de)bug }

procedure de_print_ln (s: str = '');
begin
  Writeln (s);
end;

procedure de_print_blk (s: str;  head: str = 'FILL UP';  sym: str = ':');
begin
  Writeln ('');
  Writeln (head + sym);
  Writeln (s);
end;

procedure de_print_env (e:  env_t);
begin
  Writeln ('');
  Writeln ('User: ' + e.user_id);
  Writeln ('Term: ' + e.term_id);
  Writeln ('');
end;

end.

