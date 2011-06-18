Public Class TSQL

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        Try
            For i As Integer = 0 To QueryText.Lines.Length - 1
                If QueryText.Lines(i) <> "" Then
                    'MessageBox.Show(QueryText.Lines(i))
                    execCmd(QueryText.Lines(i))
                End If
            Next
            MsgBox("Data berhasil di upload", MsgBoxStyle.Information, "Sukses")
        Catch ex As Exception

        End Try
    End Sub

    Private Sub Button2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button2.Click
        QueryText.Text = ""
    End Sub

    Private Sub TSQL_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

    End Sub
End Class