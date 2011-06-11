Module ModuleSIRS
    Public koneksi As String
    Public PSQL As String

    Public con As New Odbc.OdbcConnection
    Public cmd As New Odbc.OdbcCommand
    Public dtreader As Odbc.OdbcDataReader
    Public dtadapter As New Odbc.OdbcDataAdapter
    Public idUser, idForm As Integer
    Public posisiForm, statusForm As String
    Sub bukaServer()
        Try
            con.ConnectionString = "DSN=RSBK;UID=sa;PWD=pingpong;"
            'con.ConnectionString = "DSN=RSBK"
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
    Public Function getNumber(ByVal sql As String) As String
        Try
            Call bukaServer()
            cmd.Connection = con
            cmd.CommandType = CommandType.Text
            cmd.CommandText = sql
            Return cmd.ExecuteScalar
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
End Module
