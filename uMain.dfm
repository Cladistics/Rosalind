object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Rosalind Solver'
  ClientHeight = 498
  ClientWidth = 748
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object mmOutput: TMemo
    Left = 0
    Top = 0
    Width = 592
    Height = 498
    Align = alClient
    TabOrder = 0
  end
  object pnControl: TPanel
    Left = 592
    Top = 0
    Width = 156
    Height = 498
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 1
    object btnStart: TButton
      AlignWithMargins = True
      Left = 3
      Top = 76
      Width = 150
      Height = 25
      Align = alTop
      Caption = 'Start'
      TabOrder = 0
      OnClick = btnStartClick
    end
    object rgWorkers: TRadioGroup
      Left = 0
      Top = 0
      Width = 156
      Height = 73
      Align = alTop
      Caption = 'Problems'
      TabOrder = 1
    end
  end
end
