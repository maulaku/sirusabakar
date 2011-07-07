Public Class ChangePwd

    Private Sub btnRubah_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnRubah.Click
        If txtpasswd.Text = getNumber("select sandiPengguna from msPengguna where status=1 and namaPengguna='" & MainMenu.StUser.Text & "'") Then
            If txtNewPwd.Text = txtKomPwd.Text Then
                execCmd("update msPengguna set sandiPengguna='" & txtNewPwd.Text & "' where status=1 and namaPengguna='" & MainMenu.StUser.Text & "'")
                Me.Close()
            Else
                MsgBox("Password baru tidak sama !", MsgBoxStyle.Exclamation, "Password Error")
            End If
        Else
            MsgBox("Password Salan !", MsgBoxStyle.Exclamation, "Password Error")
        End If
    End Sub

    Private Sub btnBatal_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnBatal.Click
        Me.Close()
    End Sub
End Class