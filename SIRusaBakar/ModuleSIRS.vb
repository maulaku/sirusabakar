Module ModuleSIRS
    Public koneksi As String
    Public PSQL As String
    Public odbc As String

    Public con As New Odbc.OdbcConnection
    Public cmd As New Odbc.OdbcCommand
    Public dtreader As Odbc.OdbcDataReader
    Public dtadapter As New Odbc.OdbcDataAdapter
    Public idUser, idForm As Integer
    Public posisiForm, statusForm As String
    Sub bukaServer()
        Try
            'con.ConnectionString = "DSN=RSBK;UID=sa;PWD=pingpong;"
            'con.ConnectionString = "DSN=RSBK;"
            con.ConnectionString = "DSN=" & odbc & ";UID=sa;PWD=pingpong;"
            con.Open()
            idUser = 1
        Catch salah As Exception
            MessageBox.Show(salah.Message, "Error koneksi", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End
        End Try
    End Sub
    Sub matiServer()
        con.Close()
    End Sub
    Public Function getNumRow(ByVal sql As String) As Integer
        Try
            Call bukaServer()
            cmd.Connection = con
            cmd.CommandType = CommandType.Text
            cmd.CommandText = Sql
            getNumRow = cmd.ExecuteScalar
            cmd.Dispose()
            Call matiServer()
        Catch salah As Exception
            MessageBox.Show(salah.Message, "SQL Command Error", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End
        End Try
    End Function
    Public Function getNumber(ByVal sql As String) As String
        Try
            Call bukaServer()
            cmd.Connection = con
            cmd.CommandType = CommandType.Text
            cmd.CommandText = sql
            getNumber = cmd.ExecuteScalar
            cmd.Dispose()
            Call matiServer()
        Catch salah As Exception
            MessageBox.Show(salah.Message, "SQL Command Error", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End
        End Try
    End Function
    Public Sub execCmd(ByVal sql As String)
        Try
            Call bukaServer()
            cmd.Connection = con
            cmd.CommandText = sql
            cmd.ExecuteNonQuery()
            'dtadapter.SelectCommand.Parameters("@outVar").Direction = ParameterDirection.Output
            Call matiServer()
        Catch ex As Exception
            MessageBox.Show(ex.Message, "SQL Command Error", MessageBoxButtons.OK, MessageBoxIcon.Error)
        End Try
    End Sub
    Public Function getTabel(ByVal sql As String) As DataTable
        Try
            Call bukaServer()
            getTabel = New DataTable
            dtadapter = New Odbc.OdbcDataAdapter(sql, con)
            dtadapter.Fill(getTabel)
            dtadapter.Dispose()
            dtadapter = Nothing
            Call matiServer()
        Catch salah As Exception
            MessageBox.Show(salah.Message, "Tabel Tidak Bisa Dibuat !", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End
        End Try
    End Function
    Public Function hitUmur(ByVal lahir As Date) As String
        Dim m, d As Integer
        If lahir > Now Then
            hitUmur = ""
        End If
        m = DateDiff(DateInterval.Month, DateValue("Jan/1/" & Year(Now)), lahir)
        d = DateDiff(DateInterval.Day, DateValue(DatePart(DateInterval.Month, Now) & "/1/" & Year(Now)), lahir)
        hitUmur = DateDiff(DateInterval.Year, Now, lahir) * -1
        If Year(lahir) < Year(Now) Then
            hitUmur = hitUmur & " # " & (DateDiff(DateInterval.Month, Now, lahir) * -1) + m
        Else
            hitUmur = hitUmur & " # " & (DateDiff(DateInterval.Month, Now, lahir) * -1)
        End If
        If Month(lahir) < Year(Now) Then
            hitUmur = hitUmur & " # " & (DateDiff(DateInterval.Day, Now, lahir) * -1) + d
        Else
            hitUmur = hitUmur & " # " & (DateDiff(DateInterval.Day, Now, lahir) * -1)
        End If
        'hitUmur = hitUmur & " # " & m & " # " & d
    End Function

    Public Function ceknull(ByVal cek) As String
        If IsDBNull(cek) Then
            ceknull = ""
        Else
            ceknull = cek
        End If
    End Function
End Module
