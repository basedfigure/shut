unit barkuser;
// it's a long story.  you wouldn't understand
// as in, everyone should have their bark unit


{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,
  // Juju:
  typutil, barkutil;

type

  { lang_t }

  lang_t = record

  end;

  { opus_t }

  opus_t = record

  end;

  { cal_t }

  cal_t = record

  end;

  { team_t }

  team_t = record
    // users, pairings
  end;

  { user_t }

  user_t = record
    t:  team_t;
    hat, name, bio, prop, boon, note:  str;
    know, pair:  int;
  end;

  { mold_t }

  mold_t = record
    desc:  str_a;
    // fmt_t;
  end;


  // ..corpuses
  procedure pray_to_mata (by:  user_t);  // guidance
  procedure pray_for_info (p:  proj_e);
  procedure pray_to_do (c:  cal_t);
  procedure pray_to_line (l: lang_e;  o:  opus_t);
  // ..actions
  procedure do_kiss (const lass:  str = '(^3^)');
  // ..summons
  // en.wikipedia.org/wiki/Familiar
  procedure bark_dog (const s:  str = 'woof');
  procedure bark_goat (const s:  str = 'hoof');
  procedure bark_wai_fu_nc_menu (const emoji:  str = '<3');
  procedure bark_each_card_in_sak_dir_nc_menu ();

implementation

procedure pray_to_mata (by:  user_t);
begin
  // put architectural stuff here, so print stuff from memory that
  // are critical to the current project etc.
end;

procedure pray_for_info (p:  proj_e);
begin

end;

procedure pray_to_do (c:  cal_t);
begin
  // * The Cloister:
  // * Pattern:  order & chaos to work both those hemispheres
  // - convert to my ways, if you want
  // e.g.
  // a jedi is nearing you
  //
  // * The Catacombs:
  // place your todo list in some file and work your magic on it here
  // - get a random thing to work on
  // e.g.
  // a sith lurks nearby
end;

procedure pray_to_line (l: lang_e; o: opus_t);
begin

end;

procedure do_kiss (const lass:  str = '(^3^)');
begin
  // drab
  // drip
end;

procedure bark_dog (const s:  str = 'woof');
begin
  // dog skin
  // sitting by
end;

procedure bark_goat (const s:  str = 'hoof');
begin
  // goat fur
  // behooves you
end;

procedure bark_wai_fu_nc_menu (const emoji:  str = '<3');
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

procedure bark_each_card_in_sak_dir_nc_menu ();
var
  i:  int;
begin
  args_init (g_vars);

  if bark_proj.ncard > 0 then
    g_vars[0].id:=bark_proj.lcard[0].tit;

  for i:=1 to bark_proj.ncard - 1 do begin
    arg.id:=bark_proj.lcard[i].tit;
    args_pop_e (g_vars, arg);
  end;
end;

end.

