unit frmklaw;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus,
  Process,
  { Juju (lpk):  https://github.com/basedfigure/juju }
  fmtsak, typutil;

type


  { TKlawFrm }

  TKlawFrm = class(TForm)
    cb_project_path: TComboBox;
    main_menu: TMainMenu;
    //
    mi_tools: TMenuItem;
    mi_git_kompare_script_project: TMenuItem;
    //
    lbl_project_path: TLabel;

    procedure FormCreate (Sender: TObject);
    procedure mi_git_kompare_script_project_click (Sender: TObject);
  private

  public

  end;

var
  KlawFrm: TKlawFrm;

  rope:  sak_t;

implementation


{$R *.lfm}


{ TKlawFrm }

procedure TKlawFrm.FormCreate(Sender: TObject);
var
  i: Integer;
begin

  rope.init;

  if rope.load_fr_disk (ROPE_SAK) then begin
    cb_project_path.Items.BeginUpdate;

    try
      cb_project_path.Items.Clear;
      for i:=0 to rope.f.Count - 1 do
        cb_project_path.Items.Add (rope.f.ValueFromIndex[i]);

    finally
      cb_project_path.Items.EndUpdate;

    end;

    cb_project_path.Text:=rope.f.Values ['bf'];
  end;

end;


procedure TKlawFrm.mi_git_kompare_script_project_click (Sender: TObject);
var
  Proc: TProcess;
begin

  if Trim(cb_project_path.Text) = '' then begin
    ShowMessage('Project path is missing');
    Exit;
  end;

  Proc:=TProcess.Create(nil);
  try
    Proc.Executable:='/bin/bash';
    Proc.Parameters.Add(SH_PATH_R + 'git_kompare_diff.sh');
     Proc.Parameters.Add (cb_project_path.Text);

    Proc.Options:=[poWaitOnExit];
    Proc.Execute;

  finally
    Proc.Free;
  end;

end;

end.

