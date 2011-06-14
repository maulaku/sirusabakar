
Public Class MainMenu

    Private Sub ArrangeIconsToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ArrangeIconsToolStripMenuItem.Click
        Me.LayoutMdi(MdiLayout.ArrangeIcons)
    End Sub

    Private Sub TitleHorizontalToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TitleHorizontalToolStripMenuItem.Click
        Me.LayoutMdi(MdiLayout.TileHorizontal)
    End Sub

    Private Sub TitleToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TitleToolStripMenuItem.Click
        Me.LayoutMdi(MdiLayout.TileVertical)
    End Sub

    Private Sub CascadeToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles CascadeToolStripMenuItem.Click
        Me.LayoutMdi(MdiLayout.Cascade)
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

    Private Sub COAToolStripMenuItem1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles COAToolStripMenuItem1.Click
        Dim a As New MCoa
        a.Show()
        a.MdiParent = Me
    End Sub

    Private Sub DietToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles DietToolStripMenuItem.Click
        Dim a As New MGiziDiet
        a.Show()
        a.MdiParent = Me
    End Sub

    Private Sub MenuToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MenuToolStripMenuItem.Click
        Dim a As New MGiziMenu
        a.Show()
        a.MdiParent = Me
    End Sub

    Private Sub MakananToolStripMenuItem1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MakananToolStripMenuItem1.Click
        Dim a As New MGiziMakanan
        a.Show()
        a.MdiParent = Me
    End Sub

    Private Sub RegistrasiPasienToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles RegistrasiPasienToolStripMenuItem.Click

    End Sub

    Private Sub AgamaToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles AgamaToolStripMenuItem.Click
        Dim a As New MMrAgama
        a.Show()
        a.MdiParent = Me
    End Sub

    Private Sub PendidikanToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles PendidikanToolStripMenuItem.Click
        Dim a As New MMrPendidikan
        a.Show()
        a.MdiParent = Me
    End Sub

    Private Sub SQLQueryToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles SQLQueryToolStripMenuItem.Click
        Dim a As New TSQL
        a.Show()
        a.MdiParent = Me
    End Sub

    Private Sub PropinsiToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles PropinsiToolStripMenuItem.Click
        Dim a As New MMrPropinsi
        a.Show()
        a.MdiParent = Me
    End Sub

    Private Sub KabupatenToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles KabupatenToolStripMenuItem.Click
        Dim a As New MMrKabupaten
        a.Show()
        a.MdiParent = Me
    End Sub

    Private Sub PekerjaanToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles PekerjaanToolStripMenuItem.Click
        Dim a As New MMrPekerjaan
        a.Show()
        a.MdiParent = Me
    End Sub

    Private Sub KecamatanToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles KecamatanToolStripMenuItem.Click
        Dim a As New MMrKecamatan
        a.Show()
        a.MdiParent = Me
    End Sub
End Class
