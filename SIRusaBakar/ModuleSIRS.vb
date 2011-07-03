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
        Dim y, m, d As Integer
        If lahir > Now Then
            hitUmur = ""
        End If
        If Year(lahir) = Year(Now) Then
            If Month(lahir) = Month(Now) Then
                d = DateDiff(DateInterval.Day, lahir, Now)
            Else
                d = DateDiff(DateInterval.Day, DateValue(DatePart(DateInterval.Month, Now) & "/1/" & Year(lahir)), DateValue(DatePart(DateInterval.Month, Now) & "/1/" & Year(Now)))
            End If
        End If
        If Year(lahir) = Year(Now) Then
            m = DateDiff(DateInterval.Month, DateValue("Jan/1/" & Year(lahir)), DateValue("Jan/1/" & Year(Now)))
        End If
        y = DateDiff(DateInterval.Year, Now, lahir) * -1

        hitUmur = y & " Tahun # " & m & " Bulan # " & d & " Hari"
    End Function

    Public Function ceknull(ByVal cek) As String
        If IsDBNull(cek) Then
            ceknull = ""
        Else
            ceknull = cek
        End If
    End Function
End Module
