IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwMsCoa]'))
DROP VIEW [dbo].[vwMsCoa]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW vwMsCoa AS
SELECT top (10) id,kode_coa,nama_coa,tipe_coa,note 
FROM ms_coa
WHERE status=1
ORDER BY id

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwMsDiet]'))
DROP VIEW [dbo].[vwMsDiet]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW vwMsDiet AS
SELECT top (10) id,kode_diet,nama_diet,note
FROM ms_diet
WHERE status=1
ORDER BY id