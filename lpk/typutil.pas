unit typutil;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

const
  GIT_URL   = 'https://github.com/basedfigure/juju';
  IO_PATH_R = '../../../io/';
  SH_PATH_R   = '../../../sh/';

type
  // Style guide (e.g):
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


var
  // Global variables
  pa:  poi_a;
  // ..arrays
  g_vars:  arg_a;

  { (poi)nter }


  { (de)bug }
  procedure de_print_ln (s: str = '');
  procedure de_print_blk (s: str;  head: str = 'FILL UP';  sym: str = ':');
  procedure de_print_env (user, term: str);
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

procedure de_print_env (user, term: str);
begin
  Writeln ('');
  Writeln ('User: ' + user);
  Writeln ('Term: ' + term);
  Writeln ('');
end;

end.

