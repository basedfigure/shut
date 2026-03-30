unit editutil;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,
  // Juju:
  typutil;

type

  { text_ed_t }

  text_ed_t = record
    is_in_edit_mode:  bool;
    curs_pos:  int;
  end;

var
  ed:  text_ed_t;

  procedure ed_togg_edit_mode ();
  procedure ed_put_in (ch:  char);
  procedure ed_move_curs_ (by:  int);

implementation

uses
  dochtml;

procedure ed_togg_edit_mode ();
begin
  ed.is_in_edit_mode:=not ed.is_in_edit_mode;
end;

procedure ed_put_in (ch:  char);
begin
  if not ed.is_in_edit_mode then Exit;

    Insert (ch, page, ed.curs_pos);
    Inc (ed.curs_pos);
end;

procedure ed_move_curs_ (by:  int);
begin
  Inc (ed.curs_pos, by);

  if ed.curs_pos < 1 then ed.curs_pos:=1;
  if ed.curs_pos > Length (page)+1 then
    ed.curs_pos:=Length (page)+1;
end;

end.

