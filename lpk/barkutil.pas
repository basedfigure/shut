unit barkutil;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,
  // Juju:
  typutil;

type

  { key_t }

  key_t = record
    date, ltype:  str;  // du: formatting utils
  end;

  { card_t }

  card_t = record
    // bark
    tit, blk:  str;
    key:  key_t;
  end;

  { user_t }

  user_t = record
    id, role:  str;
  end;

  { board_t }

  board_t = record
    luser:  array of user_t;
    lpost:  array of post_t;
  end;

  { TBark }

  TBark = class
    // dosbox:
    // Turbo Pascal compat flag:  -Ss
    constructor init ();
    destructor done ();
    //
  private
    procedure scan_blks (dump: str);
  public
    path:  str;
  end;

implementation

{ TBark }

constructor TBark.init ();
{ . }
begin

end;

destructor TBark.done ();
{ . }
begin

end;

procedure TBark.scan_blks (dump:  str);
var
  lslash, lblk:  TStringList;
begin

end;

end.

