unit typutil;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

const
  GIT_URL   = 'https://github.com/basedfigure/juju';
  IO_PATH_R = '../../../io/';
  SH_PATH_R   = '../../../sh/';


  // Consoles:
  {
  To change the console you want, hit the Run's arrow button, Run Parameters...
  [x] Use launching application

  TDE has options for Xterm and Konsole in the below dropdown box
  }

  // lib folder bugfix
  {
  if you get scoping bugs, after updating your lpk or unit paths, you should del
  ete your lib folder for that project and recompile
  }


type
  // Type aliasing
  int  = integer;
  str  = string;
  bool = boolean;

  procedure de_print_ln (s: str = '');
  procedure de_print_blk (s: str;  head: str = 'FILL ME';  sym: str = ':');
  procedure de_print_env (user, term: str);
implementation

procedure de_print_ln (s: str = '');
begin
  Writeln (s);
end;

procedure de_print_blk (s: str;  head: str = 'FILL ME';  sym: str = ':');
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

