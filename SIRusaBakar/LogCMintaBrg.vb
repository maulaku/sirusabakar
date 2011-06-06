Public Class LogCMintaBrg
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
        'txtKodeATK.Enabled = True
        'txtNamaATK.Enabled = True
        'txtSatuan.Enabled = True
        'txtMinimum.Enabled = True
        'txtCatatan.Enabled = True
        'cmbGroupATK.Enabled = True
        'cmbJenisATK.Enabled = True

        'DataGridView1.Enabled = False
    End Sub
    Sub nonAktif()
        'txtKodeATK.Enabled = False
        'txtNamaATK.Enabled = False
        'txtSatuan.Enabled = False
        'txtMinimum.Enabled = False
        'txtCatatan.Enabled = False
        'cmbGroupATK.Enabled = False
        'cmbJenisATK.Enabled = False

        'DataGridView1.Enabled = True
    End Sub
    Sub munculData()
        Call bukaserver()
        PSQL = ""
        PSQL = "SELECT id,kode_inv_atk,nama_inv_atk,jenis_inv_atk,group_inv_atk,satuan,minimum,note" & _
               " FROM ms_inv_atk" & _
               " WHERE status=1" & _
               " ORDER BY id"

        dttable.Clear()
        dtadapter = New SqlClient.SqlDataAdapter(PSQL, koneksi)
        dtadapter.Fill(dttable)


        'DataGridView1.DataSource = dttable

        'DataGridView1.Columns(0).Visible = False
        'DataGridView1.Columns(7).Visible = False
        'DataGridView1.SelectionMode = DataGridViewSelectionMode.FullRowSelect ' buat select 1 row

        dttable.Dispose()
        dtadapter.Dispose()
        dtadapter = Nothing
        con.Close()
    End Sub
    Sub tampilData()
        If dttable.Rows.Count = 0 Then
            MsgBox("Data ATK : Tidak Ada", MsgBoxStyle.Information, "Data ATK")

            btnSearch.Enabled = False
            btnRefresh.Enabled = False
        Else
            'txtCatatan.Text = ""
            'Dim i As Integer
            'If status = 0 Then
            '    i = 0
            'Else
            '    i = DataGridView1.CurrentRow.Index
            'End If

            'idForm = DataGridView1.Item(0, i).Value
            'txtKodeATK.Text = DataGridView1.Item(1, i).Value
            'txtNamaATK.Text = DataGridView1.Item(2, i).Value
            'cmbJenisATK.Text = DataGridView1.Item(3, i).Value
            'cmbGroupATK.Text = DataGridView1.Item(4, i).Value
            'txtSatuan.Text = DataGridView1.Item(5, i).Value
            'txtMinimum.Text = DataGridView1.Item(6, i).Value
            'txtCatatanSebelumnya.Text = (DataGridView1.Item(7, i).Value).Replace(ControlChars.Lf, vbCrLf)

        End If
        formatGrid()
    End Sub
    Sub formatGrid()
        Dim dc As DataGridViewColumn
        'For Each dc In DataGridView1.Columns
        '    Select Case dc.Name
        '        Case "kode_inv_atk"
        '            dc.HeaderText = "Kode ATK"
        '            dc.Width = 100
        '        Case "nama_inv_atk"
        '            dc.HeaderText = "Nama ATK"
        '            dc.Width = 100
        '        Case "group_inv_atk"
        '            dc.HeaderText = "Group ATK"
        '            dc.Width = 100
        '        Case "jenis_inv_atk"
        '            dc.HeaderText = "Jenis ATK"
        '            dc.Width = 100
        '        Case "satuan"
        '            dc.HeaderText = "Satuan"
        '            dc.Width = 100
        '        Case "minimum"
        '            dc.HeaderText = "Minimum"
        '            dc.Width = 100
        '    End Select
        'Next
    End Sub
    Sub kosong()
        'txtKodeATK.Text = ""
        'txtNamaATK.Text = ""
        'txtSatuan.Text = ""
        'txtMinimum.Text = ""
    End Sub

    Private Sub ComboBox1_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles StatusPermintaan.SelectedIndexChanged

    End Sub
End Class