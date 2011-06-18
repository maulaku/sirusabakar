-- RANCANGAN FUNCTION SIRS --
----------------------------------------------------------
-- Create by : Ivhan Famly Gunawan
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


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'fnAmbilCatatanLayMRRegis') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION fnAmbilCatatanLayMRRegis
GO
----------SCALAR VALUED FUNCTION----------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION fnAmbilCatatanLayMRRegis
(
	@in_id 						INT
)

RETURNS VARCHAR(1000)

BEGIN
	RETURN (SELECT catatan FROM trLayMRRegis WHERE id = @in_id)
END;
GO

--#######################################################################--