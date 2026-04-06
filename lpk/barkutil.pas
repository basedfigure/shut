unit barkutil;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,
  // Juju:
  typutil, fmtsak;

type

  { bark_t }

  { bark_t vs TBark:
    object vs. class for educational purposes only, but now you won't be confuse
    d. Pascal was a common educational language historically, but it's serious,
    in all the right ways. I prefer taught languages to be compiled languages,
    instead of interpreted ones. }

  bark_t = object
    procedure hey (id:  str);
    procedure bye (id:  str);
  end;

  { meta_data_t }

  meta_data_t = record
    date, ltype:  str;  // du: formatting utils
  end;

  { card_t }

  card_t = record
    // bark
    tit, blk:  str;
    md:  meta_data_t;
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

  TBark = object (sak_t) // utility
    { Code and filewise consider TBark a single file, sak_t scan routines are
      more concerned with formatting and structure }
    { sak }
    ncard:  int;
    lcard:  array of card_t;

    // dosbox:
    // Turbo Pascal compat flag:  -Ss
    constructor init ();
    destructor done ();
    //
    procedure scan_tits_and_blks (dump: str);
    procedure save_each_card_as_a_file (const dir: str);

    procedure de_bark_vert_lns_in_void (const n:  int);
  public
    path:  str;
  end;

var
  bark_proj:  TBark;

const
  VERT_VOID_AFT_EACH_BARK = 5;


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
  inherited init ();
end;

destructor TBark.done ();
{ . }
begin
  inherited done ();
end;

procedure TBark.scan_tits_and_blks (dump: str);
{ A Konsole window can fit 1024 lines, if you want to show multiple barks, with
some separate command, or something. }
var
  i, j, nest:  int;
  lns:  TStringList;
  ln, blk, tit:  str;
  in_tit:  bool;
begin
  lns:=TStringList.Create ();
  lns.Text:=dump;
  SetLength (lcard, 0);
  ncard:=0;
  nest:=0;
  blk:='';
  tit:='';
  in_tit:=false;

  for i:=0 to lns.Count-1 do begin
    ln:=lns[i];

    if (nest = 0) and (Copy (Trim (ln),1,2) = '//') then begin
      tit:=ln;
      in_tit:=true;
      Continue;
    end;

    if in_tit and (nest = 0) and (Pos('{', ln) = 0) then begin
      tit:=tit + #13#10 + ln;
      Continue;
    end;

    if Pos ('{', ln) > 0 then begin

      if in_tit then begin
        SetLength (lcard, ncard+1);
        lcard[ncard].tit:=tit;
        blk:='';
        in_tit:=false;
      end;

    end;

    for j:=1 to Length (ln) do begin

      case ln[j] of
      '{':
        begin
          Inc (nest);
          if nest = 1 then blk:='';
        end;

      '}':
        begin
          if nest = 1 then begin
            lcard[ncard].blk:=blk;
            Inc (ncard);
          end;
          if nest > 0 then Dec (nest);
        end;

      else if nest >= 1 then blk:=blk+ln[j];
      end;
    end;

    if nest >= 1 then blk:=blk + #13#10;
  end;

  for i:=0 to ncard-1 do begin
    de_bark_vert_lns_in_void (VERT_VOID_AFT_EACH_BARK);
    WriteLn (lcard[i].tit, ' ;; ------------- ;;');
    Writeln (lcard[i].blk);

  end;

  lns.Free ();

end;

procedure TBark.de_bark_vert_lns_in_void (const n: int);
var
  i: Integer;
begin
  for i:=0 to n-1 do begin
    WriteLn ();
  end;
end;

procedure TBark.save_each_card_as_a_file (const dir:  str);
var
  has_head:  bool; // preamble, denoted with (sak) on first line
  ls: TStringList;
  i, idx: int;
  fn: str;
begin
  if not DirectoryExists (dir) then ForceDirectories (dir);

  has_head:=(ncard > 0) and (Pos ('(sak)', lcard[0].tit) > 0);

  ls:=TStringList.Create ();
  try
    for i:=0 to ncard-1 do begin
      if has_head then begin
        if i = 0 then
          idx:=0
        else
          // 000 if preamble (sak), reverse the rest
          idx:=ncard - i;
        end else
        idx:=ncard-1-i;

        fn:=LowerCase (StringReplace (lcard[i].tit, ' ', '_', [rfReplaceAll] ));

        fn:=StringReplace (fn, '/', '_', [rfReplaceAll] );
        fn:=StringReplace (fn, '\', '_', [rfReplaceAll] );
        fn:=StringReplace (fn, ':', '', [rfReplaceAll] );

        while Pos ('__', fn) > 0 do
          fn:=StringReplace (fn, '__', '_', [rfReplaceAll] );

        while (Length (fn) > 0) and (fn[1] = '_') do
          Delete (fn, 1, 1);
        while (Length (fn) > 0) and (fn[Length (fn)] = '_') do
          Delete (fn, Length (fn), 1);

        ls.Clear ();
        ls.Add (lcard[i].tit);
        ls.Add (lcard[i].blk);

        ls.SaveToFile (IncludeTrailingPathDelimiter (dir) +
          Format ('%.3d_%s.sak', [idx, fn] ));
    end;

  finally
    ls.Free ();
  end;
end;

end.

