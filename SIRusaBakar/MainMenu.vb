
Public Class MainMenu
    Private Sub COAToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles COAToolStripMenuItem.Click
        Dim a As New MCoa
        a.Show()
        a.MdiParent = Me
    End Sub

    Private Sub GiziDietToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles GiziDietToolStripMenuItem.Click
        Dim a As New MGiziDiet
        a.Show()
        a.MdiParent = Me
    End Sub

    Private Sub GiziMenuToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles GiziMenuToolStripMenuItem.Click
        Dim a As New MGiziMenu
        a.Show()
        a.MdiParent = Me
    End Sub

    Private Sub LogistikAlkesToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles LogistikAlkesToolStripMenuItem.Click
        Dim a As New MLogAlkes
        a.Show()
        a.MdiParent = Me
    End Sub

    Private Sub LogistikInventoryDanATKToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles LogistikInventoryDanATKToolStripMenuItem.Click
        Dim a As New MLogInvATK
        a.Show()
        a.MdiParent = Me
    End Sub

    Private Sub ObatToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ObatToolStripMenuItem.Click
        Dim a As New MObat
        a.Show()
        a.MdiParent = Me
    End Sub

    Private Sub HargaObatToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles HargaObatToolStripMenuItem.Click
        Dim a As New MObatHarga
        a.Show()
        a.MdiParent = Me
    End Sub

    Private Sub TarifAmbulanceToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TarifAmbulanceToolStripMenuItem.Click
        Dim a As New MTarifAmbulance
        a.Show()
        a.MdiParent = Me
    End Sub

    Private Sub PendaftaranPasienBaruToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles PendaftaranPasienBaruToolStripMenuItem.Click
        Dim a As New LayMRDaftarPasien
        a.Show()
        a.MdiParent = Me
    End Sub

    Private Sub MainMenu_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

    End Sub
End Class
