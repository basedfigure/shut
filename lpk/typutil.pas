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

