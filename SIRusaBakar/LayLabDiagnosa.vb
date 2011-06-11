Public Class LayLabDiagnosa
    Dim dttable As New DataTable
    Dim status As Integer = 0
    Dim dataCari As String
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
                    tny = MessageBox.Show("Mau Keluar dari Layanan Laboratorium Diagnosa ?", "Konfirmasi", MessageBoxButtons.YesNo, MessageBoxIcon.Question)
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
        Dim lastKode As String
        Dim formatKode As String
        formatKode = Format(Now(), "MMddyy")
        Try
            'Call bukaServer()
            'PSQL = "SELECT TOP 1 noMR from trLayMRDaftar WHERE noMR LIKE '%" & formatKode & "%'"
            'cmd = New SqlClient.SqlCommand(PSQL, con)
            'lastKode = cmd.ExecuteScalar
            lastKode = getNumber("SELECT TOP 1 noMR from trLayMRDaftar WHERE noMR LIKE '%" & formatKode & "%'")

            'If lastKode = "" Then
            '    txtNoMR.Text = formatKode + "00001"
            '    Exit Sub
            'End If

            Dim id As Integer = Val(Strings.Mid(lastKode, 3, 5))
            Select Case id
                '    Case 1 To 8 : txtNoMR.Text = formatKode & "0000" & id + 1
                '    Case 9 To 98 : txtNoMR.Text = formatKode & "000" & id + 1
                '    Case 99 To 998 : txtNoMR.Text = formatKode & "00" & id + 1
                '    Case 999 To 9998 : txtNoMR.Text = formatKode & "0" & id + 1
                '    Case 9999 To 99997 : txtNoMR.Text = formatKode & id + 1

                '    Case Is = 99998 : MsgBox("No. MR Terakhir", MsgBoxStyle.Critical, "Warning")
                '        txtNoMR.Text = formatKode & id + 1
                '    Case Is = 99999 : MsgBox("No. MR sudah Habis", MsgBoxStyle.Critical, "Warning")
                '        txtNoMR.Text = "HABIS"
                '        Me.Dispose()
            End Select
            'con.Close()
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub
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
        'txtNoMR.Enabled = False
        'cmbTitle.Enabled = True
        'txtNamaPasien.Enabled = True
        'txtPanggilan.Enabled = True

        'rbPria.Enabled = True
        'rbWanita.Enabled = True

        'txtTempatLahir.Enabled = True
        'cmbTglLahir.Enabled = True
        'txtUmur.Enabled = True
        'cmbAgama.Enabled = True
        'txtSukuBangsa.Enabled = True
        'txtWargaNegara.Enabled = True

        'rbA.Enabled = True
        'rbB.Enabled = True
        'rbAB.Enabled = True
        'rbO.Enabled = True

        'cmbStatus.Enabled = True
        'cmbPendidikan.Enabled = True
        'cmbPekerjaan.Enabled = True
        'txtAlamat.Enabled = True
        'txtProvinsi.Enabled = True
        'txtKota.Enabled = True
        'txtKodePos.Enabled = True
        'txtTelepon.Enabled = True
        'txtHP.Enabled = True
        'txtKabupaten.Enabled = True
        'txtKecamatan.Enabled = True
        'txtKelurahan.Enabled = True
        'txtIstri.Enabled = True
        'txtSuami.Enabled = True
        'txtAyah.Enabled = True
        'txtIbu.Enabled = True

        'chbSendiri.Enabled = True

        'txtNamaPenanggung.Enabled = True
        'cmbHubungan.Enabled = True
        'txtHubungan.Enabled = True
        'txtAlamatPenanggung.Enabled = True
        'txtTeleponPenanggung.Enabled = True
        'txtHPPenanggung.Enabled = True
        'txtCatatan.Enabled = True
        DataGridView1.Enabled = False
    End Sub
    Sub nonAktif()
        'txtNoMR.Enabled = False
        'cmbTitle.Enabled = False
        'txtNamaPasien.Enabled = False
        'txtPanggilan.Enabled = False

        'rbPria.Enabled = False
        'rbWanita.Enabled = False

        'txtTempatLahir.Enabled = False
        'cmbTglLahir.Enabled = False
        'txtUmur.Enabled = False
        'cmbAgama.Enabled = False
        'txtSukuBangsa.Enabled = False
        'txtWargaNegara.Enabled = False

        'rbA.Enabled = False
        'rbB.Enabled = False
        'rbAB.Enabled = False
        'rbO.Enabled = False

        'cmbStatus.Enabled = False
        'cmbPendidikan.Enabled = False
        'cmbPekerjaan.Enabled = False
        'txtAlamat.Enabled = False
        'txtProvinsi.Enabled = False
        'txtKota.Enabled = False
        'txtKodePos.Enabled = False
        'txtTelepon.Enabled = False
        'txtHP.Enabled = False
        'txtKabupaten.Enabled = False
        'txtKecamatan.Enabled = False
        'txtKelurahan.Enabled = False
        'txtIstri.Enabled = False
        'txtSuami.Enabled = False
        'txtAyah.Enabled = False
        'txtIbu.Enabled = False

        'chbSendiri.Enabled = False

        'txtNamaPenanggung.Enabled = False
        'cmbHubungan.Enabled = False
        'txtHubungan.Enabled = False
        'txtAlamatPenanggung.Enabled = False
        'txtTeleponPenanggung.Enabled = False
        'txtHPPenanggung.Enabled = False
        'txtCatatan.Enabled = False

        DataGridView1.Enabled = True
    End Sub
    Sub munculData()
        'Call bukaserver()
        'PSQL = ""
        'PSQL = "SELECT " & _
        '            "/*0*/id,/*1*/noMR,/*2*/title,/*3*/patientName,/*4*/panggilan," & _
        '            "/*5*/sex,/*6*/tempatLahir,/*7*/tglLahir,/*8*/umur,/*9*/agama," & _
        '            "/*10*/sukuBangsa,/*11*/wargaNegara,/*12*/golDarah,/*13*/statusMR,/*14*/pendidikan," & _
        '            "/*15*/pekerjaan,/*16*/alamat,/*17*/provinsi,/*18*/kota,/*19*/kodePos," & _
        '            "/*20*/telepon,/*21*/handphone,/*22*/kabupaten,/*23*/kecamatan,/*24*/kelurahan," & _
        '            "/*25*/namaIstri,/*26*/namaSuami,/*27*/namaAyah,/*28*/namaIbu,/*29*/statusPenanggung," & _
        '            "/*30*/namaP,/*31*/hubunganP,/*32*/hubunganPLain,/*33*/alamatP,/*34*/teleponP," & _
        '            "/*35*/handphoneP,/*36*/note" & _
        '       " FROM trLayMRDaftar" & _
        '       " WHERE status=1" & _
        '       " ORDER BY id"
        PSQL = "select * from vwLayLogDiagnosa order by ID"
        'dttable.Clear()
        ''dtadapter = New SqlClient.SqlDataAdapter(PSQL, koneksi)
        ''dtadapter.Fill(dttable)
        'dttable = get_tabel(PSQL)

        'DataGridView1.DataSource = dttable
        DataGridView1.DataSource = getTabel(PSQL)

        For i As Integer = 0 To 36
            DataGridView1.Columns(i).Visible = False
        Next

        DataGridView1.Columns(1).Visible = True 'No. MR
        DataGridView1.Columns(3).Visible = True 'Nama Pasien
        DataGridView1.Columns(4).Visible = True 'Nama Panggilan
        DataGridView1.Columns(5).Visible = True 'Jenis Kelamin

        DataGridView1.SelectionMode = DataGridViewSelectionMode.FullRowSelect ' buat select 1 row

        dttable.Dispose()
        'dtadapter.Dispose()
        'dtadapter = Nothing
        'con.Close()
    End Sub
    Sub tampilData()
        If dttable.Rows.Count = 0 Then
            MsgBox("Data MR Pasien : Tidak Ada", MsgBoxStyle.Information, "Data Medical Record")

            btnSearch.Enabled = False
            btnRefresh.Enabled = False
        Else
            'txtCatatan.Text = ""
            Dim i As Integer
            If status = 0 Then
                i = 0
            Else
                i = DataGridView1.CurrentRow.Index
            End If

            idForm = DataGridView1.Item(0, i).Value
            'txtNoMR.Text = DataGridView1.Item(1, i).Value
            'cmbTitle.Text = DataGridView1.Item(2, i).Value
            'txtNamaPasien.Text = DataGridView1.Item(3, i).Value
            'txtPanggilan.Text = DataGridView1.Item(4, i).Value
            'If DataGridView1.Item(5, i).Value = "Pria" Then
            '    rbPria.Checked = True
            'Else
            '    rbWanita.Checked = True
            'End If
            'txtTempatLahir.Text = DataGridView1.Item(6, i).Value
            'cmbTglLahir.Value = DataGridView1.Item(7, i).Value
            'txtUmur.Text = DataGridView1.Item(8, i).Value
            'cmbAgama.Text = DataGridView1.Item(9, i).Value
            'txtSukuBangsa.Text = DataGridView1.Item(10, i).Value
            'txtWargaNegara.Text = DataGridView1.Item(11, i).Value
            'If DataGridView1.Item(12, i).Value = "A" Then
            '    rbA.Checked = True
            'ElseIf DataGridView1.Item(12, i).Value = "B" Then
            '    rbB.Checked = True
            'ElseIf DataGridView1.Item(12, i).Value = "AB" Then
            '    rbAB.Checked = True
            'Else
            '    rbO.Checked = True
            'End If
            'cmbStatus.Text = DataGridView1.Item(13, i).Value
            'cmbPendidikan.Text = DataGridView1.Item(14, i).Value
            'cmbPekerjaan.Text = DataGridView1.Item(15, i).Value
            'txtAlamat.Text = DataGridView1.Item(16, i).Value
            'txtProvinsi.Text = DataGridView1.Item(17, i).Value
            'txtKota.Text = DataGridView1.Item(18, i).Value
            'txtKodePos.Text = DataGridView1.Item(19, i).Value
            'txtTelepon.Text = DataGridView1.Item(20, i).Value
            'txtHP.Text = DataGridView1.Item(21, i).Value
            'txtKabupaten.Text = DataGridView1.Item(22, i).Value
            'txtKecamatan.Text = DataGridView1.Item(23, i).Value
            'txtKelurahan.Text = DataGridView1.Item(24, i).Value
            'txtIstri.Text = DataGridView1.Item(25, i).Value
            'txtSuami.Text = DataGridView1.Item(26, i).Value
            'txtAyah.Text = DataGridView1.Item(27, i).Value
            'txtIbu.Text = DataGridView1.Item(28, i).Value

            'statusPenanggung = DataGridView1.Item(29, i).Value

            'txtNamaPenanggung.Text = DataGridView1.Item(30, i).Value
            'cmbHubungan.Text = DataGridView1.Item(31, i).Value
            'txtHubungan.Text = DataGridView1.Item(32, i).Value
            'txtAlamatPenanggung.Text = DataGridView1.Item(33, i).Value

            'txtTeleponPenanggung.Text = DataGridView1.Item(34, i).Value
            'txtHPPenanggung.Text = DataGridView1.Item(35, i).Value
            'txtCatatan.Text = DataGridView1.Item(36, i).Value
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
                Case "patientName"
                    dc.HeaderText = "Nama Pasien"
                    dc.Width = 100
                Case "panggilan"
                    dc.HeaderText = "Nama Panggilan"
                    dc.Width = 100
                Case "sex"
                    dc.HeaderText = "Jenis Kelamin"
                    dc.Width = 100
            End Select
        Next
    End Sub
    Sub kosong()
        'txtKodeTarif.Text = ""
        'txtDaerah.Text = ""
        'txtTujuan.Text = ""
        'txtTarif.Text = ""
        'txtPM.Text = ""
        'txtParaMedis.Text = ""
        'txtParaMedisPP.Text = ""
        'txtOksigen.Text = ""
        'txtMonitor.Text = ""
        'txtCatatan.Text = ""
    End Sub
    Private Sub LLabDiagnosa_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

    End Sub
End Class