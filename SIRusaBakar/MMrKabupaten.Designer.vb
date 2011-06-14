<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class MMrKabupaten
    Inherits System.Windows.Forms.Form

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(MMrKabupaten))
        Me.toolStrip = New System.Windows.Forms.ToolStrip
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
        Me.Label2 = New System.Windows.Forms.Label
        Me.txtCatatanSebelumnya = New System.Windows.Forms.RichTextBox
        Me.Label5 = New System.Windows.Forms.Label
        Me.txtCatatan = New System.Windows.Forms.TextBox
        Me.Label4 = New System.Windows.Forms.Label
        Me.txtKabupaten = New System.Windows.Forms.TextBox
        Me.DataGridView1 = New System.Windows.Forms.DataGridView
        Me.toolStrip.SuspendLayout()
        CType(Me.DataGridView1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'toolStrip
        '
        Me.toolStrip.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.btnNew, Me.btnEdit, Me.btnSave, Me.btnDelete, Me.btnRefresh, Me.ToolStripSeparator1, Me.btnFirst, Me.btnPrev, Me.btnNext, Me.btnLast, Me.ToolStripSeparator2, Me.cmbSearch, Me.txtSearch, Me.btnSearch, Me.ToolStripSeparator3, Me.btnCancel})
        Me.toolStrip.Location = New System.Drawing.Point(0, 0)
        Me.toolStrip.Name = "toolStrip"
        Me.toolStrip.Size = New System.Drawing.Size(502, 25)
        Me.toolStrip.TabIndex = 49
        Me.toolStrip.Text = "ToolStrip1"
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
        Me.btnEdit.Text = "Edit"
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
        Me.btnRefresh.Text = "Refresh"
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
        Me.cmbSearch.AutoCompleteCustomSource.AddRange(New String() {"Kode Diet", "Nama Diet"})
        Me.cmbSearch.Items.AddRange(New Object() {"Kode Diet", "Nama Diet"})
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
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(12, 50)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(59, 13)
        Me.Label2.TabIndex = 68
        Me.Label2.Text = "Kabupaten"
        '
        'txtCatatanSebelumnya
        '
        Me.txtCatatanSebelumnya.Location = New System.Drawing.Point(241, 150)
        Me.txtCatatanSebelumnya.Name = "txtCatatanSebelumnya"
        Me.txtCatatanSebelumnya.Size = New System.Drawing.Size(253, 113)
        Me.txtCatatanSebelumnya.TabIndex = 67
        Me.txtCatatanSebelumnya.Text = ""
        '
        'Label5
        '
        Me.Label5.AutoSize = True
        Me.Label5.Location = New System.Drawing.Point(238, 134)
        Me.Label5.Name = "Label5"
        Me.Label5.Size = New System.Drawing.Size(105, 13)
        Me.Label5.TabIndex = 66
        Me.Label5.Text = "Catatan Sebelumnya"
        '
        'txtCatatan
        '
        Me.txtCatatan.Location = New System.Drawing.Point(241, 47)
        Me.txtCatatan.Multiline = True
        Me.txtCatatan.Name = "txtCatatan"
        Me.txtCatatan.Size = New System.Drawing.Size(253, 77)
        Me.txtCatatan.TabIndex = 65
        '
        'Label4
        '
        Me.Label4.AutoSize = True
        Me.Label4.Location = New System.Drawing.Point(241, 31)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(44, 13)
        Me.Label4.TabIndex = 64
        Me.Label4.Text = "Catatan"
        '
        'txtKabupaten
        '
        Me.txtKabupaten.Location = New System.Drawing.Point(72, 47)
        Me.txtKabupaten.Name = "txtKabupaten"
        Me.txtKabupaten.Size = New System.Drawing.Size(163, 20)
        Me.txtKabupaten.TabIndex = 63
        '
        'DataGridView1
        '
        Me.DataGridView1.AllowUserToAddRows = False
        Me.DataGridView1.AllowUserToDeleteRows = False
        Me.DataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.DataGridView1.Location = New System.Drawing.Point(12, 80)
        Me.DataGridView1.Name = "DataGridView1"
        Me.DataGridView1.ReadOnly = True
        Me.DataGridView1.Size = New System.Drawing.Size(223, 183)
        Me.DataGridView1.TabIndex = 62
        '
        'MKabupaten
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(502, 273)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.txtCatatanSebelumnya)
        Me.Controls.Add(Me.Label5)
        Me.Controls.Add(Me.txtCatatan)
        Me.Controls.Add(Me.Label4)
        Me.Controls.Add(Me.txtKabupaten)
        Me.Controls.Add(Me.DataGridView1)
        Me.Controls.Add(Me.toolStrip)
        Me.Name = "MKabupaten"
        Me.Text = "Master Kabupaten"
        Me.toolStrip.ResumeLayout(False)
        Me.toolStrip.PerformLayout()
        CType(Me.DataGridView1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents toolStrip As System.Windows.Forms.ToolStrip
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
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents txtCatatanSebelumnya As System.Windows.Forms.RichTextBox
    Friend WithEvents Label5 As System.Windows.Forms.Label
    Friend WithEvents txtCatatan As System.Windows.Forms.TextBox
    Friend WithEvents Label4 As System.Windows.Forms.Label
    Friend WithEvents txtKabupaten As System.Windows.Forms.TextBox
    Friend WithEvents DataGridView1 As System.Windows.Forms.DataGridView
End Class
