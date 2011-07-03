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

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'vwMsKota'))
DROP VIEW vwMsKota
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW vwMsKota AS
select top (10) id,namaKota,catatan 
from msKota with (NOLOCK)
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

------------------XXXXXXXXXXXXXXXXXXXXXXXXXXXXX------------------

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'vwMsHubKel'))
DROP VIEW vwMsHubKel
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW vwMsHubKel AS
select top (10) id,namaHubKel,catatan 
from msHubKel with (NOLOCK)
where status = 1
order by id
GO

------------------XXXXXXXXXXXXXXXXXXXXXXXXXXXXX------------------

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'vwMsInstalasi'))
DROP VIEW vwMsInstalasi
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW vwMsInstalasi AS
select top (10) id,namaInstalasi,catatan 
from msInstalasi with (NOLOCK)
where status = 1
order by id
GO

------------------XXXXXXXXXXXXXXXXXXXXXXXXXXXXX------------------

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'vwMsCaraPembayaran'))
DROP VIEW vwMsCaraPembayaran
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW vwMsCaraPembayaran AS
select top (10) id,namaCaraPembayaran,catatan 
from msCaraPembayaran with (NOLOCK)
where status = 1
order by id
GO

------------------XXXXXXXXXXXXXXXXXXXXXXXXXXXXX------------------

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'vwMsTitel'))
DROP VIEW vwMsTitel
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW vwMsTitel AS
SELECT top (10) id,namaTitel,catatan 
FROM msTitel with (NOLOCK)
WHERE status = 1
ORDER BY id
GO

------------------XXXXXXXXXXXXXXXXXXXXXXXXXXXXX------------------

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'vwMsJenisPerusahaan'))
DROP VIEW vwMsJenisPerusahaan
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW vwMsJenisPerusahaan AS
select top (10) id,namaJenisPerusahaan,catatan 
from msJenisPerusahaan with (NOLOCK)
where status = 1
order by id
GO

------------------XXXXXXXXXXXXXXXXXXXXXXXXXXXXX------------------

create view vwMenuMakanan as
select m.id, m.kodemenumakanan,m.id_diet,d.kodediet,d.namadiet,m.kelompok,m.waktu
from msmenumakanan m
left outer join msdiet d on m.id_diet = d.id

------------------XXXXXXXXXXXXXXXXXXXXXXXXXXXXX------------------

select d.id,d.id_menumakanan,m.kodemenumakanan,d.id_makanan,k.namamakanan,d.jumlah
from msmenumakanandet d
inner join msmenumakanan m on m.id=d.id_menumakanan
left outer join msmakanan k on k.id=d.id_makanan

