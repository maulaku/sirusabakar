
Public Class Login
    '-------------------- Begin Load Lib ODBC ----------------------
    Private Declare Function SQLDataSources Lib "ODBC32.DLL" (ByVal henv As Integer, ByVal fDirection As Short, ByVal szDSN As String, ByVal cbDSNMax As Short, ByRef pcbDSN As Short, ByVal szDescription As String, ByVal cbDescriptionMax As Short, ByRef pcbDescription As Short) As Short
    Private Declare Function SQLAllocEnv Lib "ODBC32.DLL" (ByRef env As Integer) As Short
    '-------------------- End Load Lib ODBC ------------------------

    Dim a As String

    Private Sub OK_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles OK.Click
        odbc = cmbDatabase.SelectedItem.ToString
        If UsernameTextBox.Text <> "" And PasswordTextBox.Text <> "" Then
            If PasswordTextBox.Text = getNumber("select sandiPengguna from msPengguna where status=1 and namaPengguna='" & UsernameTextBox.Text & "'") Then
                'MainMenu.StUser.Text = UCase(UsernameTextBox.Text)
                'MainMenu.Enabled = True
                a = UCase(UsernameTextBox.Text)
                Me.Close()
            Else
                a = ""
                MsgBox("Kombinasi UserName dan Password salah !", MsgBoxStyle.Critical, "Gagal Login")
                UsernameTextBox.Focus()
            End If
        Else
            MsgBox("Harap masukkan UserName dan Password !", MsgBoxStyle.Exclamation, "Gagal Login")
            UsernameTextBox.Focus()
        End If
    End Sub
    Public Function get_login() As String
        Me.ShowDialog()
        Return a
    End Function
    Private Sub Cancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Cancel.Click
        a = ""
        Me.Close()
    End Sub

    Private Sub load_database()

        Const SQL_SUCCESS As Integer = 0
        Const SQL_FETCH_NEXT As Integer = 1
        Dim ReturnValue As Short
        Dim DSNName As String
        Dim DriverName As String
        Dim DSNNameLen As Short
        Dim DriverNameLen As Short
        Dim SQLEnv As Integer 'handle to the environment

        cmbDatabase.Items.Clear()
        If SQLAllocEnv(SQLEnv) <> -1 Then
            Do Until ReturnValue <> SQL_SUCCESS
                DSNName = Space(1024)
                DriverName = Space(1024)
                ReturnValue = SQLDataSources(SQLEnv, SQL_FETCH_NEXT, DSNName, 1024, DSNNameLen, DriverName, 1024, DriverNameLen)
                DSNName = Strings.Left(DSNName, DSNNameLen)
                DriverName = Strings.Left(DriverName, DriverNameLen)
                If DriverName = "SQL Server" Then
                    cmbDatabase.Items.Add(DSNName)
                End If
            Loop
        End If
        If cmbDatabase.Items.Count > 0 Then
            cmbDatabase.SelectedIndex = 0
        End If
    End Sub

    Private Sub Login_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        load_database()
    End Sub
End Class
