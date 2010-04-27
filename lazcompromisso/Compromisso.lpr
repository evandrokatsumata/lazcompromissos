program Compromisso;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, Forms, UPrincipal, LResources;

{$IFDEF WINDOWS}{$R Compromisso.rc}{$ENDIF}

begin
  {$I Compromisso.lrs}
  Application.Title := 'Gerenciador de compromissos';
  Application.Initialize;
  Application.CreateForm(TFAgenda, FAgenda);
  Application.Run;
end.
