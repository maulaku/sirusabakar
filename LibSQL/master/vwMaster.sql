USE SIRS

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'vwMsCoa'))
DROP VIEW vwMsCoa
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW vwMsCoa AS
SELECT top (10) id,kodeCoa,namaCoa,tipeCoa,catatan
FROM msCoa with (NOLOCK)
WHERE status=1
ORDER BY id
GO

------------------XXXXXXXXXXXXXXXXXXXXXXXXXXXXX------------------

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'vwMsDiet'))
DROP VIEW vwMsDiet
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW vwMsDiet AS
SELECT top (10) id,kodeDiet,namaDiet,catatan
FROM msDiet with (NOLOCK)
WHERE status=1
ORDER BY id
GO