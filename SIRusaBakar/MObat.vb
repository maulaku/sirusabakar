Public Class MObat
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
                    tny = MessageBox.Show("Mau Keluar dari Master Obat ?", "Konfirmasi", MessageBoxButtons.YesNo, MessageBoxIcon.Question)
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
        txtKodeObat.Enabled = True
        txtNamaObat.Enabled = True
        txtCatatan.Enabled = True
        txtIsi.Enabled = True
        txtStokMin.Enabled = True

        cmbGolonganObat.Enabled = True
        cmbKategoryObat.Enabled = True
        cmbSatuanBeli.Enabled = True
        cmbSatuanJual.Enabled = True

        DataGridView1.Enabled = False
    End Sub
    Sub nonAktif()
        txtKodeObat.Enabled = False
        txtNamaObat.Enabled = False
        txtCatatan.Enabled = False
        txtIsi.Enabled = False
        txtStokMin.Enabled = False

        cmbGolonganObat.Enabled = False
        cmbKategoryObat.Enabled = False
        cmbSatuanBeli.Enabled = False
        cmbSatuanJual.Enabled = False

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
            txtKodeObat.Text = DataGridView1.Item(1, i).Value
            txtNamaObat.Text = DataGridView1.Item(2, i).Value
            cmbGolonganObat.Text = DataGridView1.Item(3, i).Value
            cmbKategoryObat.Text = DataGridView1.Item(4, i).Value
            cmbSatuanBeli.Text = DataGridView1.Item(5, i).Value
            cmbSatuanJual.Text = DataGridView1.Item(6, i).Value
            txtIsi.Text = DataGridView1.Item(7, i).Value
            txtStokMin.Text = DataGridView1.Item(8, i).Value
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
        txtKodeObat.Text = ""
        txtNamaObat.Text = ""
        txtCatatan.Text = ""
        txtIsi.Text = ""
        txtStokMin.Text = ""

        cmbGolonganObat.SelectedIndex = 0
        cmbKategoryObat.SelectedIndex = 0
        cmbSatuanBeli.SelectedIndex = 0
        cmbSatuanJual.SelectedIndex = 0
    End Sub
    Private Sub MObat_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Try
            tombolHidup()
            nonAktif()
            munculData()
            tampilData()

            If cmbSearch.SelectionLength <> 0 Then
                cmbSearch.SelectedIndex = 0
            End If
            cmbGolonganObat.SelectedIndex = 0
            cmbKategoryObat.SelectedIndex = 0
            cmbSatuanBeli.SelectedIndex = 0
            cmbSatuanJual.SelectedIndex = 0
        Catch salah As Exception
            MessageBox.Show(salah.Message, "Error Load Form", MessageBoxButtons.OK, MessageBoxIcon.Error)
        End Try

        Me.txtSearch.TextBox.Select()
    End Sub

    Private Sub btnNew_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnNew.Click
        statusForm = "new"
        tombolMati()
        kosong()
        aktif()
        txtKodeObat.Focus()
        txtCatatanSebelumnya.Text = ""
    End Sub

    Private Sub btnDelete_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnDelete.Click
        If txtKodeObat.Text = "" Then
            MsgBox("Tidak bisa melakukan delete!", MsgBoxStyle.Information, "Information")
        Else
            Dim tanya As Integer
            tanya = MessageBox.Show("Apakah kamu akan menghapus Kode : " + txtKodeObat.Text + " ?", "Konfirmasi", MessageBoxButtons.YesNo, MessageBoxIcon.Question)
            If tanya = vbYes Then
                Call bukaServer()
                Try
                    PSQL = "EXEC sp_delete_obat " & _
                            idForm & ",'" & txtKodeObat.Text & "','" & txtNamaObat.Text & "','" & _
                            cmbGolonganObat.Text & "','" & cmbKategoryObat.Text & "','" & cmbSatuanBeli.Text & _
                            "','" & cmbSatuanJual.Text & "'," & txtIsi.Text & "," & txtStokMin.Text & ",'" & txtCatatan.Text & "'," & idUser

                    cmd = New SqlClient.SqlCommand(PSQL, con)
                    cmd.ExecuteNonQuery()
                    MessageBox.Show("Sukses Delete Data dengan Kode Obat : " & txtKodeObat.Text, "Information", MessageBoxButtons.OK, MessageBoxIcon.Information)

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
        If txtKodeObat.Text = "" Then
            MsgBox("Tidak bisa melakukan Edit!", MsgBoxStyle.Information, "Information")
        Else
            statusForm = "edit"
            tombolMati()
            aktif()
            txtKodeObat.Focus()
        End If
    End Sub

    Private Sub btnSave_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Try
            Call bukaServer()

            Select Case statusForm
                Case "new"
                    PSQL = "EXEC sp_insert_obat" & _
                            " '" & txtKodeObat.Text & "'," & _
                            " '" & txtNamaObat.Text & "'," & _
                            " '" & cmbGolonganObat.Text & "'," & _
                            " '" & cmbKategoryObat.Text & "'," & _
                            " '" & cmbSatuanBeli.Text & "'," & _
                            " '" & cmbSatuanJual.Text & "'," & _
                            " '" & txtIsi.Text & "'," & _
                            " '" & txtStokMin.Text & "'," & _
                            " '" & txtCatatan.Text & "'," & idUser

                    cmd = New SqlClient.SqlCommand(PSQL, con)
                    cmd.ExecuteNonQuery()
                    MessageBox.Show("Sukses Input Data BARU OBAT dengan Kode OBAT : " & txtKodeObat.Text, "Information", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Case "edit"
                    PSQL = "EXEC sp_update_obat" & _
                            "  " & idForm & "," & _
                            " '" & txtKodeObat.Text & "'," & _
                            " '" & txtNamaObat.Text & "'," & _
                            " '" & cmbGolonganObat.Text & "'," & _
                            " '" & cmbKategoryObat.Text & "'," & _
                            " '" & cmbSatuanBeli.Text & "'," & _
                            " '" & cmbSatuanJual.Text & "'," & _
                            " '" & txtIsi.Text & "'," & _
                            " '" & txtStokMin.Text & "'," & _
                            " '" & txtCatatan.Text & "'," & idUser


                    cmd = New SqlClient.SqlCommand(PSQL, con)
                    cmd.ExecuteNonQuery()
                    MessageBox.Show("Sukses Edit Data LAMA OBAT dengan Kode OBAT : " & txtKodeObat.Text, "Information", MessageBoxButtons.OK, MessageBoxIcon.Information)
            End Select
        Catch Salah As Exception
            MessageBox.Show(Salah.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error)
        End Try

        munculData()
        tampilData()
        tombolHidup()
        nonAktif()
        txtSearch.Focus()
        matiServer()
        statusForm = ""
    End Sub

    Private Sub btnCancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        Select Case statusForm
            Case "new"
                tombolHidup()
                tampilData()
                nonAktif()
                statusForm = ""
            Case "edit"
                tombolHidup()
                tampilData()
                nonAktif()
                statusForm = ""
        End Select
        txtSearch.Focus()
    End Sub

    Private Sub DataGridView1_CellClick(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles DataGridView1.CellClick
        status = 1
        tampilData()
        status = 0
    End Sub

    Private Sub DataGridView1_CellContentClick(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles DataGridView1.CellContentClick

    End Sub

    Private Sub btnSearch_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSearch.Click
        If cmbSearch.SelectedIndex = 0 Then
            dataCari = "kode_alkes"
        ElseIf cmbSearch.SelectedIndex = 1 Then
            dataCari = "nama_alkes"
        ElseIf cmbSearch.SelectedIndex = 2 Then
            dataCari = "jenis_alkes"
        ElseIf cmbSearch.SelectedIndex = 3 Then
            dataCari = "group_alkes"
        Else
            dataCari = "satuan"
        End If

        Try
            If txtSearch.Text = "" Then
                MessageBox.Show("Masukkan data untuk dicari !", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Exclamation)
            Else
                Call bukaServer()
                PSQL = "SELECT id,kode_obat,nama_obat,golongan_obat,kategory_obat,satuan_beli,satuan_jual,isi,stok_min,note" & _
                        " FROM ms_obat" & _
                        " WHERE status=1" & _
                        " AND " & dataCari & " = '" & txtSearch.Text & "'" & _
                        " ORDER BY id"
                        

                dttable.Clear()
                dtadapter = New SqlClient.SqlDataAdapter(PSQL, koneksi)
                dtadapter.Fill(dttable)

                DataGridView1.DataSource = dttable

                If dttable.Rows.Count = 0 Then
                    MessageBox.Show("Data tidak ada !", "Information", MessageBoxButtons.OK, MessageBoxIcon.Exclamation)
                    btnRefresh.PerformClick()
                Else
                    tampilData()
                    dttable.Dispose()
                    dtadapter.Dispose()
                    dtadapter = Nothing
                    con.Close()
                End If
            End If
        Catch salah As Exception
            MsgBox(salah.Message)
        End Try
    End Sub

    Private Sub txtCatatanSebelumnya_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtCatatanSebelumnya.KeyPress
        e.Handled = True
    End Sub

    Private Sub txtCatatanSebelumnya_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtCatatanSebelumnya.TextChanged

    End Sub

    Private Sub cmbSearch_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmbSearch.Click

    End Sub

    Private Sub cmbSearch_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles cmbSearch.KeyPress
        e.Handled = True
    End Sub

    Private Sub btnRefresh_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnRefresh.Click
        munculData()
        tampilData()
        txtSearch.Text = ""
        txtSearch.Focus()
    End Sub

    Private Sub txtSearch_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtSearch.Click

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
        status = 1
        tampilData()
        status = 0
    End Sub
End Class