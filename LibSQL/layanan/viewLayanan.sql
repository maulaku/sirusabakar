-- RANCANGAN View : LAYANAN --
----------------------------------------------------------
-- Create by : Findy Efendy
-- Date : Juni 2011
-- Database : SQL Server
-- Penulisan : Campur
USE [SIRS]
GO
----------------------------------------------------------
-- komposisi penamaan View
----------------------------------------------------------
-- contoh : vwInsertMRDaftar
-- 1. vw = View  
-- 2. nama procedure (tindakan)
-- 3. nama object
----------------------------------------------------------

----------------------------------------------------------
-- Pengaturan dasar pembuatan View
----------------------------------------------------------
-- 1. Harus selalu menggunakan perintah "WITH (NOLOCK)" untuk meningkatkan performa database
--    http://www.mollerus.net/tom/blog/2008/03/using_mssqls_nolock_for_faster_queries.html
----------------------------------------------------------

--################################################################################################

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwLogClientPermintaan]'))
DROP VIEW [dbo].[vwLogClientPermintaan]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW vwLogClientPermintaan AS
select	a.id,
			a.no_permintaan, 
			a.tgl_permintaan, 
			a.id_bagian, 
			a.status,
			b.id as lineid, 
			b.itemcat_id, 
			b.itemkel_id, 
			b.itemjenis_id, 
			b.item_id, 
			b.item_kode,
			b.item_name, 
			b.uom
from tr_log_client_permintaan_hdr a with (nolock)
	inner join tr_log_client_permintaan_det b with (NOLOCK)
	on a.id=b.permintaanid;
GO
	
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwLayLabDiagnosa]'))
DROP VIEW [dbo].[vwLayLabDiagnosa]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW vwLayLabDiagnosa
AS
SELECT   TOP (100) PERCENT id, 
			noMR, 
			titelID, 
			namaPasien, 
			panggilan, 
			sex, 
			tempatLahir, 
			tglLahir, 
			agamaID, 
			sukuBangsa, 
			wargaNegara, 
			golDarah, 
			statusMR, 
			pendidikanID, 
			pekerjaanID, 
			alamat, 
			propinsiID, 
			kota, 
			kodePos, 
			telepon, 
			handphone, 
			kabupatenID, 
			kecamatanID, 
			kelurahanID,
			namaIstri, 
			namaSuami, 
			namaAyah, 
			namaIbu, 
			statusPenanggung,
			namaPenanggung, 
			hubkelID, 
			hubkelLain, 
			alamatPenanggung, 
			teleponPenanggung, 
			handphonePenanggung, 
			catatan
FROM         dbo.trLayMRDaftar with (NOLOCK)
WHERE     (status = 1)
ORDER BY id;
GO
-------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwLayMRRegis]'))
DROP VIEW [dbo].[vwLayMRRegis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW vwLayMRRegis
AS
SELECT  	
	TOP(30) PERCENT
	id
	, idLayMRDaftar			
	, noMR						
	, tglRegis					
	, noRegis					
	, asalPasien				
	, tujuanBerobat			
	, namaPerujuk				
	, namaDokter				
	, caraPembayaran			
	, namaAsuransi				
	, namaPerusahaan			
	, noKartu					
	, noPolis					
	, catatan
FROM 
	trLayMRRegis with (NOLOCK)
WHERE					
	status = 1
ORDER BY
	id DESC
GO
	
-------------------------------------------------------	
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwLayMrRegPasien]'))
DROP VIEW [dbo].[vwLayMrRegPasien]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW vwLayMrRegPasien
AS
SELECT 	
			/*0*/mr.id,
			/*1*/mr.noMR,
			/*2*/mr.titelID,
			/*2*/T.namaTitel,
			/*3*/mr.namaPasien,
			/*4*/mr.panggilan,
			/*5*/mr.sex,
			/*6*/mr.tempatLahir,
			/*7*/mr.tglLahir,
			/*9*/mr.agamaID,
			/*10*/A.NamaAgama,
			/*11*/mr.sukuBangsa,
			/*12*/mr.wargaNegara,
			/*13*/mr.golDarah,
			/*14*/mr.statusMR,
			/*15*/mr.pendidikanID,
			/*16*/P.NamaPendidikan,
			/*17*/mr.pekerjaanID,
			/*18*/K.NamaPekerjaan,
			/*19*/mr.alamat,
			/*20*/mr.propinsiID,
			/*21*/R.NamaPropinsi,
			/*22*/mr.kota,
			/*23*/mr.kodePos,
			/*24*/mr.telepon,
			/*25*/mr.handphone,
			/*26*/mr.kabupatenID,
			/*27*/B.NamaKabupaten,
			/*28*/mr.kecamatanID,
			/*29*/C.NamaKecamatan,
			/*30*/mr.kelurahanID,
			/*31*/L.NamaKelurahan,
			/*32*/mr.namaIstri,
			/*33*/mr.namaSuami,
			/*34*/mr.namaAyah,
			/*35*/mr.namaIbu,
			/*36*/mr.statusPenanggung,
			/*37*/mr.namaPenanggung,
			/*38*/mr.HubKelID,
			/*39*/H.NamaHubKel,
			/*40*/mr.HubKelLain,
			/*41*/mr.alamatPenanggung,
			/*42*/mr.teleponPenanggung,
			/*43*/mr.handphonePenanggung,
			/*44*/mr.catatan
FROM trLayMRDaftar mr with (NOLOCK)
left outer join msTitel T with (NOLOCK) on mr.titelID=t.ID
left outer join msAgama A with (NOLOCK)on mr.agamaID=a.ID
left outer join msPendidikan P with (NOLOCK)on mr.pendidikanId=P.ID
left outer join msPekerjaan K with (NOLOCK)on mr.pekerjaanID=K.ID
left outer join msPropinsi R with (NOLOCK)on mr.propinsiID=R.ID
left outer join msKabupaten B with (NOLOCK)on mr.kabupatenID=B.ID
left outer join msKecamatan C with (NOLOCK)on mr.kecamatanID=C.ID
left outer join msKelurahan L with (NOLOCK)on mr.kelurahanID=L.ID
left outer join msHubKel H with (NOLOCK)on mr.HubKelID=H.ID
WHERE mr.status=1
GO
