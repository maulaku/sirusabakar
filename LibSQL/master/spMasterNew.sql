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
IF Objectproperty(Object_Id('dbo.sp_coa'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[sp_coa]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE sp_coa (
	/* 1*/ @in_Tindakan				VARCHAR(4),
	/* 2*/ @in_id		 				INT,
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
		@tipeForm 						VARCHAR(100),
		@tipeTindakan					VARCHAR(100),
		@KetTindakan					VARCHAR(1000);
		@hitung							int;
BEGIN
	SET @in_catatanBaru = 'Dibuat : ' +  dbo.fn_get_full_name_user(@in_user) + ' , tanggal : ' +
		CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_note + CHAR(10);

	IF @in_action='NEW'
		BEGIN			
			/* Cek data if duplicate */
			BEGIN
				SET @hitung = (SELECT COUNT(KodeCoa) from MsCoa where Status = 1 and KodeCoa = @in_kode_coa);
				IF @hitung > 1
					SET @out_msg = 'Kode Duplikasi'
				ELSE
				
				BEGIN
					INSERT INTO MsCoa (
								/* 1*/ KodeCoa,
								/* 2*/ NamaCoa,
								/* 3*/ TipeCoa,
								/* 4*/ Note,
								/* 5*/ CreateBy,
								/* 6*/ UpdateBy
					) VALUES (
								/* 1*/ @in_kode_coa, 				
								/* 2*/ @in_nama_coa,			  
								/* 3*/ @in_tipe_coa,									  
								/* 4*/ @in_new_note,					  
								/* 5*/ @in_user,
								/* 6*/ @in_user
					);
					
					SET @form_type = 'msCOA';
					SET @action_type = 'NEW';
					SET @action_desc =	'KODE COA : ' + @in_kode_coa + CHAR(20) +
										'NAMA COA : ' + @in_nama_coa + CHAR(1000) +
										'TIPE COA : ' + @in_tipe_coa + CHAR(100);
					SET @out_msg = '';
				END
			END
		END
	---------------------------------------------------
	ELSE IF @in_action='EDIT'
		BEGIN
			SET @in_new_note = 'Dibuat : ' +  dbo.fn_get_full_name_user(@in_user) + ' , tanggal : ' +
			CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_note + CHAR(10);
			
			SET @in_new_note_update = @in_new_note + CHAR(10) + '--------------------' + CHAR(10) + CHAR(10)
			+ dbo.fn_get_note_coa(@in_id_coa);

			IF @in_note = ''
				BEGIN
					UPDATE ms_coa SET
								/* 1*/ kodecoa 			= @in_kode_coa,
								/* 2*/ namacoa 			= @in_nama_coa,
								/* 3*/ tipecoa 			= @in_tipe_coa,
								/* 4*/ updateby 			= @in_user,
								/* 5*/ updatetime 		= CURRENT_TIMESTAMP
					WHERE id = @in_id_coa;
									
					SET @action_desc =	'KODE COA : ' + @in_kode_coa + CHAR(10) +
													'NAMA COA : ' + @in_nama_coa + CHAR(10) +
													'TIPE COA : ' + @in_tipe_coa + CHAR(10);													
				END
			ELSE
				BEGIN
					UPDATE mscoa SET
								/* 1*/ kodecoa 			= @in_kode_coa,
								/* 2*/ namacoa 			= @in_nama_coa,
								/* 3*/ tipecoa 			= @in_tipe_coa,
								/* 3*/ note 				= @in_new_note_update,
								/* 4*/ updateby 			= @in_user,
								/* 5*/ updatetime 		= CURRENT_TIMESTAMP
					WHERE id = @in_id_coa;
					
					SET @action_desc =	'NOTE : ' + @in_new_note + CHAR(10);
				END
			SET @form_type = 'msCOA';
			SET @action_type = 'UPDATE';
			SET @action_desc =	'KODE COA : ' + @in_kode_coa + CHAR(20) +
								'NAMA COA : ' + @in_nama_coa + CHAR(1000) +
								'TIPE COA : ' + @in_tipe_coa + CHAR(100);
		END
	ELSE IF @in_action='DEL'
		BEGIN
			UPDATE mscoa SET
				/* 1*/ status 			= 0,
				/* 2*/ updateby 		= @in_user,
				/* 3*/ updatetime 	= CURRENT_TIMESTAMP
			WHERE id = @in_id_coa;

			SET @form_type = 'msCOA';
			SET @action_type = 'DELETE';
			SET @action_desc =	'KODE COA : ' + @in_kode_coa + CHAR(20) +
								'NAMA COA : ' + @in_nama_coa + CHAR(1000) +
								'TIPE COA : ' + @in_tipe_coa + CHAR(100);
		END

	INSERT INTO mshistory (
				/* 1*/ formtype,
				/* 2*/ actiontype,
				/* 3*/ actiondesc,
				/* 4*/ createby
	) VALUES (
				/* 1*/ @formtype,
				/* 2*/ @actiontype,
				/* 3*/ @actiondesc,
				/* 4*/ @inuser	
	);
							  
END

