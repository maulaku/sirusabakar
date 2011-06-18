<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class LayMRRegis
    Inherits System.Windows.Forms.Form

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        If disposing AndAlso components IsNot Nothing Then
            components.Dispose()
        End If
        MyBase.Dispose(disposing)
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(LayMRRegis))
        Me.txtNamaAsuransi = New System.Windows.Forms.TextBox
        Me.Label19 = New System.Windows.Forms.Label
        Me.Label18 = New System.Windows.Forms.Label
        Me.Label17 = New System.Windows.Forms.Label
        Me.cmbTujuanBerobat = New System.Windows.Forms.ComboBox
        Me.Label15 = New System.Windows.Forms.Label
        Me.txtNamaPerusahaan = New System.Windows.Forms.TextBox
        Me.Label14 = New System.Windows.Forms.Label
        Me.cmbCaraPembayaran = New System.Windows.Forms.ComboBox
        Me.cmbAsalPasien = New System.Windows.Forms.ComboBox
        Me.txtNamaPerujuk = New System.Windows.Forms.TextBox
        Me.txtNoMR = New System.Windows.Forms.TextBox
        Me.Label13 = New System.Windows.Forms.Label
        Me.Label12 = New System.Windows.Forms.Label
        Me.Label8 = New System.Windows.Forms.Label
        Me.Label7 = New System.Windows.Forms.Label
        Me.Button1 = New System.Windows.Forms.Button
        Me.txtNamaDokter = New System.Windows.Forms.TextBox
        Me.Label4 = New System.Windows.Forms.Label
        Me.txtNamaPasien = New System.Windows.Forms.TextBox
        Me.cmbTglRegis = New System.Windows.Forms.DateTimePicker
        Me.txtNoRegis = New System.Windows.Forms.TextBox
        Me.Label2 = New System.Windows.Forms.Label
        Me.Label1 = New System.Windows.Forms.Label
        Me.Label3 = New System.Windows.Forms.Label
        Me.txtNoPolis = New System.Windows.Forms.TextBox
        Me.GroupBox1 = New System.Windows.Forms.GroupBox
        Me.txtNoKartu = New System.Windows.Forms.TextBox
        Me.cmbStatus = New System.Windows.Forms.ComboBox
        Me.Label23 = New System.Windows.Forms.Label
        Me.txtPetugas = New System.Windows.Forms.TextBox
        Me.Label16 = New System.Windows.Forms.Label
        Me.ToolStrip1 = New System.Windows.Forms.ToolStrip
        Me.btnNew = New System.Windows.Forms.ToolStripButton
        Me.btnEdit = New System.Windows.Forms.ToolStripButton
        Me.btnSave = New System.Windows.Forms.ToolStripButton
        Me.btnDelete = New System.Windows.Forms.ToolStripButton
        Me.btnRefresh = New System.Windows.Forms.ToolStripButton
        Me.ToolStripSeparator1 = New System.Windows.Forms.ToolStripSeparator
        Me.btnFirst = New System.Windows.Forms.ToolStripButton
        Me.btnPrev = New System.Windows.Forms.ToolStripButton
        Me.btnNext = New System.Windows.Forms.ToolStripButton
        Me.btnLast = New System.Windows.Forms.ToolStripButton
        Me.ToolStripSeparator2 = New System.Windows.Forms.ToolStripSeparator
        Me.cmbSearch = New System.Windows.Forms.ToolStripComboBox
        Me.txtSearch = New System.Windows.Forms.ToolStripTextBox
        Me.btnSearch = New System.Windows.Forms.ToolStripButton
        Me.ToolStripSeparator3 = New System.Windows.Forms.ToolStripSeparator
        Me.btnCancel = New System.Windows.Forms.ToolStripButton
        Me.DataGridView1 = New System.Windows.Forms.DataGridView
        Me.txtCatatanSebelumnya = New System.Windows.Forms.RichTextBox
        Me.Label5 = New System.Windows.Forms.Label
        Me.txtCatatan = New System.Windows.Forms.TextBox
        Me.Label6 = New System.Windows.Forms.Label
        Me.GroupBox1.SuspendLayout()
        Me.ToolStrip1.SuspendLayout()
        CType(Me.DataGridView1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'txtNamaAsuransi
        '
        Me.txtNamaAsuransi.Location = New System.Drawing.Point(124, 185)
        Me.txtNamaAsuransi.Name = "txtNamaAsuransi"
        Me.txtNamaAsuransi.Size = New System.Drawing.Size(168, 20)
        Me.txtNamaAsuransi.TabIndex = 15
        '
        'Label19
        '
        Me.Label19.AutoSize = True
        Me.Label19.Location = New System.Drawing.Point(18, 187)
        Me.Label19.Name = "Label19"
        Me.Label19.Size = New System.Drawing.Size(78, 13)
        Me.Label19.TabIndex = 14
        Me.Label19.Text = "Nama Asuransi"
        '
        'Label18
        '
        Me.Label18.AutoSize = True
        Me.Label18.Location = New System.Drawing.Point(18, 240)
        Me.Label18.Name = "Label18"
        Me.Label18.Size = New System.Drawing.Size(49, 13)
        Me.Label18.TabIndex = 13
        Me.Label18.Text = "No Kartu"
        '
        'Label17
        '
        Me.Label17.AutoSize = True
        Me.Label17.Location = New System.Drawing.Point(18, 266)
        Me.Label17.Name = "Label17"
        Me.Label17.Size = New System.Drawing.Size(46, 13)
        Me.Label17.TabIndex = 12
        Me.Label17.Text = "No Polis"
        '
        'cmbTujuanBerobat
        '
        Me.cmbTujuanBerobat.FormattingEnabled = True
        Me.cmbTujuanBerobat.Items.AddRange(New Object() {"Poliklinik", "Fisioterapi", "Laboratorium", "Rontgen", "Hemodialisa", "UGD"})
        Me.cmbTujuanBerobat.Location = New System.Drawing.Point(363, 88)
        Me.cmbTujuanBerobat.Name = "cmbTujuanBerobat"
        Me.cmbTujuanBerobat.Size = New System.Drawing.Size(100, 21)
        Me.cmbTujuanBerobat.TabIndex = 11
        '
        'Label15
        '
        Me.Label15.AutoSize = True
        Me.Label15.Location = New System.Drawing.Point(258, 91)
        Me.Label15.Name = "Label15"
        Me.Label15.Size = New System.Drawing.Size(80, 13)
        Me.Label15.TabIndex = 10
        Me.Label15.Text = "Tujuan Berobat"
        '
        'txtNamaPerusahaan
        '
        Me.txtNamaPerusahaan.Location = New System.Drawing.Point(124, 211)
        Me.txtNamaPerusahaan.Name = "txtNamaPerusahaan"
        Me.txtNamaPerusahaan.Size = New System.Drawing.Size(168, 20)
        Me.txtNamaPerusahaan.TabIndex = 9
        '
        'Label14
        '
        Me.Label14.AutoSize = True
        Me.Label14.Location = New System.Drawing.Point(19, 213)
        Me.Label14.Name = "Label14"
        Me.Label14.Size = New System.Drawing.Size(95, 13)
        Me.Label14.TabIndex = 8
        Me.Label14.Text = "Nama Perusahaan"
        '
        'cmbCaraPembayaran
        '
        Me.cmbCaraPembayaran.FormattingEnabled = True
        Me.cmbCaraPembayaran.Items.AddRange(New Object() {"Biasa", "Asuransi", "Perusahaan"})
        Me.cmbCaraPembayaran.Location = New System.Drawing.Point(124, 158)
        Me.cmbCaraPembayaran.Name = "cmbCaraPembayaran"
        Me.cmbCaraPembayaran.Size = New System.Drawing.Size(100, 21)
        Me.cmbCaraPembayaran.TabIndex = 7
        '
        'cmbAsalPasien
        '
        Me.cmbAsalPasien.FormattingEnabled = True
        Me.cmbAsalPasien.Items.AddRange(New Object() {"Umum", "Rujukan"})
        Me.cmbAsalPasien.Location = New System.Drawing.Point(124, 88)
        Me.cmbAsalPasien.Name = "cmbAsalPasien"
        Me.cmbAsalPasien.Size = New System.Drawing.Size(100, 21)
        Me.cmbAsalPasien.TabIndex = 6
        '
        'txtNamaPerujuk
        '
        Me.txtNamaPerujuk.Location = New System.Drawing.Point(124, 115)
        Me.txtNamaPerujuk.Name = "txtNamaPerujuk"
        Me.txtNamaPerujuk.Size = New System.Drawing.Size(128, 20)
        Me.txtNamaPerujuk.TabIndex = 5
        '
        'txtNoMR
        '
        Me.txtNoMR.Location = New System.Drawing.Point(124, 19)
        Me.txtNoMR.Name = "txtNoMR"
        Me.txtNoMR.Size = New System.Drawing.Size(100, 20)
        Me.txtNoMR.TabIndex = 4
        '
        'Label13
        '
        Me.Label13.AutoSize = True
        Me.Label13.Location = New System.Drawing.Point(19, 161)
        Me.Label13.Name = "Label13"
        Me.Label13.Size = New System.Drawing.Size(91, 13)
        Me.Label13.TabIndex = 3
        Me.Label13.Text = "Cara Pembayaran"
        '
        'Label12
        '
        Me.Label12.AutoSize = True
        Me.Label12.Location = New System.Drawing.Point(19, 118)
        Me.Label12.Name = "Label12"
        Me.Label12.Size = New System.Drawing.Size(74, 13)
        Me.Label12.TabIndex = 2
        Me.Label12.Text = "Nama Perujuk"
        '
        'Label8
        '
        Me.Label8.AutoSize = True
        Me.Label8.Location = New System.Drawing.Point(19, 91)
        Me.Label8.Name = "Label8"
        Me.Label8.Size = New System.Drawing.Size(62, 13)
        Me.Label8.TabIndex = 1
        Me.Label8.Text = "Asal Pasien"
        '
        'Label7
        '
        Me.Label7.AutoSize = True
        Me.Label7.Location = New System.Drawing.Point(19, 22)
        Me.Label7.Name = "Label7"
        Me.Label7.Size = New System.Drawing.Size(99, 13)
        Me.Label7.TabIndex = 0
        Me.Label7.Text = "No Medical Record"
        '
        'Button1
        '
        Me.Button1.Location = New System.Drawing.Point(230, 17)
        Me.Button1.Name = "Button1"
        Me.Button1.Size = New System.Drawing.Size(62, 23)
        Me.Button1.TabIndex = 22
        Me.Button1.Text = "View MR"
        Me.Button1.UseVisualStyleBackColor = True
        '
        'txtNamaDokter
        '
        Me.txtNamaDokter.Location = New System.Drawing.Point(363, 115)
        Me.txtNamaDokter.Name = "txtNamaDokter"
        Me.txtNamaDokter.Size = New System.Drawing.Size(100, 20)
        Me.txtNamaDokter.TabIndex = 21
        '
        'Label4
        '
        Me.Label4.AutoSize = True
        Me.Label4.Location = New System.Drawing.Point(258, 117)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(70, 13)
        Me.Label4.TabIndex = 20
        Me.Label4.Text = "Nama Dokter"
        '
        'txtNamaPasien
        '
        Me.txtNamaPasien.Location = New System.Drawing.Point(124, 45)
        Me.txtNamaPasien.Name = "txtNamaPasien"
        Me.txtNamaPasien.Size = New System.Drawing.Size(204, 20)
        Me.txtNamaPasien.TabIndex = 19
        '
        'cmbTglRegis
        '
        Me.cmbTglRegis.Location = New System.Drawing.Point(112, 71)
        Me.cmbTglRegis.Name = "cmbTglRegis"
        Me.cmbTglRegis.Size = New System.Drawing.Size(183, 20)
        Me.cmbTglRegis.TabIndex = 31
        '
        'txtNoRegis
        '
        Me.txtNoRegis.Location = New System.Drawing.Point(112, 45)
        Me.txtNoRegis.Name = "txtNoRegis"
        Me.txtNoRegis.Size = New System.Drawing.Size(183, 20)
        Me.txtNoRegis.TabIndex = 30
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.BackColor = System.Drawing.Color.Transparent
        Me.Label2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label2.Location = New System.Drawing.Point(21, 75)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(85, 13)
        Me.Label2.TabIndex = 29
        Me.Label2.Text = "Tgl Registrasi"
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.BackColor = System.Drawing.Color.Transparent
        Me.Label1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label1.ForeColor = System.Drawing.Color.Red
        Me.Label1.Location = New System.Drawing.Point(21, 48)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(83, 13)
        Me.Label1.TabIndex = 28
        Me.Label1.Text = "No Registrasi"
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.Location = New System.Drawing.Point(19, 49)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(70, 13)
        Me.Label3.TabIndex = 18
        Me.Label3.Text = "Nama Pasien"
        '
        'txtNoPolis
        '
        Me.txtNoPolis.Location = New System.Drawing.Point(124, 263)
        Me.txtNoPolis.Name = "txtNoPolis"
        Me.txtNoPolis.Size = New System.Drawing.Size(118, 20)
        Me.txtNoPolis.TabIndex = 17
        '
        'GroupBox1
        '
        Me.GroupBox1.BackColor = System.Drawing.Color.Transparent
        Me.GroupBox1.Controls.Add(Me.Button1)
        Me.GroupBox1.Controls.Add(Me.txtNamaDokter)
        Me.GroupBox1.Controls.Add(Me.Label4)
        Me.GroupBox1.Controls.Add(Me.txtNamaPasien)
        Me.GroupBox1.Controls.Add(Me.Label3)
        Me.GroupBox1.Controls.Add(Me.txtNoPolis)
        Me.GroupBox1.Controls.Add(Me.txtNoKartu)
        Me.GroupBox1.Controls.Add(Me.txtNamaAsuransi)
        Me.GroupBox1.Controls.Add(Me.Label19)
        Me.GroupBox1.Controls.Add(Me.Label18)
        Me.GroupBox1.Controls.Add(Me.Label17)
        Me.GroupBox1.Controls.Add(Me.cmbTujuanBerobat)
        Me.GroupBox1.Controls.Add(Me.Label15)
        Me.GroupBox1.Controls.Add(Me.txtNamaPerusahaan)
        Me.GroupBox1.Controls.Add(Me.Label14)
        Me.GroupBox1.Controls.Add(Me.cmbCaraPembayaran)
        Me.GroupBox1.Controls.Add(Me.cmbAsalPasien)
        Me.GroupBox1.Controls.Add(Me.txtNamaPerujuk)
        Me.GroupBox1.Controls.Add(Me.txtNoMR)
        Me.GroupBox1.Controls.Add(Me.Label13)
        Me.GroupBox1.Controls.Add(Me.Label12)
        Me.GroupBox1.Controls.Add(Me.Label8)
        Me.GroupBox1.Controls.Add(Me.Label7)
        Me.GroupBox1.Location = New System.Drawing.Point(24, 98)
        Me.GroupBox1.Name = "GroupBox1"
        Me.GroupBox1.Size = New System.Drawing.Size(487, 298)
        Me.GroupBox1.TabIndex = 36
        Me.GroupBox1.TabStop = False
        Me.GroupBox1.Text = "Registrasi"
        '
        'txtNoKartu
        '
        Me.txtNoKartu.Location = New System.Drawing.Point(124, 237)
        Me.txtNoKartu.Name = "txtNoKartu"
        Me.txtNoKartu.Size = New System.Drawing.Size(168, 20)
        Me.txtNoKartu.TabIndex = 16
        '
        'cmbStatus
        '
        Me.cmbStatus.FormattingEnabled = True
        Me.cmbStatus.Location = New System.Drawing.Point(402, 45)
        Me.cmbStatus.Name = "cmbStatus"
        Me.cmbStatus.Size = New System.Drawing.Size(100, 21)
        Me.cmbStatus.TabIndex = 35
        '
        'Label23
        '
        Me.Label23.AutoSize = True
        Me.Label23.BackColor = System.Drawing.Color.Transparent
        Me.Label23.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label23.Location = New System.Drawing.Point(342, 48)
        Me.Label23.Name = "Label23"
        Me.Label23.Size = New System.Drawing.Size(43, 13)
        Me.Label23.TabIndex = 34
        Me.Label23.Text = "Status"
        '
        'txtPetugas
        '
        Me.txtPetugas.Location = New System.Drawing.Point(402, 72)
        Me.txtPetugas.Name = "txtPetugas"
        Me.txtPetugas.Size = New System.Drawing.Size(100, 20)
        Me.txtPetugas.TabIndex = 33
        '
        'Label16
        '
        Me.Label16.AutoSize = True
        Me.Label16.BackColor = System.Drawing.Color.Transparent
        Me.Label16.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label16.Location = New System.Drawing.Point(342, 75)
        Me.Label16.Name = "Label16"
        Me.Label16.Size = New System.Drawing.Size(53, 13)
        Me.Label16.TabIndex = 32
        Me.Label16.Text = "Petugas"
        '
        'ToolStrip1
        '
        Me.ToolStrip1.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.btnNew, Me.btnEdit, Me.btnSave, Me.btnDelete, Me.btnRefresh, Me.ToolStripSeparator1, Me.btnFirst, Me.btnPrev, Me.btnNext, Me.btnLast, Me.ToolStripSeparator2, Me.cmbSearch, Me.txtSearch, Me.btnSearch, Me.ToolStripSeparator3, Me.btnCancel})
        Me.ToolStrip1.Location = New System.Drawing.Point(0, 0)
        Me.ToolStrip1.Name = "ToolStrip1"
        Me.ToolStrip1.Size = New System.Drawing.Size(926, 25)
        Me.ToolStrip1.TabIndex = 92
        Me.ToolStrip1.Text = "ToolStrip1"
        '
        'btnNew
        '
        Me.btnNew.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image
        Me.btnNew.Image = CType(resources.GetObject("btnNew.Image"), System.Drawing.Image)
        Me.btnNew.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.btnNew.Name = "btnNew"
        Me.btnNew.Size = New System.Drawing.Size(23, 22)
        Me.btnNew.Text = "New"
        '
        'btnEdit
        '
        Me.btnEdit.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image
        Me.btnEdit.Image = CType(resources.GetObject("btnEdit.Image"), System.Drawing.Image)
        Me.btnEdit.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.btnEdit.Name = "btnEdit"
        Me.btnEdit.Size = New System.Drawing.Size(23, 22)
        Me.btnEdit.Text = "ToolStripButton9"
        '
        'btnSave
        '
        Me.btnSave.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image
        Me.btnSave.Image = CType(resources.GetObject("btnSave.Image"), System.Drawing.Image)
        Me.btnSave.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.btnSave.Name = "btnSave"
        Me.btnSave.Size = New System.Drawing.Size(23, 22)
        Me.btnSave.Text = "Save"
        '
        'btnDelete
        '
        Me.btnDelete.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image
        Me.btnDelete.Image = CType(resources.GetObject("btnDelete.Image"), System.Drawing.Image)
        Me.btnDelete.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.btnDelete.Name = "btnDelete"
        Me.btnDelete.Size = New System.Drawing.Size(23, 22)
        Me.btnDelete.Text = "Delete"
        '
        'btnRefresh
        '
        Me.btnRefresh.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image
        Me.btnRefresh.Image = CType(resources.GetObject("btnRefresh.Image"), System.Drawing.Image)
        Me.btnRefresh.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.btnRefresh.Name = "btnRefresh"
        Me.btnRefresh.Size = New System.Drawing.Size(23, 22)
        Me.btnRefresh.Text = "ToolStripButton10"
        '
        'ToolStripSeparator1
        '
        Me.ToolStripSeparator1.Name = "ToolStripSeparator1"
        Me.ToolStripSeparator1.Size = New System.Drawing.Size(6, 25)
        '
        'btnFirst
        '
        Me.btnFirst.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image
        Me.btnFirst.Image = CType(resources.GetObject("btnFirst.Image"), System.Drawing.Image)
        Me.btnFirst.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.btnFirst.Name = "btnFirst"
        Me.btnFirst.Size = New System.Drawing.Size(23, 22)
        Me.btnFirst.Text = "First"
        '
        'btnPrev
        '
        Me.btnPrev.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image
        Me.btnPrev.Image = CType(resources.GetObject("btnPrev.Image"), System.Drawing.Image)
        Me.btnPrev.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.btnPrev.Name = "btnPrev"
        Me.btnPrev.Size = New System.Drawing.Size(23, 22)
        Me.btnPrev.Text = "Prev"
        '
        'btnNext
        '
        Me.btnNext.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image
        Me.btnNext.Image = CType(resources.GetObject("btnNext.Image"), System.Drawing.Image)
        Me.btnNext.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.btnNext.Name = "btnNext"
        Me.btnNext.Size = New System.Drawing.Size(23, 22)
        Me.btnNext.Text = "Next"
        '
        'btnLast
        '
        Me.btnLast.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image
        Me.btnLast.Image = CType(resources.GetObject("btnLast.Image"), System.Drawing.Image)
        Me.btnLast.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.btnLast.Name = "btnLast"
        Me.btnLast.Size = New System.Drawing.Size(23, 22)
        Me.btnLast.Text = "Last"
        '
        'ToolStripSeparator2
        '
        Me.ToolStripSeparator2.Name = "ToolStripSeparator2"
        Me.ToolStripSeparator2.Size = New System.Drawing.Size(6, 25)
        '
        'cmbSearch
        '
        Me.cmbSearch.Items.AddRange(New Object() {"Kode Tarif", "Daerah", "Tujuan"})
        Me.cmbSearch.Name = "cmbSearch"
        Me.cmbSearch.Size = New System.Drawing.Size(75, 25)
        '
        'txtSearch
        '
        Me.txtSearch.Name = "txtSearch"
        Me.txtSearch.Size = New System.Drawing.Size(80, 25)
        '
        'btnSearch
        '
        Me.btnSearch.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image
        Me.btnSearch.Image = CType(resources.GetObject("btnSearch.Image"), System.Drawing.Image)
        Me.btnSearch.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.btnSearch.Name = "btnSearch"
        Me.btnSearch.Size = New System.Drawing.Size(23, 22)
        Me.btnSearch.Text = "Find"
        '
        'ToolStripSeparator3
        '
        Me.ToolStripSeparator3.Name = "ToolStripSeparator3"
        Me.ToolStripSeparator3.Size = New System.Drawing.Size(6, 25)
        '
        'btnCancel
        '
        Me.btnCancel.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image
        Me.btnCancel.Image = CType(resources.GetObject("btnCancel.Image"), System.Drawing.Image)
        Me.btnCancel.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.btnCancel.Name = "btnCancel"
        Me.btnCancel.Size = New System.Drawing.Size(23, 22)
        Me.btnCancel.Text = "Close"
        '
        'DataGridView1
        '
        Me.DataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.DataGridView1.Location = New System.Drawing.Point(529, 45)
        Me.DataGridView1.Name = "DataGridView1"
        Me.DataGridView1.Size = New System.Drawing.Size(385, 351)
        Me.DataGridView1.TabIndex = 93
        '
        'txtCatatanSebelumnya
        '
        Me.txtCatatanSebelumnya.Location = New System.Drawing.Point(529, 428)
        Me.txtCatatanSebelumnya.Name = "txtCatatanSebelumnya"
        Me.txtCatatanSebelumnya.Size = New System.Drawing.Size(253, 113)
        Me.txtCatatanSebelumnya.TabIndex = 101
        Me.txtCatatanSebelumnya.Text = ""
        '
        'Label5
        '
        Me.Label5.AutoSize = True
        Me.Label5.BackColor = System.Drawing.Color.Transparent
        Me.Label5.Location = New System.Drawing.Point(526, 412)
        Me.Label5.Name = "Label5"
        Me.Label5.Size = New System.Drawing.Size(105, 13)
        Me.Label5.TabIndex = 100
        Me.Label5.Text = "Catatan Sebelumnya"
        '
        'txtCatatan
        '
        Me.txtCatatan.Location = New System.Drawing.Point(258, 428)
        Me.txtCatatan.Multiline = True
        Me.txtCatatan.Name = "txtCatatan"
        Me.txtCatatan.Size = New System.Drawing.Size(253, 113)
        Me.txtCatatan.TabIndex = 99
        '
        'Label6
        '
        Me.Label6.AutoSize = True
        Me.Label6.BackColor = System.Drawing.Color.Transparent
        Me.Label6.Location = New System.Drawing.Point(255, 412)
        Me.Label6.Name = "Label6"
        Me.Label6.Size = New System.Drawing.Size(44, 13)
        Me.Label6.TabIndex = 98
        Me.Label6.Text = "Catatan"
        '
        'LayMRRegis
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackgroundImage = CType(resources.GetObject("$this.BackgroundImage"), System.Drawing.Image)
        Me.ClientSize = New System.Drawing.Size(926, 553)
        Me.Controls.Add(Me.txtCatatanSebelumnya)
        Me.Controls.Add(Me.Label5)
        Me.Controls.Add(Me.txtCatatan)
        Me.Controls.Add(Me.Label6)
        Me.Controls.Add(Me.DataGridView1)
        Me.Controls.Add(Me.ToolStrip1)
        Me.Controls.Add(Me.cmbTglRegis)
        Me.Controls.Add(Me.txtNoRegis)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.GroupBox1)
        Me.Controls.Add(Me.cmbStatus)
        Me.Controls.Add(Me.Label23)
        Me.Controls.Add(Me.txtPetugas)
        Me.Controls.Add(Me.Label16)
        Me.Name = "LayMRRegis"
        Me.Text = "Layanan Registrasi Pasien (Medical Record)"
        Me.GroupBox1.ResumeLayout(False)
        Me.GroupBox1.PerformLayout()
        Me.ToolStrip1.ResumeLayout(False)
        Me.ToolStrip1.PerformLayout()
        CType(Me.DataGridView1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents txtNamaAsuransi As System.Windows.Forms.TextBox
    Friend WithEvents Label19 As System.Windows.Forms.Label
    Friend WithEvents Label18 As System.Windows.Forms.Label
    Friend WithEvents Label17 As System.Windows.Forms.Label
    Friend WithEvents cmbTujuanBerobat As System.Windows.Forms.ComboBox
    Friend WithEvents Label15 As System.Windows.Forms.Label
    Friend WithEvents txtNamaPerusahaan As System.Windows.Forms.TextBox
    Friend WithEvents Label14 As System.Windows.Forms.Label
    Friend WithEvents cmbCaraPembayaran As System.Windows.Forms.ComboBox
    Friend WithEvents cmbAsalPasien As System.Windows.Forms.ComboBox
    Friend WithEvents txtNamaPerujuk As System.Windows.Forms.TextBox
    Friend WithEvents txtNoMR As System.Windows.Forms.TextBox
    Friend WithEvents Label13 As System.Windows.Forms.Label
    Friend WithEvents Label12 As System.Windows.Forms.Label
    Friend WithEvents Label8 As System.Windows.Forms.Label
    Friend WithEvents Label7 As System.Windows.Forms.Label
    Friend WithEvents Button1 As System.Windows.Forms.Button
    Friend WithEvents txtNamaDokter As System.Windows.Forms.TextBox
    Friend WithEvents Label4 As System.Windows.Forms.Label
    Friend WithEvents txtNamaPasien As System.Windows.Forms.TextBox
    Friend WithEvents cmbTglRegis As System.Windows.Forms.DateTimePicker
    Friend WithEvents txtNoRegis As System.Windows.Forms.TextBox
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents txtNoPolis As System.Windows.Forms.TextBox
    Friend WithEvents GroupBox1 As System.Windows.Forms.GroupBox
    Friend WithEvents txtNoKartu As System.Windows.Forms.TextBox
    Friend WithEvents cmbStatus As System.Windows.Forms.ComboBox
    Friend WithEvents Label23 As System.Windows.Forms.Label
    Friend WithEvents txtPetugas As System.Windows.Forms.TextBox
    Friend WithEvents Label16 As System.Windows.Forms.Label
    Friend WithEvents ToolStrip1 As System.Windows.Forms.ToolStrip
    Friend WithEvents btnNew As System.Windows.Forms.ToolStripButton
    Friend WithEvents btnEdit As System.Windows.Forms.ToolStripButton
    Friend WithEvents btnSave As System.Windows.Forms.ToolStripButton
    Friend WithEvents btnDelete As System.Windows.Forms.ToolStripButton
    Friend WithEvents btnRefresh As System.Windows.Forms.ToolStripButton
    Friend WithEvents ToolStripSeparator1 As System.Windows.Forms.ToolStripSeparator
    Friend WithEvents btnFirst As System.Windows.Forms.ToolStripButton
    Friend WithEvents btnPrev As System.Windows.Forms.ToolStripButton
    Friend WithEvents btnNext As System.Windows.Forms.ToolStripButton
    Friend WithEvents btnLast As System.Windows.Forms.ToolStripButton
    Friend WithEvents ToolStripSeparator2 As System.Windows.Forms.ToolStripSeparator
    Friend WithEvents cmbSearch As System.Windows.Forms.ToolStripComboBox
    Friend WithEvents txtSearch As System.Windows.Forms.ToolStripTextBox
    Friend WithEvents btnSearch As System.Windows.Forms.ToolStripButton
    Friend WithEvents ToolStripSeparator3 As System.Windows.Forms.ToolStripSeparator
    Friend WithEvents btnCancel As System.Windows.Forms.ToolStripButton
    Friend WithEvents DataGridView1 As System.Windows.Forms.DataGridView
    Friend WithEvents txtCatatanSebelumnya As System.Windows.Forms.RichTextBox
    Friend WithEvents Label5 As System.Windows.Forms.Label
    Friend WithEvents txtCatatan As System.Windows.Forms.TextBox
    Friend WithEvents Label6 As System.Windows.Forms.Label
End Class
