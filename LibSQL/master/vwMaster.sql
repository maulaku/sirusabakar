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

------------------XXXXXXXXXXXXXXXXXXXXXXXXXXXXX------------------

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'vwMsMakanan'))
DROP VIEW vwMsMakanan
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW vwMsMakanan AS
select top (10) id,namamakanan,catatan 
from msmakanan with (NOLOCK)
where status = 1
order by id
GO

------------------XXXXXXXXXXXXXXXXXXXXXXXXXXXXX------------------

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'vwMsAgama'))
DROP VIEW vwMsAgama
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW vwMsAgama AS
select top (10) id,namaAgama,catatan 
from msAgama with (NOLOCK)
where status = 1
order by id
GO

------------------XXXXXXXXXXXXXXXXXXXXXXXXXXXXX------------------

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'vwMsPendidikan'))
DROP VIEW vwMsPendidikan
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW vwMsPendidikan AS
select top (10) id,namaPendidikan,catatan 
from msPendidikan with (NOLOCK)
where status = 1
order by id
GO

------------------XXXXXXXXXXXXXXXXXXXXXXXXXXXXX------------------

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'vwMsPropinsi'))
DROP VIEW vwMsPropinsi
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW vwMsPropinsi AS
select top (10) id,namaPropinsi,catatan 
from msPropinsi with (NOLOCK)
where status = 1
order by id
GO

------------------XXXXXXXXXXXXXXXXXXXXXXXXXXXXX------------------

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'vwMsKabupaten'))
DROP VIEW vwMsKabupaten
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW vwMsKabupaten AS
select top (10) id,namaKabupaten,catatan 
from msKabupaten with (NOLOCK)
where status = 1
order by id
GO

------------------XXXXXXXXXXXXXXXXXXXXXXXXXXXXX------------------

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'vwMsPekerjaan'))
DROP VIEW vwMsPekerjaan
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW vwMsPekerjaan AS
select top (10) id,namaPekerjaan,catatan 
from msPekerjaan with (NOLOCK)
where status = 1
order by id
GO

------------------XXXXXXXXXXXXXXXXXXXXXXXXXXXXX------------------

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'vwMsKecamatan'))
DROP VIEW vwMsKecamatan
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW vwMsKecamatan AS
select top (10) id,namaKecamatan,catatan 
from msKecamatan with (NOLOCK)
where status = 1
order by id
GO

------------------XXXXXXXXXXXXXXXXXXXXXXXXXXXXX------------------

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'vwMsKelurahan'))
DROP VIEW vwMsKelurahan
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW vwMsKelurahan AS
select top (10) id,namaKelurahan,catatan 
from msKelurahan with (NOLOCK)
where status = 1
order by id
GO