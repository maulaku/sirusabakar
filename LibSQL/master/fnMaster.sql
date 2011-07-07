-- RANCANGAN FUNCTION SIRS --
----------------------------------------------------------
-- Create by : Ivhan Famly Gunawan & Findy Effendy
-- Date : April 2011
-- Database : SQL Server
-- Penulisan : Indonesia
----------------------------------------------------------
USE [SIRS]
GO
----------------------------------------------------------
-- komposisi penamaan FN 
----------------------------------------------------------
-- contoh : fnAmbilNamaLengkap
-- 1. fn = function
-- 2. nama function (tindakan)
-- 3. nama object

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnAmbilNamaLengkap') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION fnAmbilNamaLengkap
GO
----------SCALAR VALUED FUNCTION----------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION fnAmbilNamaLengkap
(
	@in_idPengguna 				INT
)
RETURNS VARCHAR(200)
BEGIN
	RETURN (SELECT t2.namaLengkap 
			FROM msPengguna t1 with (NOLOCK)
			INNER JOIN msKaryawan t2 with (NOLOCK) on t1.ID_Karyawan = t2.ID 
			WHERE t1.id = @in_idPengguna)
END;
GO

--#######################################################################--

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnAmbilCatatanCOA') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION fnAmbilCatatanCOA
GO
----------SCALAR VALUED FUNCTION----------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION fnAmbilCatatanCOA
(
	@in_id 						INT
)

RETURNS VARCHAR(200)

BEGIN
	RETURN (SELECT  catatan	FROM mscoa WHERE id = @in_id)
END;
GO

--#######################################################################--

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnAmbilCatatanDiet') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION fnAmbilCatatanDiet
GO
----------SCALAR VALUED FUNCTION----------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION fnAmbilCatatanDiet
(
	@in_id 						INT
)

RETURNS VARCHAR(200)

BEGIN
	RETURN (SELECT catatan FROM msdiet WHERE id = @in_id)
END;
GO

--#######################################################################--

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnAmbilCatatanKelas') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION fnAmbilCatatanKelas
GO
----------SCALAR VALUED FUNCTION----------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION fnAmbilCatatanKelas
(
	@in_id 						INT
)

RETURNS VARCHAR(200)

BEGIN
	RETURN (SELECT catatan FROM mskelas WHERE id = @in_id)
END;
GO

--#######################################################################--

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnAmbilCatatanMakanan') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION fnAmbilCatatanMakanan
GO
----------SCALAR VALUED FUNCTION----------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION fnAmbilCatatanMakanan
(
	@in_id 						INT
)

RETURNS VARCHAR(200)

BEGIN
	RETURN (SELECT catatan FROM msmakanan WHERE id = @in_id)
END;
GO

--#######################################################################--

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnAmbilCatatanAlkes') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION fnAmbilCatatanAlkes
GO
----------SCALAR VALUED FUNCTION----------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION fnAmbilCatatanAlkes
(
	@in_id 						INT
)

RETURNS VARCHAR(200)

BEGIN
	RETURN (SELECT catatan FROM msalkes	WHERE id = @in_id)
END;
GO

--#######################################################################--

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnAmbilCatatanInvAtk') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION fnAmbilCatatanInvAtk
GO
----------SCALAR VALUED FUNCTION----------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION fnAmbilCatatanInvAtk
(
	@in_id 	INT
)

RETURNS VARCHAR(200)

BEGIN
	RETURN (SELECT catatan FROM msinvatk WHERE id = @in_id)
END;
GO

--#######################################################################--

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnAmbilCatatanObat') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION fnAmbilCatatanObat
GO
----------SCALAR VALUED FUNCTION----------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION fnAmbilCatatanObat
(
	@in_id 	INT
)

RETURNS VARCHAR(200)

BEGIN
	RETURN (SELECT catatan FROM ms_obat WHERE id = @in_id)
END;
GO

--#######################################################################--

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnAmbilCatatanTarifAmbulans') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION fnAmbilCatatanTarifAmbulans
GO
----------SCALAR VALUED FUNCTION----------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION fnAmbilCatatanTarifAmbulans(
	@inId 	INT
)

RETURNS VARCHAR(200)

BEGIN
	RETURN (SELECT catatan FROM msTarifAmbulans WHERE id = @inId)
END;
GO

--#######################################################################--

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnAmbilCatatanAgama') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION fnAmbilCatatanAgama
GO
----------SCALAR VALUED FUNCTION----------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION fnAmbilCatatanAgama
(
	@in_id 						INT
)

RETURNS VARCHAR(200)

BEGIN
	RETURN (SELECT  catatan	FROM msAgama WHERE id = @in_id)
END;
GO

--#######################################################################--

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnAmbilCatatanPendidikan') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION fnAmbilCatatanPendidikan
GO
----------SCALAR VALUED FUNCTION----------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION fnAmbilCatatanPendidikan
(
	@in_id 						INT
)

RETURNS VARCHAR(200)

BEGIN
	RETURN (SELECT  catatan	FROM msPendidikan WHERE id = @in_id)
END;
GO

--#######################################################################--

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnAmbilCatatanPropinsi') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION fnAmbilCatatanPropinsi
GO
----------SCALAR VALUED FUNCTION----------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION fnAmbilCatatanPropinsi
(
	@in_id 						INT
)

RETURNS VARCHAR(200)

BEGIN
	RETURN (SELECT  catatan	FROM msPropinsi WHERE id = @in_id)
END;
GO

--#######################################################################--

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnAmbilCatatanKabupaten') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION fnAmbilCatatanKabupaten
GO
----------SCALAR VALUED FUNCTION----------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION fnAmbilCatatanKabupaten
(
	@in_id 						INT
)

RETURNS VARCHAR(200)

BEGIN
	RETURN (SELECT  catatan	FROM msKabupaten WHERE id = @in_id)
END;
GO

--#######################################################################--

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnAmbilCatatanPekerjaan') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION fnAmbilCatatanPekerjaan
GO
----------SCALAR VALUED FUNCTION----------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION fnAmbilCatatanPekerjaan
(
	@in_id 						INT
)

RETURNS VARCHAR(200)

BEGIN
	RETURN (SELECT  catatan	FROM msPekerjaan WHERE id = @in_id)
END;
GO

--#######################################################################--

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnAmbilCatatanKecamatan') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION fnAmbilCatatanKecamatan
GO
----------SCALAR VALUED FUNCTION----------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION fnAmbilCatatanKecamatan
(
	@in_id 						INT
)

RETURNS VARCHAR(200)

BEGIN
	RETURN (SELECT  catatan	FROM msKecamatan WHERE id = @in_id)
END;
GO

--#######################################################################--

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnAmbilCatatanKelurahan') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION fnAmbilCatatanKelurahan
GO
----------SCALAR VALUED FUNCTION----------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION fnAmbilCatatanKelurahan
(
	@in_id 						INT
)

RETURNS VARCHAR(200)

BEGIN
	RETURN (SELECT  catatan	FROM msKelurahan WHERE id = @in_id)
END;
GO

--#######################################################################--

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnAmbilCatatanHubKel') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION fnAmbilCatatanHubKel
GO
----------SCALAR VALUED FUNCTION----------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION fnAmbilCatatanHubKel
(
	@in_id 						INT
)

RETURNS VARCHAR(200)

BEGIN
	RETURN (SELECT  catatan	FROM msHubKel WHERE id = @in_id)
END;
GO

--#######################################################################--

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnAmbilCatatanKota') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION fnAmbilCatatanKota
GO
----------SCALAR VALUED FUNCTION----------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION fnAmbilCatatanKota
(
	@in_id 						INT
)

RETURNS VARCHAR(200)

BEGIN
	RETURN (SELECT  catatan	FROM msKota WHERE id = @in_id)
END;
GO

--#######################################################################--

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnAmbilCatatanJenisPerusahaan') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION fnAmbilCatatanJenisPerusahaan
GO
----------SCALAR VALUED FUNCTION----------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION fnAmbilCatatanJenisPerusahaan
(
	@in_id 						INT
)

RETURNS VARCHAR(200)

BEGIN
	RETURN (SELECT catatan FROM msJenisPerusahaan WHERE id = @in_id)
END;
GO

--#######################################################################--

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnAmbilCatatanInstalasi') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION fnAmbilCatatanInstalasi
GO
----------SCALAR VALUED FUNCTION----------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION fnAmbilCatatanInstalasi
(
	@in_id 						INT
)

RETURNS VARCHAR(200)

BEGIN
	RETURN (SELECT catatan FROM msInstalasi WHERE id = @in_id)
END;
GO

--#######################################################################--

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnAmbilCatatanCaraPembayaran') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION fnAmbilCatatanCaraPembayaran
GO
----------SCALAR VALUED FUNCTION----------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION fnAmbilCatatanCaraPembayaran
(
	@in_id 						INT
)

RETURNS VARCHAR(200)

BEGIN
	RETURN (SELECT catatan FROM msCaraPembayaran WHERE id = @in_id)
END;
GO

--#######################################################################--

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnAmbilCatatanMenuMakanan') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION fnAmbilCatatanMenuMakanan
GO
----------SCALAR VALUED FUNCTION----------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION fnAmbilCatatanMenuMakanan
(
	@in_id 						INT
)

RETURNS VARCHAR(200)

BEGIN
	RETURN (SELECT catatan FROM msMenuMakanan WHERE id = @in_id)
END;
GO

--#######################################################################--

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnAmbilCatatanMenuMakananDet') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION fnAmbilCatatanMenuMakananDet
GO
----------SCALAR VALUED FUNCTION----------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION fnAmbilCatatanMenuMakananDet
(
	@in_id 						INT
)

RETURNS VARCHAR(200)

BEGIN
	RETURN (SELECT catatan FROM msMenuMakananDet WHERE id = @in_id)
END;
GO

--#######################################################################--

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnAmbilCatatanPengguna') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION fnAmbilCatatanPengguna
GO
----------SCALAR VALUED FUNCTION----------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION fnAmbilCatatanPengguna
(
	@in_id 						INT
)

RETURNS VARCHAR(200)

BEGIN
	RETURN (SELECT catatan FROM msPengguna WHERE id = @in_id)
END;
GO