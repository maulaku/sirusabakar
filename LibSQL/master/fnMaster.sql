-- RANCANGAN FUNCTION SIRS --
----------------------------------------------------------
-- Create by : Ivhan Famly Gunawan & Findy Effendy
-- Date : April 2011
-- Database : SQL Server
-- Penulisan : Indonesia
----------------------------------------------------------
--USE [SIRS]
--GO
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

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnAmbilCatatanTarifAmbulance') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION fnAmbilCatatanTarifAmbulance
GO
----------SCALAR VALUED FUNCTION----------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION fnAmbilCatatanTarifAmbulance(
	@inId 	INT
)

RETURNS VARCHAR(200)

BEGIN
	RETURN (SELECT catatan FROM msTarifAmbulance WHERE id = @inId)
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