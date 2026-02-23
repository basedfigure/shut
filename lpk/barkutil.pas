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


  procedure bark_hey;
  procedure bark_bye;
  procedure bark_wai_fu (const emoji:  str = '<3');

implementation

uses
  apputil;


{ (bark)eth }

procedure bark_hey;
begin
  WriteLn ('Helo to ', g_env.user_id);
end;

procedure bark_bye;
begin
  WriteLn ('Bye to ', g_env.user_id);
end;

procedure bark_wai_fu (const emoji:  str = '<3');
{ Wrap her in a gift box }
begin
  // Wai-fu (lore url):  en.wikipedia.org/wiki/Konami_Wai_Wai_World

  args_init (g_vars);
  g_vars[0].id:='Unromance +6';

  arg.id:='ncurses is my bitch';
  args_pop_e (g_vars, arg);

  arg.id:='scull size -13 in.';
  args_pop_e (g_vars, arg);

  arg.id:=
    'The basics are sometimes all you need to look good, in bitchcraft';
  args_pop_e (g_vars, arg);

  arg.id:='Will you be my wai-foon?';
  args_pop_e (g_vars, arg);

  arg.id:='Howly moon';
  args_pop_e (g_vars, arg);

  arg.id:='La li lu le loove <3';
  args_pop_e (g_vars, arg);

  arg.id:=emoji;
  args_pop_e (g_vars, arg);
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

