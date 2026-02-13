unit ncutil; { sak }

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,
  ncurses,  // Install (apt):  libncurses-dev
  // Juju:
  typutil;


  procedure init_nc;
  procedure draw_nc (on_ln:  int);
implementation

procedure init_nc;
begin
  initscr;
  cbreak;
  noecho;
  keypad (stdscr, true);
  curs_set (0);
end;

procedure draw_nc (on_ln: int);
begin

end;


end.

