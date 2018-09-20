unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons; //Unit2;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Memo2: TMemo;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    OpenDialog1: TOpenDialog;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    SaveDialog1: TSaveDialog;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);

  private
    { Private declarations }
    procedure Convert(Sender: TObject);
    function Check(Sender: TObject):Boolean;
    function LeftStr(const Str: string; Size: Word):string;
    function RightStr(const Str: string; Size: Word):string;
//    function Extract(Dest, Source: PChar; MaxLen: Integer): PChar;

  public
    { Public declarations }

  end;

var
  Form1: TForm1;
  FormatOk: Boolean = False;
  Converted: Boolean = False;
  OpenedFile: String = 'C:\Knd_temp.txt';

implementation

{$R *.DFM}

{�������}
procedure TForm1.BitBtn1Click(Sender: TObject);
begin
 if OpenDialog1.Execute then
  begin
  Memo1.Lines.LoadFromFile(OpenDialog1.FileName);
  OpenedFile:=OpenDialog1.FileName;
  BitBtn2Click(Form1);
  end;
end;

{��������������}
procedure TForm1.BitBtn2Click(Sender: TObject);
begin
 If Check(Form1) Then
  begin
   Convert(Form1);
   Converted:=True;
  end
 else
  begin
   Memo2.Clear;
   Converted:=False;
   ShowMessage('������ ��������� ����� �� ������������� ������� �������� ������ ��������� ����� ������ ��� DRON-7'); //���� ���-������ ���������� ������������ � ����� �����
  end;
 BitBtn2.Enabled:=Converted;
 BitBtn3.Enabled:=Converted;
 BitBtn4.Enabled:=Converted;
// Memo2.Lines[7]:='����� � �����: ' + IntToStr(Memo1.Lines.Count);
// Memo1.Lines.LoadFromFile('E:\PLC&HMI\DRON_Converter\DelphiProject\Resources\test.txt');
end;

procedure TForm1.Convert(Sender: TObject);
 var i: Smallint;
begin
 Memo2.Clear;
 {����� - "���������" (header) ����� (������ ���� �� ������...)}
 for i:=0 to 5 DO Memo2.Lines.Add(''); //������� ������ ������, � �� ��, - ������, - ��� ����� �� �������������... :-)
// Memo2.Lines[0]:=IntToStr(Length(Memo1.Lines[0]));
 Memo2.Lines[0]:=Memo1.Lines[0];
 Memo2.Lines[2]:=Memo1.Lines[1];
 Memo2.Lines[4]:='2Theta     d     I';
{����� ���� �� ����������� ���� � ����������� �������� ��������� �� ����� Memo1.Lines[i+1]}
{(�.�. 2 �����: 6 �������� �� ���� � �� ~7 �� ���-�� �������� �� �������������)}
 for i:=6 to (Memo1.Lines.Count-2) DO Memo2.Lines.Add(Memo1.Lines[i+1][1]+Memo1.Lines[i+1][2]+Memo1.Lines[i+1][3]+Memo1.Lines[i+1][4]+Memo1.Lines[i+1][5]+Memo1.Lines[i+1][6]+' 0.0000 '+Memo1.Lines[i+1][8]+Memo1.Lines[i+1][9]+Memo1.Lines[i+1][10]+Memo1.Lines[i+1][11]+Memo1.Lines[i+1][12]+Memo1.Lines[i+1][13]+Memo1.Lines[i+1][14]+Memo1.Lines[i+1][15]+Memo1.Lines[i+1][16]+Memo1.Lines[i+1][17]+Memo1.Lines[i+1][18]);
// Memo2.Lines[2]:=IntToStr(dfLength(Memo1.Lines[0]));
// for i:=1 to
// Memo2.Lines[6]:=Memo1.Lines[8][1]+Memo1.Lines[8][2]+Memo1.Lines[8][3]+Memo1.Lines[8][4]+Memo1.Lines[8][5]+Memo1.Lines[8][6]+' 0.0000 ';
end;

function TForm1.Check(Sender: TObject):boolean;
// var TempString: String;
begin
 if (Memo1.Lines.Count < 9) then Check:=False
  else if (Length(Memo1.Lines[0]) < 8) or (Length(Memo1.Lines[0]) > 10) then Check:=False
   else if (Length(Memo1.Lines[1]) < 15) then Check:=False
    else if (Length(Memo1.Lines[2]) < 13) then Check:=False
     else if (Length(Memo1.Lines[3]) < 13) then Check:=False
      else if (Length(Memo1.Lines[4]) < 13) then Check:=False
       else if (Length(Memo1.Lines[5]) < 6) then Check:=False
        else if (Length(Memo1.Lines[6]) <> 12) then Check:=False
         else if (LeftStr(Memo1.Lines[1], 10) <> '������� - ') then Check:=False
          else if (LeftStr(Memo1.Lines[2], 9) <> 'Lambda1 =') then Check:=False
           else if (LeftStr(Memo1.Lines[3], 9) <> 'Lambda2 =') then Check:=False
            else if (LeftStr(Memo1.Lines[4], 9) <> 'Lambdam =') then Check:=False
             else if (LeftStr(Memo1.Lines[5], 4) <> 'R = ') then Check:=False
//         else if (Memo1.Lines[1][1]<>'�') then Check:=False //and Memo1.Lines[1][2]<>'�' and Memo1.Lines[1][3]<>'�' and Memo1.Lines[1][4]<>'�') tnen Check:=False
 else Check:=True;
end;

function TForm1.RightStr(const Str: string; Size: Word): string;
var
  len: Byte absolute Str;
begin
  if Size > len then
    Size := len;
  RightStr := Copy(Str, len - Size + 1, Size)
end;

function TForm1.LeftStr(const Str: string; Size: Word): string;
begin
  LeftStr := Copy(Str, 1, Size)
end;

{��������� � �� �� �����}
procedure TForm1.BitBtn3Click(Sender: TObject);
begin
 if (OpenedFile <> 'C:\Knd_temp.txt') then
   begin
   if Converted then Memo2.Lines.SaveToFile('vKondor_' + ExtractFileName(OpenedFile))
    else ShowMessage('��������� ����������� ��������� ����� �����������'); //��������� ������������ � ���, ��� ����������� �� ��������� (�������� ������ ��������� �����)
   end
 else ShowMessage('�������� ���� ��� �� ������'); //��������� ������������ � ���, ��� �������� ���� ��� �� ������
// Memo2.Lines[0]:=OpenedFile;
end;

{�����}
procedure TForm1.BitBtn5Click(Sender: TObject);
begin
 Form1.Close;
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
begin
SaveDialog1.InitialDir:=ExtractFileDir(OpenedFile);
//SaveDialog1.InitialDir:=ExtractFilePath(OpenedFile);
// ��������: ���, ���� ������ "����" SaveDialog1.InitialDir:='';
 SaveDialog1.FileName:='vKondor_' + ExtractFileName(OpenedFile);
 if SaveDialog1.Execute then
  begin
  Memo2.Lines.SaveToFile(SaveDialog1.FileName);
  end;
end;

end.
