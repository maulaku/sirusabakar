Public Class BrowseMaster
    Dim dttable As New DataTable
    Private Sub BrowseMaster_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Try
            If posisiForm = "obat_MObatHarga" Then
                Call bukaServer()
                PSQL = ""
                PSQL = "" & _
                       "SELECT " & _
                           "ta.id,ta.kode_obat,ta.nama_obat,ta.golongan_obat,ta.kategory_obat,ta.satuan_beli," & _
                           "ta.satuan_jual,ta.isi,ta.stok_min" & _
                       " FROM " & _
                           " ms_obat ta" & _
                       " WHERE " & _
                            " ta.status = 1" & _
                       " ORDER BY ta.id"

                dttable.Clear()
                dtadapter = New SqlClient.SqlDataAdapter(PSQL, koneksi)
                dtadapter.Fill(dttable)

                DataGridView1.DataSource = dttable
                DataGridView1.SelectionMode = DataGridViewSelectionMode.FullRowSelect ' buat select 1 row
                DataGridView1.Columns(0).Visible = False
                'DataGridView1.Columns(0).Width = 100 --> atur lebar kolom

                dttable.Dispose()
                dtadapter.Dispose()
                con.Close()
                FormatGrid()
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub
    Private Sub FormatGrid()
        Dim dc As DataGridViewColumn
        If posisiForm = "obat_MObatHarga" Then
            For Each dc In DataGridView1.Columns
                Select Case dc.Name
                    Case "kode_barang"
                        dc.HeaderText = "Kode Barang"
                        dc.Width = 100
                    Case "nama_barang"
                        dc.HeaderText = "Nama Barang"
                        dc.Width = 150
                    Case "satuan"
                        dc.HeaderText = "Satuan"
                        dc.Width = 100
                    Case "nama_kategori"
                        dc.HeaderText = "Kategori"
                        dc.Width = 100
                    Case "harga_jual"
                        dc.HeaderText = "Harga Jual"
                        dc.Width = 100
                End Select
            Next
        End If
    End Sub
    Private Sub general_browse_ok()
        Try
            If posisiForm = "obat_MObatHarga" Then
                Dim a As MObatHarga = CType(Application.OpenForms("MObatHarga"), MObatHarga)
                a.Enabled = True

                Dim i As Integer = Me.DataGridView1.CurrentRow.Index
                a.txtKodeObat.Text = dttable.Rows(i).Item(0)
                a.txtNamaObat.Text = dttable.Rows(i).Item(1)
                a.txtSatuanJual.Text = dttable.Rows(i).Item(5)
                'a.lblSatuan.Text = dttable.Rows(i).Item(3)
                'a.txtJumlah.Focus()
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub
End Class
