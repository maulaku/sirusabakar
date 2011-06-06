-- RANCANGAN FUNCTION SIRS --
----------------------------------------------------------
-- Create by : Ivhan Famly Gunawan
-- Date : April 2011
-- Database : SQL Server
-- Penulisan : Campur
----------------------------------------------------------
USE [SIRS]
GO
----------------------------------------------------------
-- komposisi penamaan FN 
----------------------------------------------------------
-- contoh : fn_get_full_name_user
-- 1. fn = function
-- 2. nama function (tindakan)
-- 3. nama object
----------------------------------------------------------

IF OBJECT_ID (N'fn_get_full_name_user', N'FN') IS NOT NULL
    DROP FUNCTION fn_get_full_name_user;
GO
----------SCALAR VALUED FUNCTION----------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION fn_get_full_name_user
(@in_user_id INT)

RETURNS VARCHAR(200)

BEGIN
	RETURN (SELECT 
							t2.full_name 
						FROM 
							ms_user t1, ms_employee t2 
						WHERE 
							t1.id = @in_user_id
							AND t1.id_employee = t2.id)
END;
GO

--#######################################################################--

IF OBJECT_ID (N'fn_get_note_coa', N'FN') IS NOT NULL
    DROP FUNCTION fn_get_note_coa;
GO
----------SCALAR VALUED FUNCTION----------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION fn_get_note_coa(
	@in_id 						INT
)

RETURNS VARCHAR(200)

BEGIN
	RETURN (SELECT 
							note
						FROM 
							ms_coa
						WHERE 
							id = @in_id)
END;
GO

--#######################################################################--

IF OBJECT_ID (N'fn_get_note_diet', N'FN') IS NOT NULL
    DROP FUNCTION fn_get_note_diet;
GO
----------SCALAR VALUED FUNCTION----------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION fn_get_note_diet(
	@in_id 						INT
)

RETURNS VARCHAR(200)

BEGIN
	RETURN (SELECT 
							note
						FROM 
							ms_diet
						WHERE 
							id = @in_id)
END;
GO

--#######################################################################--

IF OBJECT_ID (N'fn_get_note_kelas', N'FN') IS NOT NULL
    DROP FUNCTION fn_get_note_kelas;
GO
----------SCALAR VALUED FUNCTION----------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION fn_get_note_kelas(
	@in_id 						INT
)

RETURNS VARCHAR(200)

BEGIN
	RETURN (SELECT 
							note
						FROM 
							ms_kelas
						WHERE 
							id = @in_id)
END;
GO

--#######################################################################--

IF OBJECT_ID (N'fn_get_note_makanan', N'FN') IS NOT NULL
    DROP FUNCTION fn_get_note_makanan;
GO
----------SCALAR VALUED FUNCTION----------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION fn_get_note_makanan(
	@in_id 						INT
)

RETURNS VARCHAR(200)

BEGIN
	RETURN (SELECT 
							note
						FROM 
							ms_makanan
						WHERE 
							id = @in_id)
END;
GO

--#######################################################################--

IF OBJECT_ID (N'fn_get_note_alkes', N'FN') IS NOT NULL
    DROP FUNCTION fn_get_note_alkes;
GO
----------SCALAR VALUED FUNCTION----------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION fn_get_note_alkes(
	@in_id 						INT
)

RETURNS VARCHAR(200)

BEGIN
	RETURN (SELECT 
							note
						FROM 
							ms_alkes
						WHERE 
							id = @in_id)
END;
GO

--#######################################################################--

IF OBJECT_ID (N'fn_get_note_inv_atk', N'FN') IS NOT NULL
    DROP FUNCTION fn_get_note_inv_atk;
GO
----------SCALAR VALUED FUNCTION----------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION fn_get_note_inv_atk(
	@in_id 	INT
)

RETURNS VARCHAR(200)

BEGIN
	RETURN 
	(SELECT 
		note
	FROM 
		ms_inv_atk
	WHERE 
	id = @in_id)
END;
GO

--#######################################################################--

IF OBJECT_ID (N'fn_get_note_obat', N'FN') IS NOT NULL
    DROP FUNCTION fn_get_note_obat;
GO
----------SCALAR VALUED FUNCTION----------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION fn_get_note_obat(
	@in_id 	INT
)

RETURNS VARCHAR(200)

BEGIN
	RETURN 
	(SELECT 
		note
	FROM 
		ms_obat
	WHERE 
	id = @in_id)
END;
GO

--#######################################################################--

IF OBJECT_ID (N'fnGetNoteTarifAmbulance', N'FN') IS NOT NULL
    DROP FUNCTION fnGetNoteTarifAmbulance;
GO
----------SCALAR VALUED FUNCTION----------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION fnGetNoteTarifAmbulance(
	@inId 	INT
)

RETURNS VARCHAR(200)

BEGIN
	RETURN 
	(SELECT 
		note
	FROM 
		msTarifAmbulance
	WHERE 
	id = @inId)
END;
GO

--#######################################################################--