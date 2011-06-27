Public Class LayMRDaftarPasien
    Dim status As Integer = 0
    Dim dataCari As String
    Dim list As Integer = 0
    Dim max As Integer
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
                    tny = MessageBox.Show("Mau Keluar dari Layanan Medical Record : Pendaftaran Pasien Baru ?", "Konfirmasi", MessageBoxButtons.YesNo, MessageBoxIcon.Question)
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
    Private Sub generateNoMR()
        Dim lastKode As Integer = 0

        Try
            Call bukaServer()
            PSQL = "SELECT TOP 1 noMR from trLayMRDaftar ORDER BY noMR DESC"
            cmd = New Odbc.OdbcCommand(PSQL, con)
            lastKode = Val(cmd.ExecuteScalar)

            txtNoMR.Text = Strings.Left("00000" & lastKode + 1, 6)
            con.Close()
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub
    Sub tombolMati()
        btnNew.Enabled = False
        btnSave.Enabled = True
        'btnDelete.Enabled = False
        btnEdit.Enabled = False

        btnDelete.Text = "Cancel"

        btnSearch.Enabled = False
        btnRefresh.Enabled = False
    End Sub
    Sub tombolHidup()
        btnNew.Enabled = True
        btnSave.Enabled = False
        'btnDelete.Enabled = True
        btnEdit.Enabled = True

        btnDelete.Text = "Delete"

        btnSearch.Enabled = True
        btnRefresh.Enabled = True
    End Sub
    Sub aktif()
        txtNoMR.Enabled = False
        cmbTitle.Enabled = True
        txtNamaPasien.Enabled = True
        txtPanggilan.Enabled = True

        rbPria.Enabled = True
        rbWanita.Enabled = True

        txtTempatLahir.Enabled = True
        cmbTglLahir.Enabled = True
        txtUmur.Enabled = True
        cmbAgama.Enabled = True
        txtSukuBangsa.Enabled = True
        txtWargaNegara.Enabled = True

        rbA.Enabled = True
        rbB.Enabled = True
        rbAB.Enabled = True
        rbO.Enabled = True

        cmbStatus.Enabled = True
        cmbPendidikan.Enabled = True
        cmbPekerjaan.Enabled = True
        txtAlamat.Enabled = True
        'txtPropinsi.Enabled = True
        'txtKota.Enabled = True
        txtKodePos.Enabled = True
        txtTelepon.Enabled = True
        txtHP.Enabled = True
        'txtKabupaten.Enabled = True
        'txtKecamatan.Enabled = True
        'txtKelurahan.Enabled = True
        txtIstri.Enabled = True
        txtSuami.Enabled = True
        txtAyah.Enabled = True
        txtIbu.Enabled = True

        chbSendiri.Enabled = True

        txtNamaPenanggung.Enabled = True
        cmbHubungan.Enabled = True
        txtHubungan.Enabled = True
        txtAlamatPenanggung.Enabled = True
        txtTeleponPenanggung.Enabled = True
        txtHPPenanggung.Enabled = True
        txtCatatan.Enabled = True
        DataGridView1.Enabled = False
    End Sub
    Sub nonAktif()
        txtNoMR.Enabled = False
        cmbTitle.Enabled = False
        txtNamaPasien.Enabled = False
        txtPanggilan.Enabled = False

        rbPria.Enabled = False
        rbWanita.Enabled = False

        txtTempatLahir.Enabled = False
        cmbTglLahir.Enabled = False
        txtUmur.Enabled = False
        cmbAgama.Enabled = False
        txtSukuBangsa.Enabled = False
        txtWargaNegara.Enabled = False

        rbA.Enabled = False
        rbB.Enabled = False
        rbAB.Enabled = False
        rbO.Enabled = False

        cmbStatus.Enabled = False
        cmbPendidikan.Enabled = False
        cmbPekerjaan.Enabled = False
        txtAlamat.Enabled = False
        'txtPropinsi.Enabled = False
        'txtKota.Enabled = False
        txtKodePos.Enabled = False
        txtTelepon.Enabled = False
        txtHP.Enabled = False
        'txtKabupaten.Enabled = False
        'txtKecamatan.Enabled = False
        'txtKelurahan.Enabled = False
        txtIstri.Enabled = False
        txtSuami.Enabled = False
        txtAyah.Enabled = False
        txtIbu.Enabled = False

        chbSendiri.Enabled = False

        txtNamaPenanggung.Enabled = False
        cmbHubungan.Enabled = False
        txtHubungan.Enabled = False
        txtAlamatPenanggung.Enabled = False
        txtTeleponPenanggung.Enabled = False
        txtHPPenanggung.Enabled = False
        txtCatatan.Enabled = False

        DataGridView1.Enabled = True
    End Sub
    Private Sub LoadCb()
        Dim tTitle As New DataTable
        Dim tAgama As New DataTable
        Dim tPendidikan As New DataTable
        Dim tPekerjaan As New DataTable
        Dim tHubungan As New DataTable

        'load cmbtitle
        cmbTitle.Items.Clear()
        tTitle = getTabel("select ID,NamaTitel from vwMsTitel")
        cmbTitle.DataSource = tTitle
        cmbTitle.DisplayMember = "NamaTitel"
        cmbTitle.ValueMember = "ID"

        'load cmbAgama
        cmbAgama.Items.Clear()
        tAgama = getTabel("select ID,NamaAgama from vwMsAgama")
        cmbAgama.DataSource = tAgama
        cmbAgama.DisplayMember = "NamaAgama"
        cmbAgama.ValueMember = "ID"

        'load cmbPendidikan
        cmbPendidikan.Items.Clear()
        tPendidikan = getTabel("select ID,NamaPendidikan from vwMsPendidikan")
        cmbPendidikan.DataSource = tPendidikan
        cmbPendidikan.DisplayMember = "NamaPendidikan"
        cmbPendidikan.ValueMember = "ID"

        'load cmbPekerjaan
        cmbPekerjaan.Items.Clear()
        tPekerjaan = getTabel("select ID,NamaPekerjaan from vwMsPekerjaan WHERE ID <> 1")
        cmbPekerjaan.DataSource = tPekerjaan
        cmbPekerjaan.DisplayMember = "NamaPekerjaan"
        cmbPekerjaan.ValueMember = "ID"

        'load cmbHubungan
        cmbHubungan.Items.Clear()
        tHubungan = getTabel("select ID,NamaHubKel from vwMsHubKel")
        cmbHubungan.DataSource = tHubungan
        cmbHubungan.DisplayMember = "NamaHubKel"
        cmbHubungan.ValueMember = "ID"
    End Sub
    Sub munculData()
        If list = 0 Then
            DataGridView1.DataSource = getTabel("select Top 20 * from vwLayMrRegPasien order by ID asc")
        ElseIf list = -1 Then
            DataGridView1.DataSource = getTabel("select Top 20 * from vwLayMrRegPasien order by ID desc")
        Else
            DataGridView1.DataSource = getTabel("select Top 20 * from vwLayMrRegPasien where ID not in (select top " & list & " ID from vwLayMrRegPasien order by ID) order by ID asc")
        End If

        For i As Integer = 0 To DataGridView1.ColumnCount - 1
            DataGridView1.Columns(i).Visible = False
        Next

        DataGridView1.Columns("nomr").Visible = True 'No. MR
        DataGridView1.Columns("namapasien").Visible = True 'Nama Pasien
        DataGridView1.Columns("panggilan").Visible = True 'Nama Panggilan
        DataGridView1.Columns("sex").Visible = True 'Jenis Kelamin

        DataGridView1.SelectionMode = DataGridViewSelectionMode.FullRowSelect ' buat select 1 row

    End Sub
    Sub tampilData()
        If DataGridView1.RowCount = 0 Then
            MsgBox("Data MR Pasien : Tidak Ada", MsgBoxStyle.Information, "Data Medical Record")

            btnSearch.Enabled = False
            btnRefresh.Enabled = False
        Else
            txtCatatan.Text = ""
            Dim i As Integer
            If status = 0 Then
                i = 0
            Else
                i = DataGridView1.CurrentRow.Index
            End If

            idForm = DataGridView1.Item("id", i).Value
            txtNoMR.Text = DataGridView1.Item("nomr", i).Value
            cmbTitle.SelectedValue = DataGridView1.Item("titelID", i).Value
            txtNamaPasien.Text = DataGridView1.Item("namaPasien", i).Value
            txtPanggilan.Text = DataGridView1.Item("panggilan", i).Value
            If DataGridView1.Item("sex", i).Value = "Pria" Then
                rbPria.Checked = True
            ElseIf DataGridView1.Item("sex", i).Value = "Wanita" Then
                rbWanita.Checked = True
            End If
            txtTempatLahir.Text = DataGridView1.Item("tempatLahir", i).Value
            cmbTglLahir.Value = DataGridView1.Item("tglLahir", i).Value
            'txtUmur.Text = hitUmur(cmbTglLahir.Value)
            cmbAgama.Text = DataGridView1.Item("agamaID", i).Value
            txtSukuBangsa.Text = DataGridView1.Item("sukuBangsa", i).Value
            txtWargaNegara.Text = DataGridView1.Item("wargaNegara", i).Value
            If DataGridView1.Item("golDarah", i).Value = "A" Then
                rbA.Checked = True
            ElseIf DataGridView1.Item("golDarah", i).Value = "B" Then
                rbB.Checked = True
            ElseIf DataGridView1.Item("golDarah", i).Value = "AB" Then
                rbAB.Checked = True
            ElseIf DataGridView1.Item("golDarah", i).Value = "O" Then
                rbO.Checked = True
            End If
            cmbStatus.Text = DataGridView1.Item("statusMR", i).Value
            cmbPendidikan.SelectedValue = DataGridView1.Item("pendidikanID", i).Value
            cmbPekerjaan.SelectedValue = DataGridView1.Item("pekerjaanID", i).Value
            txtAlamat.Text = DataGridView1.Item("alamat", i).Value
            'txtPropinsi.Text = DataGridView1.Item("namaPropinsi", i).Value
            IDProp.Text = DataGridView1.Item("PropinsiID", i).Value
            txtKota.Text = DataGridView1.Item(18, i).Value
            txtKodePos.Text = DataGridView1.Item(19, i).Value
            txtTelepon.Text = DataGridView1.Item(20, i).Value
            txtHP.Text = ceknull(DataGridView1.Item(21, i).Value)
            txtKabupaten.Text = DataGridView1.Item(22, i).Value
            txtKecamatan.Text = DataGridView1.Item(23, i).Value
            txtKelurahan.Text = DataGridView1.Item(24, i).Value
            txtIstri.Text = DataGridView1.Item(25, i).Value
            txtSuami.Text = DataGridView1.Item(26, i).Value
            txtAyah.Text = DataGridView1.Item(27, i).Value
            txtIbu.Text = DataGridView1.Item(28, i).Value

            statusPenanggung = DataGridView1.Item(29, i).Value

            txtNamaPenanggung.Text = DataGridView1.Item(30, i).Value
            cmbHubungan.Text = DataGridView1.Item(31, i).Value
            txtHubungan.Text = DataGridView1.Item(32, i).Value
            txtAlamatPenanggung.Text = DataGridView1.Item(33, i).Value
            txtTeleponPenanggung.Text = DataGridView1.Item(34, i).Value
            txtHPPenanggung.Text = DataGridView1.Item(35, i).Value
            txtCatatan.Text = DataGridView1.Item(36, i).Value
        End If
        formatGrid()
    End Sub
    Sub formatGrid()
        Dim dc As DataGridViewColumn
        For Each dc In DataGridView1.Columns
            Select Case dc.Name
                Case "noMR"
                    dc.HeaderText = "No. MR"
                    dc.Width = 100
                Case "namaPasien"
                    dc.HeaderText = "Nama Pasien"
                    dc.Width = 150
                Case "panggilan"
                    dc.HeaderText = "Nama Panggilan"
                    dc.Width = 150
                Case "sex"
                    dc.HeaderText = "Jenis Kelamin"
                    dc.Width = 150
            End Select
        Next
    End Sub
    Sub kosong()
        txtNamaPasien.Text = ""
        txtPanggilan.Text = ""
        txtTempatLahir.Text = ""
        txtUmur.Text = ""
        txtSukuBangsa.Text = ""
        txtWargaNegara.Text = ""

        txtAlamat.Text = ""
        txtPropinsi.Text = ""
        txtKota.Text = ""
        txtKodePos.Text = ""
        txtTelepon.Text = ""
        txtHP.Text = ""
        txtKabupaten.Text = ""
        txtKecamatan.Text = ""
        txtKelurahan.Text = ""
        txtIstri.Text = ""
        txtSuami.Text = ""
        txtAyah.Text = ""
        txtIbu.Text = ""

        txtNamaPenanggung.Text = ""
        txtHubungan.Text = ""
        txtAlamatPenanggung.Text = ""
        txtTeleponPenanggung.Text = ""
        txtHPPenanggung.Text = ""
    End Sub
    Private Sub RPasien_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Try
            LoadCb()
            tombolHidup()
            nonAktif()
            munculData()
            tampilData()

            cmbSearch.SelectedIndex = 0
            'cmbTitle.SelectedIndex = 0

            'cariHubKel()
            'cariAgama()
            'cariPendidikan()

        Catch salah As Exception
            MessageBox.Show(salah.Message, "Error Load Form", MessageBoxButtons.OK, MessageBoxIcon.Error)
        End Try

        Me.txtSearch.TextBox.Select()
    End Sub

    Private Sub btnNew_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        statusForm = "new"
        generateNoMR()
        tombolMati()
        kosong()
        aktif()
        txtNamaPasien.Focus()
    End Sub

    Private Sub btnDelete_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnDelete.Click
        Dim tanya As Integer
        If btnDelete.Text = "Cancel" Then
            tombolHidup()
            tampilData()
            nonAktif()
            statusForm = ""
        ElseIf btnDelete.Text = "Delete" Then
            tanya = MessageBox.Show("Apakah kamu akan menghapus No. MR : " + txtNoMR.Text + " ?", "Konfirmasi", MessageBoxButtons.YesNo, MessageBoxIcon.Question)
            If tanya = vbYes Then
                Call bukaServer()
                Try
                    PSQL = "EXEC spDeleteMRDaftar " & _
                            idForm & ",'" & txtNoMR.Text & "','" & txtNamaPasien.Text & "','" & idUser & "'"

                    cmd = New Odbc.OdbcCommand(PSQL, con)
                    cmd.ExecuteNonQuery()
                    MessageBox.Show("Sukses Delete Data dengan No. MR : " & txtNoMR.Text, "Information", MessageBoxButtons.OK, MessageBoxIcon.Information)

                    munculData()
                    tampilData()

                    kosong()
                Catch Salah As Exception
                    MessageBox.Show(Salah.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error)
                End Try
            End If
            con.Close()
            cmd.Dispose()
        End If
    End Sub

    Private Sub btnEdit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnEdit.Click
        If idForm > 0 Then
            statusForm = "edit"
            tombolMati()
            aktif()
            txtNamaPasien.Focus()
        Else
            MsgBox("Silahkan Pilih Data yang akan di Rubah", MsgBoxStyle.Information, "Rubah Data")
        End If
    End Sub
    Dim sex, golDarah As String
    Dim statusPenanggung As Integer = 0
    Private Sub btnSave_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Try
            Call bukaServer()

            If txtNamaPasien.Text = "" Then
                MsgBox("Data belum Lengkap", MsgBoxStyle.Information, "Save Data Gagal")
            End If
            Select Case statusForm
                Case "new"
                    PSQL = "EXEC spInsertMRDaftar" & _
                            " '" & txtNoMR.Text & "'," & _
                            "  " & cmbTitle.SelectedValue & "," & _
                            " '" & txtNamaPasien.Text & "'," & _
                            " '" & txtPanggilan.Text & "'," & _
                            " '" & sex & "'," & _
                            " '" & txtTempatLahir.Text & "'," & _
                            " '" & cmbTglLahir.Value & "'," & _
                            "  " & cmbAgama.SelectedValue & "," & _
                            " '" & txtSukuBangsa.Text & "'," & _
                            " '" & txtWargaNegara.Text & "'," & _
                            " '" & golDarah & "'," & _
                            " '" & cmbStatus.Text & "'," & _
                            "  " & cmbPendidikan.SelectedValue & "," & _
                            "  " & cmbPekerjaan.SelectedValue & "," & _
                            " '" & txtAlamat.Text & "'," & _
                            " '" & IDProp.Text & "'," & _
                            " '" & IDKota.Text & "'," & _
                            " '" & txtKodePos.Text & "'," & _
                            " '" & txtTelepon.Text & "'," & _
                            " '" & txtHP.Text & "'," & _
                            " '" & IDKab.Text & "'," & _
                            " '" & IDKec.Text & "'," & _
                            " '" & IDKel.Text & "'," & _
                            " '" & txtIstri.Text & "'," & _
                            " '" & txtSuami.Text & "'," & _
                            " '" & txtAyah.Text & "'," & _
                            " '" & txtIbu.Text & "'," & _
                            " '" & statusPenanggung & "'," & _
                            " '" & txtNamaPenanggung.Text & "'," & _
                            "  " & cmbHubungan.SelectedValue & "," & _
                            " '" & txtHubungan.Text & "'," & _
                            " '" & txtAlamatPenanggung.Text & "'," & _
                            " '" & txtTeleponPenanggung.Text & "'," & _
                            " '" & txtHPPenanggung.Text & "'," & _
                            " '" & txtCatatan.Text & "'," & idUser

                    cmd = New Odbc.OdbcCommand(PSQL, con)
                    cmd.ExecuteNonQuery()
                    MessageBox.Show("Sukses Input Data BARU MR dengan No. MR : " & txtNoMR.Text, "Information", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Case "edit"
                    PSQL = "EXEC spUpdateMRDaftar" & _
                            " '" & idForm & "'," & _
                            " '" & txtNoMR.Text & "'," & _
                            "  " & cmbTitle.SelectedValue & "," & _
                            " '" & txtNamaPasien.Text & "'," & _
                            " '" & txtPanggilan.Text & "'," & _
                            " '" & sex & "'," & _
                            " '" & txtTempatLahir.Text & "'," & _
                            " '" & cmbTglLahir.Value & "'," & _
                            "  " & cmbAgama.SelectedValue & "," & _
                            " '" & txtSukuBangsa.Text & "'," & _
                            " '" & txtWargaNegara.Text & "'," & _
                            " '" & golDarah & "'," & _
                            " '" & cmbStatus.Text & "'," & _
                            "  " & cmbPendidikan.SelectedValue & "," & _
                            "  " & cmbPekerjaan.SelectedValue & "," & _
                            " '" & txtAlamat.Text & "'," & _
                            " '" & IDProp.Text & "'," & _
                            " '" & IDKota.Text & "'," & _
                            " '" & txtKodePos.Text & "'," & _
                            " '" & txtTelepon.Text & "'," & _
                            " '" & txtHP.Text & "'," & _
                            " '" & IDKab.Text & "'," & _
                            " '" & IDKec.Text & "'," & _
                            " '" & IDKel.Text & "'," & _
                            " '" & txtIstri.Text & "'," & _
                            " '" & txtSuami.Text & "'," & _
                            " '" & txtAyah.Text & "'," & _
                            " '" & txtIbu.Text & "'," & _
                            " '" & statusPenanggung & "'," & _
                            " '" & txtNamaPenanggung.Text & "'," & _
                            "  " & cmbHubungan.SelectedValue & "," & _
                            " '" & txtHubungan.Text & "'," & _
                            " '" & txtAlamatPenanggung.Text & "'," & _
                            " '" & txtTeleponPenanggung.Text & "'," & _
                            " '" & txtHPPenanggung.Text & "'," & _
                            " '" & txtCatatan.Text & "'," & idUser

                    cmd = New Odbc.OdbcCommand(PSQL, con)
                    cmd.ExecuteNonQuery()
                    MessageBox.Show("Sukses Edit Data LAMA MR dengan No. MR : " & txtNoMR.Text, "Information", MessageBoxButtons.OK, MessageBoxIcon.Information)
            End Select
        Catch Salah As Exception
            MessageBox.Show(Salah.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error)
        End Try

        matiServer()
        munculData()
        tampilData()
        tombolHidup()
        nonAktif()
        txtSearch.Focus()
        statusForm = ""
        status = 0
    End Sub

    Private Sub btnCancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        'Select Case statusForm
        '    Case "new"
        '        tombolHidup()
        '        tampilData()
        '        nonAktif()
        '        statusForm = ""
        '    Case "edit"
        '        tombolHidup()
        '        tampilData()
        '        nonAktif()
        '        statusForm = ""
        'End Select
        'txtSearch.Focus()
        Me.Close()
    End Sub

    Private Sub DataGridView1_CellClick(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles DataGridView1.CellClick
        status = 1
        tampilData()
        status = 0
    End Sub

    Private Sub btnSearch_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSearch.Click
        Select Case cmbSearch.SelectedIndex
            Case 0
                dataCari = "noMR"
            Case 1
                dataCari = "namaPasien"
            Case 2
                dataCari = "alamat"
            Case 3
                dataCari = "tgllahir"
        End Select
        'If cmbSearch.SelectedIndex = 0 Then
        '    dataCari = "noMR"
        'ElseIf cmbSearch.SelectedIndex = 1 Then
        '    dataCari = "namaPasien"
        'End If

        Try
            If txtSearch.Text = "" Then
                MessageBox.Show("Masukkan data untuk dicari !", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Exclamation)
            Else
                Call bukaServer()
                PSQL = "select * from vw" & _
                        " WHERE status = 1" & _
                        " AND " & dataCari & " = '" & txtSearch.Text & "'" & _
                    " ORDER BY id"

                DataGridView1.DataSource = getTabel(PSQL)

                If DataGridView1.RowCount = 0 Then
                    MessageBox.Show("Data tidak ada !", "Information", MessageBoxButtons.OK, MessageBoxIcon.Exclamation)
                    btnRefresh.PerformClick()
                Else
                    tampilData()
                End If
            End If
        Catch salah As Exception
            MsgBox(salah.Message)
        End Try
    End Sub

    Private Sub btnNew_Click_1(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnNew.Click
        statusForm = "new"
        generateNoMR()
        tombolMati()
        kosong()
        aktif()
        txtNamaPasien.Focus()
    End Sub
    'Private Sub cariHubKel()
    '    Try
    '        Call bukaServer()
    '        Dim da As New SqlClient.SqlDataAdapter

    '        PSQL = "select namaHubKel from msHubKel WHERE status = 1 order by namaHubKel"
    '        cmd = New Odbc.OdbcCommand(PSQL, con)
    '        dtreader = cmd.ExecuteReader()

    '        If dtreader.HasRows Then
    '            While dtreader.Read
    '                Me.cmbHubungan.Items.Add(dtreader("namaHubKel"))
    '            End While
    '        End If

    '        cmd.Dispose()
    '        dtreader.Close()
    '        con.Close()
    '    Catch ex As Exception
    '        MsgBox(ex.Message, MsgBoxStyle.Critical, "Peringatan")
    '    End Try
    '    cmbHubungan.SelectedIndex = 0
    'End Sub
    'Private Sub cariAgama()
    '    Try
    '        Call bukaServer()
    '        Dim da As New SqlClient.SqlDataAdapter

    '        PSQL = "select namaAgama from msAgama WHERE status = 1 order by namaAgama"
    '        cmd = New Odbc.OdbcCommand(PSQL, con)
    '        dtreader = cmd.ExecuteReader()

    '        If dtreader.HasRows Then
    '            While dtreader.Read
    '                Me.cmbAgama.Items.Add(dtreader("namaAgama"))
    '            End While
    '        End If

    '        cmd.Dispose()
    '        dtreader.Close()
    '        con.Close()
    '    Catch ex As Exception
    '        MsgBox(ex.Message, MsgBoxStyle.Critical, "Peringatan")
    '    End Try
    '    cmbAgama.SelectedIndex = 0
    'End Sub
    'Private Sub cariPendidikan()
    '    Try
    '        Call bukaServer()
    '        Dim da As New SqlClient.SqlDataAdapter

    '        PSQL = "select namaPendidikan from msPendidikan WHERE status = 1 order by namaPendidikan"
    '        cmd = New Odbc.OdbcCommand(PSQL, con)
    '        dtreader = cmd.ExecuteReader()

    '        If dtreader.HasRows Then
    '            While dtreader.Read
    '                Me.cmbPendidikan.Items.Add(dtreader("namaPendidikan"))
    '            End While
    '        End If

    '        cmd.Dispose()
    '        dtreader.Close()
    '        con.Close()
    '    Catch ex As Exception
    '        MsgBox(ex.Message, MsgBoxStyle.Critical, "Peringatan")
    '    End Try
    '    cmbPendidikan.SelectedIndex = 0
    'End Sub
    Private Sub chbSendiri_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles chbSendiri.CheckedChanged
        If chbSendiri.Checked = True Then
            statusPenanggung = 1
            txtNamaPenanggung.Enabled = False
            txtHPPenanggung.Enabled = False
            txtTeleponPenanggung.Enabled = False
            txtAlamatPenanggung.Enabled = False
            cmbHubungan.Enabled = False
            txtHubungan.Enabled = False

            txtNamaPenanggung.Text = ""
            txtHPPenanggung.Text = ""
            txtTeleponPenanggung.Text = ""
            txtAlamatPenanggung.Text = ""
            txtHubungan.Text = ""
        Else
            statusPenanggung = 0
            txtNamaPenanggung.Enabled = True
            txtHPPenanggung.Enabled = True
            txtTeleponPenanggung.Enabled = True
            txtAlamatPenanggung.Enabled = True
            cmbHubungan.Enabled = True
            txtHubungan.Enabled = True

            txtNamaPenanggung.Text = ""
            txtHPPenanggung.Text = ""
            txtTeleponPenanggung.Text = ""
            txtAlamatPenanggung.Text = ""
            txtHubungan.Text = ""
        End If
    End Sub
    Private Sub txtSearch_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtSearch.KeyPress
        If e.KeyChar = ChrW(13) Then
            btnSearch.PerformClick()
        End If
    End Sub

    Private Sub rbPria_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles rbPria.CheckedChanged
        If rbPria.Checked Then
            sex = "P"
        End If
    End Sub

    Private Sub rbWanita_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles rbWanita.CheckedChanged
        If rbWanita.Checked Then
            sex = "W"
        End If
    End Sub

    Private Sub rbA_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles rbA.CheckedChanged
        If rbA.Checked Then
            golDarah = "A"
        End If
    End Sub

    Private Sub rbB_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles rbB.CheckedChanged
        If rbB.Checked Then
            golDarah = "B"
        End If
    End Sub

    Private Sub rbAB_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles rbAB.CheckedChanged
        If rbAB.Checked Then
            golDarah = "AB"
        End If
    End Sub

    Private Sub rbO_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles rbO.CheckedChanged
        If rbO.Checked Then
            golDarah = "O"
        End If
    End Sub

    Private Sub Button3_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles BtnKota.Click
        Dim frm2 As New CariData
        IDKota.Text = frm2.getselection("select ID,namakota as 'Nama Kota' from msKota where status=1", "Pilih Kota")
    End Sub

    Private Sub Button5_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles BtnKab.Click
        Dim frm2 As New CariData
        IDKab.Text = frm2.getselection("select ID,namakabupaten as 'Nama Kabupaten' from msKabupaten where status=1", "Pilih Kabupaten")
    End Sub

    Private Sub Button4_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles BtnKec.Click
        Dim frm2 As New CariData
        IDKec.Text = frm2.getselection("select ID,namakecamatan as 'Nama Kecamatan' from msKecamatan where status=1", "Pilih Kecamatan")
    End Sub

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles BtnKel.Click
        Dim frm2 As New CariData
        IDKel.Text = frm2.getselection("select ID,namakelurahan as 'Nama Kelurahan' from msKelurahan where status=1", "Pilih Kelurahan")
    End Sub

    Private Sub IDProp_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs)
        txtPropinsi.Text = getNumber("select namapropinsi from mspropinsi where status=1 and id=" & IDProp.Text)
    End Sub

    Private Sub IDKota_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs)
        txtKota.Text = getNumber("select namakota from mskota where status=1 and id=" & IDKota.Text)
    End Sub

    Private Sub IDKab_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs)
        txtKabupaten.Text = getNumber("select namakabupaten from mskabupaten where status=1 and id=" & IDKab.Text)
    End Sub

    Private Sub IDKec_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs)
        txtKecamatan.Text = getNumber("select namakecamatan from mskecamatan where status=1 and id=" & IDKec.Text)
    End Sub

    Private Sub IDKel_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs)
        txtKelurahan.Text = getNumber("select namakelurahan from mskelurahan where status=1 and id=" & IDKel.Text)
    End Sub

    Private Sub txtKodePos_Validated(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtKodePos.Validated
        If IsNumeric(txtKodePos.Text) Then
            MsgBox(txtKodePos.Text)
        End If
    End Sub

    Private Sub BtnProp_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles BtnProp.Click
        Dim frm2 As New CariData
        IDProp.Text = frm2.getselection("select ID,namapropinsi as 'Nama Propinsi' from msPropinsi where status=1", "Pilih Propinsi")
    End Sub

    Private Sub LayMRDaftarPasien_KeyDown(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles MyBase.KeyDown
        Dim x As Integer
        x = TabData.SelectedIndex
        If e.KeyCode = Keys.Right Then
            If x + 1 < TabData.TabCount - 1 Then
                x += 1
            End If
        End If
        If e.KeyCode = Keys.Left Then
            If x - 1 > 0 Then
                x = x - 1
            End If
        End If
        TabData.SelectTab(x)
        'MsgBox(TabData.SelectedIndex)
    End Sub

    Private Sub ToolStripButton4_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ToolStripButton4.Click
        list = 0
        munculData()
    End Sub

    Private Sub ToolStripButton7_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ToolStripButton7.Click
        list = -1
        munculData()
    End Sub

    Private Sub ToolStripButton6_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ToolStripButton6.Click
        max = getNumRow("select * from vwLayMrRegPasien")
        If list + 20 < max Then
            list += 20
        Else
            list = -1
        End If
        munculData()
    End Sub

    Private Sub ToolStripButton5_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ToolStripButton5.Click
        If list - 20 > 0 Then
            list -= 20
        Else
            list = 0
        End If
        munculData()
    End Sub

    Private Sub TabAlamat_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TabAlamat.Click

    End Sub
End Class