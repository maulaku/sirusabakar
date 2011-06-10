Module ModuleSIRS
    Public koneksi As String
    Public PSQL As String

    'Public con As New SqlClient.SqlConnection
    Public con As New Odbc.OdbcConnection

    'Public cmd As New SqlClient.SqlCommand
    Public cmd As New Odbc.OdbcCommand

    'Public dtreader As SqlClient.SqlDataReader
    Public dtreader As Odbc.OdbcDataReader

    'Public dtadapter As New SqlClient.SqlDataAdapter
    Public dtadapter As New Odbc.OdbcDataAdapter

    Public idUser, idForm As Integer
    Public posisiForm, statusForm As String

    Sub bukaServer()
        Try
            'koneksi = "Data Source=XPINX2PIN\SQLEXPRESS;Initial Catalog=RSBK;Integrated Security=True"
            'koneksi = "DSN=RSBK"
            'con = New SqlClient.SqlConnection(koneksi)
            'con = New Odbc.OdbcConnection(koneksi)

            con.ConnectionString = "DSN=RSBK;UID=sa;PWD=pingpong;"
            con.Open()
            idUser = 1
        Catch salah As Exception
            MessageBox.Show(salah.Message, "Error koneksi", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End
        End Try
    End Sub

    Sub matiServer()
        con.Close()
        'cmd.Dispose()
    End Sub

    Public Function get_number(ByVal sql As String) As String
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

    Public Sub exec_cmd(ByVal sql As String)
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


    Public Function get_tabel(ByVal sql As String) As DataTable
        Try
            Call bukaServer()
            get_tabel = New DataTable
            dtadapter = New Odbc.OdbcDataAdapter(sql, con)
            dtadapter.Fill(get_tabel)
            dtadapter.Dispose()
            dtadapter = Nothing
            Call matiServer()
        Catch salah As Exception
            MessageBox.Show(salah.Message, "Table Failed to Fill", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End
        End Try
    End Function


End Module
