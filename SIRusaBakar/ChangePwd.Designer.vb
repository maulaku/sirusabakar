<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class ChangePwd
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
        Me.Label6 = New System.Windows.Forms.Label
        Me.txtKomPwd = New System.Windows.Forms.TextBox
        Me.Label3 = New System.Windows.Forms.Label
        Me.txtNewPwd = New System.Windows.Forms.TextBox
        Me.Label2 = New System.Windows.Forms.Label
        Me.txtpasswd = New System.Windows.Forms.TextBox
        Me.btnRubah = New System.Windows.Forms.Button
        Me.btnBatal = New System.Windows.Forms.Button
        Me.SuspendLayout()
        '
        'Label6
        '
        Me.Label6.AutoSize = True
        Me.Label6.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label6.Location = New System.Drawing.Point(14, 85)
        Me.Label6.Name = "Label6"
        Me.Label6.Size = New System.Drawing.Size(131, 13)
        Me.Label6.TabIndex = 102
        Me.Label6.Text = "Kata Sandi Konfirmasi"
        '
        'txtKomPwd
        '
        Me.txtKomPwd.Location = New System.Drawing.Point(151, 82)
        Me.txtKomPwd.Name = "txtKomPwd"
        Me.txtKomPwd.Size = New System.Drawing.Size(163, 20)
        Me.txtKomPwd.TabIndex = 101
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label3.Location = New System.Drawing.Point(14, 59)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(99, 13)
        Me.Label3.TabIndex = 100
        Me.Label3.Text = "Kata Sandi Baru"
        '
        'txtNewPwd
        '
        Me.txtNewPwd.Location = New System.Drawing.Point(151, 56)
        Me.txtNewPwd.Name = "txtNewPwd"
        Me.txtNewPwd.Size = New System.Drawing.Size(163, 20)
        Me.txtNewPwd.TabIndex = 99
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label2.Location = New System.Drawing.Point(14, 15)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(69, 13)
        Me.Label2.TabIndex = 98
        Me.Label2.Text = "Kata Sandi"
        '
        'txtpasswd
        '
        Me.txtpasswd.Location = New System.Drawing.Point(151, 12)
        Me.txtpasswd.Name = "txtpasswd"
        Me.txtpasswd.Size = New System.Drawing.Size(163, 20)
        Me.txtpasswd.TabIndex = 97
        '
        'btnRubah
        '
        Me.btnRubah.Location = New System.Drawing.Point(70, 123)
        Me.btnRubah.Name = "btnRubah"
        Me.btnRubah.Size = New System.Drawing.Size(75, 23)
        Me.btnRubah.TabIndex = 103
        Me.btnRubah.Text = "Rubah"
        Me.btnRubah.UseVisualStyleBackColor = True
        '
        'btnBatal
        '
        Me.btnBatal.Location = New System.Drawing.Point(163, 123)
        Me.btnBatal.Name = "btnBatal"
        Me.btnBatal.Size = New System.Drawing.Size(75, 23)
        Me.btnBatal.TabIndex = 104
        Me.btnBatal.Text = "Batal"
        Me.btnBatal.UseVisualStyleBackColor = True
        '
        'ChangePwd
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(329, 158)
        Me.Controls.Add(Me.btnBatal)
        Me.Controls.Add(Me.btnRubah)
        Me.Controls.Add(Me.Label6)
        Me.Controls.Add(Me.txtKomPwd)
        Me.Controls.Add(Me.Label3)
        Me.Controls.Add(Me.txtNewPwd)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.txtpasswd)
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "ChangePwd"
        Me.Text = "Change Password"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents Label6 As System.Windows.Forms.Label
    Friend WithEvents txtKomPwd As System.Windows.Forms.TextBox
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents txtNewPwd As System.Windows.Forms.TextBox
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents txtpasswd As System.Windows.Forms.TextBox
    Friend WithEvents btnRubah As System.Windows.Forms.Button
    Friend WithEvents btnBatal As System.Windows.Forms.Button
End Class
