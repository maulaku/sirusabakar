Public Class CariData
    Dim a, query As String
    Public Function GetSelection(ByVal sql, ByVal title) As String
        query = sql
        Me.Text = title
        Me.Show()
        Return a
    End Function

    Private Sub load_grid()
        DataGridView1.DataSource = getTabel(query)
        DataGridView1.Columns("ID").Visible = False
        DataGridView1.RowHeadersVisible = False
        DataGridView1.SelectionMode = DataGridViewSelectionMode.FullRowSelect
        DataGridView1.AutoResizeColumns()
        DataGridView1.AllowUserToAddRows = False
        DataGridView1.ReadOnly = True
    End Sub

    Private Sub CariData_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        load_grid()
    End Sub
    Private Sub pilih()
        a = DataGridView1.Item("ID", DataGridView1.CurrentRow.Index).Value
    End Sub

    Private Sub DataGridView1_DoubleClick(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles DataGridView1.DoubleClick
        pilih()
    End Sub

    Private Sub btnOK_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnOK.Click
        pilih()
        Me.Close()
    End Sub

    Private Sub btnCancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        a = "0"
        Me.Close()
    End Sub
End Class