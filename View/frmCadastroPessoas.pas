unit frmCadastroPessoas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, RxToolEdit;

type
  TfrmCadastroDePessoas = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel1: TPanel;
    Panel2: TPanel;
    ledNome: TLabeledEdit;
    ledNascimento: TLabeledEdit;
    ledCPF: TLabeledEdit;
    ledRG: TLabeledEdit;
    ledEmail: TLabeledEdit;
    ledTelefone: TLabeledEdit;
    ledCEP: TLabeledEdit;
    ledBairro: TLabeledEdit;
    ledCidade: TLabeledEdit;
    ledEstado: TLabeledEdit;
    ComboBox1: TComboBox;
    btnSalvar: TBitBtn;
    TabSheet2: TTabSheet;
    btnCancelar: TBitBtn;
    lbTipoPessoa: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastroDePessoas: TfrmCadastroDePessoas;

implementation

{$R *.dfm}

end.
