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
----------------------------------------------------------

IF OBJECT_ID (N'fnAmbilNamaLengkap', N'FN') IS NOT NULL
    DROP FUNCTION fnAmbilNamaLengkap;
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
	RETURN (SELECT 
							t2.namaLengkap 
						FROM 
							msPengguna t1 with (NOLOCK)
							Inner Join msKaryawan t2 with (NOLOCK) on t1.ID_Karyawan = t2.ID 
						WHERE 
							t1.id = @in_IdPengguna
END;
GO

--#######################################################################--

IF OBJECT_ID (N'fnAmbilCatatanCOA', N'FN') IS NOT NULL
    DROP FUNCTION fnAmbilCatatanCOA;
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

IF OBJECT_ID (N'fnAmbilCatatanDiet', N'FN') IS NOT NULL
    DROP FUNCTION fnAmbilCatatanDiet;
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

IF OBJECT_ID (N'fnAmbilCatatanKelas', N'FN') IS NOT NULL
    DROP FUNCTION fnAmbilCatatanKelas;
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
	RETURN (SELECT 
							catatan
						FROM 
							mskelas
						WHERE 
							id = @in_id)
END;
GO

--#######################################################################--

IF OBJECT_ID (N'fnAmbilCatatanMakanan', N'FN') IS NOT NULL
    DROP FUNCTION fnAmbilCatatanMakanan;
GO
----------SCALAR VALUED FUNCTION----------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION fnAmbilCatatanMakanan(
	@in_id 						INT
)

RETURNS VARCHAR(200)

BEGIN
	RETURN (SELECT 
							catatan
						FROM 
							msmakanan
						WHERE 
							id = @in_id)
END;
GO

--#######################################################################--

IF OBJECT_ID (N'fnAmbilCatatanAlkes', N'FN') IS NOT NULL
    DROP FUNCTION fnAmbilCatatanAlkess;
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
	RETURN (SELECT 
							catatan
						FROM 
							msalkes
						WHERE 
							id = @in_id)
END;
GO

--#######################################################################--

IF OBJECT_ID (N'fnAmbilCatatanInvAtk', N'FN') IS NOT NULL
    DROP FUNCTION fnAmbilCatatanInvAtk;
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
	RETURN 
	(SELECT 
		catatan
	FROM 
		msinvatk
	WHERE 
	id = @in_id)
END;
GO

--#######################################################################--

IF OBJECT_ID (N'fnAmbilCatatanObat', N'FN') IS NOT NULL
    DROP FUNCTION fnAmbilCatatanObat;
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
	RETURN 
	(SELECT 
		catatan
	FROM 
		ms_obat
	WHERE 
	id = @in_id)
END;
GO

--#######################################################################--

IF OBJECT_ID (N'fnAmbilCatatanTarifAmbulance', N'FN') IS NOT NULL
    DROP FUNCTION fnAmbilCatatanTarifAmbulance;
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
	RETURN 
	(SELECT 
		catatan
	FROM 
		msTarifAmbulance
	WHERE 
	id = @inId)
END;
GO

--#######################################################################--