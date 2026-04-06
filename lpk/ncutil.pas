unit ncutil; // ncurses { sak }

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,
  ncurses,  // Install (apt):  libncurses-dev
  // Juju:
  typutil;


  procedure init_nc;
  procedure draw_nc (const s: str; const larg: arg_a; on_ln: int;
    win_:  str = 'BARKsak');
  procedure draw_cli_cmd_ln_nc (b:  box_t);
  //procedure draw_bar_nc (b:  box_t);

var
  nc_win:  PWINDOW;

implementation

procedure init_nc;
begin
  initscr;
  cbreak;
  noecho;
  keypad (stdscr, true);
  curs_set (0);
end;

procedure draw_nc (const s: str; const larg: arg_a; on_ln: int;
  win_:  str = 'BARKsak');
var
  i, max_lns, scro, bar_hei, bar_zero: int;
  win_tit: PChar;
begin
  clear ();

  max_lns:=LINES - 3;
  scro:=0;

  if on_ln >= max_lns then
    scro:=on_ln - max_lns+1;

  for i:=0 to max_lns-1 do begin
    if i + scro > High (larg) then break;
    if (i + scro) = on_ln then attron (A_REVERSE);

    mvprintw (i+2, 1, '%s', PChar (larg[i+scro].id));

    if (i + scro) = on_ln then attroff (A_REVERSE);
  end;

  if High (larg) >= 0 then begin
    bar_hei:=max_lns * max_lns div (High (larg)+1);
    if bar_hei < 1 then bar_hei:=1;

    bar_zero:=scro * max_lns div (High (larg)+1);

    for i:=0 to max_lns-1 do begin
      if (i >= bar_zero) and (i < bar_zero + bar_hei) then
        mvaddch (i + 2, COLS - 2, Ord ('#'))
      else
        mvaddch (i + 2, COLS - 2, Ord ('|'));
    end;
  end;

  attron (A_REVERSE);
  mvprintw (2, 1, '%s', PChar (s));

  for i:=0 to COLS-1 do
    mvaddch (0, i, Ord (' '));

    win_tit:=PChar (win_);
    mvprintw (0, 1, win_tit);

  attroff (A_REVERSE);

  refresh ();
end;

procedure draw_cli_cmd_ln_nc (b:  box_t);
var
  tog_is_in: bool = false;
begin


end;

end.

