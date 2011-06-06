Public Class MPerush
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
                    tny = MessageBox.Show("Mau Keluar dari Master Perusahaan ?", "Konfirmasi", MessageBoxButtons.YesNo, MessageBoxIcon.Question)
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
        'txtKodeObat.Enabled = True
        'txtNamaObat.Enabled = True
        'txtCatatan.Enabled = True
        'txtIsi.Enabled = True
        'txtStokMin.Enabled = True

        'cmbGolonganObat.Enabled = True
        'cmbKategoryObat.Enabled = True
        'cmbSatuanBeli.Enabled = True
        'cmbSatuanJual.Enabled = True

        DataGridView1.Enabled = False
    End Sub
    Sub nonAktif()
        'txtKodeObat.Enabled = False
        'txtNamaObat.Enabled = False
        'txtCatatan.Enabled = False
        'txtIsi.Enabled = False
        'txtStokMin.Enabled = False

        'cmbGolonganObat.Enabled = False
        'cmbKategoryObat.Enabled = False
        'cmbSatuanBeli.Enabled = False
        'cmbSatuanJual.Enabled = False

        DataGridView1.Enabled = True
    End Sub
    Sub munculData()
        Call bukaserver()
        PSQL = ""
        PSQL = "SELECT id,kode_obat,nama_obat,golongan_obat,kategory_obat,satuan_beli,satuan_jual,isi,stok_min,note" & _
               " FROM ms_obat" & _
               " WHERE status=1" & _
               " ORDER BY id"

        dttable.Clear()
        dtadapter = New SqlClient.SqlDataAdapter(PSQL, koneksi)
        dtadapter.Fill(dttable)


        DataGridView1.DataSource = dttable

        DataGridView1.Columns(0).Visible = False
        DataGridView1.Columns(9).Visible = False
        DataGridView1.SelectionMode = DataGridViewSelectionMode.FullRowSelect ' buat select 1 row

        dttable.Dispose()
        dtadapter.Dispose()
        dtadapter = Nothing
        con.Close()
    End Sub
    Sub tampilData()
        If dttable.Rows.Count = 0 Then
            MsgBox("Data Obat : Tidak Ada", MsgBoxStyle.Information, "Data Obat")

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

            idForm = DataGridView1.Item(0, i).Value
            'txtKodeObat.Text = DataGridView1.Item(1, i).Value
            'txtNamaObat.Text = DataGridView1.Item(2, i).Value
            'cmbGolonganObat.Text = DataGridView1.Item(3, i).Value
            'cmbKategoryObat.Text = DataGridView1.Item(4, i).Value
            'cmbSatuanBeli.Text = DataGridView1.Item(5, i).Value
            'cmbSatuanJual.Text = DataGridView1.Item(6, i).Value
            'txtIsi.Text = DataGridView1.Item(7, i).Value
            'txtStokMin.Text = DataGridView1.Item(8, i).Value
            txtCatatanSebelumnya.Text = (DataGridView1.Item(9, i).Value).Replace(ControlChars.Lf, vbCrLf)

        End If
        formatGrid()
    End Sub
    Sub formatGrid()
        Dim dc As DataGridViewColumn
        For Each dc In DataGridView1.Columns
            Select Case dc.Name
                Case "kode_obat"
                    dc.HeaderText = "Kode Obat"
                    dc.Width = 100
                Case "nama_obat"
                    dc.HeaderText = "Nama Obat"
                    dc.Width = 100
                Case "golongan_obat"
                    dc.HeaderText = "Golongan Obat"
                    dc.Width = 100
                Case "kategory_obat"
                    dc.HeaderText = "Kategory Obat"
                    dc.Width = 100
                Case "satuan_beli"
                    dc.HeaderText = "Satuan Beli"
                    dc.Width = 100
                Case "satuan_jual"
                    dc.HeaderText = "Satuan Jual"
                    dc.Width = 100
                Case "isi"
                    dc.HeaderText = "Isi"
                    dc.Width = 100
                Case "stok_min"
                    dc.HeaderText = "Stok Minimal"
                    dc.Width = 100
            End Select
        Next
    End Sub
    Sub kosong()
        'txtKodeObat.Text = ""
        'txtNamaObat.Text = ""
        'txtCatatan.Text = ""
        'txtIsi.Text = ""
        'txtStokMin.Text = ""

        'cmbGolonganObat.SelectedIndex = 0
        'cmbKategoryObat.SelectedIndex = 0
        'cmbSatuanBeli.SelectedIndex = 0
        'cmbSatuanJual.SelectedIndex = 0
    End Sub

    Private Sub MPerush_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

    End Sub
End Class