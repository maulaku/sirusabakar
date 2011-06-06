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
            koneksi = "Data Source=XPINX2PIN\SQLEXPRESS;Initial Catalog=RSBK;Integrated Security=True"
            'con = New SqlClient.SqlConnection(koneksi)
            con = New Odbc.OdbcConnection(koneksi)
            con.Open()
            idUser = 1
        Catch salah As Exception
            MessageBox.Show(salah.Message, "Error koneksi", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End
        End Try
    End Sub
    Sub matiServer()
        con.Close()
        cmd.Dispose()
    End Sub
End Module
