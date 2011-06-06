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