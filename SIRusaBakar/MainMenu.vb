
Public Class MainMenu
    'Protected Overrides Function ProcessCmdKey(ByRef msg As System.Windows.Forms.Message, ByVal keyData As System.Windows.Forms.Keys) As Boolean
    '    Try

    '        If msg.WParam.ToInt32 = Convert.ToInt32(Keys.Escape) Then
    '            'Dim tny As Integer
    '            'tny = MessageBox.Show("Mau Keluar dari Main Menu ?", "Konfirmasi", MessageBoxButtons.YesNo, MessageBoxIcon.Question)
    '            'If tny = vbYes Then
    '            Me.Dispose()
    '        Else
    '            Return MyBase.ProcessCmdKey(msg, keyData)
    '        End If
    '    Catch ex As Exception
    '        Return False
    '    End Try
    '    Return MyBase.ProcessCmdKey(msg, keyData)
    'End Function
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
    Private Sub PreLogin(ByVal val As Boolean)
        Me.SQLQueryToolStripMenuItem.Enabled = val
        Me.MasterToolStripMenuItem.Enabled = val
        Me.MedicalRecordToolStripMenuItem.Enabled = val
        Me.LaboratoriumToolStripMenuItem.Enabled = val
        Me.PoliklinikToolStripMenuItem.Enabled = val
        Me.WindowsToolStripMenuItem.Enabled = val
    End Sub
    Private Sub MainMenu_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Dim a As New Login
        'If StUser.Text = "UserName" Then
        '    Me.Enabled = False
        PreLogin(False)
        StUser.Text = a.get_login
        'End If
        If StUser.Text <> "" Then
            PreLogin(True)
        End If
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
        Dim a As New LayMRRegis
        a.Show()
        a.MdiParent = Me
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

    Private Sub KelurahanToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles KelurahanToolStripMenuItem.Click
        Dim a As New MMrKelurahan
        a.Show()
        a.MdiParent = Me
    End Sub

    Private Sub HubunganKelToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles HubunganKelToolStripMenuItem.Click
        Dim a As New MMrHubKel
        a.Show()
        a.MdiParent = Me
    End Sub

    Private Sub CaraPembayaranToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles CaraPembayaranToolStripMenuItem.Click
        Dim a As New MMrCaraPembayaran
        a.Show()
        a.MdiParent = Me
    End Sub

    Private Sub InstalasiToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles InstalasiToolStripMenuItem.Click
        Dim a As New MMrInstalasi
        a.Show()
        a.MdiParent = Me
    End Sub

    Private Sub KotaToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles KotaToolStripMenuItem.Click
        Dim a As New MMrKota
        a.Show()
        a.MdiParent = Me
    End Sub

    Private Sub JenisPerusahaanToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles JenisPerusahaanToolStripMenuItem.Click
        Dim a As New MPerush
        a.Show()
        a.MdiParent = Me
    End Sub

    Private Sub TitleToolStripMenuItem1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TitleToolStripMenuItem1.Click
        Dim a As New MMrTitle
        a.Show()
        a.MdiParent = Me
    End Sub

    Private Sub ExitToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ExitToolStripMenuItem.Click
        End
    End Sub

    Private Sub ChangeUserToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ChangeUserToolStripMenuItem.Click
        Dim a As New Login
        StUser.Text = ""
        If StUser.Text = "" Then
            PreLogin(False)
            StUser.Text = a.get_login
            If StUser.Text <> "" Then
                PreLogin(True)
            End If
        End If
    End Sub

    Private Sub MasterPenggunaToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MasterPenggunaToolStripMenuItem.Click
        Dim a As New MsPengguna
        a.Show()
        a.MdiParent = Me
    End Sub

    Private Sub ChangePasswordToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ChangePasswordToolStripMenuItem.Click
        Dim a As New ChangePwd
        a.Show()
        a.MdiParent = Me
    End Sub
End Class
