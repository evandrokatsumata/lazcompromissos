(*
        Essa Agenda de compromisso pode ser distribuida livremente!
        Qualquer alteração feita, favor enviar uma copia para
        leonardolp@gmail.com ou entrar em contato pelo relatosnoturno.blogspot.com

        Fique a vontade!
*)

unit UPrincipal;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, DB, LResources, Forms, ExtCtrls, StdCtrls, Calendar, DBCtrls,
  Buttons, ZConnection, ZDataset, Classes, Dialogs;

type

  { TFAgenda }

  TFAgenda = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Calendario: TCalendar;
    Conexao: TZConnection;
    DBMemo1: TDBMemo;
    dsCompromisso: TDatasource;
    imgFundo: TImage;
    Label1: TLabel;
    Label2: TLabel;
    lbDia: TLabel;
    lbData: TLabel;
    lbMes: TLabel;
    qryCompromisso: TZQuery;
    qryCompromissodata: TDateField;
    qryCompromissodescricao: TBlobField;
    qryCompromissoDESCRICAO1: TMemoField;
    qryCompromissoDT1: TDateField;
    qryCompromissoid: TLargeintField;
    qryCompromissoID1: TLongintField;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure CalendarioChange(Sender: TObject);
    procedure CalendarioClick(Sender: TObject);
    procedure DBMemo1Enter(Sender: TObject);
    procedure DBMemo1Exit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FAgenda: TFAgenda;

implementation

{ TFAgenda }

procedure TFAgenda.CalendarioClick(Sender: TObject);
begin
  qryCompromisso.Close;
  qryCompromisso.SQL.Text := 'select * from compromissos where (data = ' +
    QuotedStr(FormatDateTime('yyyy-mm-dd', Calendario.DateTime)) + ') ';
  qryCompromisso.Open;
  lbData.Caption := FormatDateTime('dd/mm/yyyy', Calendario.DateTime);
  lbDia.Caption := FormatDateTime('dd', Calendario.DateTime);
  lbMes.Caption := FormatDateTime('mm', Calendario.DateTime);
end;

procedure TFAgenda.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

procedure TFAgenda.BitBtn2Click(Sender: TObject);
begin
  if (qryCompromissodescricao.AsString <> '') then
  begin
    qryCompromissodata.AsDateTime := Calendario.DateTime;
    qryCompromisso.Post;
    qryCompromisso.ApplyUpdates;
  end;
end;

procedure TFAgenda.CalendarioChange(Sender: TObject);
begin
  ActiveControl := nil;
end;

procedure TFAgenda.DBMemo1Enter(Sender: TObject);
begin
  if (qryCompromissodescricao.AsString = '') then
    qryCompromisso.Append
  else
    qryCompromisso.Edit;
end;

procedure TFAgenda.DBMemo1Exit(Sender: TObject);
begin
  //ShowMessage('passei ak');

end;

procedure TFAgenda.FormCreate(Sender: TObject);
var
  sPath: string;
begin
  sPath := ExtractFilePath(Application.ExeName);
  Conexao.Database := sPath + 'compromisso.db';
  Conexao.Connected := True;

  Calendario.Font.Size := 11;

  Calendario.DateTime := Date;
  qryCompromisso.Close;
  qryCompromisso.SQL.Text := 'SELECT * FROM compromissos WHERE (data = ' +
    QuotedStr(FormatDateTime('yyyy-mm-dd', Calendario.DateTime)) + ') ';
  qryCompromisso.Open;
  lbData.Caption := FormatDateTime('dd/mm/yyyy', Calendario.DateTime);
  lbDia.Caption := FormatDateTime('dd', Calendario.DateTime);
  lbMes.Caption := FormatDateTime('mm', Calendario.DateTime);
end;

initialization
  {$I UPrincipal.lrs}

end.

