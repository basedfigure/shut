unit ncutil; { sak }

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,
  ncurses,  // Install (apt):  libncurses-dev
  // Juju:
  typutil;


  procedure init_nc;
  procedure draw_nc (const s:  str; const larg:  arg_a;  on_ln: int);

implementation

procedure init_nc;
begin
  initscr;
  cbreak;
  noecho;
  keypad (stdscr, true);
  curs_set (0);
end;

procedure draw_nc (const s:  str; const larg:  arg_a;  on_ln: int);
var
  i: int;
begin
  clear;
  //mvprintw (0, 2, 'Move:  j/k,  Select:  enter');
  //
  //
  for i:=0 to High (larg) do begin
    if i = on_ln then attron (A_REVERSE);

    mvprintw (i + 2, 1, '%s', PChar(larg[i].id));

    if i = on_ln then attroff (A_REVERSE);

  end;


  // style test:
  attron (A_REVERSE);
  mvprintw (2, 1, '%s', PChar(s));

  for i:=0 to COLS-1 do
    mvaddch(0, i, Ord (' '));
    mvprintw (0, 1, 'WIDE RIBBON');

  attroff (A_REVERSE);



  refresh;
end;


end.

