object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Memory Manager testing'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 39
    Height = 13
    Caption = 'Threads'
  end
  object RunTest: TButton
    Left = 144
    Top = 8
    Width = 81
    Height = 49
    Caption = 'Run'
    TabOrder = 0
    OnClick = RunTestClick
  end
  object NumThreads: TEdit
    Left = 8
    Top = 24
    Width = 50
    Height = 21
    TabOrder = 1
    Text = '4'
  end
  object ResultsMemo: TMemo
    Left = 8
    Top = 79
    Width = 369
    Height = 209
    TabOrder = 2
  end
  object UseLocks: TCheckBox
    Left = 8
    Top = 56
    Width = 121
    Height = 17
    Caption = 'Use critical sections'
    TabOrder = 3
  end
end
