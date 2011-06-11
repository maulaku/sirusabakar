-- RANCANGAN STORE PROCEDURE--
----------------------------------------------------------
-- Create by : Findy Efendy
-- Date : April 2011
-- Database : SQL Server
-- Penulisan : Indonesia
----------------------------------------------------------
USE [SIRS]
GO
----------------------------------------------------------
-- komposisi penamaan SP -= Untuk Insert, Update, Delete Master Database =-
----------------------------------------------------------
-- contoh : sp_coa
-- 1. sp = store procedure  
-- 2. nama object (
----------------------------------------------------------

--#######################################################################-- sp_coa 

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[spMsCoa] (
	/* 1*/ @in_Tindakan				VARCHAR(4),
	/* 2*/ @in_id		 			INT,
	/* 3*/ @in_kodecoa 				VARCHAR(20),
	/* 4*/ @in_namacoa				VARCHAR(1000),
	/* 5*/ @in_tipecoa				VARCHAR(100),
	/* 6*/ @in_catatan				VARCHAR(4000),
	/* 7*/ @in_idpengguna			INT,
	/* 8*/ @out_keterangan			VARCHAR(500) OUTPUT
	)
AS
DECLARE 	
		@in_catatanBaru				VARCHAR(5000),
		@in_catatanTerbaru			VARCHAR(5000),
		@tipeForm 					VARCHAR(100),
		@tipeTindakan				VARCHAR(100),
		@KetTindakan				VARCHAR(1000),
		@hitung						int;
BEGIN
	SET @tipeForm = 'msCOA';
	SET @KetTindakan =	'KODE COA : ' + @in_kodecoa + CHAR(10) +
						'NAMA COA : ' + @in_namacoa + CHAR(10) +
						'TIPE COA : ' + @in_tipecoa + CHAR(10);

	SET @in_catatanBaru = 'Dibuat : ' +  dbo.fnAmbilNamaLengkap(@in_idpengguna) + ' , tanggal : ' +
		CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_catatan + CHAR(10);

	IF @in_Tindakan='NEW'
		BEGIN			
			/* Cek data sudah Ada */
			BEGIN
				SET @hitung = (SELECT COUNT(KodeCoa) from MsCoa where Status = 1 and KodeCoa = @in_kodecoa group by kodecoa);
				IF @hitung > 1
					RETURN 'Kode Duplikasi'
				ELSE
				
				BEGIN
					INSERT INTO MsCoa (
								/* 1*/ KodeCoa,
								/* 2*/ NamaCoa,
								/* 3*/ TipeCoa,
								/* 4*/ catatan,
								/* 5*/ dibuatOleh ,
								/* 6*/ waktuBuat
					) VALUES (
								/* 1*/ @in_kodecoa, 				
								/* 2*/ @in_namacoa,			  
								/* 3*/ @in_tipecoa,									  
								/* 4*/ @in_catatanBaru,					  
								/* 5*/ @in_idpengguna,
								/* 6*/ CURRENT_TIMESTAMP
					);
										
					SET @tipeTindakan = 'NEW';
					SET @KetTindakan =	'KODE COA : ' + @in_kodecoa + CHAR(10) +
										'NAMA COA : ' + @in_namacoa + CHAR(10) +
										'TIPE COA : ' + @in_tipecoa + CHAR(10);
					SET @out_keterangan = '';
				END
			END
		END
	---------------------------------------------------
	ELSE IF @in_Tindakan='EDIT'
		BEGIN
--			SET @in_catatanBaru = 'Dibuat : ' +  dbo.fnAmbilNamaLengkap(@in_idpengguna) + ' , tanggal : ' +
--			CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_catatan + CHAR(10);
			
			SET @in_catatanTerbaru = @in_catatanBaru + CHAR(10) + '--------------------' + CHAR(10) + CHAR(10)
			+ dbo.fnAmbilCatatancoa(@in_id);

			IF @in_catatan = ''
				BEGIN
					UPDATE mscoa SET
								/* 1*/ kodecoa 			= @in_kodecoa,
								/* 2*/ namacoa 			= @in_namacoa,
								/* 3*/ tipecoa 			= @in_tipecoa,
								/* 4*/ dieditOleh  		= @in_idpengguna,
								/* 5*/ waktuEdit		= CURRENT_TIMESTAMP
					WHERE id = @in_id;																					
				END
			ELSE
				BEGIN
					UPDATE mscoa SET
								/* 1*/ kodecoa 			= @in_kodecoa,
								/* 2*/ namacoa 			= @in_namacoa,
								/* 3*/ tipecoa 			= @in_tipecoa,
								/* 3*/ catatan			= @in_catatanTerbaru,
								/* 4*/ dieditOleh  		= @in_idpengguna,
								/* 5*/ waktuEdit 		= CURRENT_TIMESTAMP
					WHERE id = @in_id;
					
					SET @KetTindakan =	@ketTindakan + CHAR(10) +
										'NOTE : ' + @in_catatanBaru + CHAR(10);
				END
			SET @tipeTindakan = 'UPDATE';
		END
	ELSE IF @in_Tindakan='DEL'
		BEGIN
			UPDATE mscoa SET
				/* 1*/ status 			= 0,
				/* 2*/ dieditOleh  		= @in_idpengguna,
				/* 3*/ waktuedit		= CURRENT_TIMESTAMP
			WHERE id = @in_id;
			SET @tipeTindakan = 'DELETE';
		END

	INSERT INTO mshistory (
				/* 1*/ tipeform,
				/* 2*/ tipeTindakan,
				/* 3*/ deskripsiTindakan,
				/* 4*/ dibuatOleh
	) VALUES (
				/* 1*/ @tipeForm,
				/* 2*/ @tipeTindakan,
				/* 3*/ @KetTindakan,
				/* 4*/ @in_idpengguna	
	);
							  
END
GO


--############################################################################# spMsDiet

IF Objectproperty(Object_Id('spMsDiet'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[spMsDiet]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE spMsDiet (
	/* 1*/ @in_Tindakan				VARCHAR(4),
	/* 2*/ @in_id		 			INT,
	/* 3*/ @in_kode_diet 			VARCHAR(20),
	/* 4*/ @in_nama_diet			VARCHAR(100),
	/* 5*/ @in_note					VARCHAR(4000),
	/* 6*/ @in_user					INT,
	/* 7*/ @out_keterangan			VARCHAR(500) OUTPUT
	)
AS
	DECLARE 	
		@in_new_note				VARCHAR(5000),
		@in_new_note_update		VARCHAR(5000),
		@form_type 					VARCHAR(100),
		@action_type				VARCHAR(100),
		@action_desc				VARCHAR(1000),
		@hitung						INT;
BEGIN
	SET @form_type = 'DIET';
	SET @action_desc =	'KODE DIET : ' + @in_kode_diet + CHAR(10) +
						'NAMA DIET : ' + @in_nama_diet + CHAR(10);

	SET @in_new_note = 'Dibuat : ' +  dbo.fnAmbilNamaLengkap(@in_user) + ' , tanggal : ' +
	CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_note + CHAR(10);
	
	IF @in_Tindakan='NEW'
		BEGIN	
			/* Cek data sudah Ada */
			BEGIN
				SET @hitung = (SELECT COUNT(KodeDiet) from MsDiet where Status = 1 and KodeDiet = @in_kode_diet group by kodediet);
				IF @hitung > 1
					SET @out_keterangan = 'Kode Duplikasi'
				ELSE				
				BEGIN	
					INSERT INTO msdiet (
								/* 1*/ kodediet,
								/* 2*/ namadiet,
								/* 3*/ catatan,
								/* 4*/ dibuatoleh
					) VALUES (
								/* 1*/ @in_kode_diet, 				
								/* 2*/ @in_nama_diet,			  									  
								/* 3*/ @in_new_note,					  
								/* 4*/ @in_user
					);												
					SET @action_type = 'NEW';					
				END
			END
		END
------------------------------------------------------------------- Edit MsDiet
	ELSE IF @in_Tindakan='EDIT'
		BEGIN	
			SET @in_new_note_update = @in_new_note + CHAR(10) + '--------------------' + CHAR(10) + CHAR(10)
										+dbo.fnAmbilCatatandiet(@in_id);	
			IF @in_note = ''
				BEGIN
					UPDATE msdiet SET
								/* 1*/ kodediet 			= @in_kode_diet,
								/* 2*/ namadiet 			= @in_nama_diet,
								/* 3*/ dieditoleh 			= @in_user,
								/* 4*/ waktuedit	 		= CURRENT_TIMESTAMP
					WHERE id = @in_id;													
				END
			ELSE
				BEGIN
					UPDATE msdiet SET
								/* 1*/ kodediet 			= @in_kode_diet,
								/* 2*/ namadiet 			= @in_nama_diet,
								/* 3*/ catatan 				= @in_new_note_update,
								/* 4*/ dieditoleh 			= @in_user,
								/* 5*/ waktuedit	 		= CURRENT_TIMESTAMP
					WHERE id = @in_id;					
					SET @action_desc =	@action_desc + CHAR(10) +
										'NOTE : ' + @in_new_note + CHAR(10);
				END
			SET @action_type = 'UPDATE';
		END
	ELSE IF @in_Tindakan='DEL'
		BEGIN
			UPDATE msdiet SET
						/* 1*/ status 			= 0,
						/* 2*/ dieditoleh 		= @in_user,
						/* 3*/ waktuedit	 	= CURRENT_TIMESTAMP
			WHERE id = @in_id;
			SET @action_type = 'DELETE';
		END

	
	INSERT INTO mshistory (
				/* 1*/ tipeform,
				/* 2*/ tipeTindakan,
				/* 3*/ deskripsiTindakan,
				/* 4*/ dibuatOleh
	) VALUES (
				/* 1*/ @form_type,
				/* 2*/ @action_type,
				/* 3*/ @action_desc,
				/* 4*/ @in_user	
	);
							  
END
GO