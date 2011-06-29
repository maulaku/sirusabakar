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
	/* 1*/   @innoMR 								VARCHAR(16)	
	/* 2*/ , @intitel 							VARCHAR(8)
	/* 3*/ , @inpatientname					VARCHAR(100)
	/* 4*/ , @inpanggilan		 				VARCHAR(100)
	/* 5*/ , @insex		 			VARCHAR(10)
	/* 6*/ , @intempatLahir					VARCHAR(100)
	/* 7*/ , @intglLahir						DATETIME
	/* 8 , @inumur								INT*/
	/* 9*/ , @inagama							VARCHAR(100)
	/*10*/ , @insukuBangsa						VARCHAR(100)
	/*11*/ , @inwargaNegara					VARCHAR(100)
	/*12*/ , @ingolDarah						VARCHAR(8)
	/*13*/ , @instatusMR						VARCHAR(50)
	/*14*/ , @inpendidikan						VARCHAR(20)
	/*15*/ , @inpekerjaan						VARCHAR(100)	
	/*16*/ , @inalamat							VARCHAR(1000)
	/*17*/ , @inprovinsi						VARCHAR(100)
	/*18*/ , @inkota             			VARCHAR(100)
	/*19*/ , @inkodePos							VARCHAR(100)
	/*20*/ , @intelepon							VARCHAR(100)
	/*21*/ , @inhandphone						VARCHAR(100)
	/*22*/ , @inkabupaten						VARCHAR(100)
	/*23*/ , @inkecamatan						VARCHAR(100)
	/*24*/ , @inkelurahan						VARCHAR(100)
	/*25*/ , @innamaIstri						VARCHAR(100)
	/*26*/ , @innamaSuami						VARCHAR(100)
	/*27*/ , @innamaAyah						VARCHAR(100)
	/*28*/ , @innamaIbu							VARCHAR(100)
	/*29*/ , @instatusPenanggung				INT
	/*30*/ , @innamaP							VARCHAR(100)
	/*31*/ , @inhubunganP						VARCHAR(100)
	/*32*/ , @inhubunganPLain					VARCHAR(100)
	/*33*/ , @inalamatP							VARCHAR(1000)
	/*34*/ , @inteleponP						VARCHAR(100)
	/*35*/ , @inhandphoneP						VARCHAR(100)
	/*36*/ , @innote						VARCHAR(4000)
	/*37*/ , @inuser						INT
AS      	                        
	DECLARE 	
		@formType 									VARCHAR(100)
		, @actionType									VARCHAR(100)
		, @actionDesc									VARCHAR(1000)
	;
BEGIN
	
	INSERT INTO trLayMRDaftar (
				/* 1*/ noMR,
				/* 2*/ titelID,
				/* 3*/ namapasien,
				/* 4*/ panggilan,
				/* 5*/ sex,		 					
				/* 6*/ tempatLahir,			
				/* 7*/ tglLahir,			
				/* 8 umur,		*/				
				/* 9*/ agamaID,						
				/*10*/ sukuBangsa,			
				/*11*/ wargaNegara,			
				/*12*/ golDarah,				
				/*13*/ statusMR,					
				/*14*/ pendidikanID,			
				/*15*/ pekerjaanID,				
				/*16*/ alamat,					
				/*17*/ propinsiID,				
				/*18*/ kota,           
				/*19*/ kodePos,					
				/*20*/ telepon,					
				/*21*/ handphone,				
				/*22*/ kabupatenID,				
				/*23*/ kecamatanID,				
				/*24*/ kelurahanID,				
				/*25*/ namaIstri,				
				/*26*/ namaSuami,				
				/*27*/ namaAyah,				
				/*28*/ namaIbu,					
				/*29*/ statusPenanggung,
				/*30*/ namaPenanggung,						
				/*31*/ hubkelID,				
				/*32*/ hubkelLain,		
				/*33*/ alamatPenanggung,					
				/*34*/ teleponPenanggung,				
				/*35*/ handphonePenanggung,
				/*36*/ catatan,							
				/*37*/ dibuatoleh,
				/*38*/ dieditoleh
	) VALUES (
				/* 1*/ @inNoMR, 						
				/* 2*/ @inTitel, 						
				/* 3*/ @inPatientName, 			
				/* 4*/ @inPanggilan,		 		
				/* 5*/ @inSex,		 					
				/* 6*/ @inTempatLahir,			
				/* 7*/ @inTglLahir,					
				/* 8 @inUmur,		*/					
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


--#######################################################################-- spUpdateMRDaftar -- 12


IF Objectproperty(Object_Id('dbo.spUpdateMRDaftar'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[spUpdateMRDaftar]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE spUpdateMRDaftar
	/* 1*/	@inIdMrLayDaftar					INT,
	/* 2*/	@inNoMR 								VARCHAR(8),	
	/* 3*/	@inTitel 							VARCHAR(8),
	/* 4*/	@inPatientName 					VARCHAR(100),
	/* 5*/	@inPanggilan		 				VARCHAR(100),
	/* 6*/	@inSex		 						VARCHAR(10),
	/* 7*/	@inTempatLahir						VARCHAR(100),
	/* 8*/	@inTglLahir							DATETIME,
	/* 9	@inUmur								INT,		*/
	/*10*/	@inAgama								VARCHAR(100),
	/*11*/	@inSukuBangsa						VARCHAR(100),
	/*12*/	@inWargaNegara						VARCHAR(100),
	/*13*/	@inGolDarah							VARCHAR(8),
	/*14*/	@inStatusMR							VARCHAR(50),
	/*15*/	@inPendidikan						VARCHAR(20),
	/*16*/	@inPekerjaan						VARCHAR(100),	
	/*17*/	@inAlamat							VARCHAR(1000),
	/*18*/	@inProvinsi							VARCHAR(100),
	/*19*/	@inKota             				VARCHAR(100),
	/*20*/	@inKodePos							VARCHAR(100),
	/*21*/	@inTelepon							VARCHAR(100),
	/*22*/	@inHandphone						VARCHAR(100),
	/*23*/	@inKabupaten						VARCHAR(100),
	/*24*/	@inKecamatan						VARCHAR(100),
	/*25*/	@inKelurahan						VARCHAR(100),
	/*26*/	@inNamaIstri						VARCHAR(100),
	/*27*/	@inNamaSuami						VARCHAR(100),
	/*28*/	@inNamaAyah							VARCHAR(100),
	/*29*/	@inNamaIbu							VARCHAR(100),
	/*30*/	@inStatusPenanggung				INT,
	/*31*/	@inNamaP								VARCHAR(100),
	/*32*/	@inHubunganP						VARCHAR(100),
	/*33*/	@inHubunganPLain					VARCHAR(100),
	/*34*/	@inAlamatP							VARCHAR(1000),
	/*35*/	@inTeleponP							VARCHAR(100),
	/*36*/	@inHandphoneP						VARCHAR(100),
	/*37*/	@inNote								VARCHAR(4000),
	/*38*/	@inUser								INT
AS
	DECLARE 	
		@inNewNote									VARCHAR(5000),
		@inNewNoteUpdate							VARCHAR(5000),
		@formType 									VARCHAR(100),
		@actionType									VARCHAR(100),
		@actionDesc									VARCHAR(1000);
BEGIN
	UPDATE trLayMRDaftar SET
		/* 1*/ noMR							= @inNoMR, 						   
		/* 2*/ titelID						= @inTitel, 						   
		/* 3*/ Namapasien		      = @inPatientName, 			   
		/* 4*/ panggilan			      = @inPanggilan,		 		   
		/* 5*/ sex						   = @inSex,		 					   
		/* 6*/ tempatLahir			   = @inTempatLahir,			   
		/* 7*/ tglLahir				   = @inTglLahir,					   
		/* 8 umur							= @inUmur,			*/				   
		/* 9*/ agamaID						= @inAgama,						   
		/*10*/ sukuBangsa				   = @inSukuBangsa,				   
		/*11*/ wargaNegara			   = @inWargaNegara,			   
		/*12*/ golDarah					= @inGolDarah,					   
		/*13*/ statusMR					= @inStatusMR,						 
		/*14*/ pendidikanID				   = @inPendidikan,				   
		/*15*/ pekerjaanID				   = @inPekerjaan,				   
		/*16*/ alamat						= @inAlamat,						   
		/*17*/ propinsiID					= @inProvinsi,					   
		/*18*/ kota							= @inKota,                
		/*19*/ kodePos					   = @inKodePos,					   
		/*20*/ telepon					   = @inTelepon,					   
		/*21*/ handphone				   = @inHandphone,				   
		/*22*/ kabupatenID				   = @inKabupaten,				   
		/*23*/ kecamatanID			      = @inKecamatan,				   
		/*24*/ kelurahanID				   = @inKelurahan,				   
		/*25*/ namaIstri					= @inNamaIstri,				   
		/*26*/ namaSuami			      = @inNamaSuami,				   
		/*27*/ namaAyah					= @inNamaAyah,				     
		/*28*/ namaIbu					   = @inNamaIbu,					   
		/*29*/ statusPenanggung		   = @inStatusPenanggung,	   
		/*30*/ namaPenanggung						= @inNamaP,						   
		/*31*/ hubkelID					= @inHubunganP,				   
		/*32*/ hubkelLain			   = @inHubunganPLain,		   
		/*33*/ alamatPenanggung						= @inAlamatP,					   
		/*34*/ teleponPenanggung					= @inTeleponP,					   
		/*35*/ handphonePenanggung					= @inHandphoneP,				   
		/*36*/ catatan							= @inNote,							   
		/*37*/ waktuedit					= CURRENT_TIMESTAMP,               
		/*38*/ dieditoleh              	= @inUser							   
	WHERE id = @inIdMrLayDaftar;
	
	---------------------------------------------------
		
	SET @formType = 'MR PENDAFTARAN';
	SET @actionType = 'UPDATE';
	SET @actionDesc =		'NO MR : ' + @inNoMR + CHAR(10) +
								'NAMA : ' + @inPatientName + CHAR(10);
	
	---------------------------------------------------
	
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


--#######################################################################-- spDeleteMRDaftar -- 6


IF Objectproperty(Object_Id('dbo.spDeleteMRDaftar'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[spDeleteMRDaftar]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE spDeleteMRDaftar 
	/* 1*/	@inIdMrLayDaftar				INT,
	/* 2*/	@inNoMR 							VARCHAR(12),	
	/* 3*/	@inNamaPasien 					VARCHAR(100),
	/* 4*/ 	@inUser							INT
AS
	DECLARE 	
		@formType 								VARCHAR(100),
		@actionType								VARCHAR(100),
		@actionDesc								VARCHAR(1000);
BEGIN

	UPDATE trLayMRDaftar SET
				/* 1*/ status 			= 0,
				/* 2*/ dieditoleh 		= @inUser,
				/* 3*/ waktuedit 	= CURRENT_TIMESTAMP
	WHERE id = @inIdMrLayDaftar;
					
	---------------------------------------------------
		
	SET @formType = 'MR PENDAFTARAN';
	SET @actionType = 'DELETE';
	SET @actionDesc =		'NO MR : ' + @inNoMR + CHAR(10) +
								'NAMA : ' + @inNamaPasien + CHAR(10);
	
	---------------------------------------------------
	
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


--#######################################################################-- spInsertTrHistory -- 4


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.spInsertTrHistory') AND type in (N'P', N'PC'))
DROP PROCEDURE spInsertTrHistory
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE spInsertTrHistory (
	/* 1*/ @in_tipeForm					VARCHAR(100),
	/* 2*/ @in_tipeTindakan				VARCHAR(100),
	/* 3*/ @in_deskripsiTindakan		VARCHAR(1000),
	/* 4*/ @in_idpengguna				INT
)
AS
BEGIN
	INSERT INTO trHistory (
				/* 1*/ tipeform,
				/* 2*/ tipeTindakan,
				/* 3*/ deskripsiTindakan,
				/* 4*/ dibuatOleh
	) VALUES (
				/* 1*/ @in_tipeForm,
				/* 2*/ @in_tipeTindakan,
				/* 3*/ @in_deskripsiTindakan,
				/* 4*/ @in_idpengguna	
	);
END
GO

--#######################################################################-- spInsertMRRegis -- 15

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.spInsertMRRegis') AND type in (N'P', N'PC'))
DROP PROCEDURE spInsertMRRegis
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE spInsertMRRegis
	/* 1*/	@in_idLayMRDaftar 				INT	
	/* 2*/	, @in_noMR 							VARCHAR(16)	
	/* 3*/	, @in_tglRegis 					DATETIME
	/* 4*/	, @in_noRegis 						VARCHAR(32)
	/* 5*/	, @in_asalPasien		 			VARCHAR(100)
	/* 6*/	, @in_tujuanBerobat		 		VARCHAR(10)
	/* 7*/	, @in_namaPerujuk					VARCHAR(100)
	/* 8*/	, @in_namaDokter					VARCHAR(100)
	/* 9*/	, @in_caraPembayaran				VARCHAR(100)
	/*10*/	, @in_namaAsuransi				VARCHAR(100)
	/*11*/	, @in_namaPerusahaan				VARCHAR(100)
	/*12*/	, @in_noKartu						VARCHAR(100)
	/*13*/	, @in_noPolis						VARCHAR(100)
	/*14*/	, @in_catatan						VARCHAR(4000)
	/*15*/	, @in_idPengguna					INT
AS      	                        
	DECLARE 	
		@tipeForm 									VARCHAR(100)
		, @tipeTindakan							VARCHAR(100)
		, @deskripsiTindakan						VARCHAR(1000);
BEGIN
	
	INSERT INTO trLayMRRegis (
				/* 1*/ idLayMRDaftar
				/* 2*/ , noMR
				/* 3*/ , tglRegis
				/* 4*/ , noRegis
				/* 5*/ , asalPasien	 					
				/* 6*/ , tujuanBerobat			
				/* 7*/ , namaPerujuk		
				/* 8*/ , namaDokter						
				/* 9*/ , caraPembayaran						
				/*10*/ , namaAsuransi			
				/*11*/ , namaPerusahaan			
				/*12*/ , noKartu		
				/*13*/ , noPolis								
				/*14*/ , catatan							
				/*15*/ , dibuatOleh
				/*16*/ , dieditOleh
	) VALUES (
				/* 1*/ @in_idLayMRDaftar 			
				/* 2*/ , @in_noMR 						
				/* 3*/ , @in_tglRegis 			   
				/* 4*/ , @in_noRegis 				
				/* 5*/ , @in_asalPasien		 	   	
				/* 6*/ , @in_tujuanBerobat		   
				/* 7*/ , @in_namaPerujuk				
				/* 8*/ , @in_namaDokter			   		
				/* 9*/ , @in_caraPembayaran			
				/*10*/ , @in_namaAsuransi		   	
				/*11*/ , @in_namaPerusahaan		
				/*12*/ , @in_noKartu				   	
				/*13*/ , @in_noPolis				   					   	
				/*14*/ , @in_catatan					   
				/*15*/ , @in_idPengguna
				/*16*/ , @in_idPengguna									   					
	);
	
	---------------------------------------------------
		
	SET @tipeForm 						= 	'MR REGIS';
	SET @tipeTindakan 				= 	'NEW';
	SET @deskripsiTindakan 			=	'NO. REGIS : ' + @in_noRegis + CHAR(10) +
												'NO. MR : ' + @in_noMR + CHAR(10);
	
	EXEC spInsertTrHistory 	         
	/* 1*/ @tipeForm           
	/* 2*/ , @tipeTindakan     
	/* 3*/ , @deskripsiTindakan
	/* 4*/ , @in_idPengguna    
							  
END
GO

--#######################################################################-- spUpdateMRRegis -- 16

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.spUpdateMRRegis') AND type in (N'P', N'PC'))
DROP PROCEDURE spUpdateMRRegis
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE spUpdateMRRegis
	/* 1*/	@in_idLayMRRegis 					INT	
	/* 2*/	, @in_idLayMRDaftar 				INT	
	/* 3*/	, @in_noMR 							VARCHAR(16)	
	/* 4*/	, @in_tglRegis 					VARCHAR(8)
	/* 5*/	, @in_noRegis 						VARCHAR(32)
	/* 6*/	, @in_asalPasien		 			VARCHAR(100)
	/* 7*/	, @in_tujuanBerobat		 		VARCHAR(10)
	/* 8*/	, @in_namaPerujuk					VARCHAR(100)
	/* 9*/	, @in_namaDokter					VARCHAR(100)
	/*10*/	, @in_caraPembayaran				VARCHAR(100)
	/*11*/	, @in_namaAsuransi				VARCHAR(100)
	/*12*/	, @in_namaPerusahaan				VARCHAR(100)
	/*13*/	, @in_noKartu						VARCHAR(100)
	/*14*/	, @in_noPolis						VARCHAR(100)
	/*15*/	, @in_catatan						VARCHAR(4000)
	/*16*/	, @in_idPengguna					INT
AS
	DECLARE 	
		@in_catatanBaru							VARCHAR(5000)
		, @in_catatanTerbaru						VARCHAR(5000)
		, @tipeForm 								VARCHAR(100)
		, @tipeTindakan							VARCHAR(100)
		, @deskripsiTindakan						VARCHAR(1000)
	;
BEGIN
	SET @tipeForm 				= 	'trLayMRRegis';
	SET @tipeTindakan 		= 	'UPDATE';
	SET @deskripsiTindakan 	=	'NO. REGIS : ' + @in_noRegis + CHAR(10) +
										'NO. MR : ' + @in_noMR + CHAR(10);		
	SET @in_catatanBaru 		=	'DIBUAT   : ' +  dbo.fnAmbilNamaLengkap(@in_idpengguna) + ' , TANGGAL : ' +
										CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + 
										@in_catatan + CHAR(10);									
	SET @in_catatanTerbaru 	= 	@in_catatanBaru + CHAR(10) + '--------------------' + CHAR(10) + CHAR(10)
										+ dbo.fnAmbilCatatanLayMRRegis(@in_idLayMRRegis);
	
	IF @in_catatan = ''
		BEGIN		
			UPDATE trLayMRRegis SET
				/* 1*/   idLayMRDaftar    			= @in_idLayMRDaftar 		
				/* 2*/ , noMR           			= @in_noMR 					
				/* 3*/ , tglRegis       			= @in_tglRegis 			
				/* 4*/ , noRegis        			= @in_noRegis 				
				/* 5*/ , asalPasien	 				= @in_asalPasien		 	
				/* 6*/ , tujuanBerobat				= @in_tujuanBerobat		
				/* 7*/ , namaPerujuk					= @in_namaPerujuk			
				/* 8*/ , namaDokter					= @in_namaDokter			
				/* 9*/ , caraPembayaran				= @in_caraPembayaran		
				/*10*/ , namaAsuransi				= @in_namaAsuransi		
				/*11*/ , namaPerusahaan				= @in_namaPerusahaan		
				/*12*/ , noKartu		   			= @in_noKartu				
				/*13*/ , noPolis						= @in_noPolis							
				/*14*/ , dieditOleh     			= @in_idPengguna			
				/*15*/ , waktuEdit					= CURRENT_TIMESTAMP               					   
			WHERE id = @in_idLayMRRegis;
		END
	ELSE
		BEGIN		
			UPDATE trLayMRRegis SET
				/* 1*/ idLayMRDaftar    			= @in_idLayMRDaftar 		
				/* 2*/ , noMR           			= @in_noMR 					
				/* 3*/ , tglRegis       			= @in_tglRegis 			
				/* 4*/ , noRegis        			= @in_noRegis 				
				/* 5*/ , asalPasien	 				= @in_asalPasien		 	
				/* 6*/ , tujuanBerobat				= @in_tujuanBerobat		
				/* 7*/ , namaPerujuk					= @in_namaPerujuk			
				/* 8*/ , namaDokter					= @in_namaDokter			
				/* 9*/ , caraPembayaran				= @in_caraPembayaran		
				/*10*/ , namaAsuransi				= @in_namaAsuransi		
				/*11*/ , namaPerusahaan				= @in_namaPerusahaan		
				/*12*/ , noKartu		   			= @in_noKartu				
				/*13*/ , noPolis						= @in_noPolis				
				/*14*/ , catatan						= @in_catatanTerbaru				
				/*15*/ , dieditOleh     			= @in_idPengguna			
				/*16*/ , waktuEdit					= CURRENT_TIMESTAMP               					   
			WHERE id = @in_idLayMRRegis;
		END
	---------------------------------------------------
	
	EXEC spInsertTrHistory 	         
	/* 1*/ @tipeForm           
	/* 2*/ , @tipeTindakan     
	/* 3*/ , @deskripsiTindakan
	/* 4*/ , @in_idPengguna
							  
END
GO

--#######################################################################-- spDeleteMRRegis -- 4

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.spDeleteMRRegis') AND type in (N'P', N'PC'))
DROP PROCEDURE spDeleteMRRegis
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE spDeleteMRRegis 
	/* 1*/ @in_idMrLayRegis				INT
	/* 2*/ , @in_noMR 					VARCHAR(16)	
	/* 3*/ , @in_noRegis					VARCHAR(32)
	/* 4*/ , @in_idPengguna				INT
AS
	DECLARE 	
		@tipeForm 							VARCHAR(100)
		, @tipeTindakan					VARCHAR(100)
		, @deskripsiTindakan				VARCHAR(1000)
	;
BEGIN

	UPDATE trLayMRRegis SET
				/* 1*/ status 			= 0,
				/* 2*/ dieditOleh 	= @in_idPengguna,
				/* 3*/ waktuEdit 		= CURRENT_TIMESTAMP
	WHERE id = @in_idMrLayRegis;
					
	---------------------------------------------------
		
	SET @tipeForm 					= 	'trLayMRRegis';
	SET @tipeTindakan 			= 	'DELETE';
	SET @deskripsiTindakan 		=	'NO MR : ' + @in_noMR + CHAR(10) +
											'NO. REGIS : ' + @in_noRegis + CHAR(10);
	
	---------------------------------------------------
	
	EXEC spInsertTrHistory 	         
	/* 1*/ @tipeForm           
	/* 2*/ , @tipeTindakan     
	/* 3*/ , @deskripsiTindakan
	/* 4*/ , @in_idPengguna
							  
END
GO