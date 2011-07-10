Public Class LayMRRegis
    Dim dttable As New DataTable
    Dim status As Integer = 0
    Dim dataCari As String
    Dim idLayMrDaftar As Integer
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
                If statusForm = "new" Or statusForm = "edit" Then
                    btnCancel.PerformClick()
                Else
                    Dim tny As Integer
                    tny = MessageBox.Show("Mau Keluar dari Layanan Medical Record : Registrasi Pasien ?", "Konfirmasi", MessageBoxButtons.YesNo, MessageBoxIcon.Question)
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
        'txtNoRegis.Enabled = False
        txtNoMR.Enabled = True
        txtNamaPasien.Enabled = True
        cmbAsalPasien.Enabled = True

        cmbTujuanBerobat.Enabled = True
        txtNamaPerujuk.Enabled = True
        txtNamaDokter.Enabled = True
        cmbCaraPembayaran.Enabled = True
        txtNamaAsuransi.Enabled = True
        txtNamaPerusahaan.Enabled = True

        txtNoKartu.Enabled = True
        txtNoPolis.Enabled = True
        DataGridView1.Enabled = False
    End Sub
    Private Sub nonAktif()
        'txtNoRegis.Enabled = True
        txtNoMR.Enabled = False
        txtNamaPasien.Enabled = False
        cmbAsalPasien.Enabled = False

        cmbTujuanBerobat.Enabled = False
        txtNamaPerujuk.Enabled = False
        txtNamaDokter.Enabled = False
        cmbCaraPembayaran.Enabled = False
        txtNamaAsuransi.Enabled = False
        txtNamaPerusahaan.Enabled = False

        txtNoKartu.Enabled = False
        txtNoPolis.Enabled = False
        DataGridView1.Enabled = True
    End Sub
    Private Sub generateNoRegis()
        Dim lastKode As String
        Try
            Call bukaServer()
            PSQL = "SELECT TOP 1 id,noRegis FROM trLayMRRegis ORDER BY id DESC"
            cmd = New Odbc.OdbcCommand(PSQL, con)
            lastKode = cmd.ExecuteScalar

            Dim formatWaktu As String
            formatWaktu = Format(Now(), "yyyyMMdd")

            If lastKode = "" Then
                lblNoRegis.Text = lblNoRegis.Text + "00001"
                Exit Sub
            End If

            Dim id As Integer = Val(Strings.Mid(lastKode, 3, 5))
            Select Case id
                Case 1 To 8 : lblNoRegis.Text = formatWaktu & "00" & id + 1
                Case 9 To 98 : lblNoRegis.Text = formatWaktu & "0" & id + 1
                Case 99 To 998 : lblNoRegis.Text = formatWaktu & id + 1

                Case Is = 998 : MsgBox("No. Registrasi Terakhir", MsgBoxStyle.Critical, "Warning")
                    lblNoRegis.Text = formatWaktu & id + 1
                Case Is = 99999 : MsgBox("No. Registrasi sudah Habis", MsgBoxStyle.Critical, "Warning")
                    lblNoRegis.Text = "HABIS"
                    Me.Dispose()
            End Select
            matiServer()
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub
    Private Sub tampilDataGrid(ByVal sql As String)
        DataGridView1.DataSource = getTabel(sql)
        For i As Integer = 0 To DataGridView1.ColumnCount - 1
            DataGridView1.Columns(i).Visible = False
        Next

        DataGridView1.Columns("tglRegis").Visible = True 'Tanggal Regis
        DataGridView1.Columns("noRegis").Visible = True 'No. Regis
        'DataGridView1.Columns("namaPasien").Visible = True 'Nama Pasien
        DataGridView1.SelectionMode = DataGridViewSelectionMode.FullRowSelect ' buat select 1 row
        DataGridView1.AllowUserToAddRows = False
    End Sub
    Private Sub tampilData(ByVal row As Integer)
        If DataGridView1.RowCount = 0 Then
            MsgBox("Data Registrasi : Tidak Ada", MsgBoxStyle.Information, "Data Registrasi")
            btnSearch.Enabled = False
            btnRefresh.Enabled = False
        Else
            idForm = DataGridView1.Item(0, row).Value
            idLayMRDaftar = DataGridView1.Item(1, row).Value
            txtNoMR.Text = DataGridView1.Item(2, row).Value
            txtNamaPasien.Text = DataGridView1.Item(15, row).Value
            cmbTglRegis.Text = DataGridView1.Item(3, row).Value
            'txtNoRegis.Text = DataGridView1.Item(4, row).Value
            cmbAsalPasien.Text = DataGridView1.Item(5, row).Value

            cmbTujuanBerobat.Text = DataGridView1.Item(6, row).Value
            txtNamaPerujuk.Text = DataGridView1.Item(7, row).Value
            txtNamaDokter.Text = DataGridView1.Item(8, row).Value
            cmbCaraPembayaran.Text = DataGridView1.Item(9, row).Value
            txtNamaAsuransi.Text = DataGridView1.Item(10, row).Value
            txtNamaPerusahaan.Text = DataGridView1.Item(11, row).Value

            txtNoKartu.Text = DataGridView1.Item(12, row).Value
            txtNoPolis.Text = DataGridView1.Item(13, row).Value
            txtCatatan.Text = DataGridView1.Item(14, row).Value
            txtCatatanSebelumnya.Text = (DataGridView1.Item(4, row).Value).Replace(ControlChars.Lf, vbCrLf)
        End If
        formatGrid()
    End Sub
    Private Sub formatGrid()
        Dim dc As DataGridViewColumn
        For Each dc In DataGridView1.Columns
            Select Case dc.Name
                Case "tglRegis"
                    dc.HeaderText = "Tanggal Registrasi"
                    dc.Width = 100
                Case "noRegis"
                    dc.HeaderText = "Nomor Registrasi"
                    dc.Width = 100
            End Select
        Next
    End Sub
    Private Sub kosong()
        txtNoMR.Text = ""
        txtNamaPasien.Text = ""
        txtNamaPerujuk.Text = ""
        txtNamaDokter.Text = ""
        txtNamaAsuransi.Text = ""
        txtNamaPerusahaan.Text = ""
        txtNoKartu.Text = ""
        txtNoPolis.Text = ""
        txtCatatan.Text = ""
    End Sub
    Private Sub LoadCb()
        Dim tTitle As New DataTable
        Dim tAgama As New DataTable
        Dim tPendidikan As New DataTable
        Dim tPekerjaan As New DataTable
        Dim tHubungan As New DataTable

        'load cmbAsalPasien
        cmbAsalPasien.Items.Clear()
        tTitle = getTabel("select id,namaAsalPasien from vwMsAsalPasien")
        cmbAsalPasien.DataSource = tTitle
        cmbAsalPasien.DisplayMember = "namaAsalPasien"
        cmbAsalPasien.ValueMember = "id"

        'load cmbcarapembayaran
        cmbCaraPembayaran.Items.Clear()
        tTitle = getTabel("select id,namaCaraPembayaran from vwMsCaraPembayaran")
        cmbCaraPembayaran.DataSource = tTitle
        cmbCaraPembayaran.DisplayMember = "namaCaraPembayaran"
        cmbCaraPembayaran.ValueMember = "id"

        'load cmbtujuanberobat
        cmbTujuanBerobat.Items.Clear()
        tTitle = getTabel("select id,namaInstalasi from vwMsInstalasi")
        cmbTujuanBerobat.DataSource = tTitle
        cmbTujuanBerobat.DisplayMember = "namaInstalasi"
        cmbTujuanBerobat.ValueMember = "id"

    End Sub
    Private Sub LayMRRegis_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Try
        tombolHidup()
        nonAktif()
        tampilDataGrid("select * from vwLayMRRegis")
        tampilData(0)
        cmbSearch.SelectedIndex = 0
        LoadCb()
        generateNoRegis()

        Me.txtSearch.TextBox.Select()
        'Catch ex As Exception
        '    MessageBox.Show(ex.Message, "Error Load Form", MessageBoxButtons.OK, MessageBoxIcon.Error)
        'End Try
    End Sub

    Private Sub btnNew_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnNew.Click
        statusForm = "NEW"
        tombolMati()
        kosong()
        aktif()
        txtNoMR.Focus()
        txtCatatanSebelumnya.Text = ""
    End Sub

    Private Sub btnDelete_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnDelete.Click
        If lblNoRegis.Text = "" Then
            MsgBox("Tidak bisa melakukan delete!", MsgBoxStyle.Information, "Information")
        Else
            Dim tanya As Integer
            tanya = MessageBox.Show("Apakah kamu akan menghapus No. Registrasi : " + lblNoRegis.Text + " ?", "Konfirmasi", MessageBoxButtons.YesNo, MessageBoxIcon.Question)
            If tanya = vbYes Then
                statusForm = "DEL"

                MessageBox.Show("Sukses Delete Data dengan No. Registrasi : " & lblNoRegis.Text, "Information", MessageBoxButtons.OK, MessageBoxIcon.Information)

                tampilDataGrid("select * from vwTrLayMRRegis")
                tampilData(0)
            End If
        End If
    End Sub

    Private Sub btnEdit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnEdit.Click
        If lblNoRegis.Text = "" Then
            MsgBox("Tidak bisa melakukan Edit!", MsgBoxStyle.Information, "Information")
        Else
            statusForm = "EDIT"
            tombolMati()
            aktif()
            txtNamaPasien.Focus()
        End If
    End Sub

    Private Sub btnSave_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Select Case statusForm
            Case "NEW"
                MessageBox.Show("Sukses Input Data BARU Regis Pasien dengan No. Regis : " & lblNoRegis.Text, "Information", MessageBoxButtons.OK, MessageBoxIcon.Information)
            Case "EDIT"
                MessageBox.Show("Sukses Edit Data LAMA Regis Pasien dengan No. Regis : " & lblNoRegis.Text, "Information", MessageBoxButtons.OK, MessageBoxIcon.Information)
        End Select

        tampilDataGrid("SELECT * FROM vwTrLayMRRegis")
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
                tampilData(DataGridView1.CurrentRow.Index)
                nonAktif()
                statusForm = ""
            Case "EDIT"
                tombolHidup()
                tampilData(DataGridView1.CurrentRow.Index)
                nonAktif()
                statusForm = ""
        End Select
    End Sub

    Private Sub DataGridView1_CellClick(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles DataGridView1.CellClick
        tampilData(DataGridView1.CurrentRow.Index)
    End Sub

    Private Sub btnSearch_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSearch.Click
        If cmbSearch.SelectedIndex = 0 Then
            dataCari = "kodeCoa"
        ElseIf cmbSearch.SelectedIndex = 1 Then
            dataCari = "namaCoa"
        Else
            dataCari = "tipeCoa"
        End If

        If txtSearch.Text = "" Then
            MessageBox.Show("Masukkan data untuk dicari !", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Exclamation)
        Else
            TampilDataGrid("SELECT * FROM vwTrLayMRRegis WHERE " & dataCari & " LIKE '%" & txtSearch.Text & "%'")

            If DataGridView1.RowCount = 0 Then
                MessageBox.Show("Data tidak ada !", "Information", MessageBoxButtons.OK, MessageBoxIcon.Exclamation)
                btnRefresh.PerformClick()
            Else
                tampilData(0)
            End If
        End If
    End Sub

    Private Sub cmbSearch_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmbSearch.Click

    End Sub

    Private Sub cmbSearch_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles cmbSearch.KeyPress
        e.Handled = True
    End Sub

    Private Sub txtCatatanSebelumnya_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtCatatanSebelumnya.KeyPress
        e.Handled = True
    End Sub

    Private Sub btnRefresh_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnRefresh.Click
        TampilDataGrid("select * from vwTrLayMRRegis")
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
        tampilData(DataGridView1.CurrentRow.Index)
    End Sub

    Private Sub DataGridView1_CellDoubleClick(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles DataGridView1.CellDoubleClick
        btnEdit.PerformClick()
    End Sub

    Private Sub btnFirst_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnFirst.Click
        DataGridView1.CurrentCell = DataGridView1.Item(1, 0)
        tampilData(DataGridView1.CurrentRow.Index)
    End Sub

    Private Sub btnLast_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnLast.Click
        DataGridView1.CurrentCell = DataGridView1.Item(1, DataGridView1.RowCount - 1)
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

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click

    End Sub
End Class