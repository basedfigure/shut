unit barkutil;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,
  // Juju:
  typutil;

type

  { bark_t }

  { bark_t vs TBark:
    object vs. class for educational purposes only, but now you won't be confuse
    d. Pascal was a common educational language historically, but it's serious }

  bark_t = object
    procedure hey(id:  str);
    procedure bye(id:  str);
  end;

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
    //lpost:  array of post_t;
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

uses
  apputil;

{ bark_t }

procedure bark_t.hey (id:  str);
begin
  WriteLn ('Helo to ', id);
  Writeln ();
end;

procedure bark_t.bye (id:  str);
begin
  WriteLn ('Bye to ', id);
  Writeln ();
end;


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

