VERSION 5.00
Begin VB.Form Login 
   Caption         =   "Login"
   ClientHeight    =   1485
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   3660
   LinkTopic       =   "Form1"
   ScaleHeight     =   1485
   ScaleWidth      =   3660
   StartUpPosition =   2  'CenterScreen
   Begin VB.PictureBox Picture1 
      Height          =   1215
      Left            =   120
      ScaleHeight     =   1155
      ScaleWidth      =   3315
      TabIndex        =   3
      Top             =   120
      Width           =   3375
      Begin VB.TextBox TxtNamaKsr 
         Height          =   350
         IMEMode         =   3  'DISABLE
         Left            =   1200
         TabIndex        =   0
         Text            =   "UUS"
         Top             =   120
         Width           =   2000
      End
      Begin VB.TextBox TxtPasswordKsr 
         Height          =   350
         IMEMode         =   3  'DISABLE
         Left            =   1200
         PasswordChar    =   "X"
         TabIndex        =   1
         Text            =   "LUPA"
         Top             =   600
         Width           =   2000
      End
      Begin VB.Label Label1 
         BorderStyle     =   1  'Fixed Single
         Caption         =   " Nama User"
         Height          =   345
         Left            =   120
         TabIndex        =   5
         Top             =   120
         Width           =   1005
      End
      Begin VB.Label Label2 
         BorderStyle     =   1  'Fixed Single
         Caption         =   " Password"
         Height          =   345
         Left            =   120
         TabIndex        =   4
         Top             =   600
         Width           =   1005
      End
   End
   Begin VB.TextBox TxtKodeKsr 
      Height          =   350
      IMEMode         =   3  'DISABLE
      Left            =   1320
      TabIndex        =   2
      Top             =   1560
      Width           =   2000
   End
   Begin VB.Label Label3 
      BorderStyle     =   1  'Fixed Single
      Caption         =   " Kode Kasir"
      Height          =   345
      Left            =   240
      TabIndex        =   6
      Top             =   1560
      Width           =   1005
   End
End
Attribute VB_Name = "Login"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Dim A As Byte
Dim B As Byte

Private Sub Form_Load()
    TxtNamaKsr.MaxLength = 35
    TxtPasswordKsr.MaxLength = 15
    TxtPasswordKsr.PasswordChar = "*"
    TxtPasswordKsr.Enabled = False
    TxtKodeKsr.Enabled = False
End Sub

Private Sub TxtNamaKsr_KeyPress(Keyascii As Integer)
Keyascii = Asc(UCase(Chr(Keyascii)))
If Keyascii = 27 Then Unload Me
If Keyascii = 13 Then
    Call BukaDB
    RSKasir.Open "Select NamaKsr from Kasir where NamaKsr ='" & TxtNamaKsr & "'", Conn
    
    If RSKasir.EOF Then
        A = A + 1
        If 1 - A = 0 Then
            MsgBox "Kesempatan ke " & A & " Salah" & Chr(13) & _
                    "Nama '" & TxtNamaKsr & "' tidak dikenal"
            TxtNamaKsr = ""
            TxtNamaKsr.SetFocus
        ElseIf 2 - A = 0 Then
            MsgBox "Kesempatan ke " & A & " Salah" & Chr(13) & _
                    "Nama '" & TxtNamaKsr & "' tidak dikenal"
            TxtNamaKsr = ""
            TxtNamaKsr.SetFocus
        ElseIf 3 - A = 0 Then
            MsgBox "Kesempatan ke " & A & " Salah" & Chr(13) & _
                    "Nama '" & TxtNamaKsr & "' tidak dikenal" & Chr(13) & _
                    "Kesempatan habis, Ulangi dari awal"
            'End
            Unload Me
            Exit Sub
        End If
    Else
        TxtNamaKsr.Enabled = False
        TxtPasswordKsr.Enabled = True
        TxtPasswordKsr.SetFocus
    End If
End If
End Sub

Private Sub txtpasswordksr_KeyPress(Keyascii As Integer)
Keyascii = Asc(UCase(Chr(Keyascii)))
If Keyascii = 27 Then Unload Me
Dim LoginKasir As String
Dim KodeKasir As String
Dim NamaKasir As String
If Keyascii = 13 Then
    
    Call BukaDB
    RSKasir.Open "Select * from Kasir where NamaKsr ='" & TxtNamaKsr & "' and PasswordKsr='" & TxtPasswordKsr & "'", Conn
    If RSKasir.EOF Then
        B = B + 1
        If 1 - B = 0 Then
            MsgBox "Kesempatan ke " & B & " Salah"
            TxtPasswordKsr = ""
            TxtPasswordKsr.SetFocus
        ElseIf 2 - B = 0 Then
            MsgBox "Kesempatan ke " & B & " Salah"
            TxtPasswordKsr = ""
            TxtPasswordKsr.SetFocus
        ElseIf 3 - B = 0 Then
            MsgBox "Kesempatan ke " & B & " Salah"
            'End
            Unload Me
            Exit Sub
        End If
    Else
        'Unload Me
        Login.Visible = False
        Menu.Show
        KodeKasir = RSKasir!Kodeksr
        NamaKasir = RSKasir!Namaksr
        Kodeksr = KodeKasir
        Namaksr = NamaKasir
        Cucian.Kodeksr = KodeKasir
        Cucian.Namaksr = NamaKasir
        Pengiriman.Kodeksr = KodeKasir
        Pengiriman.Namaksr = NamaKasir
    End If
End If
End Sub

