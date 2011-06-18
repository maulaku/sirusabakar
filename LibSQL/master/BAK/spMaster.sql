-- RANCANGAN STORE PROCEDURE--
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
-- contoh : sp_insert_coa
-- 1. sp = store procedure  
-- 2. nama procedure (tindakan)
-- 3. nama object
----------------------------------------------------------

--#######################################################################-- sp_insert_coa -- 5

IF Objectproperty(Object_Id('dbo.sp_insert_coa'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[sp_insert_coa]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE sp_insert_coa
	/* 1*/ @in_kode_coa 				VARCHAR(20),
	/* 2*/ @in_nama_coa					VARCHAR(100),
	/* 3*/ @in_tipe_coa					VARCHAR(100),
	/* 4*/ @in_note							VARCHAR(4000),
	/* 5*/ @in_user							INT
AS
	DECLARE 	
		@in_new_note							VARCHAR(5000),
		@form_type 								VARCHAR(100),
		@action_type							VARCHAR(100),
		@action_desc							VARCHAR(1000);
BEGIN
	SET @in_new_note = 'Dibuat : ' +  dbo.fn_get_full_name_user(@in_user) + ' , tanggal : ' +
	CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_note + CHAR(10);
	
	INSERT INTO ms_coa (
				/* 1*/ kode_coa,
				/* 2*/ nama_coa,
				/* 3*/ tipe_coa,
				/* 4*/ note,
				/* 5*/ create_by,
				/* 6*/ update_by
	) VALUES (
				/* 1*/ @in_kode_coa, 				
				/* 2*/ @in_nama_coa,			  
				/* 3*/ @in_tipe_coa,									  
				/* 4*/ @in_new_note,					  
				/* 5*/ @in_user,
				/* 6*/ @in_user
	);
	
	---------------------------------------------------
		
	SET @form_type = 'COA';
	SET @action_type = 'NEW';
	SET @action_desc =	'KODE COA : ' + @in_kode_coa + CHAR(10) +
								'NAMA COA : ' + @in_nama_coa + CHAR(10) +
								'TIPE COA : ' + @in_tipe_coa + CHAR(10);
	
	INSERT INTO ms_history (
				/* 1*/ form_type,
				/* 2*/ action_type,
				/* 3*/ action_desc,
				/* 4*/ create_by
	) VALUES (
				/* 1*/ @form_type,
				/* 2*/ @action_type,
				/* 3*/ @action_desc,
				/* 4*/ @in_user	
	);
							  
END
GO

--#######################################################################-- sp_update_coa -- 6

IF Objectproperty(Object_Id('dbo.sp_update_coa'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[sp_update_coa]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE sp_update_coa
	/* 1*/ @in_id_coa 						INT,
	/* 2*/ @in_kode_coa 					VARCHAR(20),
	/* 3*/ @in_nama_coa						VARCHAR(100),
	/* 4*/ @in_tipe_coa						VARCHAR(100),
	/* 5*/ @in_note								VARCHAR(4000),
	/* 6*/ @in_user								INT
AS
	DECLARE 	
		@in_new_note								VARCHAR(5000),
		@in_new_note_update					VARCHAR(5000),
		@form_type 									VARCHAR(100),
		@action_type								VARCHAR(100),
		@action_desc								VARCHAR(1000);
BEGIN
	SET @in_new_note = 'Dibuat : ' +  dbo.fn_get_full_name_user(@in_user) + ' , tanggal : ' +
	CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_note + CHAR(10);
	
	SET @in_new_note_update = @in_new_note + CHAR(10) + '--------------------' + CHAR(10) + CHAR(10)
	+ dbo.fn_get_note_coa(@in_id_coa);
	
	
	IF @in_note = ''
		BEGIN
			UPDATE ms_coa SET
						/* 1*/ kode_coa 			= @in_kode_coa,
						/* 2*/ nama_coa 			= @in_nama_coa,
						/* 3*/ tipe_coa 			= @in_tipe_coa,
						/* 4*/ update_by 			= @in_user,
						/* 5*/ update_time 		= CURRENT_TIMESTAMP
			WHERE id = @in_id_coa;
			
			
			SET @action_desc =	'KODE COA : ' + @in_kode_coa + CHAR(10) +
											'NAMA COA : ' + @in_nama_coa + CHAR(10) +
											'TIPE COA : ' + @in_tipe_coa + CHAR(10);
											
		END
	ELSE
		BEGIN
			UPDATE ms_coa SET
						/* 1*/ kode_coa 			= @in_kode_coa,
						/* 2*/ nama_coa 			= @in_nama_coa,
						/* 3*/ tipe_coa 			= @in_tipe_coa,
						/* 3*/ note 					= @in_new_note_update,
						/* 4*/ update_by 			= @in_user,
						/* 5*/ update_time 		= CURRENT_TIMESTAMP
			WHERE id = @in_id_coa;
			
			SET @action_desc =	'NOTE : ' + @in_new_note + CHAR(10);
		END
	
	SET @form_type = 'COA';
	SET @action_type = 'UPDATE';
	---------------------------------------------------
	
	INSERT INTO ms_history (
				/* 1*/ form_type,
				/* 2*/ action_type,
				/* 3*/ action_desc,
				/* 4*/ create_by
	) VALUES (
				/* 1*/ @form_type,
				/* 2*/ @action_type,
				/* 3*/ @action_desc,
				/* 4*/ @in_user	
	);
							  
END
GO

--#######################################################################-- sp_delete_coa -- 5

IF Objectproperty(Object_Id('dbo.sp_delete_coa'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[sp_delete_coa]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE sp_delete_coa
	/* 1*/ @in_id_coa 						INT,
	/* 2*/ @in_kode_coa 					VARCHAR(20),
	/* 3*/ @in_nama_coa						VARCHAR(100),
	/* 4*/ @in_tipe_coa						VARCHAR(100),
	/* 5*/ @in_user								INT
AS
	DECLARE 	
		@form_type 									VARCHAR(100),
		@action_type								VARCHAR(100),
		@action_desc								VARCHAR(1000);
BEGIN

	UPDATE ms_coa SET
				/* 1*/ status 			= 0,
				/* 2*/ update_by 		= @in_user,
				/* 3*/ update_time 	= CURRENT_TIMESTAMP
	WHERE id = @in_id_coa;
					
	SET @action_desc =	'KODE COA : ' + @in_kode_coa + CHAR(10) +
											'NAMA COA : ' + @in_nama_coa + CHAR(10) +
											'TIPE COA : ' + @in_tipe_coa + CHAR(10);
	
	SET @form_type = 'COA';
	SET @action_type = 'DELETE';
	---------------------------------------------------
	
	INSERT INTO ms_history (
				/* 1*/ form_type,
				/* 2*/ action_type,
				/* 3*/ action_desc,
				/* 4*/ create_by
	) VALUES (
				/* 1*/ @form_type,
				/* 2*/ @action_type,
				/* 3*/ @action_desc,
				/* 4*/ @in_user	
	);
							  
END
GO

--#######################################################################-- sp_insert_obat -- 10

IF Objectproperty(Object_Id('dbo.sp_insert_obat'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[sp_insert_obat]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE sp_insert_obat
	/* 1*/ @in_kode_obat					VARCHAR(20),
	/* 2*/ @in_nama_obat					VARCHAR(100),
	/* 3*/ @in_golongan_obat			VARCHAR(100),
	/* 4*/ @in_kategory_obat			VARCHAR(100),
	/* 5*/ @in_satuan_beli				VARCHAR(100),
	/* 6*/ @in_satuan_jual				VARCHAR(100),
	/* 7*/ @in_isi							INT,
	/* 8*/ @in_stok_min					INT,
	/* 9*/ @in_note						VARCHAR(4000),
	/*10*/ @in_user						INT
AS
	DECLARE 	
		@in_new_note						VARCHAR(5000),
		@form_type 							VARCHAR(100),
		@action_type						VARCHAR(100),
		@action_desc						VARCHAR(1000);
BEGIN
	SET @in_new_note = 'Dibuat : ' +  dbo.fn_get_full_name_user(@in_user) + ' , tanggal : ' +
	CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_note + CHAR(10);
	
	INSERT INTO ms_obat (
		/* 1*/ kode_obat,
		/* 2*/ nama_obat,
		/* 3*/ golongan_obat,
		/* 4*/ kategory_obat,
		/* 5*/ satuan_beli,
		/* 6*/ satuan_jual,
		/* 7*/ isi,
		/* 8*/ stok_min,
		/* 9*/ note,
		/*10*/ create_by,
		/*11*/ update_by
	) VALUES (
		/* 1*/ @in_kode_obat, 				
		/* 2*/ @in_nama_obat,			  
		/* 3*/ @in_golongan_obat,									  
		/* 3*/ @in_kategory_obat,
		/* 3*/ @in_satuan_beli,
		/* 3*/ @in_satuan_jual,
		/* 3*/ @in_isi,
		/* 3*/ @in_stok_min,
		/* 4*/ @in_new_note,					  
		/* 5*/ @in_user,
		/* 6*/ @in_user
	);
	
	---------------------------------------------------
		
	SET @form_type = 'OBAT';
	SET @action_type = 'NEW';
	SET @action_desc =	'KODE OBAT : ' + @in_kode_obat + CHAR(10) +
								'NAMA OBAT : ' + @in_nama_obat + CHAR(10) +
								'GOLONGAN OBAT : ' + @in_golongan_obat + CHAR(10) +
								'KATEGORY OBAT : ' + @in_kategory_obat + CHAR(10) +
								'SATUAN BELI : ' + @in_satuan_beli + CHAR(10) +
								'SATUAN JUAL : ' + @in_satuan_jual+ CHAR(10)
								;
	
	INSERT INTO ms_history (
		/* 1*/ form_type,
		/* 2*/ action_type,
		/* 3*/ action_desc,
		/* 4*/ create_by
	) VALUES (
		/* 1*/ @form_type,
		/* 2*/ @action_type,
		/* 3*/ @action_desc,
		/* 4*/ @in_user	
	);
							  
END
GO

--#######################################################################-- sp_update_obat -- 11

IF Objectproperty(Object_Id('dbo.sp_update_obat'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[sp_update_obat]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE sp_update_obat
	/* 1*/ @in_id_obat 			INT,
	/* 2*/ @in_kode_obat			VARCHAR(20),
	/* 3*/ @in_nama_obat			VARCHAR(100),
	/* 4*/ @in_gol_obat			VARCHAR(100),
	/* 5*/ @in_kategory_obat	VARCHAR(100),
	/* 6*/ @in_satuan_beli		VARCHAR(100),
	/* 7*/ @in_satuan_jual		VARCHAR(100),
	/* 8*/ @in_isi					INT,
	/* 9*/ @in_stok_min			INT,
	/*10*/ @in_note				VARCHAR(4000),
	/*11*/ @in_user				INT
AS
	DECLARE 	
		@in_new_note				VARCHAR(5000),
		@in_new_note_update		VARCHAR(5000),
		@form_type 					VARCHAR(100),
		@action_type				VARCHAR(100),
		@action_desc				VARCHAR(1000);
BEGIN
	SET @in_new_note = 'Dibuat : ' +  dbo.fn_get_full_name_user(@in_user) + ' , tanggal : ' +
	CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_note + CHAR(10);
	
	SET @in_new_note_update = @in_new_note + CHAR(10) + '--------------------' + CHAR(10) + CHAR(10)
	+ dbo.fn_get_note_obat(@in_id_obat);
	
	
	IF @in_note = ''
		BEGIN
			UPDATE ms_obat SET
				/* 1*/ kode_obat 			= @in_kode_obat,
				/* 2*/ nama_obat 			= @in_nama_obat,
				/* 3*/ golongan_obat 	= @in_gol_obat,
				/* 4*/ kategory_obat 	= @in_kategory_obat,
				/* 5*/ satuan_beli 		= @in_satuan_beli,
				/* 6*/ satuan_jual 		= @in_satuan_jual,
				/* 7*/ isi 					= @in_isi,
				/* 8*/ stok_min 			= @in_stok_min,
				/* 9*/ update_by 			= @in_user,
				/*10*/ update_time 		= CURRENT_TIMESTAMP
			WHERE id = @in_id_obat;
			
			
			SET @action_desc =	'KODE OBAT : ' + @in_kode_obat + CHAR(10) +
										'NAMA OBAT : ' + @in_nama_obat + CHAR(10) +
										'GOLONGAN OBAT : ' + @in_gol_obat + CHAR(10) +
										'KATEGORY OBAT : ' + @in_kategory_obat + CHAR(10) +
										'SATUAN BELI : ' + @in_satuan_beli + CHAR(10) +
										'SATUAN JUAL : ' + @in_satuan_jual+ CHAR(10)
										;							
		END
	ELSE
		BEGIN
			UPDATE ms_obat SET
				/* 1*/ kode_obat 			= @in_kode_obat,
				/* 2*/ nama_obat 			= @in_nama_obat,
				/* 3*/ golongan_obat 	= @in_gol_obat,
				/* 4*/ kategory_obat 	= @in_kategory_obat,
				/* 5*/ satuan_beli 		= @in_satuan_beli,
				/* 6*/ satuan_jual 		= @in_satuan_jual,
				/* 7*/ isi 					= @in_isi,
				/* 8*/ stok_min 			= @in_stok_min,
				/* 9*/ note 				= @in_new_note_update,
				/*10*/ update_by 			= @in_user,
				/*11*/ update_time 		= CURRENT_TIMESTAMP
			WHERE id = @in_id_obat;
			
			SET @action_desc =	'KODE OBAT : ' + @in_kode_obat + CHAR(10) +
										'NAMA OBAT : ' + @in_nama_obat + CHAR(10) +
										'GOLONGAN OBAT : ' + @in_gol_obat + CHAR(10) +
										'KATEGORY OBAT : ' + @in_kategory_obat + CHAR(10) +
										'SATUAN BELI : ' + @in_satuan_beli + CHAR(10) +
										'SATUAN JUAL : ' + @in_satuan_jual + CHAR(10) +
										'NOTE : ' + @in_new_note + CHAR(10);
		END
	
	SET @form_type = 'OBAT';
	SET @action_type = 'UPDATE';
	---------------------------------------------------
	
	INSERT INTO ms_history (
				/* 1*/ form_type,
				/* 2*/ action_type,
				/* 3*/ action_desc,
				/* 4*/ create_by
	) VALUES (
				/* 1*/ @form_type,
				/* 2*/ @action_type,
				/* 3*/ @action_desc,
				/* 4*/ @in_user	
	);
							  
END
GO

--#######################################################################-- sp_delete_obat -- 5

IF Objectproperty(Object_Id('dbo.sp_delete_obat'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[sp_delete_obat]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE sp_delete_obat
	/* 1*/ @in_id_obat 					INT,
	/* 1*/ @in_kode_obat					VARCHAR(20),
	/* 2*/ @in_nama_obat					VARCHAR(100),
	/* 3*/ @in_gol_obat					VARCHAR(100),
	/* 4*/ @in_kategory_obat			VARCHAR(100),
	/* 5*/ @in_satuan_beli				VARCHAR(100),
	/* 6*/ @in_satuan_jual				VARCHAR(100),
	/* 7*/ @in_isi							INT,
	/* 8*/ @in_stok_min					INT,
	/* 9*/ @in_note						VARCHAR(4000),
	/*10*/ @in_user						INT
AS
	DECLARE 	
		@form_type 							VARCHAR(100),
		@action_type						VARCHAR(100),
		@action_desc						VARCHAR(1000);
BEGIN

	UPDATE ms_obat SET
				/* 1*/ status 			= 0,
				/* 2*/ update_by 		= @in_user,
				/* 3*/ update_time 	= CURRENT_TIMESTAMP
	WHERE id = @in_id_obat;
					
	SET @action_desc =	'KODE OBAT : ' + @in_kode_obat + CHAR(10) +
								'NAMA OBAT : ' + @in_nama_obat + CHAR(10) +
								'KATEGORY OBAT : ' + @in_kategory_obat + CHAR(10);
								
	
	SET @form_type = 'OBAT';
	SET @action_type = 'DELETE';
	---------------------------------------------------
	
	INSERT INTO ms_history (
				/* 1*/ form_type,
				/* 2*/ action_type,
				/* 3*/ action_desc,
				/* 4*/ create_by
	) VALUES (
				/* 1*/ @form_type,
				/* 2*/ @action_type,
				/* 3*/ @action_desc,
				/* 4*/ @in_user	
	);
							  
END
GO

--#######################################################################-- sp_insert_diet -- 4

IF Objectproperty(Object_Id('dbo.sp_insert_diet'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[sp_insert_diet]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE sp_insert_diet
	/* 1*/ @in_kode_diet 					VARCHAR(20),
	/* 2*/ @in_nama_diet						VARCHAR(100),
	/* 3*/ @in_note							VARCHAR(4000),
	/* 4*/ @in_user							INT
AS
	DECLARE 	
		@in_new_note							VARCHAR(5000),
		@form_type 								VARCHAR(100),
		@action_type							VARCHAR(100),
		@action_desc							VARCHAR(1000);
BEGIN
	SET @in_new_note = 'Dibuat : ' +  dbo.fn_get_full_name_user(@in_user) + ' , tanggal : ' +
	CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_note + CHAR(10);
	
	INSERT INTO ms_diet (
				/* 1*/ kode_diet,
				/* 2*/ nama_diet,
				/* 3*/ note,
				/* 4*/ create_by,
				/* 5*/ update_by
	) VALUES (
				/* 1*/ @in_kode_diet, 				
				/* 2*/ @in_nama_diet,			  									  
				/* 3*/ @in_new_note,					  
				/* 4*/ @in_user,
				/* 5*/ @in_user
	);
	
	---------------------------------------------------
		
	SET @form_type = 'DIET';
	SET @action_type = 'NEW';
	SET @action_desc =	'KODE DIET : ' + @in_kode_diet + CHAR(10) +
								'NAMA DIET : ' + @in_nama_diet + CHAR(10);
	
	INSERT INTO ms_history (
				/* 1*/ form_type,
				/* 2*/ action_type,
				/* 3*/ action_desc,
				/* 4*/ create_by
	) VALUES (
				/* 1*/ @form_type,
				/* 2*/ @action_type,
				/* 3*/ @action_desc,
				/* 4*/ @in_user	
	);
							  
END
GO

--#######################################################################-- sp_update_diet -- 5

IF Objectproperty(Object_Id('dbo.sp_update_diet'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[sp_update_diet]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE sp_update_diet
	/* 1*/ @in_id_diet					INT,
	/* 2*/ @in_kode_diet 				VARCHAR(20),
	/* 3*/ @in_nama_diet					VARCHAR(100),
	/* 4*/ @in_note						VARCHAR(4000),
	/* 5*/ @in_user						INT
AS
	DECLARE 	
		@in_new_note						VARCHAR(5000),
		@in_new_note_update				VARCHAR(5000),
		@form_type 							VARCHAR(100),
		@action_type						VARCHAR(100),
		@action_desc						VARCHAR(1000);
BEGIN
	SET @in_new_note = 'Dibuat : ' +  dbo.fn_get_full_name_user(@in_user) + ' , tanggal : ' +
	CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_note + CHAR(10);
	
	SET @in_new_note_update = @in_new_note + CHAR(10) + '--------------------' + CHAR(10) + CHAR(10)
	+ dbo.fn_get_note_diet(@in_id_diet);
	
	
	IF @in_note = ''
		BEGIN
			UPDATE ms_diet SET
						/* 1*/ kode_diet 			= @in_kode_diet,
						/* 2*/ nama_diet 			= @in_nama_diet,
						/* 3*/ update_by 			= @in_user,
						/* 4*/ update_time 		= CURRENT_TIMESTAMP
			WHERE id = @in_id_diet;
			
			
			SET @action_desc =	'KODE DIET : ' + @in_kode_diet + CHAR(10) +
										'NAMA DIET : ' + @in_nama_diet + CHAR(10);
											
		END
	ELSE
		BEGIN
			UPDATE ms_diet SET
						/* 1*/ kode_diet 			= @in_kode_diet,
						/* 2*/ nama_diet 			= @in_nama_diet,
						/* 3*/ note 				= @in_new_note_update,
						/* 4*/ update_by 			= @in_user,
						/* 5*/ update_time 		= CURRENT_TIMESTAMP
			WHERE id = @in_id_diet;
			
			SET @action_desc =	'NOTE : ' + @in_new_note + CHAR(10);
		END
	
	SET @form_type = 'DIET';
	SET @action_type = 'UPDATE';
	---------------------------------------------------
	
	INSERT INTO ms_history (
				/* 1*/ form_type,
				/* 2*/ action_type,
				/* 3*/ action_desc,
				/* 4*/ create_by
	) VALUES (
				/* 1*/ @form_type,
				/* 2*/ @action_type,
				/* 3*/ @action_desc,
				/* 4*/ @in_user	
	);
							  
END
GO

--#######################################################################-- sp_delete_diet -- 4

IF Objectproperty(Object_Id('dbo.sp_delete_diet'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[sp_delete_diet]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE sp_delete_diet 
	/* 1*/ @in_id_diet 			INT,
	/* 2*/ @in_kode_diet 		VARCHAR(20),
	/* 3*/ @in_nama_diet			VARCHAR(100),
	/* 4*/ @in_user				INT
AS
	DECLARE 	
		@form_type 					VARCHAR(100),
		@action_type				VARCHAR(100),
		@action_desc				VARCHAR(1000);
BEGIN

	UPDATE ms_diet SET
				/* 1*/ status 			= 0,
				/* 2*/ update_by 		= @in_user,
				/* 3*/ update_time 	= CURRENT_TIMESTAMP
	WHERE id = @in_id_diet;
					
	SET @action_desc =	'KODE DIET : ' + @in_kode_diet + CHAR(10) +
								'NAMA DIET : ' + @in_nama_diet + CHAR(10);
	
	SET @form_type = 'DIET';
	SET @action_type = 'DELETE';
	---------------------------------------------------
	
	INSERT INTO ms_history (
				/* 1*/ form_type,
				/* 2*/ action_type,
				/* 3*/ action_desc,
				/* 4*/ create_by
	) VALUES (
				/* 1*/ @form_type,
				/* 2*/ @action_type,
				/* 3*/ @action_desc,
				/* 4*/ @in_user	
	);
							  
END
GO

--#######################################################################-- sp_insert_kelas -- 4

IF Objectproperty(Object_Id('dbo.sp_insert_kelas'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[sp_insert_kelas]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE sp_insert_kelas
	/* 1*/ @in_kode_kelas 					VARCHAR(20),
	/* 2*/ @in_nama_kelas					VARCHAR(100),
	/* 3*/ @in_note							VARCHAR(4000),
	/* 4*/ @in_user							INT
AS
	DECLARE 	
		@in_new_note							VARCHAR(5000),
		@form_type 								VARCHAR(100),
		@action_type							VARCHAR(100),
		@action_desc							VARCHAR(1000);
BEGIN
	SET @in_new_note = 'Dibuat : ' +  dbo.fn_get_full_name_user(@in_user) + ' , tanggal : ' +
	CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_note + CHAR(10);
	
	INSERT INTO ms_kelas (
				/* 1*/ kode_kelas,
				/* 2*/ nama_kelas,
				/* 3*/ note,
				/* 4*/ create_by,
				/* 5*/ update_by
	) VALUES (
				/* 1*/ @in_kode_kelas, 				
				/* 2*/ @in_nama_kelas,			  									  
				/* 3*/ @in_new_note,					  
				/* 4*/ @in_user,
				/* 5*/ @in_user
	);
	
	---------------------------------------------------
		
	SET @form_type = 'KELAS';
	SET @action_type = 'NEW';
	SET @action_desc =	'KODE KELAS : ' + @in_kode_kelas + CHAR(10) +
								'NAMA KELAS : ' + @in_nama_kelas + CHAR(10);
	
	INSERT INTO ms_history (
				/* 1*/ form_type,
				/* 2*/ action_type,
				/* 3*/ action_desc,
				/* 4*/ create_by
	) VALUES (
				/* 1*/ @form_type,
				/* 2*/ @action_type,
				/* 3*/ @action_desc,
				/* 4*/ @in_user	
	);
							  
END
GO

--#######################################################################-- sp_update_kelas -- 5

IF Objectproperty(Object_Id('dbo.sp_update_kelas'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[sp_update_kelas]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE sp_update_kelas
	/* 1*/ @in_id_kelas					INT,
	/* 2*/ @in_kode_kelas 				VARCHAR(20),
	/* 3*/ @in_nama_kelas				VARCHAR(100),
	/* 4*/ @in_note						VARCHAR(4000),
	/* 5*/ @in_user						INT
AS
	DECLARE 	
		@in_new_note						VARCHAR(5000),
		@in_new_note_update				VARCHAR(5000),
		@form_type 							VARCHAR(100),
		@action_type						VARCHAR(100),
		@action_desc						VARCHAR(1000);
BEGIN
	SET @in_new_note = 'Dibuat : ' +  dbo.fn_get_full_name_user(@in_user) + ' , tanggal : ' +
	CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_note + CHAR(10);
	
	SET @in_new_note_update = @in_new_note + CHAR(10) + '--------------------' + CHAR(10) + CHAR(10)
	+ dbo.fn_get_note_kelas(@in_id_kelas);
	
	
	IF @in_note = ''
		BEGIN
			UPDATE ms_kelas SET
						/* 1*/ kode_kelas 			= @in_kode_kelas,
						/* 2*/ nama_kelas 			= @in_nama_kelas,
						/* 4*/ update_by 				= @in_user,
						/* 5*/ update_time 			= CURRENT_TIMESTAMP
			WHERE id = @in_id_kelas;
			
			
			SET @action_desc =	'KODE KELAS : ' + @in_kode_kelas + CHAR(10) +
										'NAMA KELAS : ' + @in_nama_kelas + CHAR(10);
											
		END
	ELSE
		BEGIN
			UPDATE ms_kelas SET
						/* 1*/ kode_kelas 			= @in_kode_kelas,
						/* 2*/ nama_kelas 			= @in_nama_kelas,
						/* 3*/ note 					= @in_new_note_update,
						/* 4*/ update_by 				= @in_user,
						/* 5*/ update_time 			= CURRENT_TIMESTAMP
			WHERE id = @in_id_kelas;
			
			SET @action_desc =	'NOTE : ' + @in_new_note + CHAR(10);
		END
	
	SET @form_type = 'KELAS';
	SET @action_type = 'UPDATE';
	---------------------------------------------------
	
	INSERT INTO ms_history (
				/* 1*/ form_type,
				/* 2*/ action_type,
				/* 3*/ action_desc,
				/* 4*/ create_by
	) VALUES (
				/* 1*/ @form_type,
				/* 2*/ @action_type,
				/* 3*/ @action_desc,
				/* 4*/ @in_user	
	);
							  
END
GO

--#######################################################################-- sp_delete_kelas -- 4

IF Objectproperty(Object_Id('dbo.sp_delete_kelas'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[sp_delete_kelas]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE sp_delete_kelas 
	/* 1*/ @in_id_kelas					INT,
	/* 2*/ @in_kode_kelas 				VARCHAR(20),
	/* 3*/ @in_nama_kelas				VARCHAR(100),
	/* 4*/ @in_user						INT
AS
	DECLARE 	
		@form_type 							VARCHAR(100),
		@action_type						VARCHAR(100),
		@action_desc						VARCHAR(1000);
BEGIN

	UPDATE ms_kelas SET
				/* 1*/ status 			= 0,
				/* 2*/ update_by 		= @in_user,
				/* 3*/ update_time 	= CURRENT_TIMESTAMP
	WHERE id = @in_id_kelas;
					
	SET @action_desc =	'KODE KELAS : ' + @in_kode_kelas + CHAR(10) +
											'NAMA KELAS : ' + @in_nama_kelas + CHAR(10);
	
	SET @form_type = 'KELAS';
	SET @action_type = 'DELETE';
	---------------------------------------------------
	
	INSERT INTO ms_history (
				/* 1*/ form_type,
				/* 2*/ action_type,
				/* 3*/ action_desc,
				/* 4*/ create_by
	) VALUES (
				/* 1*/ @form_type,
				/* 2*/ @action_type,
				/* 3*/ @action_desc,
				/* 4*/ @in_user	
	);
							  
END
GO

--#######################################################################-- sp_insert_menu_makanan -- 4

IF Objectproperty(Object_Id('dbo.sp_insert_menu_makanan'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[sp_insert_menu_makanan]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE sp_insert_menu_makanan
	/* 1*/ @in_kode_menu 					VARCHAR(20),
	/* 2*/ @in_id_diet						INT,
	/* 3*/ @in_kelompok						VARCHAR(100),
	/* 4*/ @in_waktu 							VARCHAR(100),
	/* 5*/ @in_note							VARCHAR(4000),
	/* 6*/ @in_user							INT
AS
	DECLARE 	
		@in_new_note							VARCHAR(5000),
		@form_type 								VARCHAR(100),
		@action_type							VARCHAR(100),
		@action_desc							VARCHAR(1000);
BEGIN
	SET @in_new_note = 'Dibuat : ' +  dbo.fn_get_full_name_user(@in_user) + ' , tanggal : ' +
	CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_note + CHAR(10);
	
	INSERT INTO ms_menu_makanan (
				/* 1*/ kode_menu,
				/* 2*/ id_diet,
				/* 3*/ kelompok,
				/* 4*/ waktu,
				/* 5*/ note,
				/* 6*/ create_by,
				/* 7*/ update_by
	) VALUES (
				/* 1*/ @in_kode_menu, 				
				/* 2*/ @in_id_diet,		
				/* 3*/ @in_kelompok,	
				/* 4*/ @in_waktu,		  									  
				/* 5*/ @in_new_note,					  
				/* 6*/ @in_user,
				/* 7*/ @in_user
	);
	
	---------------------------------------------------
		
	SET @form_type = 'MENU MAKANAN';
	SET @action_type = 'NEW';
	SET @action_desc =	'KODE MENU : ' + @in_kode_menu + CHAR(10) +
								'KELOMPOK : ' + @in_kelompok + CHAR(10) +
								'WAKTU : ' + @in_waktu + CHAR(10);
	
	INSERT INTO ms_history (
				/* 1*/ form_type,
				/* 2*/ action_type,
				/* 3*/ action_desc,
				/* 4*/ create_by
	) VALUES (
				/* 1*/ @form_type,
				/* 2*/ @action_type,
				/* 3*/ @action_desc,
				/* 4*/ @in_user	
	);
							  
END
GO

--#######################################################################-- sp_update_menu_makanan -- 6

IF Objectproperty(Object_Id('dbo.sp_update_menu_makanan'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[sp_update_menu_makanan]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE sp_update_menu_makanan
	/* 1*/ @in_id_menu_makanan				INT,
	/* 2*/ @in_kode_menu 					VARCHAR(20),
	/* 3*/ @in_id_diet						INT,
	/* 4*/ @in_kelompok						VARCHAR(100),
	/* 5*/ @in_waktu							VARCHAR(100),
	/* 6*/ @in_note							VARCHAR(4000),
	/* 7*/ @in_user							INT
AS
	DECLARE 	
		@in_new_note							VARCHAR(5000),
		@in_new_note_update					VARCHAR(5000),
		@form_type 								VARCHAR(100),
		@action_type							VARCHAR(100),
		@action_desc							VARCHAR(1000);
BEGIN
	SET @in_new_note = 'Dibuat : ' +  dbo.fn_get_full_name_user(@in_user) + ' , tanggal : ' +
	CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_note + CHAR(10);
	
	SET @in_new_note_update = @in_new_note + CHAR(10) + '--------------------' + CHAR(10) + CHAR(10)
	+ dbo.fn_get_note_menu_makanan(@in_id_menu_makanan);
	
	
	IF @in_note = ''
		BEGIN
			UPDATE ms_menu_makanan SET
						/* 1*/ kode_menu 				= @in_kode_menu,
						/* 2*/ id_diet 				= @in_id_diet,
						/* 3*/ kelompok 				= @in_kelompok,
						/* 4*/ waktu 					= @in_waktu,
						/* 5*/ update_by 				= @in_user,
						/* 6*/ update_time 			= CURRENT_TIMESTAMP
			WHERE id = @in_id_menu_makanan;
			
			
			SET @action_desc =	'KODE MENU : ' + @in_kode_menu + CHAR(10) +
										'KELOMPOK : ' + @in_kelompok + CHAR(10) +
										'WAKTU : ' + @in_waktu + CHAR(10);
											
		END
	ELSE
		BEGIN
			UPDATE ms_menu_makanan SET
						/* 1*/ kode_menu 				= @in_kode_menu,
						/* 2*/ id_diet 					= @in_id_diet,
						/* 3*/ kelompok 				= @in_kelompok,
						/* 4*/ waktu 						= @in_waktu,
						/* 5*/ note 						= @in_new_note_update,
						/* 6*/ update_by 				= @in_user,
						/* 7*/ update_time 			= CURRENT_TIMESTAMP
			WHERE id = @in_id_menu_makanan;
			
			SET @action_desc =	'KODE MENU : ' + @in_kode_menu + CHAR(10) +
													'KELOMPOK : ' + @in_kelompok + CHAR(10) +
													'WAKTU : ' + @in_waktu + CHAR(10) +
													'NOTE : ' + @in_new_note + CHAR(10);
		END
	
	SET @form_type = 'MENU MAKANAN';
	SET @action_type = 'UPDATE';
	---------------------------------------------------
	
	INSERT INTO ms_history (
				/* 1*/ form_type,
				/* 2*/ action_type,
				/* 3*/ action_desc,
				/* 4*/ create_by
	) VALUES (
				/* 1*/ @form_type,
				/* 2*/ @action_type,
				/* 3*/ @action_desc,
				/* 4*/ @in_user	
	);
							  
END
GO

--#######################################################################-- sp_delete_menu_makanan -- 4

IF Objectproperty(Object_Id('dbo.sp_delete_menu_makanan'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[sp_delete_menu_makanan]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE sp_delete_menu_makanan
	/* 1*/ @in_id_menu_makanan				INT,
	/* 2*/ @in_kode_menu 							VARCHAR(20),
	/* 3*/ @in_kelompok								VARCHAR(100),
	/* 4*/ @in_waktu									VARCHAR(100),
	/* 5*/ @in_user										INT
AS
	DECLARE 	
		@form_type 									VARCHAR(100),
		@action_type								VARCHAR(100),
		@action_desc								VARCHAR(1000);
BEGIN
	
	UPDATE ms_menu_makanan SET
						/* 1*/ status 					= 0,
						/* 2*/ update_by 				= @in_user,
						/* 3*/ update_time 			= CURRENT_TIMESTAMP
	WHERE id = @in_id_menu_makanan;
	
	UPDATE ms_menu_makanan_det SET
						/* 1*/ status 					= 0
	WHERE id_menu_makanan = @in_id_menu_makanan;
			
			
	SET @action_desc =	'KODE MENU : ' + @in_kode_menu + CHAR(10) +
											'KELOMPOK : ' + @in_kelompok + CHAR(10) +
											'WAKTU : ' + @in_waktu + CHAR(10);
											
	SET @form_type = 'MENU MAKANAN';
	SET @action_type = 'DELETE';
	---------------------------------------------------
	
	INSERT INTO ms_history (
				/* 1*/ form_type,
				/* 2*/ action_type,
				/* 3*/ action_desc,
				/* 4*/ create_by
	) VALUES (
				/* 1*/ @form_type,
				/* 2*/ @action_type,
				/* 3*/ @action_desc,
				/* 4*/ @in_user	
	);
							  
END
GO

--#######################################################################-- sp_insert_menu_makanan_det -- 4

IF Objectproperty(Object_Id('dbo.sp_insert_menu_makanan_det'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[sp_insert_menu_makanan_det]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE sp_insert_menu_makanan_det
	/* 1*/ @in_id_menu_makanan		INT,
	/* 2*/ @in_id_makanan					INT,
	/* 3*/ @in_jumlah							INT,
	/* 4*/ @in_user								INT
AS
	
BEGIN
	
	INSERT INTO ms_menu_makanan_det (
				/* 1*/ id_menu_makanan,
				/* 2*/ id_makanan,
				/* 3*/ jumlah,
				/* 4*/ create_by
	) VALUES (
				/* 1*/ @in_id_menu_makanan, 				
				/* 2*/ @in_id_makanan,		
				/* 3*/ @in_jumlah,					  
				/* 4*/ @in_user
	);
							  
END
GO

--#######################################################################-- sp_delete_menu_makanan_det -- 1

IF Objectproperty(Object_Id('dbo.sp_delete_menu_makanan_det'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[sp_delete_menu_makanan_det]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE sp_delete_menu_makanan_det
	/* 1*/ @in_id_menu_makanan		INT
AS
	
BEGIN
	
	DELETE FROM ms_menu_makanan_det
	WHERE id_menu_makanan = @in_id_menu_makanan 
							  
END
GO

--#######################################################################-- sp_insert_makanan -- 3

IF Objectproperty(Object_Id('dbo.sp_insert_makanan'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[sp_insert_makanan]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE sp_insert_makanan
	/* 1*/ @in_nama_makanan				VARCHAR(100),
	/* 2*/ @in_note								VARCHAR(4000),
	/* 3*/ @in_user								INT
AS
	DECLARE 	
		@in_new_note								VARCHAR(5000),
		@form_type 									VARCHAR(100),
		@action_type								VARCHAR(100),
		@action_desc								VARCHAR(1000);
BEGIN
	SET @in_new_note = 'Dibuat : ' +  dbo.fn_get_full_name_user(@in_user) + ' , tanggal : ' +
	CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_note + CHAR(10);
	
	INSERT INTO ms_makanan (
				/* 1*/ nama_makanan,
				/* 2*/ note,
				/* 3*/ create_by,
				/* 4*/ update_by
	) VALUES ( 				
				/* 1*/ @in_nama_makanan,			  									  
				/* 2*/ @in_new_note,					  
				/* 3*/ @in_user,
				/* 4*/ @in_user
	);
	
	---------------------------------------------------
		
	SET @form_type = 'MAKANAN';
	SET @action_type = 'NEW';
	SET @action_desc =	'NAMA MAKANAN : ' + @in_nama_makanan + CHAR(10);
	
	INSERT INTO ms_history (
				/* 1*/ form_type,
				/* 2*/ action_type,
				/* 3*/ action_desc,
				/* 4*/ create_by
	) VALUES (
				/* 1*/ @form_type,
				/* 2*/ @action_type,
				/* 3*/ @action_desc,
				/* 4*/ @in_user	
	);
							  
END
GO

--#######################################################################-- sp_update_makanan -- 4

IF Objectproperty(Object_Id('dbo.sp_update_makanan'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[sp_update_makanan]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE sp_update_makanan
	/* 1*/ @in_id_makanan				INT,
	/* 2*/ @in_nama_makanan				VARCHAR(100),
	/* 3*/ @in_note						VARCHAR(4000),
	/* 4*/ @in_user						INT
AS
	DECLARE 	
		@in_new_note						VARCHAR(5000),
		@in_new_note_update				VARCHAR(5000),
		@form_type 							VARCHAR(100),
		@action_type						VARCHAR(100),
		@action_desc						VARCHAR(1000);
BEGIN
	SET @in_new_note = 'Dibuat : ' +  dbo.fn_get_full_name_user(@in_user) + ' , tanggal : ' +
	CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_note + CHAR(10);
	
	SET @in_new_note_update = @in_new_note + CHAR(10) + '--------------------' + CHAR(10) + CHAR(10)
	+ dbo.fn_get_note_makanan(@in_id_makanan);
	
	
	IF @in_note = ''
		BEGIN
			UPDATE ms_makanan SET
						/* 1*/ nama_makanan 		= @in_nama_makanan,
						/* 2*/ update_by 				= @in_user,
						/* 3*/ update_time 			= CURRENT_TIMESTAMP
			WHERE id = @in_id_makanan;
			
			
			SET @action_desc = 'NAMA MAKANAN : ' + @in_nama_makanan + CHAR(10);
											
		END
	ELSE
		BEGIN
			UPDATE ms_makanan SET
						/* 1*/ nama_makanan 		= @in_nama_makanan,
						/* 2*/ note 						= @in_new_note_update,
						/* 3*/ update_by 				= @in_user,
						/* 4*/ update_time 			= CURRENT_TIMESTAMP
			WHERE id = @in_id_makanan;
			
			SET @action_desc =	'NAMA MAKANAN : ' + @in_nama_makanan + CHAR(10) +
													'NOTE : ' + @in_new_note + CHAR(10);
		END
	
	SET @form_type = 'MAKANAN';
	SET @action_type = 'UPDATE';
	---------------------------------------------------
	
	INSERT INTO ms_history (
				/* 1*/ form_type,
				/* 2*/ action_type,
				/* 3*/ action_desc,
				/* 4*/ create_by
	) VALUES (
				/* 1*/ @form_type,
				/* 2*/ @action_type,
				/* 3*/ @action_desc,
				/* 4*/ @in_user	
	);
							  
END
GO

--#######################################################################-- sp_delete_makanan -- 4

IF Objectproperty(Object_Id('dbo.sp_delete_makanan'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[sp_delete_makanan]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE sp_delete_makanan 
	/* 1*/ @in_id_makanan				INT,
	/* 3*/ @in_nama_makanan				VARCHAR(100),
	/* 4*/ @in_user						INT
AS
	DECLARE 	
		@form_type 							VARCHAR(100),
		@action_type						VARCHAR(100),
		@action_desc						VARCHAR(1000);
BEGIN

	UPDATE ms_makanan SET
				/* 1*/ status 			= 0,
				/* 2*/ update_by 		= @in_user,
				/* 3*/ update_time 	= CURRENT_TIMESTAMP
	WHERE id = @in_id_makanan;
					
	SET @action_desc =	'NAMA MAKANAN : ' + @in_nama_makanan + CHAR(10);
	
	SET @form_type = 'MAKANAN';
	SET @action_type = 'DELETE';
	---------------------------------------------------
	
	INSERT INTO ms_history (
				/* 1*/ form_type,
				/* 2*/ action_type,
				/* 3*/ action_desc,
				/* 4*/ create_by
	) VALUES (
				/* 1*/ @form_type,
				/* 2*/ @action_type,
				/* 3*/ @action_desc,
				/* 4*/ @in_user	
	);
							  
END
GO

--#######################################################################-- sp_insert_alkes -- 8

IF Objectproperty(Object_Id('dbo.sp_insert_alkes'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[sp_insert_alkes]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE sp_insert_alkes
	/* 1*/ @in_kode_alkes				VARCHAR(20),
	/* 2*/ @in_nama_alkes				VARCHAR(100),
	/* 3*/ @in_jenis_alkes				VARCHAR(100),
	/* 4*/ @in_group_alkes				VARCHAR(100),
	/* 5*/ @in_satuan						VARCHAR(100),
	/* 6*/ @in_minimum					INT,
	/* 7*/ @in_note						VARCHAR(4000),
	/* 8*/ @in_user						INT
AS
	DECLARE 	
		@in_new_note						VARCHAR(5000),
		@form_type 							VARCHAR(100),
		@action_type						VARCHAR(100),
		@action_desc						VARCHAR(1000);
BEGIN
	SET @in_new_note = 'Dibuat : ' +  dbo.fn_get_full_name_user(@in_user) + ' , tanggal : ' +
	CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_note + CHAR(10);
	
	INSERT INTO ms_alkes (
				/* 1*/ kode_alkes,
				/* 1*/ nama_alkes,
				/* 1*/ jenis_alkes,
				/* 1*/ group_alkes,
				/* 1*/ satuan,
				/* 1*/ minimum,
				/* 2*/ note,
				/* 3*/ create_by,
				/* 4*/ update_by
	) VALUES ( 				
				/* 1*/ @in_kode_alkes,
				/* 1*/ @in_nama_alkes,
				/* 1*/ @in_jenis_alkes,
				/* 1*/ @in_group_alkes,
				/* 1*/ @in_satuan,
				/* 1*/ @in_minimum,			  									  
				/* 2*/ @in_new_note,					  
				/* 3*/ @in_user,
				/* 4*/ @in_user
	);
	
	---------------------------------------------------
		
	SET @form_type = 'ALKES';
	SET @action_type = 'NEW';
	SET @action_desc =	'KODE ALKES : ' + @in_kode_alkes + CHAR(10) +
								'NAMA ALKES : ' + @in_nama_alkes + CHAR(10) +
								'JENIS ALKES : ' + @in_jenis_alkes + CHAR(10) +
								'GROUP ALKES : ' + @in_group_alkes + CHAR(10) +
								'SATUAN : ' + @in_satuan + CHAR(10) +
								'MINIMUM : ' + CAST(@in_minimum as VARCHAR(16))+ CHAR(10);
	
	INSERT INTO ms_history (
				/* 1*/ form_type,
				/* 2*/ action_type,
				/* 3*/ action_desc,
				/* 4*/ create_by
	) VALUES (
				/* 1*/ @form_type,
				/* 2*/ @action_type,
				/* 3*/ @action_desc,
				/* 4*/ @in_user	
	);
							  
END
GO

--#######################################################################-- sp_update_alkes -- 4

IF Objectproperty(Object_Id('dbo.sp_update_alkes'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[sp_update_alkes]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE sp_update_alkes
	/* 1*/ @in_id_alkes				INT,
	/* 2*/ @in_kode_alkes			VARCHAR(20),
	/* 3*/ @in_nama_alkes			VARCHAR(100),
	/* 4*/ @in_jenis_alkes			VARCHAR(100),
	/* 5*/ @in_group_alkes			VARCHAR(100),
	/* 6*/ @in_satuan					VARCHAR(100),
	/* 7*/ @in_minimum				INT,
	/* 8*/ @in_note					VARCHAR(4000),
	/* 9*/ @in_user					INT
AS
	DECLARE 	
		@in_new_note					VARCHAR(5000),
		@in_new_note_update			VARCHAR(5000),
		@form_type 						VARCHAR(100),
		@action_type					VARCHAR(100),
		@action_desc					VARCHAR(1000);
BEGIN
	SET @in_new_note = 'Dibuat : ' +  dbo.fn_get_full_name_user(@in_user) + ' , tanggal : ' +
	CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_note + CHAR(10);
	
	SET @in_new_note_update = @in_new_note + CHAR(10) + '--------------------' + CHAR(10) + CHAR(10)
	+ dbo.fn_get_note_alkes(@in_id_alkes);
	
	
	IF @in_note = ''
		BEGIN
			UPDATE ms_alkes SET
						/* 1*/ kode_alkes 			= @in_kode_alkes,
						/* 2*/ nama_alkes 			= @in_nama_alkes,
						/* 3*/ jenis_alkes 			= @in_jenis_alkes,
						/* 4*/ group_alkes 			= @in_group_alkes,
						/* 5*/ satuan				 	= @in_satuan,
						/* 6*/ minimum			 		= @in_minimum,
						/* 7*/ update_by 				= @in_user,
						/* 8*/ update_time 			= CURRENT_TIMESTAMP
			WHERE id = @in_id_alkes;
			
			
			SET @action_desc =	'KODE ALKES : ' + @in_kode_alkes + CHAR(10) +
										'NAMA ALKES : ' + @in_nama_alkes + CHAR(10) +
										'JENIS ALKES : ' + @in_jenis_alkes + CHAR(10) +
										'GROUP ALKES : ' + @in_group_alkes + CHAR(10) +
										'SATUAN : ' + @in_satuan + CHAR(10) +
										'MINIMUM : ' + CAST(@in_minimum AS VARCHAR(16)) + CHAR(10);				
		END
	ELSE
		BEGIN
			UPDATE ms_alkes SET
						/* 1*/ kode_alkes 			= @in_kode_alkes,
						/* 2*/ nama_alkes 			= @in_nama_alkes,
						/* 3*/ jenis_alkes 			= @in_jenis_alkes,
						/* 4*/ group_alkes 			= @in_group_alkes,
						/* 5*/ satuan				 	= @in_satuan,
						/* 6*/ minimum			 		= @in_minimum,
						/* 7*/ note 					= @in_new_note_update,
						/* 8*/ update_by 				= @in_user,
						/* 9*/ update_time 			= CURRENT_TIMESTAMP
			WHERE id = @in_id_alkes;
			
			SET @action_desc =	'NOTE : ' + @in_new_note + CHAR(10);
		END
	
	SET @form_type = 'ALKES';
	SET @action_type = 'UPDATE';
	---------------------------------------------------
	
	INSERT INTO ms_history (
				/* 1*/ form_type,
				/* 2*/ action_type,
				/* 3*/ action_desc,
				/* 4*/ create_by
	) VALUES (
				/* 1*/ @form_type,
				/* 2*/ @action_type,
				/* 3*/ @action_desc,
				/* 4*/ @in_user	
	);
							  
END
GO

--#######################################################################-- sp_delete_alkes -- 4

IF Objectproperty(Object_Id('dbo.sp_delete_alkes'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[sp_delete_alkes]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE sp_delete_alkes 
	/* 1*/ @in_id_alkes				INT,
	/* 2*/ @in_kode_alkes			VARCHAR(20),
	/* 3*/ @in_nama_alkes			VARCHAR(100),
	/* 4*/ @in_jenis_alkes			VARCHAR(100),
	/* 5*/ @in_group_alkes			VARCHAR(100),
	/* 6*/ @in_satuan					VARCHAR(100),
	/* 7*/ @in_minimum				INT,
	/* 4*/ @in_user					INT
AS
	DECLARE 	
		@form_type 						VARCHAR(100),
		@action_type					VARCHAR(100),
		@action_desc					VARCHAR(1000);
BEGIN

	UPDATE ms_alkes SET
				/* 1*/ status 			= 0,
				/* 2*/ update_by 		= @in_user,
				/* 3*/ update_time 	= CURRENT_TIMESTAMP
	WHERE id = @in_id_alkes;
					
	SET @action_desc =	'KODE ALKES : ' + @in_kode_alkes + CHAR(10) +
								'NAMA ALKES : ' + @in_nama_alkes + CHAR(10) +
								'JENIS ALKES : ' + @in_jenis_alkes + CHAR(10) +
								'GROUP ALKES : ' + @in_group_alkes + CHAR(10) +
								'SATUAN : ' + @in_satuan + CHAR(10) +
								'MINIMUM : ' + CAST(@in_minimum AS VARCHAR(16)) + CHAR(10);
	
	SET @form_type = 'ALKES';
	SET @action_type = 'DELETE';
	---------------------------------------------------
	
	INSERT INTO ms_history (
				/* 1*/ form_type,
				/* 2*/ action_type,
				/* 3*/ action_desc,
				/* 4*/ create_by
	) VALUES (
				/* 1*/ @form_type,
				/* 2*/ @action_type,
				/* 3*/ @action_desc,
				/* 4*/ @in_user	
	);
							  
END
GO

--#######################################################################-- sp_insert_inv_atk -- 8

IF Objectproperty(Object_Id('dbo.sp_insert_inv_atk'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[sp_insert_inv_atk]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE sp_insert_inv_atk
	/* 1*/ @in_kode_inv_atk				VARCHAR(20),
	/* 2*/ @in_nama_inv_atk				VARCHAR(100),
	/* 3*/ @in_jenis_inv_atk			VARCHAR(100),
	/* 4*/ @in_group_inv_atk			VARCHAR(100),
	/* 5*/ @in_satuan						VARCHAR(100),
	/* 6*/ @in_minimum					INT,
	/* 7*/ @in_note						VARCHAR(4000),
	/* 8*/ @in_user						INT
AS
	DECLARE 	
		@in_new_note						VARCHAR(5000),
		@form_type 							VARCHAR(100),
		@action_type						VARCHAR(100),
		@action_desc						VARCHAR(1000);
BEGIN
	SET @in_new_note = 'Dibuat : ' +  dbo.fn_get_full_name_user(@in_user) + ' , tanggal : ' +
	CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_note + CHAR(10);
	
	INSERT INTO ms_inv_atk (
				/* 1*/ kode_inv_atk,
				/* 1*/ nama_inv_atk,
				/* 1*/ jenis_inv_atk,
				/* 1*/ group_inv_atk,
				/* 1*/ satuan,
				/* 1*/ minimum,
				/* 2*/ note,
				/* 3*/ create_by,
				/* 4*/ update_by
	) VALUES ( 				
				/* 1*/ @in_kode_inv_atk,
				/* 1*/ @in_nama_inv_atk,
				/* 1*/ @in_jenis_inv_atk,
				/* 1*/ @in_group_inv_atk,
				/* 1*/ @in_satuan,
				/* 1*/ @in_minimum,			  									  
				/* 2*/ @in_new_note,					  
				/* 3*/ @in_user,
				/* 4*/ @in_user
	);
	
	---------------------------------------------------
		
	SET @form_type = 'INVENTORY ATK';
	SET @action_type = 'NEW';
	SET @action_desc =	'KODE INVENTORY ATK : ' + @in_kode_inv_atk + CHAR(10) +
								'NAMA INVENTORY ATK : ' + @in_nama_inv_atk + CHAR(10) +
								'JENIS INVENTORY ATK : ' + @in_jenis_inv_atk + CHAR(10) +
								'GROUP INVENTORY ATK : ' + @in_group_inv_atk + CHAR(10) +
								'SATUAN : ' + @in_satuan + CHAR(10) +
								'MINIMUM : ' + CAST(@in_minimum AS VARCHAR(16)) + CHAR(10);
	
	INSERT INTO ms_history (
				/* 1*/ form_type,
				/* 2*/ action_type,
				/* 3*/ action_desc,
				/* 4*/ create_by
	) VALUES (
				/* 1*/ @form_type,
				/* 2*/ @action_type,
				/* 3*/ @action_desc,
				/* 4*/ @in_user	
	);
							  
END
GO

--#######################################################################-- sp_update_inv_atk -- 4

IF Objectproperty(Object_Id('dbo.sp_update_inv_atk'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[sp_update_inv_atk]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE sp_update_inv_atk
	/* 1*/ @in_id_inv_atk				INT,
	/* 2*/ @in_kode_inv_atk			VARCHAR(20),
	/* 3*/ @in_nama_inv_atk			VARCHAR(100),
	/* 4*/ @in_jenis_inv_atk		VARCHAR(100),
	/* 5*/ @in_group_inv_atk		VARCHAR(100),
	/* 6*/ @in_satuan						VARCHAR(100),
	/* 7*/ @in_minimum					INT,
	/* 8*/ @in_note							VARCHAR(4000),
	/* 9*/ @in_user							INT
AS
	DECLARE 	
		@in_new_note						VARCHAR(5000),
		@in_new_note_update				VARCHAR(5000),
		@form_type 							VARCHAR(100),
		@action_type						VARCHAR(100),
		@action_desc						VARCHAR(1000);
BEGIN
	SET @in_new_note = 'Dibuat : ' +  dbo.fn_get_full_name_user(@in_user) + ' , tanggal : ' +
	CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_note + CHAR(10);
	
	SET @in_new_note_update = @in_new_note + CHAR(10) + '--------------------' + CHAR(10) + CHAR(10)
	+ dbo.fn_get_note_inv_atk(@in_id_inv_atk);
	
	
	IF @in_note = ''
		BEGIN
			UPDATE ms_inv_atk SET
						/* 1*/ kode_inv_atk 			= @in_kode_inv_atk,
						/* 2*/ nama_inv_atk 			= @in_nama_inv_atk,
						/* 3*/ jenis_inv_atk			= @in_jenis_inv_atk,
						/* 4*/ group_inv_atk 		= @in_group_inv_atk,
						/* 5*/ satuan				 	= @in_satuan,
						/* 6*/ minimum			 		= @in_minimum,
						/* 7*/ update_by 				= @in_user,
						/* 8*/ update_time 			= CURRENT_TIMESTAMP
			WHERE id = @in_id_inv_atk;
			
			
			SET @action_desc =	'KODE INVENTORY ATK : ' + @in_kode_inv_atk + CHAR(10) +
										'NAMA INVENTORY ATK : ' + @in_nama_inv_atk + CHAR(10) +
										'JENIS INVENTORY ATK : ' + @in_jenis_inv_atk + CHAR(10) +
										'GROUP INVENTORY ATK : ' + @in_group_inv_atk + CHAR(10) +
										'SATUAN : ' + @in_satuan + CHAR(10) +
										'MINIMUM : ' + CAST(@in_minimum AS VARCHAR(16)) + CHAR(10);
											
		END
	ELSE
		BEGIN
			UPDATE ms_inv_atk SET
						/* 1*/ kode_inv_atk 			= @in_kode_inv_atk,
						/* 2*/ nama_inv_atk 			= @in_nama_inv_atk,
						/* 3*/ jenis_inv_atk 		= @in_jenis_inv_atk,
						/* 4*/ group_inv_atk 		= @in_group_inv_atk,
						/* 5*/ satuan				 	= @in_satuan,
						/* 6*/ minimum			 		= @in_minimum,
						/* 7*/ note 					= @in_new_note_update,
						/* 8*/ update_by 				= @in_user,
						/* 9*/ update_time 			= CURRENT_TIMESTAMP
			WHERE id = @in_id_inv_atk;
			
			SET @action_desc =	'NOTE : ' + @in_new_note + CHAR(10);
		END
	
	SET @form_type = 'INVENTORY ATK';
	SET @action_type = 'UPDATE';
	---------------------------------------------------
	
	INSERT INTO ms_history (
				/* 1*/ form_type,
				/* 2*/ action_type,
				/* 3*/ action_desc,
				/* 4*/ create_by
	) VALUES (
				/* 1*/ @form_type,
				/* 2*/ @action_type,
				/* 3*/ @action_desc,
				/* 4*/ @in_user	
	);
							  
END
GO

--#######################################################################-- sp_delete_inv_atk -- 8

IF Objectproperty(Object_Id('dbo.sp_delete_inv_atk'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[sp_delete_inv_atk]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE sp_delete_inv_atk 
	/* 1*/ @in_id_inv_atk					INT,
	/* 2*/ @in_kode_inv_atk					VARCHAR(20),
	/* 3*/ @in_nama_inv_atk					VARCHAR(100),
	/* 4*/ @in_jenis_inv_atk				VARCHAR(100),
	/* 5*/ @in_group_inv_atk				VARCHAR(100),
	/* 6*/ @in_satuan							VARCHAR(100),
	/* 7*/ @in_minimum						INT,
	/* 8*/ @in_user							INT
AS
	DECLARE 	
		@form_type 								VARCHAR(100),
		@action_type							VARCHAR(100),
		@action_desc							VARCHAR(1000);
BEGIN

	UPDATE ms_inv_atk SET
				/* 1*/ status 			= 0,
				/* 2*/ update_by 		= @in_user,
				/* 3*/ update_time 	= CURRENT_TIMESTAMP
	WHERE id = @in_id_inv_atk;
					
	SET @action_desc =	'KODE INVENTORY ATK : ' + @in_kode_inv_atk + CHAR(10) +
								'NAMA INVENTORY ATK : ' + @in_nama_inv_atk + CHAR(10) +
								'JENIS INVENTORY ATK : ' + @in_jenis_inv_atk + CHAR(10) +
								'GROUP INVENTORY ATK : ' + @in_group_inv_atk + CHAR(10) +
								'SATUAN : ' + @in_satuan + CHAR(10) +
								'MINIMUM : ' + CAST(@in_minimum AS VARCHAR(16)) + CHAR(10);
	
	SET @form_type = 'INVENTORY ATK';
	SET @action_type = 'DELETE';
	---------------------------------------------------
	
	INSERT INTO ms_history (
				/* 1*/ form_type,
				/* 2*/ action_type,
				/* 3*/ action_desc,
				/* 4*/ create_by
	) VALUES (
				/* 1*/ @form_type,
				/* 2*/ @action_type,
				/* 3*/ @action_desc,
				/* 4*/ @in_user	
	);
							  
END
GO

--#######################################################################-- spInsertTarifAmbulance -- 11

IF Objectproperty(Object_Id('dbo.spInsertTarifAmbulance'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[spInsertTarifAmbulance]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE spInsertTarifAmbulance
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