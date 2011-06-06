-- RANCANGAN STORE PROCEDURE : LAYANAN --
----------------------------------------------------------
-- Create by : Ivhan Famly Gunawan
-- Date : April 2011
-- Database : SQL Server
-- Penulisan : Campur
----------------------------------------------------------
USE [SIRS]
GO
----------------------------------------------------------
-- komposisi penamaan SP 
----------------------------------------------------------
-- contoh : spInsertMRDaftar
-- 1. sp = store procedure  
-- 2. nama procedure (tindakan)
-- 3. nama object
----------------------------------------------------------

--#######################################################################-- spInsertMRDaftar -- 37

IF Objectproperty(Object_Id('dbo.spInsertMRDaftar'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[spInsertMRDaftar]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE spInsertMRDaftar
	/* 1*/@inNoMR 								VARCHAR(8),	
	/* 2*/@inTitle 								VARCHAR(8),
	/* 3*/@inPatientName 					VARCHAR(100),
	/* 4*/@inPanggilan		 				VARCHAR(100),
	/* 5*/@inSex		 							VARCHAR(10),
	/* 6*/@inTempatLahir					VARCHAR(100),
	/* 7*/@inTglLahir							DATETIME,
	/* 8*/@inUmur									INT,		
	/* 9*/@inAgama								VARCHAR(100),
	/*10*/@inSukuBangsa						VARCHAR(100),
	/*11*/@inWargaNegara					VARCHAR(100),
	/*12*/@inGolDarah							VARCHAR(8),
	/*13*/@inStatusMR							VARCHAR(50),
	/*14*/@inPendidikan						VARCHAR(20),
	/*15*/@inPekerjaan						VARCHAR(100),	
	/*16*/@inAlamat								VARCHAR(1000),
	/*17*/@inProvinsi							VARCHAR(100),
	/*18*/@inKota             		VARCHAR(100),
	/*19*/@inKodePos							VARCHAR(100),
	/*20*/@inTelepon							VARCHAR(100),
	/*21*/@inHandphone						VARCHAR(100),
	/*22*/@inKabupaten						VARCHAR(100),
	/*23*/@inKecamatan						VARCHAR(100),
	/*24*/@inKelurahan						VARCHAR(100),
	/*25*/@inNamaIstri						VARCHAR(100),
	/*26*/@inNamaSuami						VARCHAR(100),
	/*27*/@inNamaAyah							VARCHAR(100),
	/*28*/@inNamaIbu							VARCHAR(100),
	/*29*/@inStatusPenanggung			INT,
	/*30*/@inNamaP								VARCHAR(100),
	/*31*/@inHubunganP						VARCHAR(100),
	/*32*/@inHubunganPLain				VARCHAR(100),
	/*33*/@inAlamatP							VARCHAR(1000),
	/*34*/@inTeleponP							VARCHAR(100),
	/*35*/@inHandphoneP						VARCHAR(100),
	/*36*/@inNote									VARCHAR(4000),
	/*37*/@inUser									INT
AS                              
	DECLARE 	
		@formType 							VARCHAR(100),
		@actionType							VARCHAR(100),
		@actionDesc							VARCHAR(1000);
BEGIN
	
	INSERT INTO trLayMRDaftar (
				/* 1*/ noMR,
				/* 2*/ title,
				/* 3*/ patientName,
				/* 4*/ panggilan,
				/* 5*/ sex,		 					
				/* 6*/ tempatLahir,			
				/* 7*/ tglLahir,			
				/* 8*/ umur,						
				/* 9*/ agama,						
				/*10*/ sukuBangsa,			
				/*11*/ wargaNegara,			
				/*12*/ golDarah,				
				/*13*/ statusMR,					
				/*14*/ pendidikan,			
				/*15*/ pekerjaan,				
				/*16*/ alamat,					
				/*17*/ provinsi,				
				/*18*/ kota,           
				/*19*/ kodePos,					
				/*20*/ telepon,					
				/*21*/ handphone,				
				/*22*/ kabupaten,				
				/*23*/ kecamatan,				
				/*24*/ kelurahan,				
				/*25*/ namaIstri,				
				/*26*/ namaSuami,				
				/*27*/ namaAyah,				
				/*28*/ namaIbu,					
				/*29*/ statusPenanggung,
				/*30*/ namaP,						
				/*31*/ hubunganP,				
				/*32*/ hubunganPLain,		
				/*33*/ alamatP,					
				/*34*/ teleponP,				
				/*35*/ handphoneP,
				/*36*/ note,							
				/*37*/ createBy,
				/*38*/ updateBy
	) VALUES (
				/* 1*/ @inNoMR, 						
				/* 2*/ @inTitle, 						
				/* 3*/ @inPatientName, 			
				/* 4*/ @inPanggilan,		 		
				/* 5*/ @inSex,		 					
				/* 6*/ @inTempatLahir,			
				/* 7*/ @inTglLahir,					
				/* 8*/ @inUmur,							
				/* 9*/ @inAgama,						
				/*10*/ @inSukuBangsa,				
				/*11*/ @inWargaNegara,			
				/*12*/ @inGolDarah,					
				/*13*/ @inStatusMR,						
				/*14*/ @inPendidikan,				
				/*15*/ @inPekerjaan,				
				/*16*/ @inAlamat,						
				/*17*/ @inProvinsi,					
				/*18*/ @inKota,             
				/*19*/ @inKodePos,					
				/*20*/ @inTelepon,					
				/*21*/ @inHandphone,				
				/*22*/ @inKabupaten,				
				/*23*/ @inKecamatan,				
				/*24*/ @inKelurahan,				
				/*25*/ @inNamaIstri,				
				/*26*/ @inNamaSuami,				
				/*27*/ @inNamaAyah,				
				/*28*/ @inNamaIbu,					
				/*29*/ @inStatusPenanggung,	
				/*30*/ @inNamaP,						
				/*31*/ @inHubunganP,				
				/*32*/ @inHubunganPLain,		
				/*33*/ @inAlamatP,					
				/*34*/ @inTeleponP,					
				/*35*/ @inHandphoneP,				
				/*36*/ @inNote,							
				/*37*/ @inUser,
				/*38*/ @inUser							
	);
	
	---------------------------------------------------
		
	SET @formType = 'MR PENDAFTARAN';
	SET @actionType = 'NEW';
	SET @actionDesc =		'NO MR : ' + @inNoMR + CHAR(10) +
											'NAMA : ' + @inPatientName + CHAR(10);
	
	INSERT INTO msHistoryLayanan (
				/* 1*/ formType,
				/* 2*/ actionType,
				/* 3*/ actionDesc,
				/* 4*/ createBy
	) VALUES (
				/* 1*/ @formType,
				/* 2*/ @actionType,
				/* 3*/ @actionDesc,
				/* 4*/ @inUser	
	);
							  
END
GO


--#######################################################################-- spUpdateTarifAmbulance -- 12

IF Objectproperty(Object_Id('dbo.spUpdateTarifAmbulance'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[spUpdateTarifAmbulance]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE spUpdateTarifAmbulance
	/* 1*/ @inIdTarifAmbulance		INT,
	/* 2*/ @inKodeTarif						VARCHAR(20),
	/* 3*/ @inDaerah							VARCHAR(100),
	/* 4*/ @inTujuan							VARCHAR(100),
	/* 5*/ @inTarif								DECIMAL,
	/* 6*/ @inPM									DECIMAL,
	/* 7*/ @inParaMedis						DECIMAL,
	/* 8*/ @inParaMedisPP					DECIMAL,
	/* 9*/ @inOksigen							DECIMAL,
	/*10*/ @inMonitor							DECIMAL,
	/*11*/ @inNote								VARCHAR(4000),
	/*12*/ @inUser								INT
AS
	DECLARE 	
		@inNewNote									VARCHAR(5000),
		@inNewNoteUpdate						VARCHAR(5000),
		@formType 									VARCHAR(100),
		@actionType									VARCHAR(100),
		@actionDesc									VARCHAR(1000);
BEGIN
	SET @inNewNote = 'Dibuat : ' +  dbo.fn_get_full_name_user(@inUser) + ' , tanggal : ' +
	CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @inNote + CHAR(10);
	
	SET @inNewNoteUpdate = @inNewNote + CHAR(10) + '--------------------' + CHAR(10) + CHAR(10)
	+ dbo.fnGetNoteTarifAmbulance(@inIdTarifAmbulance);
	
	
	IF @inNote = ''
		BEGIN
			UPDATE msTarifAmbulance SET
						/* 1*/ kodeTarif 					= @inKodeTarif,
						/* 2*/ daerah 						= @inDaerah,
						/* 3*/ tujuan							= @inTujuan,
						/* 4*/ tarif 							= @inTarif,
						/* 5*/ pendampingMedis		= @inPM,
						/* 6*/ paraMedis			 		= @inParaMedis,
						/* 6*/ paraMedisPP			 	= @inParaMedisPP,
						/* 6*/ oksigen			 			= @inOksigen,
						/* 6*/ monitor			 			= @inMonitor,
						/* 6*/ note			 					= @inNewNoteUpdate,
						/* 7*/ update_by 					= @inUser,
						/* 8*/ update_time 				= CURRENT_TIMESTAMP
			WHERE id = @inIdTarifAmbulance;
			
			
			SET @actionDesc =	'KODE TARIF : ' + @inKodeTarif + CHAR(10) +
												'DAERAH : ' + @inDaerah + CHAR(10) +
												'TUJUAN : ' + @inTujuan + CHAR(10) +
												'TARIF : ' + CAST(@inTarif AS VARCHAR(16))+ CHAR(10);
											
		END
	ELSE
		BEGIN
			UPDATE msTarifAmbulance SET
						/* 1*/ kodeTarif 					= @inKodeTarif,
						/* 2*/ daerah 						= @inDaerah,
						/* 3*/ tujuan							= @inTujuan,
						/* 4*/ tarif 							= @inTarif,
						/* 5*/ pendampingMedis		= @inPM,
						/* 6*/ paraMedis			 		= @inParaMedis,
						/* 6*/ paraMedisPP			 	= @inParaMedisPP,
						/* 6*/ oksigen			 			= @inOksigen,
						/* 6*/ monitor			 			= @inMonitor,
						/* 6*/ note			 					= @inNewNoteUpdate,
						/* 7*/ update_by 					= @inUser,
						/* 8*/ update_time 				= CURRENT_TIMESTAMP
			WHERE id = @inIdTarifAmbulance;
			
			SET @actionDesc =		'KODE TARIF : ' + @inKodeTarif + CHAR(10) +
													'DAERAH : ' + @inDaerah + CHAR(10) +
													'TUJUAN : ' + @inTujuan + CHAR(10) +
													'TARIF : ' + CAST(@inTarif AS VARCHAR(16))+ CHAR(10) +
													'NOTE : ' + @inNewNote + CHAR(10);
		END
	
	SET @formType = 'TARIF AMBULANCE';
	SET @actionType = 'UPDATE';
	---------------------------------------------------
	
	INSERT INTO ms_history (
				/* 1*/ form_type,
				/* 2*/ action_type,
				/* 3*/ action_desc,
				/* 4*/ create_by
	) VALUES (
				/* 1*/ @formType,
				/* 2*/ @actionType,
				/* 3*/ @actionDesc,
				/* 4*/ @inUser	
	);
							  
END
GO

--#######################################################################-- spDeleteTarifAmbulance -- 6

IF Objectproperty(Object_Id('dbo.spDeleteTarifAmbulance'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[spDeleteTarifAmbulance]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE spDeleteTarifAmbulance 
	/* 1*/ @inIdTarifAmbulance		INT,
	/* 2*/ @inKodeTarif						VARCHAR(20),
	/* 3*/ @inDaerah							VARCHAR(100),
	/* 4*/ @inTujuan							VARCHAR(100),
	/* 5*/ @inTarif								DECIMAL,
	/* 6*/ @inUser								INT
AS
	DECLARE 	
		@formType 								VARCHAR(100),
		@actionType								VARCHAR(100),
		@actionDesc								VARCHAR(1000);
BEGIN

	UPDATE msTarifAmbulance SET
				/* 1*/ status 			= 0,
				/* 2*/ update_by 		= @inUser,
				/* 3*/ update_time 	= CURRENT_TIMESTAMP
	WHERE id = @inIdTarifAmbulance;
					
		SET @actionDesc =	'KODE TARIF : ' + @inKodeTarif + CHAR(10) +
												'DAERAH : ' + @inDaerah + CHAR(10) +
												'TUJUAN : ' + @inTujuan + CHAR(10) +
												'TARIF : ' + CAST(@inTarif AS VARCHAR(16))+ CHAR(10);
	
	SET @formType = 'TARIF AMBULANCE';
	SET @actionType = 'DELETE';
	---------------------------------------------------
	
	INSERT INTO ms_history (
				/* 1*/ form_type,
				/* 2*/ action_type,
				/* 3*/ action_desc,
				/* 4*/ create_by
	) VALUES (
				/* 1*/ @formType,
				/* 2*/ @actionType,
				/* 3*/ @actionDesc,
				/* 4*/ @inUser	
	);
							  
END
GO


--#######################################################################-- spInsertMR -- 11

IF Objectproperty(Object_Id('dbo.spInsertMR'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[spInsertMR]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE spInsertMR
	/* 1*/ @inKodeTarif						VARCHAR(20),
	/* 2*/ @inDaerah							VARCHAR(100),
	/* 3*/ @inTujuan							VARCHAR(100),
	/* 4*/ @inTarif								DECIMAL,
	/* 5*/ @inPM									DECIMAL,
	/* 6*/ @inParaMedis						DECIMAL,
	/* 7*/ @inParaMedisPP					DECIMAL,
	/* 8*/ @inOksigen							DECIMAL,
	/* 9*/ @inMonitor							DECIMAL,
	/*10*/ @inNote								VARCHAR(4000),
	/*11*/ @inUser								INT
AS
	DECLARE 	
		@inNewNote						VARCHAR(5000),
		@formType 						VARCHAR(100),
		@actionType						VARCHAR(100),
		@actionDesc						VARCHAR(1000);
BEGIN
	SET @inNewNote = 'Dibuat : ' +  dbo.fn_get_full_name_user(@inUser) + ' , tanggal : ' +
	CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @inNote + CHAR(10);
	
	INSERT INTO msTarifAmbulance (
				/* 1*/ kodeTarif,
				/* 2*/ daerah,
				/* 3*/ tujuan,
				/* 4*/ tarif,
				/* 5*/ pendampingMedis,
				/* 6*/ paraMedis,
				/* 7*/ paraMedisPP,
				/* 8*/ oksigen,
				/* 9*/ monitor,
				/*10*/ note,
				/*11*/ create_by,
				/*12*/ update_by
	) VALUES ( 				
				/* 1*/ @inKodeTarif,
				/* 2*/ @inDaerah,
				/* 3*/ @inTujuan,
				/* 4*/ @inTarif,
				/* 5*/ @inPM,
				/* 6*/ @inParaMedis,
				/* 7*/ @inParaMedisPP,
				/* 8*/ @inOksigen,
				/* 9*/ @inMonitor,			  									  
				/*10*/ @inNewNote,					  
				/*11*/ @inUser,
				/*12*/ @inUser
	);
	
	---------------------------------------------------
		
	SET @formType = 'TARIF AMBULANCE';
	SET @actionType = 'EDIT';
	SET @actionDesc =	'KODE TARIF : ' + @inKodeTarif + CHAR(10) +
										'DAERAH : ' + @inDaerah + CHAR(10) +
										'TUJUAN : ' + @inTujuan + CHAR(10) +
										'TARIF : ' + CAST(@inTarif AS VARCHAR(16))+ CHAR(10);
	
	INSERT INTO ms_history (
				/* 1*/ form_type,
				/* 2*/ action_type,
				/* 3*/ action_desc,
				/* 4*/ create_by
	) VALUES (
				/* 1*/ @formType,
				/* 2*/ @actionType,
				/* 3*/ @actionDesc,
				/* 4*/ @inUser	
	);
							  
END
GO