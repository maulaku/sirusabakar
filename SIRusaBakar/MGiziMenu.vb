Public Class MGiziMenu
    Dim status As Integer = 0
    Dim dataCari As String
    Dim keterangan As String
    Protected Overrides Function ProcessCmdKey(ByRef msg As System.Windows.Forms.Message, ByVal keyData As System.Windows.Forms.Keys) As Boolean
        Try
            If msg.WParam.ToInt32 = Convert.ToInt32(Keys.F2) Then
                If statusForm <> "edit" Then
                    btnNew.PerformClick()
                End If
            ElseIf msg.WParam.ToInt32 = Convert.ToInt32(Keys.F3) Then
                If statusForm <> "new" Then
                    btnEdit.PerformClick()
                End If
            ElseIf msg.WParam.ToInt32 = Convert.ToInt32(Keys.F4) Then
                btnSave.PerformClick()
            ElseIf msg.WParam.ToInt32 = Convert.ToInt32(Keys.F5) Then
                btnRefresh.PerformClick()
            ElseIf msg.WParam.ToInt32 = Convert.ToInt32(Keys.Up) Or msg.WParam.ToInt32 = Convert.ToInt32(Keys.Down) Then
                DataGridView1.Focus()
            ElseIf msg.WParam.ToInt32 = Convert.ToInt32(Keys.Escape) Then
                If statusForm = "NEW" Or statusForm = "EDIT" Then
                    btnCancel.PerformClick()
                Else
                    Dim tny As Integer
                    tny = MessageBox.Show("Mau Keluar dari Master COA ?", "Konfirmasi", MessageBoxButtons.YesNo, MessageBoxIcon.Question)
                    If tny = vbYes Then
                        Me.Dispose()
                    Else
                        Return MyBase.ProcessCmdKey(msg, keyData)
                    End If
                End If
            ElseIf msg.WParam.ToInt32 = Convert.ToInt32(Keys.Delete) Then
                btnDelete.PerformClick()
            Else
                Return MyBase.ProcessCmdKey(msg, keyData)
            End If
        Catch ex As Exception
            Return False
        End Try
        Return MyBase.ProcessCmdKey(msg, keyData)
    End Function
    Private Sub tombolMati()
        btnNew.Enabled = False
        btnSave.Enabled = True
        btnDelete.Enabled = False
        btnEdit.Enabled = False
        btnSearch.Enabled = False
        btnRefresh.Enabled = False
    End Sub
    Private Sub tombolHidup()
        btnNew.Enabled = True
        btnSave.Enabled = False
        btnDelete.Enabled = True
        btnEdit.Enabled = True
        btnSearch.Enabled = True
        btnRefresh.Enabled = True
    End Sub
    Private Sub aktif()
        txtKodeMenu.Enabled = True
        txtKodeDiet.Enabled = True
        txtNamaDiet.Enabled = True
        txtCatatan.Enabled = True
        txtKelompok.Enabled = True
        cmbWaktu.Enabled = True
        btnDiet.Enabled = True
        grpMakanan.Enabled = True
        DataGridView2.Enabled = False
    End Sub
    Private Sub nonAktif()
        txtKodeMenu.Enabled = False
        txtKodeDiet.Enabled = False
        txtNamaDiet.Enabled = False
        txtCatatan.Enabled = False
        txtKelompok.Enabled = False
        cmbWaktu.Enabled = False
        btnDiet.Enabled = False
        grpMakanan.Enabled = False
        DataGridView2.Enabled = True
    End Sub
    Private Sub tampilgriddetail(ByVal sql As String)
        DataGridView1.DataSource = getTabel(sql)
        DataGridView1.Columns("id").Visible = False
        DataGridView1.Columns("id_menumakanan").Visible = False
        DataGridView1.Columns("kodemenumakanan").Visible = False
        DataGridView1.Columns("id_makanan").Visible = False
        formatGridDet()
    End Sub
    Private Sub formatGridDet()
        Dim dc As DataGridViewColumn
        For Each dc In DataGridView1.Columns
            Select Case dc.Name
                Case "namamakanan"
                    dc.HeaderText = "Nama Makanan"
                Case "jumlah"
                    dc.HeaderText = "Jumlah"
            End Select
        Next
    End Sub
    Private Sub tampildataDetail(ByVal row As Integer)
        If DataGridView1.RowCount > 0 Then
            txtNamaMakanan.Text = DataGridView1.Item("namamakanan", row).Value
            txtJumlah.Text = DataGridView1.Item("jumlah", row).Value
        End If
    End Sub
    Private Sub TampilDataGrid(ByVal sql As String)
        DataGridView2.DataSource = getTabel(sql)
        DataGridView2.Columns("id").Visible = False
        DataGridView2.Columns("id_diet").Visible = False
        DataGridView2.Columns("catatan").Visible = False
        DataGridView2.SelectionMode = DataGridViewSelectionMode.FullRowSelect ' buat select 1 row
        formatGrid()
    End Sub
    Private Sub tampilData(ByVal row As Integer)
        If DataGridView2.RowCount = 0 Then
            MsgBox("Data Menu Diet : Tidak Ada", MsgBoxStyle.Information, "Data Menu Diet")
            btnSearch.Enabled = False
            btnRefresh.Enabled = False
        Else
            'txtCatatan.Text = ""
            idForm = DataGridView2.Item("id", row).Value
            txtKodeMenu.Text = DataGridView2.Item("kodemenumakanan", row).Value
            txtKodeDiet.Text = DataGridView2.Item("kodediet", row).Value
            txtNamaDiet.Text = DataGridView2.Item("namadiet", row).Value
            txtKelompok.Text = DataGridView2.Item("kelompok", row).Value
            cmbWaktu.Text = DataGridView2.Item("waktu", row).Value
            txtCatatanSebelumnya.Text = (DataGridView2.Item("catatan", row).Value).Replace(ControlChars.Lf, vbCrLf)
            If idForm <> "" Then
                tampilgriddetail("select * from vwMsMenuMakananDet where id_memumakanan=" & idForm)
                tampildataDetail(0)
            End If
        End If
    End Sub
    Private Sub formatGrid()
        Dim dc As DataGridViewColumn
        For Each dc In DataGridView2.Columns
            Select Case dc.Name
                Case "kodemenumakanan"
                    dc.HeaderText = "Kode Menu Makanan"
                    dc.Width = 100
                Case "kodediet"
                    dc.HeaderText = "Kode Diet"
                    dc.Width = 100
                Case "namadiet"
                    dc.HeaderText = "Nama Diet"
                    dc.Width = 100
                Case "kelompok"
                    dc.HeaderText = "Kelompok"
                    dc.Width = 100
                Case "waktu"
                    dc.HeaderText = "Waktu"
                    dc.Width = 100
            End Select
        Next
    End Sub
    Private Sub kosong()
        txtKodeMenu.Text = ""
        txtKodeDiet.Text = ""
        txtNamaDiet.Text = ""
        txtKelompok.Text = ""
        cmbWaktu.SelectedIndex = 0
    End Sub
    Private Sub kirimData()
        Try
            PSQL = "EXEC spMsMenuMakanan" & _
                    " '" & statusForm & "'," & _
                    "  " & idForm & "," & _
                    " '" & txtKodeMenu.Text & "'," & _
                    " '" & IDdiet.Text & "'," & _
                    " '" & txtKelompok.Text & "'," & _
                    " '" & cmbWaktu.SelectedText & "'," & _
                    " '" & txtCatatan.Text & "'," & _
                    "  " & idUser & " "
            execCmd(PSQL)
            For i As Integer = 0 To DataGridView1.RowCount - 1

            Next
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub
    Private Sub MCoa_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        odbc = "RSBK"
        Try
            tombolHidup()
            nonAktif()
            TampilDataGrid("select * from vwMsMenuMakanan")
            tampilData(0)
            cmbSearch.SelectedIndex = 0

            Me.txtSearch.TextBox.Select()
        Catch ex As Exception
            MessageBox.Show(ex.Message, "Error Load Form", MessageBoxButtons.OK, MessageBoxIcon.Error)
        End Try
    End Sub
    Private Sub btnNew_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnNew.Click
        statusForm = "NEW"
        tombolMati()
        kosong()
        aktif()
        txtKodeMenu.Focus()
        txtCatatanSebelumnya.Text = ""
    End Sub
    Private Sub btnDelete_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnDelete.Click
        If txtKodeMenu.Text = "" Then
            MsgBox("Tidak bisa melakukan delete!", MsgBoxStyle.Information, "Information")
        Else
            Dim tanya As Integer
            tanya = MessageBox.Show("Apakah kamu akan menghapus Menu : " + txtKodeMenu.Text + " ?", "Konfirmasi", MessageBoxButtons.YesNo, MessageBoxIcon.Question)
            If tanya = vbYes Then
                statusForm = "DEL"
                kirimData()
                MessageBox.Show("Sukses Delete Data dengan Menu : " & txtKodeMenu.Text, "Information", MessageBoxButtons.OK, MessageBoxIcon.Information)
                TampilDataGrid("select * from vwmsmenumakanan")
                tampilData(0)
            End If
        End If
    End Sub
    Private Sub btnEdit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnEdit.Click
        If txtKodeMenu.Text = "" Then
            MsgBox("Tidak bisa melakukan Edit!", MsgBoxStyle.Information, "Information")
        Else
            statusForm = "EDIT"
            tombolMati()
            aktif()
            txtKodeMenu.Focus()
        End If
    End Sub
    Private Sub btnSave_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSave.Click
        If cekdata Then
            kirimData()
            Select Case statusForm
                Case "NEW"
                    MessageBox.Show("Sukses Input Data Kode Menu Makanan : " & txtKodeMenu.Text, "Information", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Case "EDIT"
                    MessageBox.Show("Sukses Edit Data Kode Menu Makanan : " & txtKodeMenu.Text, "Information", MessageBoxButtons.OK, MessageBoxIcon.Information)
            End Select
        End If
        TampilDataGrid("select * from vwMsMenuMakanan")
        tampilData(0)
        tombolHidup()
        nonAktif()
        txtSearch.Focus()
        statusForm = ""
    End Sub
    Private Sub btnCancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        Select Case statusForm
            Case "NEW"
                tombolHidup()
                tampilData(DataGridView2.CurrentRow.Index)
                nonAktif()
                statusForm = ""
            Case "EDIT"
                tombolHidup()
                tampilData(DataGridView2.CurrentRow.Index)
                nonAktif()
                statusForm = ""
                'Case Else
                '    Me.Close()
        End Select
    End Sub
    Private Sub DataGridView1_CellClick(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles DataGridView1.CellClick
        tampilData(DataGridView2.CurrentRow.Index)
    End Sub
    Private Sub btnSearch_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSearch.Click
        If cmbSearch.SelectedIndex = 0 Then
            dataCari = "kodemenumakanan"
        ElseIf cmbSearch.SelectedIndex = 1 Then
            dataCari = "kodediet"
        Else
            dataCari = "kelompok"
        End If

        If txtSearch.Text = "" Then
            MessageBox.Show("Masukkan data untuk dicari !", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Exclamation)
        Else
            TampilDataGrid("SELECT * FROM vwmsmenumakanan WHERE " & dataCari & " LIKE '%" & txtSearch.Text & "%'")

            If DataGridView1.RowCount = 0 Then
                MessageBox.Show("Data tidak ada !", "Information", MessageBoxButtons.OK, MessageBoxIcon.Exclamation)
                btnRefresh.PerformClick()
            Else
                tampilData(0)
            End If
        End If
    End Sub
    Private Sub cmbSearch_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs)
        e.Handled = True
    End Sub
    Private Sub txtCatatanSebelumnya_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs)
        e.Handled = True
    End Sub
    Private Sub btnRefresh_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnRefresh.Click
        TampilDataGrid("select * from vwmsMenuMakanan")
        tampilData(0)
        txtSearch.Text = ""
        txtSearch.Focus()
    End Sub
    Private Sub txtSearch_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtSearch.KeyPress
        If e.KeyChar = ChrW(13) Then
            btnSearch.PerformClick()
        End If
    End Sub
    Private Sub DataGridView1_KeyUp(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles DataGridView1.KeyUp
        tampildataDetail(DataGridView2.CurrentRow.Index)
    End Sub
    Private Sub DataGridView1_CellDoubleClick(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles DataGridView1.CellDoubleClick
        btnEdit.PerformClick()
    End Sub

    Private Sub btnLast_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnLast.Click
        DataGridView1.CurrentCell = DataGridView1.Item(1, DataGridView1.RowCount - 1)
        tampilData(DataGridView2.CurrentRow.Index)
    End Sub

    Private Sub btnFirst_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnFirst.Click
        DataGridView1.CurrentCell = DataGridView1.Item(1, 0)
        tampilData(DataGridView2.CurrentRow.Index)
    End Sub

    Private Sub btnNext_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnNext.Click
        Dim i As Integer
        If DataGridView2.CurrentRow Is Nothing Then
            i = -1
        Else
            i = DataGridView2.CurrentRow.Index
        End If
        If i + 1 < DataGridView2.RowCount Then
            DataGridView2.CurrentCell = DataGridView1.Item(1, i + 1)
            tampilData(DataGridView2.CurrentRow.Index)
        End If
    End Sub

    Private Sub btnPrev_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnPrev.Click
        Dim i As Integer
        If DataGridView2.CurrentRow Is Nothing Then
            i = 1
        Else
            i = DataGridView2.CurrentRow.Index
        End If
        If i - 1 >= 0 Then
            DataGridView2.CurrentCell = DataGridView2.Item(1, i - 1)
            tampilData(DataGridView2.CurrentRow.Index)
        End If
    End Sub
    Private Function cekdata() As Boolean
        If txtKodeMenu.Text = "" Then
            Return False
        ElseIf txtKodeDiet.Text = "" Then
            Return False
        ElseIf txtNamaDiet.Text = "" Then
            Return False
        Else
            Return True
        End If
    End Function

    Private Sub btnDiet_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnDiet.Click
        Dim frm2 As New CariData
        IDdiet.Text = frm2.GetSelection("select ID,kodediet as 'Kode Diet',namadiet as 'Nama Diet' from msDiet where status=1", "Pilih Diet")
    End Sub

    Private Sub IDdiet_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles IDdiet.TextChanged
        If IDdiet.Text <> "" Then
            txtKodeDiet.Text = getNumber("select kodediet from msDiet where status=1 and id=" & IDdiet.Text)
            txtNamaDiet.Text = getNumber("select namadiet from msDiet where status=1 and id=" & IDdiet.Text)
        End If
    End Sub

    Private Sub btnMakanan_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnMakanan.Click
        Dim frm2 As New CariData
        IDmakanan.Text = frm2.GetSelection("select ID,namaMakanan as 'Nama Makanan' from msMakanan where status=1", "Pilih Makanan")
    End Sub

    Private Sub IDmakanan_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles IDmakanan.TextChanged
        If IDmakanan.Text <> "" Then
            txtNamaMakanan.Text = getNumber("select namamakanan from msmakanan where status=1 and id=" & IDmakanan.Text)
        End If
    End Sub

    Private Sub DataGridView2_KeyUp(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles DataGridView2.KeyUp
        tampildataDetail(DataGridView1.CurrentRow.Index)
    End Sub

    Private Sub DataGridView2_CellClick(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles DataGridView2.CellClick
        tampildataDetail(DataGridView1.CurrentRow.Index)
    End Sub

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        DataGridView1.Rows.Add()
        DataGridView1.Item("id", DataGridView1.RowCount).Value = idForm
        DataGridView1.Item("id_menumakanan", DataGridView1.RowCount).Value = IDmakanan.Text
        DataGridView1.Item("kodemakanan", DataGridView1.RowCount).Value = txtKodeMenu.Text
        DataGridView1.Item("namamakanan", DataGridView1.RowCount).Value = txtNamaMakanan.Text
        DataGridView1.Item("jumlah", DataGridView1.RowCount).Value = txtJumlah.Text
    End Sub

    Private Sub Button2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button2.Click
        DataGridView1.Rows.Remove(DataGridView1.CurrentRow)
    End Sub
End Class