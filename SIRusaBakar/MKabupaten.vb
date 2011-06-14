Public Class MKabupaten
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
                    tny = MessageBox.Show("Mau Keluar dari Master Kabupaten ?", "Konfirmasi", MessageBoxButtons.YesNo, MessageBoxIcon.Question)
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
    Sub tombolMati()
        btnNew.Enabled = False
        btnSave.Enabled = True
        btnDelete.Enabled = False
        btnEdit.Enabled = False

        btnSearch.Enabled = False
        btnRefresh.Enabled = False
    End Sub
    Sub tombolHidup()
        btnNew.Enabled = True
        btnSave.Enabled = False
        btnDelete.Enabled = True
        btnEdit.Enabled = True

        btnSearch.Enabled = True
        btnRefresh.Enabled = True
    End Sub
    Sub aktif()
        txtKabupaten.Enabled = True
        txtCatatan.Enabled = True

        DataGridView1.Enabled = False
    End Sub
    Sub nonAktif()
        txtKabupaten.Enabled = False
        txtCatatan.Enabled = False

        DataGridView1.Enabled = True
    End Sub
    Sub TampilDataGrid(ByVal sql As String)
        DataGridView1.DataSource = getTabel(sql)
        DataGridView1.Columns("id").Visible = False
        DataGridView1.Columns("catatan").Visible = False
        DataGridView1.SelectionMode = DataGridViewSelectionMode.FullRowSelect ' buat select 1 row
    End Sub
    Sub tampilData(ByVal row As Integer)
        If DataGridView1.RowCount = 0 Then
            MsgBox("Data Kabupaten : Tidak Ada", MsgBoxStyle.Information, "Data Diet")
            btnSearch.Enabled = False
            btnRefresh.Enabled = False
        Else
            txtCatatan.Text = ""
            idForm = DataGridView1.Item(0, row).Value
            txtKabupaten.Text = DataGridView1.Item(1, row).Value
            txtCatatanSebelumnya.Text = (DataGridView1.Item(2, row).Value).Replace(ControlChars.Lf, vbCrLf)
        End If
        formatGrid()
    End Sub
    Sub formatGrid()
        Dim dc As DataGridViewColumn
        For Each dc In DataGridView1.Columns
            Select Case dc.Name
                Case "namaKabupaten"
                    dc.HeaderText = "Nama Kabupaten"
                    dc.Width = 100
            End Select
        Next
    End Sub
    Sub kosong()
        txtKabupaten.Text = ""
    End Sub
    Private Sub MKabupaten_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Try
            tombolHidup()
            nonAktif()
            TampilDataGrid("select * from vwMsKabupaten")
            tampilData(0)

            If cmbSearch.SelectionLength <> 0 Then
                cmbSearch.SelectedIndex = 0
            End If
        Catch salah As Exception
            MessageBox.Show(salah.Message, "Error Load Form", MessageBoxButtons.OK, MessageBoxIcon.Error)
        End Try
    End Sub
    Private Sub btnNew_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnNew.Click
        statusForm = "NEW"
        tombolMati()
        kosong()
        aktif()
        txtKabupaten.Focus()
        txtCatatanSebelumnya.Text = ""
    End Sub
    Private Sub btnDelete_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnDelete.Click
        If txtKabupaten.Text = "" Then
            MsgBox("Tidak bisa melakukan delete!", MsgBoxStyle.Information, "Information")
        Else
            Dim tanya As Integer
            tanya = MessageBox.Show("Apakah kamu akan menghapus Kode : " + txtKabupaten.Text + " ?", "Konfirmasi", MessageBoxButtons.YesNo, MessageBoxIcon.Question)
            If tanya = vbYes Then
                statusForm = "DEL"
                kirimData()
                MessageBox.Show("Sukses Delete Data dengan Kode Diet : " & txtKabupaten.Text, "Information", MessageBoxButtons.OK, MessageBoxIcon.Information)

                TampilDataGrid("select * from vwmsKabupaten")
                tampilData(0)
            End If
        End If
    End Sub

    Private Sub btnEdit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnEdit.Click
        If txtKabupaten.Text = "" Then
            MsgBox("Tidak bisa melakukan Edit!", MsgBoxStyle.Information, "Information")
        Else
            statusForm = "EDIT"
            tombolMati()
            aktif()
            txtKabupaten.Focus()
        End If
    End Sub

    Private Sub btnSave_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSave.Click
        kirimData()
        Select Case statusForm
            Case "NEW"
                MessageBox.Show("Sukses Input Data BARU Diet dengan Kode Diet : " & txtKabupaten.Text, "Information", MessageBoxButtons.OK, MessageBoxIcon.Information)
            Case "EDIT"
                MessageBox.Show("Sukses Edit Data LAMA Diet dengan Kode Diet : " & txtKabupaten.Text, "Information", MessageBoxButtons.OK, MessageBoxIcon.Information)
        End Select
        TampilDataGrid("select * from vwMsKabupaten")
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
                tampilData(0)
                nonAktif()
                statusForm = ""
            Case "EDIt"
                tombolHidup()
                tampilData(0)
                nonAktif()
                statusForm = ""
            Case Else
                Me.Close()
        End Select
    End Sub

    Private Sub DataGridView1_CellClick(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles DataGridView1.CellClick
        tampilData(DataGridView1.CurrentRow.Index)
    End Sub

    Private Sub btnSearch_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSearch.Click
        If cmbSearch.SelectedIndex = 0 Then
            dataCari = "namaKabupaten"
        End If

        If txtSearch.Text = "" Then
            MessageBox.Show("Masukkan data untuk dicari !", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Exclamation)
        Else
            TampilDataGrid("SELECT * FROM vwmsKabupaten WHERE " & dataCari & " LIKE '%" & txtSearch.Text & "%'")

            If DataGridView1.RowCount = 0 Then
                MessageBox.Show("Data tidak ada !", "Information", MessageBoxButtons.OK, MessageBoxIcon.Exclamation)
                btnRefresh.PerformClick()
            Else
                tampilData(0)
            End If
        End If
    End Sub
    Private Sub cmbSearch_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles cmbSearch.KeyPress
        e.Handled = True
    End Sub
    Private Sub txtCatatanSebelumnya_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtCatatanSebelumnya.KeyPress
        e.Handled = True
    End Sub

    Private Sub btnRefresh_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnRefresh.Click
        TampilDataGrid("select * from vwmsKabupaten")
        tampilData(0)
        txtSearch.Text = ""
        txtSearch.Focus()
    End Sub
    Private Sub txtSearch_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtSearch.KeyPress
        If e.KeyChar = ChrW(13) Then
            btnSearch.PerformClick()
        End If
    End Sub

    Private Sub DataGridView1_CellDoubleClick(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles DataGridView1.CellDoubleClick
        btnEdit.PerformClick()
    End Sub

    Private Sub DataGridView1_KeyUp(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles DataGridView1.KeyUp
        tampilData(DataGridView1.CurrentRow.Index)
    End Sub

    Private Sub btnLast_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnLast.Click
        DataGridView1.CurrentCell = DataGridView1.Item(1, DataGridView1.RowCount - 1)
        tampilData(DataGridView1.CurrentRow.Index)
    End Sub

    Private Sub btnFirst_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnFirst.Click
        DataGridView1.CurrentCell = DataGridView1.Item(1, 0)
        tampilData(DataGridView1.CurrentRow.Index)
    End Sub

    Private Sub btnPrev_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnPrev.Click
        Dim i As Integer
        If DataGridView1.CurrentRow Is Nothing Then
            i = 1
        Else
            i = DataGridView1.CurrentRow.Index
        End If
        If i - 1 >= 0 Then
            DataGridView1.CurrentCell = DataGridView1.Item(1, i - 1)
            tampilData(DataGridView1.CurrentRow.Index)
        End If
    End Sub

    Private Sub btnNext_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnNext.Click
        Dim i As Integer
        If DataGridView1.CurrentRow Is Nothing Then
            i = -1
        Else
            i = DataGridView1.CurrentRow.Index
        End If
        If i + 1 < DataGridView1.RowCount Then
            DataGridView1.CurrentCell = DataGridView1.Item(1, i + 1)
            tampilData(DataGridView1.CurrentRow.Index)
        End If
    End Sub

    Private Sub kirimData()
        Try
            PSQL = "EXEC spMsKabupaten" & _
                    " '" & statusForm & "'," & _
                    "  " & idForm & "," & _
                    " '" & txtKabupaten.Text & "'," & _
                    " '" & txtCatatan.Text & "'," & _
                    "  " & idUser & "," & _
                    " '" & keterangan & "'"
            execCmd(PSQL)
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

End Class