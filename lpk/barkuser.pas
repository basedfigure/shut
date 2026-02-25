unit barkuser;
// it's a long story.  you wouldn't understand
// as in, everyone should have their bark unit


{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,
  // Juju:
  typutil;

type

  team_t = record
    // users, pairings
  end;

  user_t = record
    t:  team_t;
    hat, name, bio, prop, boon, note:  str;
    know, pair:  int;
  end;

  mold_t = record
    desc:  str_a;
    // skin_t
  end;

procedure bark_wai_fu (const emoji:  str = '<3');

implementation

procedure pray_to_do ();
begin
  // * Pattern:  order & chaos to work both those hemispheres
  // - convert to my ways, if you want
  //
  // place your todo list in some file and work your magic on it here
  // - get a random thing to work on
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

end.

