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

--#######################################################################-- spInsMsHistory

IF Objectproperty(Object_Id('spInsMsHistory'), N'isprocedure') = 1
DROP PROCEDURE spInsMsHistory
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE spInsMsHistory (
	/* 1*/ @tipeForm			VARCHAR(100),
	/* 2*/ @tipeTindakan		VARCHAR(100),
	/* 3*/ @KetTindakan		VARCHAR(1000),
	/* 4*/ @in_idpengguna	INT
)
AS
BEGIN
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

--#######################################################################-- spCOA 

IF Objectproperty(Object_Id('spMsCoa'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[spMsCoa]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE spMsCoa (
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
	SET @in_catatanTerbaru = 	'DIBUAT   : ' +  dbo.fnAmbilNamaLengkap(@in_idpengguna) + ' , TANGGAL : ' +
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
	--------------------------------------------------- New COA
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
		---------------------------------------------------- Update COA
	ELSE IF @in_Tindakan='DEL'
		BEGIN
			UPDATE mscoa SET
				/* 1*/ status 			= 0,
				/* 2*/ dieditOleh  		= @in_idpengguna,
				/* 3*/ waktuedit		= CURRENT_TIMESTAMP
			WHERE id = @in_id;
			SET @tipeTindakan = 'DELETE';
		END
--------------------------------------------------------- Delete COA

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
	SET @in_new_note = 	'DIBUAT    : ' +  dbo.fnAmbilNamaLengkap(@in_user) + ' , TANGGAL : ' +
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
------------------------------------------------------------------- New MsDiet
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
		----------------------------------------------------------- Update Diet
	ELSE IF @in_Tindakan='DEL'
		BEGIN
			UPDATE msdiet SET
						/* 1*/ status 			= 0,
						/* 2*/ dieditoleh 		= @in_user,
						/* 3*/ waktuedit	 	= CURRENT_TIMESTAMP
			WHERE id = @in_id;
			SET @action_type = 'DELETE';
		END
------------------------------------------------------------------ Delete Diet
	
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


--############################################################################# spMsMakanan

IF Objectproperty(Object_Id('spMsMakanan'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[spMsMakanan]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE spMsMakanan (
	/* 1*/ @in_Tindakan				VARCHAR(4),
	/* 2*/ @in_id		 			INT,
	/* 3*/ @in_nama_makanan			VARCHAR(100),
	/* 4*/ @in_note					VARCHAR(4000),
	/* 5*/ @in_user					INT,
	/* 6*/ @out_keterangan			VARCHAR(500) OUTPUT
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
	SET @form_type = 'MsMakanan';
	SET @action_desc =	'NAMA MAKANAN : ' + @in_nama_makanan + CHAR(10);
	SET @in_new_note = 	'DIBUAT       : ' +  dbo.fnAmbilNamaLengkap(@in_user) + ' , TANGGAL : ' +
	CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_note + CHAR(10);
	
	IF @in_Tindakan='NEW'
		BEGIN	
			/* Cek data sudah Ada */
			BEGIN
				SET @hitung = (SELECT COUNT(NamaMakanan) from MsMakanan where Status = 1 and NamaMakanan = @in_nama_makanan group by namamakanan);
				IF @hitung > 1
					SET @out_keterangan = 'Kode Duplikasi'
				ELSE				
				BEGIN	
					INSERT INTO msMakanan (
								/* 1*/ namaMakanan,
								/* 2*/ catatan,
								/* 3*/ dibuatoleh
					) VALUES ( 				
								/* 1*/ @in_nama_makanan,			  									  
								/* 2*/ @in_new_note,					  
								/* 3*/ @in_user
					);												
					SET @action_type = 'NEW';					
				END
			END
		END
------------------------------------------------------------------- New Makanan
	ELSE IF @in_Tindakan='EDIT'
		BEGIN	
			SET @in_new_note_update = @in_new_note + CHAR(10) + '--------------------' + CHAR(10) + CHAR(10)
										+dbo.fnAmbilCatatanMakanan(@in_id);	
			IF @in_note = ''
				BEGIN
					UPDATE msMakanan SET
								/* 1*/ namaMakanan 			= @in_nama_makanan,
								/* 2*/ dieditoleh 			= @in_user,
								/* 3*/ waktuedit	 		= CURRENT_TIMESTAMP
					WHERE id = @in_id;													
				END
			ELSE
				BEGIN
					UPDATE msMakanan SET
								/* 1*/ namamakanan 			= @in_nama_makanan,
								/* 2*/ catatan 				= @in_new_note_update,
								/* 3*/ dieditoleh 			= @in_user,
								/* 4*/ waktuedit	 		= CURRENT_TIMESTAMP
					WHERE id = @in_id;					
					SET @action_desc =	@action_desc + CHAR(10) +
										'NOTE : ' + @in_new_note + CHAR(10);
				END
			SET @action_type = 'UPDATE';
		END		
------------------------------------------------------------------- Edit Makanan
	ELSE IF @in_Tindakan='DEL'
		BEGIN
			UPDATE msMakanan SET
						/* 1*/ status 			= 0,
						/* 2*/ dieditoleh 		= @in_user,
						/* 3*/ waktuedit	 	= CURRENT_TIMESTAMP
			WHERE id = @in_id;
			SET @action_type = 'DELETE';
		END
------------------------------------------------------------------- Delete makanan
	
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


--############################################################################# spMsAgama

IF Objectproperty(Object_Id('spMsAgama'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[spMsAgama]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE spMsAgama (
	/* 1*/ @in_Tindakan				VARCHAR(4),
	/* 2*/ @in_id		 			INT,
	/* 3*/ @in_nama_agama			VARCHAR(100),
	/* 4*/ @in_note					VARCHAR(4000),
	/* 5*/ @in_user					INT,
	/* 6*/ @out_keterangan			VARCHAR(500) OUTPUT
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
	SET @form_type = 'MsAgama';
	SET @action_desc =	'NAMA AGAMA : ' + @in_nama_agama + CHAR(10);
	SET @in_new_note = 	'DIBUAT     : ' +  dbo.fnAmbilNamaLengkap(@in_user) + ' , TANGGAL : ' +
	CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_note + CHAR(10);
	
	IF @in_Tindakan='NEW'
		BEGIN	
			/* Cek data sudah Ada */
			BEGIN
				SET @hitung = (SELECT COUNT(NamaAgama) from MsAgama where Status = 1 and NamaAgama = @in_nama_agama group by namaAgama);
				IF @hitung > 1
					SET @out_keterangan = 'Kode Duplikasi'
				ELSE				
				BEGIN	
					INSERT INTO msAgama (
								/* 1*/ namaAgama,
								/* 2*/ catatan,
								/* 3*/ dibuatoleh
					) VALUES ( 				
								/* 1*/ @in_nama_Agama,			  									  
								/* 2*/ @in_new_note,					  
								/* 3*/ @in_user
					);												
					SET @action_type = 'NEW';					
				END
			END
		END
------------------------------------------------------------------- New Agama
	ELSE IF @in_Tindakan='EDIT'
		BEGIN	
			SET @in_new_note_update = @in_new_note + CHAR(10) + '--------------------' + CHAR(10) + CHAR(10)
										+dbo.fnAmbilCatatanAgama(@in_id);	
			IF @in_note = ''
				BEGIN
					UPDATE msAgama SET
								/* 1*/ namaAgama 			= @in_nama_agama,
								/* 2*/ dieditoleh 			= @in_user,
								/* 3*/ waktuedit	 		= CURRENT_TIMESTAMP
					WHERE id = @in_id;													
				END
			ELSE
				BEGIN
					UPDATE msAgama SET
								/* 1*/ namaAgama 			= @in_nama_Agama,
								/* 2*/ catatan 				= @in_new_note_update,
								/* 3*/ dieditoleh 			= @in_user,
								/* 4*/ waktuedit	 		= CURRENT_TIMESTAMP
					WHERE id = @in_id;					
					SET @action_desc =	@action_desc + CHAR(10) +
										'NOTE : ' + @in_new_note + CHAR(10);
				END
			SET @action_type = 'UPDATE';
		END		
------------------------------------------------------------------- Edit Agama
	ELSE IF @in_Tindakan='DEL'
		BEGIN
			UPDATE msAgama SET
						/* 1*/ status 			= 0,
						/* 2*/ dieditoleh 		= @in_user,
						/* 3*/ waktuedit	 	= CURRENT_TIMESTAMP
			WHERE id = @in_id;
			SET @action_type = 'DELETE';
		END
------------------------------------------------------------------- Delete Agama
	
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


--############################################################################# spMsPendidikan

IF Objectproperty(Object_Id('spMsPendidikan'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[spMsPendidikan]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE spMsPendidikan (
	/* 1*/ @in_Tindakan				VARCHAR(4),
	/* 2*/ @in_id		 			INT,
	/* 3*/ @in_nama_pendidikan			VARCHAR(100),
	/* 4*/ @in_note					VARCHAR(4000),
	/* 5*/ @in_user					INT,
	/* 6*/ @out_keterangan			VARCHAR(500) OUTPUT
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
	SET @form_type = 'MsPendidikan';
	SET @action_desc =	'NAMA PENDIDIKAN : ' + @in_nama_pendidikan + CHAR(10);
	SET @in_new_note = 	'DIBUAT          : ' +  dbo.fnAmbilNamaLengkap(@in_user) + ' , TANGGAL : ' +
	CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_note + CHAR(10);
	
	IF @in_Tindakan='NEW'
		BEGIN	
			/* Cek data sudah Ada */
			BEGIN
				SET @hitung = (SELECT COUNT(NamaPendidikan) from MsPendidikan where Status = 1 and NamaPendidikan = @in_nama_Pendidikan group by namaPendidikan);
				IF @hitung > 1
					SET @out_keterangan = 'Kode Duplikasi'
				ELSE				
				BEGIN	
					INSERT INTO msPendidikan (
								/* 1*/ namaPendidikan,
								/* 2*/ catatan,
								/* 3*/ dibuatoleh
					) VALUES ( 				
								/* 1*/ @in_nama_Pendidikan,			  									  
								/* 2*/ @in_new_note,					  
								/* 3*/ @in_user
					);												
					SET @action_type = 'NEW';					
				END
			END
		END
------------------------------------------------------------------- New Pendidikan
	ELSE IF @in_Tindakan='EDIT'
		BEGIN	
			SET @in_new_note_update = @in_new_note + CHAR(10) + '--------------------' + CHAR(10) + CHAR(10)
										+dbo.fnAmbilCatatanPendidikan(@in_id);	
			IF @in_note = ''
				BEGIN
					UPDATE msPendidikan SET
								/* 1*/ namaPendidikan 			= @in_nama_Pendidikan,
								/* 2*/ dieditoleh 			= @in_user,
								/* 3*/ waktuedit	 		= CURRENT_TIMESTAMP
					WHERE id = @in_id;													
				END
			ELSE
				BEGIN
					UPDATE msPendidikan SET
								/* 1*/ namaPendidikan			= @in_nama_Pendidikan,
								/* 2*/ catatan 				= @in_new_note_update,
								/* 3*/ dieditoleh 			= @in_user,
								/* 4*/ waktuedit	 		= CURRENT_TIMESTAMP
					WHERE id = @in_id;					
					SET @action_desc =	@action_desc + CHAR(10) +
										'NOTE : ' + @in_new_note + CHAR(10);
				END
			SET @action_type = 'UPDATE';
		END		
------------------------------------------------------------------- Edit Pendidikan
	ELSE IF @in_Tindakan='DEL'
		BEGIN
			UPDATE msPendidikan SET
						/* 1*/ status 			= 0,
						/* 2*/ dieditoleh 		= @in_user,
						/* 3*/ waktuedit	 	= CURRENT_TIMESTAMP
			WHERE id = @in_id;
			SET @action_type = 'DELETE';
		END
------------------------------------------------------------------- Delete Pendidikan
	
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

--############################################################################# spMsPropinsi

IF Objectproperty(Object_Id('spMsPropinsi'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[spMsPropinsi]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE spMsPropinsi (
	/* 1*/ @in_Tindakan				VARCHAR(4),
	/* 2*/ @in_id		 			INT,
	/* 3*/ @in_nama_Propinsi			VARCHAR(100),
	/* 4*/ @in_note					VARCHAR(4000),
	/* 5*/ @in_user					INT,
	/* 6*/ @out_keterangan			VARCHAR(500) OUTPUT
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
	SET @form_type = 'MsPropinsi';
	SET @action_desc =	'NAMA Propinsi : ' + @in_nama_Propinsi + CHAR(10);
	SET @in_new_note = 	'DIBUAT          : ' +  dbo.fnAmbilNamaLengkap(@in_user) + ' , TANGGAL : ' +
	CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_note + CHAR(10);
	
	IF @in_Tindakan='NEW'
		BEGIN	
			/* Cek data sudah Ada */
			BEGIN
				SET @hitung = (SELECT COUNT(NamaPropinsi) from MsPropinsi where Status = 1 and NamaPropinsi = @in_nama_Propinsi group by namaPropinsi);
				IF @hitung > 1
					SET @out_keterangan = 'Kode Duplikasi'
				ELSE				
				BEGIN	
					INSERT INTO msPropinsi (
								/* 1*/ namaPropinsi,
								/* 2*/ catatan,
								/* 3*/ dibuatoleh
					) VALUES ( 				
								/* 1*/ @in_nama_Propinsi,			  									  
								/* 2*/ @in_new_note,					  
								/* 3*/ @in_user
					);												
					SET @action_type = 'NEW';					
				END
			END
		END
------------------------------------------------------------------- New Propinsi
	ELSE IF @in_Tindakan='EDIT'
		BEGIN	
			SET @in_new_note_update = @in_new_note + CHAR(10) + '--------------------' + CHAR(10) + CHAR(10)
										+dbo.fnAmbilCatatanPropinsi(@in_id);	
			IF @in_note = ''
				BEGIN
					UPDATE msPropinsi SET
								/* 1*/ namaPropinsi 			= @in_nama_Propinsi,
								/* 2*/ dieditoleh 			= @in_user,
								/* 3*/ waktuedit	 		= CURRENT_TIMESTAMP
					WHERE id = @in_id;													
				END
			ELSE
				BEGIN
					UPDATE msPropinsi SET
								/* 1*/ namaPropinsi			= @in_nama_Propinsi,
								/* 2*/ catatan 				= @in_new_note_update,
								/* 3*/ dieditoleh 			= @in_user,
								/* 4*/ waktuedit	 		= CURRENT_TIMESTAMP
					WHERE id = @in_id;					
					SET @action_desc =	@action_desc + CHAR(10) +
										'NOTE : ' + @in_new_note + CHAR(10);
				END
			SET @action_type = 'UPDATE';
		END		
------------------------------------------------------------------- Edit Propinsi
	ELSE IF @in_Tindakan='DEL'
		BEGIN
			UPDATE msPropinsi SET
						/* 1*/ status 			= 0,
						/* 2*/ dieditoleh 		= @in_user,
						/* 3*/ waktuedit	 	= CURRENT_TIMESTAMP
			WHERE id = @in_id;
			SET @action_type = 'DELETE';
		END
------------------------------------------------------------------- Delete Propinsi
	
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

--############################################################################# spMsKabupaten

IF Objectproperty(Object_Id('spMsKabupaten'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[spMsKabupaten]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE spMsKabupaten (
	/* 1*/ @in_Tindakan				VARCHAR(4),
	/* 2*/ @in_id		 			INT,
	/* 3*/ @in_nama_Kabupaten			VARCHAR(100),
	/* 4*/ @in_note					VARCHAR(4000),
	/* 5*/ @in_user					INT,
	/* 6*/ @out_keterangan			VARCHAR(500) OUTPUT
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
	SET @form_type = 'MsKabupaten';
	SET @action_desc =	'NAMA Kabupaten : ' + @in_nama_Kabupaten + CHAR(10);
	SET @in_new_note = 	'DIBUAT          : ' +  dbo.fnAmbilNamaLengkap(@in_user) + ' , TANGGAL : ' +
	CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_note + CHAR(10);
	
	IF @in_Tindakan='NEW'
		BEGIN	
			/* Cek data sudah Ada */
			BEGIN
				SET @hitung = (SELECT COUNT(NamaKabupaten) from MsKabupaten where Status = 1 and NamaKabupaten = @in_nama_Kabupaten group by namaKabupaten);
				IF @hitung > 1
					SET @out_keterangan = 'Kode Duplikasi'
				ELSE				
				BEGIN	
					INSERT INTO msKabupaten (
								/* 1*/ namaKabupaten,
								/* 2*/ catatan,
								/* 3*/ dibuatoleh
					) VALUES ( 				
								/* 1*/ @in_nama_Kabupaten,			  									  
								/* 2*/ @in_new_note,					  
								/* 3*/ @in_user
					);												
					SET @action_type = 'NEW';					
				END
			END
		END
------------------------------------------------------------------- New Kabupaten
	ELSE IF @in_Tindakan='EDIT'
		BEGIN	
			SET @in_new_note_update = @in_new_note + CHAR(10) + '--------------------' + CHAR(10) + CHAR(10)
										+dbo.fnAmbilCatatanKabupaten(@in_id);	
			IF @in_note = ''
				BEGIN
					UPDATE msKabupaten SET
								/* 1*/ namaKabupaten 			= @in_nama_Kabupaten,
								/* 2*/ dieditoleh 			= @in_user,
								/* 3*/ waktuedit	 		= CURRENT_TIMESTAMP
					WHERE id = @in_id;													
				END
			ELSE
				BEGIN
					UPDATE msKabupaten SET
								/* 1*/ namaKabupaten			= @in_nama_Kabupaten,
								/* 2*/ catatan 				= @in_new_note_update,
								/* 3*/ dieditoleh 			= @in_user,
								/* 4*/ waktuedit	 		= CURRENT_TIMESTAMP
					WHERE id = @in_id;					
					SET @action_desc =	@action_desc + CHAR(10) +
										'NOTE : ' + @in_new_note + CHAR(10);
				END
			SET @action_type = 'UPDATE';
		END		
------------------------------------------------------------------- Edit Kabupaten
	ELSE IF @in_Tindakan='DEL'
		BEGIN
			UPDATE msKabupaten SET
						/* 1*/ status 			= 0,
						/* 2*/ dieditoleh 		= @in_user,
						/* 3*/ waktuedit	 	= CURRENT_TIMESTAMP
			WHERE id = @in_id;
			SET @action_type = 'DELETE';
		END
------------------------------------------------------------------- Delete Kabupaten
	
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

--############################################################################# spMsPekerjaan

IF Objectproperty(Object_Id('spMsPekerjaan'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[spMsPekerjaan]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE spMsPekerjaan (
	/* 1*/ @in_Tindakan				VARCHAR(4),
	/* 2*/ @in_id		 			INT,
	/* 3*/ @in_nama_Pekerjaan			VARCHAR(100),
	/* 4*/ @in_note					VARCHAR(4000),
	/* 5*/ @in_user					INT,
	/* 6*/ @out_keterangan			VARCHAR(500) OUTPUT
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
	SET @form_type = 'MsPekerjaan';
	SET @action_desc =	'NAMA Pekerjaan : ' + @in_nama_Pekerjaan + CHAR(10);
	SET @in_new_note = 	'DIBUAT          : ' +  dbo.fnAmbilNamaLengkap(@in_user) + ' , TANGGAL : ' +
	CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_note + CHAR(10);
	
	IF @in_Tindakan='NEW'
		BEGIN	
			/* Cek data sudah Ada */
			BEGIN
				SET @hitung = (SELECT COUNT(NamaPekerjaan) from MsPekerjaan where Status = 1 and NamaPekerjaan = @in_nama_Pekerjaan group by namaPekerjaan);
				IF @hitung > 1
					SET @out_keterangan = 'Kode Duplikasi'
				ELSE				
				BEGIN	
					INSERT INTO msPekerjaan (
								/* 1*/ namaPekerjaan,
								/* 2*/ catatan,
								/* 3*/ dibuatoleh
					) VALUES ( 				
								/* 1*/ @in_nama_Pekerjaan,			  									  
								/* 2*/ @in_new_note,					  
								/* 3*/ @in_user
					);												
					SET @action_type = 'NEW';					
				END
			END
		END
------------------------------------------------------------------- New Pekerjaan
	ELSE IF @in_Tindakan='EDIT'
		BEGIN	
			SET @in_new_note_update = @in_new_note + CHAR(10) + '--------------------' + CHAR(10) + CHAR(10)
										+dbo.fnAmbilCatatanPekerjaan(@in_id);	
			IF @in_note = ''
				BEGIN
					UPDATE msPekerjaan SET
								/* 1*/ namaPekerjaan 			= @in_nama_Pekerjaan,
								/* 2*/ dieditoleh 			= @in_user,
								/* 3*/ waktuedit	 		= CURRENT_TIMESTAMP
					WHERE id = @in_id;													
				END
			ELSE
				BEGIN
					UPDATE msPekerjaan SET
								/* 1*/ namaPekerjaan			= @in_nama_Pekerjaan,
								/* 2*/ catatan 				= @in_new_note_update,
								/* 3*/ dieditoleh 			= @in_user,
								/* 4*/ waktuedit	 		= CURRENT_TIMESTAMP
					WHERE id = @in_id;					
					SET @action_desc =	@action_desc + CHAR(10) +
										'NOTE : ' + @in_new_note + CHAR(10);
				END
			SET @action_type = 'UPDATE';
		END		
------------------------------------------------------------------- Edit Pekerjaan
	ELSE IF @in_Tindakan='DEL'
		BEGIN
			UPDATE msPekerjaan SET
						/* 1*/ status 			= 0,
						/* 2*/ dieditoleh 		= @in_user,
						/* 3*/ waktuedit	 	= CURRENT_TIMESTAMP
			WHERE id = @in_id;
			SET @action_type = 'DELETE';
		END
------------------------------------------------------------------- Delete Pekerjaan
	
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

--############################################################################# spMsKecamatan

IF Objectproperty(Object_Id('spMsKecamatan'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[spMsKecamatan]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE spMsKecamatan (
	/* 1*/ @in_Tindakan				VARCHAR(4),
	/* 2*/ @in_id		 			INT,
	/* 3*/ @in_nama_Kecamatan			VARCHAR(100),
	/* 4*/ @in_note					VARCHAR(4000),
	/* 5*/ @in_user					INT,
	/* 6*/ @out_keterangan			VARCHAR(500) OUTPUT
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
	SET @form_type = 'MsKecamatan';
	SET @action_desc =	'NAMA Kecamatan : ' + @in_nama_Kecamatan + CHAR(10);
	SET @in_new_note = 	'DIBUAT          : ' +  dbo.fnAmbilNamaLengkap(@in_user) + ' , TANGGAL : ' +
	CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_note + CHAR(10);
	
	IF @in_Tindakan='NEW'
		BEGIN	
			/* Cek data sudah Ada */
			BEGIN
				SET @hitung = (SELECT COUNT(NamaKecamatan) from MsKecamatan where Status = 1 and NamaKecamatan = @in_nama_Kecamatan group by namaKecamatan);
				IF @hitung > 1
					SET @out_keterangan = 'Kode Duplikasi'
				ELSE				
				BEGIN	
					INSERT INTO msKecamatan (
								/* 1*/ namaKecamatan,
								/* 2*/ catatan,
								/* 3*/ dibuatoleh
					) VALUES ( 				
								/* 1*/ @in_nama_Kecamatan,			  									  
								/* 2*/ @in_new_note,					  
								/* 3*/ @in_user
					);												
					SET @action_type = 'NEW';					
				END
			END
		END
------------------------------------------------------------------- New Kecamatan
	ELSE IF @in_Tindakan='EDIT'
		BEGIN	
			SET @in_new_note_update = @in_new_note + CHAR(10) + '--------------------' + CHAR(10) + CHAR(10)
										+dbo.fnAmbilCatatanKecamatan(@in_id);	
			IF @in_note = ''
				BEGIN
					UPDATE msKecamatan SET
								/* 1*/ namaKecamatan 			= @in_nama_Kecamatan,
								/* 2*/ dieditoleh 			= @in_user,
								/* 3*/ waktuedit	 		= CURRENT_TIMESTAMP
					WHERE id = @in_id;													
				END
			ELSE
				BEGIN
					UPDATE msKecamatan SET
								/* 1*/ namaKecamatan			= @in_nama_Kecamatan,
								/* 2*/ catatan 				= @in_new_note_update,
								/* 3*/ dieditoleh 			= @in_user,
								/* 4*/ waktuedit	 		= CURRENT_TIMESTAMP
					WHERE id = @in_id;					
					SET @action_desc =	@action_desc + CHAR(10) +
										'NOTE : ' + @in_new_note + CHAR(10);
				END
			SET @action_type = 'UPDATE';
		END		
------------------------------------------------------------------- Edit Kecamatan
	ELSE IF @in_Tindakan='DEL'
		BEGIN
			UPDATE msKecamatan SET
						/* 1*/ status 			= 0,
						/* 2*/ dieditoleh 		= @in_user,
						/* 3*/ waktuedit	 	= CURRENT_TIMESTAMP
			WHERE id = @in_id;
			SET @action_type = 'DELETE';
		END
------------------------------------------------------------------- Delete Kecamatan
	
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

--############################################################################# spMsKelurahan

IF Objectproperty(Object_Id('spMsKelurahan'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[spMsKelurahan]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE spMsKelurahan (
	/* 1*/ @in_Tindakan				VARCHAR(4),
	/* 2*/ @in_id		 			INT,
	/* 3*/ @in_nama_Kelurahan			VARCHAR(100),
	/* 4*/ @in_note					VARCHAR(4000),
	/* 5*/ @in_user					INT,
	/* 6*/ @out_keterangan			VARCHAR(500) OUTPUT
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
	SET @form_type = 'MsKelurahan';
	SET @action_desc =	'NAMA Kelurahan : ' + @in_nama_Kelurahan + CHAR(10);
	SET @in_new_note = 	'DIBUAT          : ' +  dbo.fnAmbilNamaLengkap(@in_user) + ' , TANGGAL : ' +
	CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_note + CHAR(10);
	
	IF @in_Tindakan='NEW'
		BEGIN	
			/* Cek data sudah Ada */
			BEGIN
				SET @hitung = (SELECT COUNT(NamaKelurahan) from MsKelurahan where Status = 1 and NamaKelurahan = @in_nama_Kelurahan group by namaKelurahan);
				IF @hitung > 1
					SET @out_keterangan = 'Kode Duplikasi'
				ELSE				
				BEGIN	
					INSERT INTO msKelurahan (
								/* 1*/ namaKelurahan,
								/* 2*/ catatan,
								/* 3*/ dibuatoleh
					) VALUES ( 				
								/* 1*/ @in_nama_Kelurahan,			  									  
								/* 2*/ @in_new_note,					  
								/* 3*/ @in_user
					);												
					SET @action_type = 'NEW';					
				END
			END
		END
------------------------------------------------------------------- New Kelurahan
	ELSE IF @in_Tindakan='EDIT'
		BEGIN	
			SET @in_new_note_update = @in_new_note + CHAR(10) + '--------------------' + CHAR(10) + CHAR(10)
										+dbo.fnAmbilCatatanKelurahan(@in_id);	
			IF @in_note = ''
				BEGIN
					UPDATE msKelurahan SET
								/* 1*/ namaKelurahan 			= @in_nama_Kelurahan,
								/* 2*/ dieditoleh 			= @in_user,
								/* 3*/ waktuedit	 		= CURRENT_TIMESTAMP
					WHERE id = @in_id;													
				END
			ELSE
				BEGIN
					UPDATE msKelurahan SET
								/* 1*/ namaKelurahan			= @in_nama_Kelurahan,
								/* 2*/ catatan 				= @in_new_note_update,
								/* 3*/ dieditoleh 			= @in_user,
								/* 4*/ waktuedit	 		= CURRENT_TIMESTAMP
					WHERE id = @in_id;					
					SET @action_desc =	@action_desc + CHAR(10) +
										'NOTE : ' + @in_new_note + CHAR(10);
				END
			SET @action_type = 'UPDATE';
		END		
------------------------------------------------------------------- Edit Kelurahan
	ELSE IF @in_Tindakan='DEL'
		BEGIN
			UPDATE msKelurahan SET
						/* 1*/ status 			= 0,
						/* 2*/ dieditoleh 		= @in_user,
						/* 3*/ waktuedit	 	= CURRENT_TIMESTAMP
			WHERE id = @in_id;
			SET @action_type = 'DELETE';
		END
------------------------------------------------------------------- Delete Kelurahan
	
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

--############################################################################# spMsHubKel

IF Objectproperty(Object_Id('spMsHubKel'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[spMsHubKel]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE spMsHubKel (
	/* 1*/ @in_Tindakan				VARCHAR(4),
	/* 2*/ @in_id		 			INT,
	/* 3*/ @in_nama_HubKel			VARCHAR(100),
	/* 4*/ @in_note					VARCHAR(4000),
	/* 5*/ @in_user					INT,
	/* 6*/ @out_keterangan			VARCHAR(500) OUTPUT
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
	SET @form_type = 'MsHubKel';
	SET @action_desc =	'NAMA HubKel : ' + @in_nama_HubKel + CHAR(10);
	SET @in_new_note = 	'DIBUAT          : ' +  dbo.fnAmbilNamaLengkap(@in_user) + ' , TANGGAL : ' +
	CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_note + CHAR(10);
	
	IF @in_Tindakan='NEW'
		BEGIN	
			/* Cek data sudah Ada */
			BEGIN
				SET @hitung = (SELECT COUNT(NamaHubKel) from MsHubKel where Status = 1 and NamaHubKel = @in_nama_HubKel group by namaHubKel);
				IF @hitung > 1
					SET @out_keterangan = 'Kode Duplikasi'
				ELSE				
				BEGIN	
					INSERT INTO msHubKel (
								/* 1*/ namaHubKel,
								/* 2*/ catatan,
								/* 3*/ dibuatoleh
					) VALUES ( 				
								/* 1*/ @in_nama_HubKel,			  									  
								/* 2*/ @in_new_note,					  
								/* 3*/ @in_user
					);												
					SET @action_type = 'NEW';					
				END
			END
		END
------------------------------------------------------------------- New HubKel
	ELSE IF @in_Tindakan='EDIT'
		BEGIN	
			SET @in_new_note_update = @in_new_note + CHAR(10) + '--------------------' + CHAR(10) + CHAR(10)
										+dbo.fnAmbilCatatanHubKel(@in_id);	
			IF @in_note = ''
				BEGIN
					UPDATE msHubKel SET
								/* 1*/ namaHubKel 			= @in_nama_HubKel,
								/* 2*/ dieditoleh 			= @in_user,
								/* 3*/ waktuedit	 		= CURRENT_TIMESTAMP
					WHERE id = @in_id;													
				END
			ELSE
				BEGIN
					UPDATE msHubKel SET
								/* 1*/ namaHubKel			= @in_nama_HubKel,
								/* 2*/ catatan 				= @in_new_note_update,
								/* 3*/ dieditoleh 			= @in_user,
								/* 4*/ waktuedit	 		= CURRENT_TIMESTAMP
					WHERE id = @in_id;					
					SET @action_desc =	@action_desc + CHAR(10) +
										'NOTE : ' + @in_new_note + CHAR(10);
				END
			SET @action_type = 'UPDATE';
		END		
------------------------------------------------------------------- Edit HubKel
	ELSE IF @in_Tindakan='DEL'
		BEGIN
			UPDATE msHubKel SET
						/* 1*/ status 			= 0,
						/* 2*/ dieditoleh 		= @in_user,
						/* 3*/ waktuedit	 	= CURRENT_TIMESTAMP
			WHERE id = @in_id;
			SET @action_type = 'DELETE';
		END
------------------------------------------------------------------- Delete HubKel
	
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