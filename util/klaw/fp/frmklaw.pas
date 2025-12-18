unit frmklaw;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus,
  ExtCtrls, ValEdit, Process,
  { Juju (lpk):  https://github.com/basedfigure/juju }
  fmtutil, fmtsak, typutil;

type


  { TKlawFrm }

  TKlawFrm = class(TForm)
    main_menu: TMainMenu;
    //
    mi_tools: TMenuItem;
    mi_git_kompare_script_project: TMenuItem;
    mi_git_cmd_templates: TMenuItem;

    mi_config: TMenuItem;
    mi_silent_console_mode: TMenuItem;
    mi_tog_console_on_launch: TMenuItem;
    mi_tog_path_editing: TMenuItem;
    //

    lbl_project_path: TLabel;
    cb_project_path: TComboBox;

    edt_project_title: TEdit;
    //
    side_l_panl: TPanel;
    split1: TSplitter;
    side_r_pnl: TPanel;
    //
    vle_sak_input_field_editor: TValueListEditor;

    { Proc }
    procedure FormCreate (Sender: TObject);

    // Tools
    procedure mi_git_kompare_script_project_click (Sender: TObject);
    // Config
    procedure mi_tog_console_on_launch_click(Sender: TObject);
    // Form controls
    procedure cb_project_path_change (Sender: TObject);
  private

  public

  end;

var
  KlawFrm: TKlawFrm;

  rope:  sak_t;

implementation



{$R *.lfm}


{ TKlawFrm }

procedure TKlawFrm.FormCreate (Sender: TObject);
var
  i: int;
begin

  rope.init;

  if rope.load_fr_disk (ROPE_SAK) then begin
    cb_project_path.Items.BeginUpdate;

    try cb_project_path.Items.Clear;

      for i:=0 to rope.f.Count-1 do

        cb_project_path.Items.Add (
          rip_file_or_fold_name (rope.f.ValueFromIndex[i]));

    finally
      cb_project_path.Items.EndUpdate;

    end;


    cb_project_path.Text:=rip_file_or_fold_name (rope.f.Values['bf']);

    edt_project_title.Text:=cb_project_path.Text;
  end;

end;


procedure TKlawFrm.mi_git_kompare_script_project_click (Sender: TObject);
var
  Proc: TProcess;
begin

  if Trim (cb_project_path.Text) = '' then begin
    ShowMessage ('Project path is missing');
    Exit;
  end;

  Proc:=TProcess.Create (nil);
  try
    Proc.Executable:='/bin/bash';
    Proc.Parameters.Add (SH_PATH_R + 'git_kompare_diff.sh');
     Proc.Parameters.Add (rope.f.ValueFromIndex[0]);

    Proc.Options:=[poWaitOnExit];
    Proc.Execute;

  finally
    Proc.Free;
  end;

end;

procedure TKlawFrm.mi_tog_console_on_launch_click(Sender: TObject);
begin
  // To-do:  console is for debug prints and enabling git commit mode
  //  and sensitive commands, so a test user can't misclick on them
end;

procedure TKlawFrm.cb_project_path_change (Sender: TObject);
begin
  edt_project_title.Text:=cb_project_path.Text;

  if cb_project_path.ItemIndex >= 0 then
    vle_sak_input_field_editor.Values ['Path']:=
     rope.f.ValueFromIndex [cb_project_path.ItemIndex];
end;


end.

