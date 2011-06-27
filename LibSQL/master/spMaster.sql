-- RANCANGAN STORE PROCEDURE--
----------------------------------------------------------
-- Create by : Ivhan FG
-- Date : April 2011
-- Database : SQL Server
-- Penulisan : Indonesia
----------------------------------------------------------
USE [SIRS]
GO
----------------------------------------------------------
-- komposisi penamaan SP -= Untuk Insert, Update, Delete Master Database =-
----------------------------------------------------------
-- contoh : spCoa
-- 1. sp = store procedure  
-- 2. nama object (
----------------------------------------------------------

--#######################################################################-- spInsMsHistory -- 4

IF Objectproperty(Object_Id('spInsMsHistory'), N'isprocedure') = 1
DROP PROCEDURE spInsMsHistory
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE spInsMsHistory (
	/* 1*/ @in_tipeForm					VARCHAR(100),
	/* 2*/ @in_tipeTindakan				VARCHAR(100),
	/* 3*/ @in_deskripsiTindakan		VARCHAR(1000),
	/* 4*/ @in_idpengguna				INT
)
AS
BEGIN
	INSERT INTO mshistory (
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

--############################################################################# spMsDiet -- 8


IF Objectproperty(Object_Id('spMsDiet'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[spMsDiet]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE spMsDiet (
	/* 1*/ @in_tindakan					VARCHAR(4)
	/* 2*/ , @in_id		 				INT
	/* 3*/ , @in_kodeDiet 				VARCHAR(20)
	/* 4*/ , @in_namaDiet				VARCHAR(100)
	/* 5*/ , @in_catatan					VARCHAR(4000)
	/* 6*/ , @in_idPengguna				INT
	/* 7*/ , @out_str					VARCHAR(500) OUTPUT
	/* 8*/ , @out_desc					VARCHAR(500) OUTPUT 
)
AS
	DECLARE 	
		@in_catatanBaru					VARCHAR(5000)
		, @in_catatanTerbaru				VARCHAR(5000)
		, @tipeForm 						VARCHAR(100)
		, @tipeTindakan					VARCHAR(100)
		, @deskripsiTindakan				VARCHAR(1000)
		, @jumlah							INT
	;
BEGIN
	SET @tipeForm 					= 	'DIET';
	SET @deskripsiTindakan 		=	'KODE DIET : ' + @in_kodeDiet + CHAR(10) +
											'NAMA DIET : ' + @in_namaDiet + CHAR(10);
	SET @in_catatanBaru 			= 	'DIBUAT    : ' +  dbo.fnAmbilNamaLengkap(@in_idPengguna) + ' , TANGGAL : ' +
											CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + 
											@in_catatan + CHAR(10);
	
	IF @in_tindakan='NEW'
	---------------------------------------------------------------- New MsDiet
		BEGIN	
			SET @tipeTindakan = 'NEW';	
			/* Cek data sudah Ada */
				-- SET @jumlah = (SELECT COUNT(kodeDiet) from MsDiet where status = 1 and KodeDiet = @in_kodeDiet group by kodeDiet);
				-- IF @jumlah > 1
				-- 	SET @out_desc = 'Kode Duplikasi'
				-- ELSE				
			BEGIN	
				INSERT INTO msdiet (
							/* 1*/ kodeDiet
							/* 2*/ , namaDiet
							/* 3*/ , catatan
							/* 4*/ , dibuatoleh
				) VALUES (
							/* 1*/ @in_kodeDiet 				
							/* 2*/ , @in_namaDiet			  									  
							/* 3*/ , @in_catatanBaru				  
							/* 4*/ , @in_idPengguna
				);																
			END
		END
		
	ELSE IF @in_tindakan='EDIT'
	---------------------------------------------------------------- Update Diet
		BEGIN
			SET @tipeTindakan = 'UPDATE';	
			SET @in_catatanTerbaru = 	@in_catatanBaru + CHAR(10) + '--------------------' + CHAR(10) + CHAR(10)
												+dbo.fnAmbilCatatanDiet(@in_id);	
			IF @in_catatan = ''
				BEGIN
					UPDATE msdiet SET
								/* 1*/ kodediet 			= @in_kodeDiet
								/* 2*/ , namadiet 		= @in_namaDiet
								/* 3*/ , dieditoleh 		= @in_idPengguna
								/* 4*/ , waktuedit	 	= CURRENT_TIMESTAMP
					WHERE id = @in_id;													
				END
			ELSE
				BEGIN
					UPDATE msdiet SET
								/* 1*/ kodediet 			= @in_kodeDiet
								/* 2*/ , namadiet 		= @in_namaDiet
								/* 3*/ , catatan 			= @in_catatanTerbaru
								/* 4*/ , dieditoleh 		= @in_idPengguna
								/* 5*/ , waktuedit	 	= CURRENT_TIMESTAMP
					WHERE id = @in_id;					
					SET @deskripsiTindakan =	@deskripsiTindakan + CHAR(10) +
														'CATATAN : ' + @in_catatanTerbaru + CHAR(10);
				END
		END
	
	ELSE IF @in_Tindakan='DEL'
	------------------------------------------------------------------ Delete Diet
		BEGIN
			SET @tipeTindakan = 'DELETE'; 
			UPDATE msDiet SET
						/* 1*/ status 				= 0
						/* 2*/ , dieditoleh 		= @in_idPengguna
						/* 3*/ , waktuedit	 	= CURRENT_TIMESTAMP
			WHERE id = @in_id;		
		END
	
	------------------------------------------------------------------ Insert History Diet
	EXEC spInsMsHistory 	
		/* 1*/ @tipeForm
		/* 2*/ , @tipeTindakan
		/* 3*/ , @deskripsiTindakan
		/* 4*/ , @in_idpengguna					  
END
GO


--############################################################################# spMsMakanan -- 8

IF Objectproperty(Object_Id('spMsMakanan'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[spMsMakanan]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE spMsMakanan (
	/* 1*/ @in_tindakan					VARCHAR(4)
	/* 2*/ , @in_id		 				INT
	/* 3*/ , @in_namaMakanan			VARCHAR(100)
	/* 4*/ , @in_catatan					VARCHAR(4000)
	/* 5*/ , @in_idPengguna				INT
	/* 7*/ , @out_str					VARCHAR(500) OUTPUT
	/* 8*/ , @out_desc					VARCHAR(500) OUTPUT	
)
AS
	DECLARE 	
		@in_catatanBaru					VARCHAR(5000)
		, @in_catatanTerbaru				VARCHAR(5000)
		, @tipeForm 						VARCHAR(100)
		, @tipeTindakan					VARCHAR(100)
		, @deskripsiTindakan				VARCHAR(1000)
		, @jumlah							INT
	;
BEGIN
	SET @tipeForm 					=	'MsMakanan';
	SET @deskripsiTindakan 		=	'NAMA MAKANAN : ' + @in_namaMakanan + CHAR(10);
	SET @in_catatanBaru 			= 	'DIBUAT : ' +  dbo.fnAmbilNamaLengkap(@in_idPengguna) + ' , TANGGAL : ' +
											CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_catatan + CHAR(10);
	
	IF @in_tindakan='NEW'
	------------------------------------------------------------------- New Makanan
		BEGIN	
			SET @tipeTindakan = 'NEW';	
			/* Cek data sudah Ada */
			-- SET @jumlah = (SELECT COUNT(NamaMakanan) from MsMakanan where Status = 1 and NamaMakanan = @in_nama_makanan group by namamakanan);
			-- IF @jumlah > 1
			-- 	SET @out_str = 'Kode Duplikasi'
			-- ELSE				
			BEGIN	
				INSERT INTO msMakanan (
							/* 1*/ namaMakanan
							/* 2*/ , catatan
							/* 3*/ , dibuatoleh
				) VALUES ( 				
							/* 1*/ @in_namaMakanan			  									  
							/* 2*/ , @in_catatanBaru					  
							/* 3*/ , @in_idPengguna
				);																
			END
		END

	ELSE IF @in_tindakan='EDIT'
	------------------------------------------------------------------- Edit Makanan
		BEGIN
			SET @tipeTindakan = 'UPDATE';	
			SET @in_catatanTerbaru = 	@in_catatanBaru + CHAR(10) + '--------------------' + CHAR(10) + CHAR(10)
												+ dbo.fnAmbilCatatanMakanan(@in_id);	
			IF @in_catatan = ''
				BEGIN
					UPDATE msMakanan SET
								/* 1*/ namaMakanan 			= @in_namaMakanan
								/* 2*/ , dieditoleh 			= @in_idPengguna
								/* 3*/ , waktuedit	 		= CURRENT_TIMESTAMP
					WHERE id = @in_id;													
				END
			ELSE
				BEGIN
					UPDATE msMakanan SET
								/* 1*/ namamakanan 			= @in_namaMakanan
								/* 2*/ , catatan 				= @in_catatanTerbaru
								/* 3*/ , dieditoleh 			= @in_idPengguna
								/* 4*/ , waktuedit	 		= CURRENT_TIMESTAMP
					WHERE id = @in_id;					
					SET @deskripsiTindakan =	@deskripsiTindakan + CHAR(10) +
														'CATATAN : ' + @in_catatanTerbaru + CHAR(10);
				END
		END		
	
	ELSE IF @in_tindakan='DELETE'
	------------------------------------------------------------------- Delete makanan
		BEGIN
			SET @tipeTindakan = 'DELETE';
			UPDATE msMakanan SET
						/* 1*/ status 			= 0
						/* 2*/ , dieditoleh 	= @in_idPengguna
						/* 3*/ , waktuedit	 	= CURRENT_TIMESTAMP
			WHERE id = @in_id;
		END
	
	------------------------------------------------------------------ Insert History Makanan
	EXEC spInsMsHistory 	
		/* 1*/ @tipeForm
		/* 2*/ , @tipeTindakan
		/* 3*/ , @deskripsiTindakan
		/* 4*/ , @in_idpengguna			
							  
END
GO


--############################################################################# spMsAgama  -- 8

IF Objectproperty(Object_Id('spMsAgama'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[spMsAgama]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE spMsAgama (
	/* 1*/ @in_tindakan					VARCHAR(4)
	/* 2*/ , @in_id		 				INT
	/* 3*/ , @in_namaAgama				VARCHAR(100)
	/* 4*/ , @in_catatan					VARCHAR(4000)
	/* 5*/ , @in_idPengguna				INT
	/* 7*/ , @out_str						VARCHAR(500) OUTPUT
	/* 8*/ , @out_desc					VARCHAR(500) OUTPUT	
)
AS
	DECLARE 	
		@in_catatanBaru					VARCHAR(5000)
		, @in_catatanTerbaru				VARCHAR(5000)
		, @tipeForm 						VARCHAR(100)
		, @tipeTindakan					VARCHAR(100)
		, @deskripsiTindakan				VARCHAR(1000)
		, @jumlah							INT
	;
BEGIN
	SET @tipeForm 					=	'MsAgama';
	SET @deskripsiTindakan 		=	'NAMA AGAMA : ' + @in_namaAgama + CHAR(10);
	SET @in_catatanBaru 			= 	'DIBUAT : ' +  dbo.fnAmbilNamaLengkap(@in_idPengguna) + ' , TANGGAL : ' +
											CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_catatan + CHAR(10);
	
	IF @in_tindakan='NEW'
	------------------------------------------------------------------- New Agama
		BEGIN	
			SET @tipeTindakan = 'NEW';	
			/* Cek data sudah Ada */
			-- SET @jumlah = (SELECT COUNT(NamaMakanan) from MsMakanan where Status = 1 and NamaMakanan = @in_nama_makanan group by namamakanan);
			-- IF @jumlah > 1
			-- 	SET @out_str = 'Kode Duplikasi'
			-- ELSE				
			BEGIN	
				INSERT INTO msAgama (
							/* 1*/ namaAgama,
							/* 2*/ catatan,
							/* 3*/ dibuatoleh
				) VALUES ( 				
							/* 1*/ UPPER(@in_namaAgama),			  									  
							/* 2*/ @in_catatanBaru,					  
							/* 3*/ @in_idPengguna
				);																
			END
		END

	ELSE IF @in_tindakan='EDIT'
	------------------------------------------------------------------- Edit Agama
		BEGIN	
			SET @tipeTindakan 		= 	'UPDATE'; 
			SET @in_catatanTerbaru 	= 	@in_catatanBaru + CHAR(10) + '--------------------' + CHAR(10) + CHAR(10)
												+	dbo.fnAmbilCatatanAgama(@in_id);	
			IF @in_catatan = ''
				BEGIN
					UPDATE msAgama SET
								/* 1*/ namaAgama 				= UPPER(@in_namaAgama)
								/* 2*/ , dieditoleh 			= @in_idPengguna
								/* 3*/ , waktuedit	 		= CURRENT_TIMESTAMP
					WHERE id = @in_id;													
				END
			ELSE
				BEGIN
					UPDATE msAgama SET
								/* 1*/ namaAgama 				= UPPER(@in_namaAgama)
								/* 2*/ , catatan 				= @in_catatanTerbaru
								/* 3*/ , dieditoleh 			= @in_idPengguna
								/* 4*/ , waktuedit	 		= CURRENT_TIMESTAMP
					WHERE id = @in_id;					
					SET @deskripsiTindakan =	@deskripsiTindakan + CHAR(10) +
														'CATATAN : ' + @in_catatanTerbaru + CHAR(10);
				END
		END		
	
	ELSE IF @in_tindakan='DEL'
	------------------------------------------------------------------- Delete Agama
		BEGIN
			SET @tipeTindakan = 'DELETE';	
			UPDATE msAgama SET
						/* 1*/ status 			= 0,
						/* 2*/ dieditoleh 	= @in_idPengguna,
						/* 3*/ waktuedit	 	= CURRENT_TIMESTAMP
			WHERE id = @in_id;
		END
	
	------------------------------------------------------------------ Insert History Agama
	EXEC spInsMsHistory 	
		/* 1*/ @tipeForm
		/* 2*/ , @tipeTindakan
		/* 3*/ , @deskripsiTindakan
		/* 4*/ , @in_idpengguna			
							  
END
GO


--############################################################################# spMsPendidikan -- 8

IF Objectproperty(Object_Id('spMsPendidikan'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[spMsPendidikan]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE spMsPendidikan (
	/* 1*/ @in_tindakan					VARCHAR(4)
	/* 2*/ , @in_id		 				INT
	/* 3*/ , @in_namaPendidikan		VARCHAR(100)
	/* 4*/ , @in_catatan					VARCHAR(4000)
	/* 5*/ , @in_idPengguna				INT
	/* 7*/ , @out_str						VARCHAR(500) OUTPUT
	/* 8*/ , @out_desc					VARCHAR(500) OUTPUT	
)
AS
	DECLARE 	
		@in_catatanBaru					VARCHAR(5000)
		, @in_catatanTerbaru				VARCHAR(5000)
		, @tipeForm 						VARCHAR(100)
		, @tipeTindakan					VARCHAR(100)
		, @deskripsiTindakan				VARCHAR(1000)
		, @jumlah							INT
	;
BEGIN
	SET @tipeForm 					=	'MsPendidikan';
	SET @deskripsiTindakan 		=	'NAMA PENDIDIKAN : ' + @in_namaPendidikan + CHAR(10);
	SET @in_catatanBaru 			= 	'DIBUAT : ' +  dbo.fnAmbilNamaLengkap(@in_idPengguna) + ' , TANGGAL : ' +
											CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_catatan + CHAR(10);
	
	IF @in_tindakan='NEW'
	------------------------------------------------------------------- New Agama
		BEGIN	
			SET @tipeTindakan = 'NEW';	
			/* Cek data sudah Ada */
			-- SET @jumlah = (SELECT COUNT(NamaMakanan) from MsMakanan where Status = 1 and NamaMakanan = @in_nama_makanan group by namamakanan);
			-- IF @jumlah > 1
			-- 	SET @out_str = 'Kode Duplikasi'
			-- ELSE				
			BEGIN	
				INSERT INTO msPendidikan (
							/* 1*/ namaPendidikan,
							/* 2*/ catatan,
							/* 3*/ dibuatoleh
				) VALUES ( 				
							/* 1*/ UPPER(@in_namaPendidikan),			  									  
							/* 2*/ @in_catatanBaru,					  
							/* 3*/ @in_idPengguna
				);																
			END
		END

	ELSE IF @in_tindakan='EDIT'
	------------------------------------------------------------------- Edit Pendidikan
		BEGIN	
			SET @tipeTindakan 		= 	'UPDATE'; 
			SET @in_catatanTerbaru 	= 	@in_catatanBaru + CHAR(10) + '--------------------' + CHAR(10) + CHAR(10)
												+	dbo.fnAmbilCatatanPendidikan(@in_id);	
			IF @in_catatan = ''
				BEGIN
					UPDATE msPendidikan SET
								/* 1*/ namaPendidikan 		= UPPER(@in_namaPendidikan)
								/* 2*/ , dieditoleh 			= @in_idPengguna
								/* 3*/ , waktuedit	 		= CURRENT_TIMESTAMP
					WHERE id = @in_id;													
				END
			ELSE
				BEGIN
					UPDATE msPendidikan SET
								/* 1*/ namaPendidikan 		= UPPER(@in_namaPendidikan)
								/* 2*/ , catatan 				= @in_catatanTerbaru
								/* 3*/ , dieditoleh 			= @in_idPengguna
								/* 4*/ , waktuedit	 		= CURRENT_TIMESTAMP
					WHERE id = @in_id;					
					SET @deskripsiTindakan =	@deskripsiTindakan + CHAR(10) +
														'CATATAN : ' + @in_catatanTerbaru + CHAR(10);
				END
		END		
	
	ELSE IF @in_tindakan='DEL'
	------------------------------------------------------------------- Delete Pendidikan
		BEGIN
			SET @tipeTindakan = 'DELETE';	
			UPDATE msPendidikan SET
						/* 1*/ status 			= 0,
						/* 2*/ dieditoleh 	= @in_idPengguna,
						/* 3*/ waktuedit	 	= CURRENT_TIMESTAMP
			WHERE id = @in_id;
		END
	
	------------------------------------------------------------------ Insert History Pendidikan
	EXEC spInsMsHistory 	
		/* 1*/ @tipeForm
		/* 2*/ , @tipeTindakan
		/* 3*/ , @deskripsiTindakan
		/* 4*/ , @in_idpengguna			
							  
END
GO

--############################################################################# spMsPropinsi -- 8

IF Objectproperty(Object_Id('spMsPropinsi'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[spMsPropinsi]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE spMsPropinsi (
	/* 1*/ @in_tindakan					VARCHAR(4)
	/* 2*/ , @in_id		 				INT
	/* 3*/ , @in_namaPropinsi			VARCHAR(100)
	/* 4*/ , @in_catatan					VARCHAR(4000)
	/* 5*/ , @in_idPengguna				INT
	/* 7*/ , @out_str						VARCHAR(500) OUTPUT
	/* 8*/ , @out_desc					VARCHAR(500) OUTPUT	
)
AS
	DECLARE 	
		@in_catatanBaru					VARCHAR(5000)
		, @in_catatanTerbaru				VARCHAR(5000)
		, @tipeForm 						VARCHAR(100)
		, @tipeTindakan					VARCHAR(100)
		, @deskripsiTindakan				VARCHAR(1000)
		, @jumlah							INT
	;
BEGIN
	SET @tipeForm 					=	'MsPropinsi';
	SET @deskripsiTindakan 		=	'NAMA PROPINSI : ' + @in_namaPropinsi + CHAR(10);
	SET @in_catatanBaru 			= 	'DIBUAT : ' +  dbo.fnAmbilNamaLengkap(@in_idPengguna) + ' , TANGGAL : ' +
											CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_catatan + CHAR(10);
	
	IF @in_tindakan='NEW'
	------------------------------------------------------------------- New Propinsi
		BEGIN	
			SET @tipeTindakan = 'NEW';	
			/* Cek data sudah Ada */
			-- SET @jumlah = (SELECT COUNT(namaPropinsi) from MsPropinsi where Status = 1 and NamaPropinsi = @in_namaPropinsi group by namaPropinsi);
			-- IF @jumlah > 1
			-- 	SET @out_str = 'Kode Duplikasi'
			-- ELSE				
			BEGIN	
				INSERT INTO msPropinsi (
							/* 1*/ namaPropinsi,
							/* 2*/ catatan,
							/* 3*/ dibuatoleh
				) VALUES ( 				
							/* 1*/ UPPER(@in_namaPropinsi),			  									  
							/* 2*/ @in_catatanBaru,					  
							/* 3*/ @in_idPengguna
				);																
			END
		END

	ELSE IF @in_tindakan='EDIT'
	------------------------------------------------------------------- Edit Propinsi
		BEGIN	
			SET @tipeTindakan 		= 	'UPDATE'; 
			SET @in_catatanTerbaru 	= 	@in_catatanBaru + CHAR(10) + '--------------------' + CHAR(10) + CHAR(10)
												+	dbo.fnAmbilCatatanPropinsi(@in_id);	
			IF @in_catatan = ''
				BEGIN
					UPDATE msPropinsi SET
								/* 1*/ namaPropinsi 			= UPPER(@in_namaPropinsi)
								/* 2*/ , dieditoleh 			= @in_idPengguna
								/* 3*/ , waktuedit	 		= CURRENT_TIMESTAMP
					WHERE id = @in_id;													
				END
			ELSE
				BEGIN
					UPDATE msPropinsi SET
								/* 1*/ namaPropinsi 			= UPPER(@in_namaPropinsi)
								/* 2*/ , catatan 				= @in_catatanTerbaru
								/* 3*/ , dieditoleh 			= @in_idPengguna
								/* 4*/ , waktuedit	 		= CURRENT_TIMESTAMP
					WHERE id = @in_id;					
					SET @deskripsiTindakan =	@deskripsiTindakan + CHAR(10) +
														'CATATAN : ' + @in_catatanTerbaru + CHAR(10);
				END
		END		
	
	ELSE IF @in_tindakan='DEL'
	------------------------------------------------------------------- Delete Propinsi
		BEGIN
			SET @tipeTindakan = 'DELETE';	
			UPDATE msPropinsi SET
						/* 1*/ status 			= 0,
						/* 2*/ dieditoleh 	= @in_idPengguna,
						/* 3*/ waktuedit	 	= CURRENT_TIMESTAMP
			WHERE id = @in_id;
		END
	
	------------------------------------------------------------------ Insert History Propinsi
	EXEC spInsMsHistory 	
		/* 1*/ @tipeForm
		/* 2*/ , @tipeTindakan
		/* 3*/ , @deskripsiTindakan
		/* 4*/ , @in_idpengguna			
							  
END
GO

--############################################################################# spMsKabupaten -- 8

IF Objectproperty(Object_Id('spMsKabupaten'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[spMsKabupaten]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE spMsKabupaten (
	/* 1*/ @in_tindakan					VARCHAR(4)
	/* 2*/ , @in_id		 				INT
	/* 3*/ , @in_namaKabupaten			VARCHAR(100)
	/* 4*/ , @in_catatan					VARCHAR(4000)
	/* 5*/ , @in_idPengguna				INT
	/* 7*/ , @out_str						VARCHAR(500) OUTPUT
	/* 8*/ , @out_desc					VARCHAR(500) OUTPUT	
)
AS
	DECLARE 	
		@in_catatanBaru					VARCHAR(5000)
		, @in_catatanTerbaru				VARCHAR(5000)
		, @tipeForm 						VARCHAR(100)
		, @tipeTindakan					VARCHAR(100)
		, @deskripsiTindakan				VARCHAR(1000)
		, @jumlah							INT
	;
BEGIN
	SET @tipeForm 					=	'MsKabupaten';
	SET @deskripsiTindakan 		=	'NAMA KABUPATEN : ' + @in_namaKabupaten + CHAR(10);
	SET @in_catatanBaru 			= 	'DIBUAT : ' +  dbo.fnAmbilNamaLengkap(@in_idPengguna) + ' , TANGGAL : ' +
											CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_catatan + CHAR(10);
	
	IF @in_tindakan='NEW'
	------------------------------------------------------------------- New Kabupaten
		BEGIN	
			SET @tipeTindakan = 'NEW';	
			/* Cek data sudah Ada */
			-- SET @jumlah = (SELECT COUNT(namaKabupaten) from MsKabupaten where Status = 1 and NamaKabupaten = @in_namaKabupaten group by namaKabupaten);
			-- IF @jumlah > 1
			-- 	SET @out_str = 'Kode Duplikasi'
			-- ELSE				
			BEGIN	
				INSERT INTO msKabupaten (
							/* 1*/ namaKabupaten,
							/* 2*/ catatan,
							/* 3*/ dibuatoleh
				) VALUES ( 				
							/* 1*/ UPPER(@in_namaKabupaten),			  									  
							/* 2*/ @in_catatanBaru,					  
							/* 3*/ @in_idPengguna
				);																
			END
		END

	ELSE IF @in_tindakan='EDIT'
	------------------------------------------------------------------- Edit Kabupaten
		BEGIN	
			SET @tipeTindakan 		= 	'UPDATE'; 
			SET @in_catatanTerbaru 	= 	@in_catatanBaru + CHAR(10) + '--------------------' + CHAR(10) + CHAR(10)
												+	dbo.fnAmbilCatatanKabupaten(@in_id);	
			IF @in_catatan = ''
				BEGIN
					UPDATE msKabupaten SET
								/* 1*/ namaKabupaten 		= UPPER(@in_namaKabupaten)
								/* 2*/ , dieditoleh 			= @in_idPengguna
								/* 3*/ , waktuedit	 		= CURRENT_TIMESTAMP
					WHERE id = @in_id;													
				END
			ELSE
				BEGIN
					UPDATE msKabupaten SET
								/* 1*/ namaKabupaten 		= UPPER(@in_namaKabupaten)
								/* 2*/ , catatan 				= @in_catatanTerbaru
								/* 3*/ , dieditoleh 			= @in_idPengguna
								/* 4*/ , waktuedit	 		= CURRENT_TIMESTAMP
					WHERE id = @in_id;					
					SET @deskripsiTindakan =	@deskripsiTindakan + CHAR(10) +
														'CATATAN : ' + @in_catatanTerbaru + CHAR(10);
				END
		END		
	
	ELSE IF @in_tindakan='DEL'
	------------------------------------------------------------------- Delete Kabupaten
		BEGIN
			SET @tipeTindakan = 'DELETE';	
			UPDATE msKabupaten SET
						/* 1*/ status 			= 0,
						/* 2*/ dieditoleh 	= @in_idPengguna,
						/* 3*/ waktuedit	 	= CURRENT_TIMESTAMP
			WHERE id = @in_id;
		END
	
	------------------------------------------------------------------ Insert History Kabupaten
	EXEC spInsMsHistory 	
		/* 1*/ @tipeForm
		/* 2*/ , @tipeTindakan
		/* 3*/ , @deskripsiTindakan
		/* 4*/ , @in_idpengguna			
							  
END
GO

--############################################################################# spMsPekerjaan -- 8

IF Objectproperty(Object_Id('spMsPekerjaan'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[spMsPekerjaan]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE spMsPekerjaan (
	/* 1*/ @in_tindakan					VARCHAR(4)
	/* 2*/ , @in_id		 				INT
	/* 3*/ , @in_namaPekerjaan			VARCHAR(100)
	/* 4*/ , @in_catatan					VARCHAR(4000)
	/* 5*/ , @in_idPengguna				INT
	/* 7*/ , @out_str						VARCHAR(500) OUTPUT
	/* 8*/ , @out_desc					VARCHAR(500) OUTPUT	
)
AS
	DECLARE 	
		@in_catatanBaru					VARCHAR(5000)
		, @in_catatanTerbaru				VARCHAR(5000)
		, @tipeForm 						VARCHAR(100)
		, @tipeTindakan					VARCHAR(100)
		, @deskripsiTindakan				VARCHAR(1000)
		, @jumlah							INT
	;
BEGIN
	SET @tipeForm 					=	'msPekerjaan';
	SET @deskripsiTindakan 		=	'NAMA Pekerjaan : ' + @in_namaPekerjaan + CHAR(10);
	SET @in_catatanBaru 			= 	'DIBUAT : ' +  dbo.fnAmbilNamaLengkap(@in_idPengguna) + ' , TANGGAL : ' +
											CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_catatan + CHAR(10);
	
	IF @in_tindakan='NEW'
	------------------------------------------------------------------- New Pekerjaan
		BEGIN	
			SET @tipeTindakan = 'NEW';	
			/* Cek data sudah Ada */
			-- SET @jumlah = (SELECT COUNT(namaPekerjaan) from MsPekerjaan where Status = 1 and NamaPekerjaan = @in_namaPekerjaan group by namaPekerjaan);
			-- IF @jumlah > 1
			-- 	SET @out_str = 'Kode Duplikasi'
			-- ELSE				
			BEGIN	
				INSERT INTO msPekerjaan (
							/* 1*/ namaPekerjaan,
							/* 2*/ catatan,
							/* 3*/ dibuatoleh
				) VALUES ( 				
							/* 1*/ UPPER(@in_namaPekerjaan),			  									  
							/* 2*/ @in_catatanBaru,					  
							/* 3*/ @in_idPengguna
				);																
			END
		END

	ELSE IF @in_tindakan='EDIT'
	------------------------------------------------------------------- Edit Pekerjaan
		BEGIN	
			SET @tipeTindakan 		= 	'UPDATE'; 
			SET @in_catatanTerbaru 	= 	@in_catatanBaru + CHAR(10) + '--------------------' + CHAR(10) + CHAR(10)
												+	dbo.fnAmbilCatatanPekerjaan(@in_id);	
			IF @in_catatan = ''
				BEGIN
					UPDATE msPekerjaan SET
								/* 1*/ namaPekerjaan 		= UPPER(@in_namaPekerjaan)
								/* 2*/ , dieditoleh 			= @in_idPengguna
								/* 3*/ , waktuedit	 		= CURRENT_TIMESTAMP
					WHERE id = @in_id;													
				END
			ELSE
				BEGIN
					UPDATE msPekerjaan SET
								/* 1*/ namaPekerjaan 		= UPPER(@in_namaPekerjaan)
								/* 2*/ , catatan 				= @in_catatanTerbaru
								/* 3*/ , dieditoleh 			= @in_idPengguna
								/* 4*/ , waktuedit	 		= CURRENT_TIMESTAMP
					WHERE id = @in_id;					
					SET @deskripsiTindakan =	@deskripsiTindakan + CHAR(10) +
														'CATATAN : ' + @in_catatanTerbaru + CHAR(10);
				END
		END		
	
	ELSE IF @in_tindakan='DEL'
	------------------------------------------------------------------- Delete Pekerjaan
		BEGIN
			SET @tipeTindakan = 'DELETE';	
			UPDATE msPekerjaan SET
						/* 1*/ status 			= 0,
						/* 2*/ dieditoleh 	= @in_idPengguna,
						/* 3*/ waktuedit	 	= CURRENT_TIMESTAMP
			WHERE id = @in_id;
		END
	
	------------------------------------------------------------------ Insert History Pekerjaan
	EXEC spInsMsHistory 	
		/* 1*/ @tipeForm
		/* 2*/ , @tipeTindakan
		/* 3*/ , @deskripsiTindakan
		/* 4*/ , @in_idpengguna			
							  
END
GO

--############################################################################# spMsKecamatan -- 8

IF Objectproperty(Object_Id('spMsKecamatan'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[spMsKecamatan]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE spMsKecamatan (
	/* 1*/ @in_tindakan					VARCHAR(4)
	/* 2*/ , @in_id		 				INT
	/* 3*/ , @in_namaKecamatan			VARCHAR(100)
	/* 4*/ , @in_catatan					VARCHAR(4000)
	/* 5*/ , @in_idPengguna				INT
	/* 7*/ , @out_str						VARCHAR(500) OUTPUT
	/* 8*/ , @out_desc					VARCHAR(500) OUTPUT	
)
AS
	DECLARE 	
		@in_catatanBaru					VARCHAR(5000)
		, @in_catatanTerbaru				VARCHAR(5000)
		, @tipeForm 						VARCHAR(100)
		, @tipeTindakan					VARCHAR(100)
		, @deskripsiTindakan				VARCHAR(1000)
		, @jumlah							INT
	;
BEGIN
	SET @tipeForm 					=	'MsKecamatan';
	SET @deskripsiTindakan 		=	'NAMA KECAMATAN : ' + @in_namaKecamatan + CHAR(10);
	SET @in_catatanBaru 			= 	'DIBUAT : ' +  dbo.fnAmbilNamaLengkap(@in_idPengguna) + ' , TANGGAL : ' +
											CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_catatan + CHAR(10);
	
	IF @in_tindakan='NEW'
	------------------------------------------------------------------- New Kecamatan
		BEGIN	
			SET @tipeTindakan = 'NEW';	
			/* Cek data sudah Ada */
			-- SET @jumlah = (SELECT COUNT(namaKecamatan) from MsKecamatan where Status = 1 and NamaKecamatan = @in_namaKecamatan group by namaKecamatan);
			-- IF @jumlah > 1
			-- 	SET @out_str = 'Kode Duplikasi'
			-- ELSE				
			BEGIN	
				INSERT INTO msKecamatan (
							/* 1*/ namaKecamatan,
							/* 2*/ catatan,
							/* 3*/ dibuatoleh
				) VALUES ( 				
							/* 1*/ UPPER(@in_namaKecamatan),			  									  
							/* 2*/ @in_catatanBaru,					  
							/* 3*/ @in_idPengguna
				);																
			END
		END

	ELSE IF @in_tindakan='EDIT'
	------------------------------------------------------------------- Edit Kecamatan
		BEGIN	
			SET @tipeTindakan 		= 	'UPDATE'; 
			SET @in_catatanTerbaru 	= 	@in_catatanBaru + CHAR(10) + '--------------------' + CHAR(10) + CHAR(10)
												+	dbo.fnAmbilCatatanKecamatan(@in_id);	
			IF @in_catatan = ''
				BEGIN
					UPDATE msKecamatan SET
								/* 1*/ namaKecamatan 		= UPPER(@in_namaKecamatan)
								/* 2*/ , dieditoleh 			= @in_idPengguna
								/* 3*/ , waktuedit	 		= CURRENT_TIMESTAMP
					WHERE id = @in_id;													
				END
			ELSE
				BEGIN
					UPDATE msKecamatan SET
								/* 1*/ namaKecamatan 		= UPPER(@in_namaKecamatan)
								/* 2*/ , catatan 				= @in_catatanTerbaru
								/* 3*/ , dieditoleh 			= @in_idPengguna
								/* 4*/ , waktuedit	 		= CURRENT_TIMESTAMP
					WHERE id = @in_id;					
					SET @deskripsiTindakan =	@deskripsiTindakan + CHAR(10) +
														'CATATAN : ' + @in_catatanTerbaru + CHAR(10);
				END
		END		
	
	ELSE IF @in_tindakan = 'DEL'
	------------------------------------------------------------------- Delete Kecamatan
		BEGIN
			SET @tipeTindakan = 'DELETE';
			UPDATE msKecamatan SET
				/* 1*/ status 				= 	0
				/* 2*/ , dieditoleh 		= 	@in_idPengguna
				/* 3*/ , waktuedit	 	= 	CURRENT_TIMESTAMP
			WHERE id = @in_id;
			
		END
	
	------------------------------------------------------------------ Insert History Kecamatan
	EXEC spInsMsHistory 	
		/* 1*/ @tipeForm
		/* 2*/ , @tipeTindakan
		/* 3*/ , @deskripsiTindakan
		/* 4*/ , @in_idpengguna			
							  
END
GO

--############################################################################# spMsKelurahan -- 8

IF Objectproperty(Object_Id('spMsKelurahan'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[spMsKelurahan]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE spMsKelurahan (
	/* 1*/ @in_tindakan					VARCHAR(4)
	/* 2*/ , @in_id		 				INT
	/* 3*/ , @in_namaKelurahan			VARCHAR(100)
	/* 4*/ , @in_catatan					VARCHAR(4000)
	/* 5*/ , @in_idPengguna				INT
	/* 7*/ , @out_str						VARCHAR(500) OUTPUT
	/* 8*/ , @out_desc					VARCHAR(500) OUTPUT	
)
AS
	DECLARE 	
		@in_catatanBaru					VARCHAR(5000)
		, @in_catatanTerbaru				VARCHAR(5000)
		, @tipeForm 						VARCHAR(100)
		, @tipeTindakan					VARCHAR(100)
		, @deskripsiTindakan				VARCHAR(1000)
		, @jumlah							INT
	;
BEGIN
	SET @tipeForm 					=	'MsKelurahan';
	SET @deskripsiTindakan 		=	'NAMA Kelurahan : ' + @in_namaKelurahan + CHAR(10);
	SET @in_catatanBaru 			= 	'DIBUAT : ' +  dbo.fnAmbilNamaLengkap(@in_idPengguna) + ' , TANGGAL : ' +
											CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_catatan + CHAR(10);
	
	IF @in_tindakan='NEW'
	------------------------------------------------------------------- New Kelurahan
		BEGIN	
			SET @tipeTindakan = 'NEW';	
			/* Cek data sudah Ada */
			-- SET @jumlah = (SELECT COUNT(namaKelurahan) from MsKelurahan where Status = 1 and NamaKelurahan = @in_namaKelurahan group by namaKelurahan);
			-- IF @jumlah > 1
			-- 	SET @out_str = 'Kode Duplikasi'
			-- ELSE				
			BEGIN	
				INSERT INTO msKelurahan (
							/* 1*/ namaKelurahan,
							/* 2*/ catatan,
							/* 3*/ dibuatoleh
				) VALUES ( 				
							/* 1*/ UPPER(@in_namaKelurahan),			  									  
							/* 2*/ @in_catatanBaru,					  
							/* 3*/ @in_idPengguna
				);																
			END
		END

	ELSE IF @in_tindakan='EDIT'
	------------------------------------------------------------------- Edit Kelurahan
		BEGIN	
			SET @tipeTindakan 		= 	'UPDATE'; 
			SET @in_catatanTerbaru 	= 	@in_catatanBaru + CHAR(10) + '--------------------' + CHAR(10) + CHAR(10)
												+	dbo.fnAmbilCatatanKelurahan(@in_id);	
			IF @in_catatan = ''
				BEGIN
					UPDATE msKelurahan SET
								/* 1*/ namaKelurahan 		= UPPER(@in_namaKelurahan)
								/* 2*/ , dieditoleh 			= @in_idPengguna
								/* 3*/ , waktuedit	 		= CURRENT_TIMESTAMP
					WHERE id = @in_id;													
				END
			ELSE
				BEGIN
					UPDATE msKelurahan SET
								/* 1*/ namaKelurahan 		= UPPER(@in_namaKelurahan)
								/* 2*/ , catatan 				= @in_catatanTerbaru
								/* 3*/ , dieditoleh 			= @in_idPengguna
								/* 4*/ , waktuedit	 		= CURRENT_TIMESTAMP
					WHERE id = @in_id;					
					SET @deskripsiTindakan =	@deskripsiTindakan + CHAR(10) +
														'CATATAN : ' + @in_catatanTerbaru + CHAR(10);
				END
		END		
	
	ELSE IF @in_tindakan='DEL'
	------------------------------------------------------------------- Delete Kelurahan
		BEGIN
			SET @tipeTindakan = 'DELETE';	
			UPDATE msKelurahan SET
						/* 1*/ status 			= 0,
						/* 2*/ dieditoleh 	= @in_idPengguna,
						/* 3*/ waktuedit	 	= CURRENT_TIMESTAMP
			WHERE id = @in_id;
		END
	
	------------------------------------------------------------------ Insert History Kelurahan
	EXEC spInsMsHistory 	
		/* 1*/ @tipeForm
		/* 2*/ , @tipeTindakan
		/* 3*/ , @deskripsiTindakan
		/* 4*/ , @in_idpengguna			
							  
END
GO

--############################################################################# spMsHubKel -- 8

IF Objectproperty(Object_Id('spMsHubKel'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[spMsHubKel]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE spMsHubKel (
	/* 1*/ @in_tindakan					VARCHAR(4)
	/* 2*/ , @in_id		 				INT
	/* 3*/ , @in_namaHubKel				VARCHAR(100)
	/* 4*/ , @in_catatan					VARCHAR(4000)
	/* 5*/ , @in_idPengguna				INT
	/* 7*/ , @out_str						VARCHAR(500) OUTPUT
	/* 8*/ , @out_desc					VARCHAR(500) OUTPUT	
)
AS
	DECLARE 	
		@in_catatanBaru					VARCHAR(5000)
		, @in_catatanTerbaru				VARCHAR(5000)
		, @tipeForm 						VARCHAR(100)
		, @tipeTindakan					VARCHAR(100)
		, @deskripsiTindakan				VARCHAR(1000)
		, @jumlah							INT
	;
BEGIN
	SET @tipeForm 					=	'MsHubKel';
	SET @deskripsiTindakan 		=	'HUBUNGAN KELUARGA : ' + @in_namaHubKel + CHAR(10);
	SET @in_catatanBaru 			= 	'DIBUAT : ' +  dbo.fnAmbilNamaLengkap(@in_idPengguna) + ' , TANGGAL : ' +
											CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_catatan + CHAR(10);
	
	IF @in_tindakan='NEW'
	------------------------------------------------------------------- New HubKel
		BEGIN	
			SET @tipeTindakan = 'NEW';	
			/* Cek data sudah Ada */
			-- SET @jumlah = (SELECT COUNT(namaHubKel) from MsHubKel where Status = 1 and NamaHubKel = @in_namaHubKel group by namaHubKel);
			-- IF @jumlah > 1
			-- 	SET @out_str = 'Kode Duplikasi'
			-- ELSE				
			BEGIN	
				INSERT INTO msHubKel (
							/* 1*/ namaHubKel,
							/* 2*/ catatan,
							/* 3*/ dibuatoleh
				) VALUES ( 				
							/* 1*/ UPPER(@in_namaHubKel),			  									  
							/* 2*/ @in_catatanBaru,					  
							/* 3*/ @in_idPengguna
				);																
			END
		END

	ELSE IF @in_tindakan='EDIT'
	------------------------------------------------------------------- Edit HubKel
		BEGIN	
			SET @tipeTindakan 		= 	'UPDATE'; 
			SET @in_catatanTerbaru 	= 	@in_catatanBaru + CHAR(10) + '--------------------' + CHAR(10) + CHAR(10)
												+	dbo.fnAmbilCatatanHubKel(@in_id);	
			IF @in_catatan = ''
				BEGIN
					UPDATE msHubKel SET
								/* 1*/ namaHubKel 			= UPPER(@in_namaHubKel)
								/* 2*/ , dieditoleh 			= @in_idPengguna
								/* 3*/ , waktuedit	 		= CURRENT_TIMESTAMP
					WHERE id = @in_id;													
				END
			ELSE
				BEGIN
					UPDATE msHubKel SET
								/* 1*/ namaHubKel 			= UPPER(@in_namaHubKel)
								/* 2*/ , catatan 				= @in_catatanTerbaru
								/* 3*/ , dieditoleh 			= @in_idPengguna
								/* 4*/ , waktuedit	 		= CURRENT_TIMESTAMP
					WHERE id = @in_id;					
					SET @deskripsiTindakan =	@deskripsiTindakan + CHAR(10) +
														'CATATAN : ' + @in_catatanTerbaru + CHAR(10);
				END
		END		
	
	ELSE IF @in_tindakan='DEL'
	------------------------------------------------------------------- Delete HubKel
		BEGIN
			SET @tipeTindakan = 'DELETE';	
			UPDATE msHubKel SET
						/* 1*/ status 			= 0,
						/* 2*/ dieditoleh 	= @in_idPengguna,
						/* 3*/ waktuedit	 	= CURRENT_TIMESTAMP
			WHERE id = @in_id;
		END
	
	------------------------------------------------------------------ Insert History HubKel
	EXEC spInsMsHistory 	
		/* 1*/ @tipeForm
		/* 2*/ , @tipeTindakan
		/* 3*/ , @deskripsiTindakan
		/* 4*/ , @in_idpengguna			
							  
END
GO

--####################################################################### spCOA -- 9

IF Objectproperty(Object_Id('spMsCoa'), N'isprocedure') = 1
DROP PROCEDURE spMsCoa
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE spMsCoa (
	/* 1*/ @in_tindakan				VARCHAR(4)
	/* 2*/ , @in_id		 			INT
	/* 3*/ , @in_kodecoa 			VARCHAR(20)
	/* 4*/ , @in_namacoa				VARCHAR(1000)
	/* 5*/ , @in_tipecoa				VARCHAR(100)
	/* 6*/ , @in_catatan				VARCHAR(4000)
	/* 7*/ , @in_idpengguna			INT
	/* 8*/ , @out_str					VARCHAR(500) OUTPUT
	/* 9*/ , @out_desc 				VARCHAR(500) OUTPUT	
	)
AS
	DECLARE 	
		@in_catatanBaru					VARCHAR(5000)
		, @in_catatanTerbaru				VARCHAR(5000)
		, @tipeForm 						VARCHAR(100)
		, @tipeTindakan					VARCHAR(100)
		, @deskripsiTindakan				VARCHAR(1000)
		, @jumlah							INT
	;
BEGIN
	SET @tipeForm 				= 	'msCOA';
	SET @deskripsiTindakan 	= 	'KODE COA : ' + @in_kodecoa + CHAR(10) +
										'NAMA COA : ' + @in_namacoa + CHAR(10) +
										'TIPE COA : ' + @in_tipecoa + CHAR(10);
	SET @in_catatanBaru 		=	'DIBUAT   : ' +  dbo.fnAmbilNamaLengkap(@in_idpengguna) + ' , TANGGAL : ' +
										CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + 
										@in_catatan + CHAR(10);
	--------------------------------------------------- New COA 
	IF @in_tindakan='NEW'
		BEGIN		
			/* Cek data sudah Ada */
			SET @jumlah = (SELECT COUNT(KodeCoa) FROM MsCoa where Status = 1 AND KodeCoa = @in_kodecoa GROUP BY kodecoa);
			
			IF @jumlah > 1
				BEGIN
					RETURN 'Kode Duplikasi';
				END
			ELSE
				BEGIN
					SET @tipeTindakan = 'NEW';
					INSERT INTO MsCoa (
								/* 1*/ kodeCoa
								/* 2*/ , namaCoa
								/* 3*/ , tipeCoa
								/* 4*/ , catatan
								/* 5*/ , dibuatOleh
								/* 6*/ , waktuBuat
					) VALUES (
								/* 1*/ @in_kodecoa				
								/* 2*/ , @in_namaCoa			  
								/* 3*/ , @in_tipeCoa									  
								/* 4*/ , @in_catatanBaru				  
								/* 5*/ , @in_idPengguna
								/* 6*/ , CURRENT_TIMESTAMP
					);
					--SET @out_str		= '';				
					--SET @out_desc	= '';
				END
		END
	---------------------------------------------------- Update COA
	ELSE IF @in_tindakan='EDIT'
		BEGIN
			SET @tipeTindakan = 'UPDATE';
			SET @deskripsiTindakan =	@deskripsiTindakan + CHAR(10) +
												'NOTE : ' + @in_catatanBaru + CHAR(10);
												
			SET @in_catatanTerbaru = @in_catatanBaru + CHAR(10) + '--------------------' + CHAR(10) + CHAR(10)
			+ dbo.fnAmbilCatatancoa(@in_id);

			IF @in_catatan = ''
				BEGIN
					UPDATE mscoa SET
								/* 1*/ kodeCoa 			= @in_kodeCoa
								/* 2*/ , namaCoa 			= @in_namaCoa
								/* 3*/ , tipeCoa 			= @in_tipeCoa
								/* 4*/ , dieditOleh  	= @in_idPengguna
								/* 5*/ , waktuEdit		= CURRENT_TIMESTAMP
					WHERE id = @in_id;
				END																					
			ELSE
				BEGIN
					UPDATE mscoa SET
								/* 1*/ kodecoa 			= @in_kodecoa
								/* 2*/ , namacoa 			= @in_namacoa
								/* 3*/ , tipecoa 			= @in_tipecoa
								/* 4*/ , catatan			= @in_catatanTerbaru
								/* 5*/ , dieditOleh  	= @in_idpengguna
								/* 6*/ , waktuEdit 		= CURRENT_TIMESTAMP
					WHERE id = @in_id;
				END
		END
	---------------------------------------------------- Delete COA
	ELSE IF @in_tindakan='DEL'
		BEGIN
			SET @tipeTindakan = 'DELETE';
			UPDATE mscoa SET
				/* 1*/ status 				= 0
				/* 2*/ , dieditOleh  	= @in_idPengguna
				/* 3*/ , waktuedit		= CURRENT_TIMESTAMP
			WHERE id = @in_id;
		END
	---------------------------------------------------- Insert History COA
	EXEC spInsMsHistory 	
		/* 1*/ @tipeForm
		/* 2*/ , @tipeTindakan
		/* 3*/ , @deskripsiTindakan
		/* 4*/ , @in_idpengguna

END
GO

--############################################################################# spMsKota -- 8

IF Objectproperty(Object_Id('spMsKota'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[spMsKota]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE spMsKota (
	/* 1*/ @in_tindakan					VARCHAR(4)
	/* 2*/ , @in_id		 				INT
	/* 3*/ , @in_namaKota				VARCHAR(100)
	/* 4*/ , @in_catatan					VARCHAR(4000)
	/* 5*/ , @in_idPengguna				INT
	/* 7*/ , @out_str						VARCHAR(500) OUTPUT
	/* 8*/ , @out_desc					VARCHAR(500) OUTPUT	
)
AS
	DECLARE 	
		@in_catatanBaru					VARCHAR(5000)
		, @in_catatanTerbaru				VARCHAR(5000)
		, @tipeForm 						VARCHAR(100)
		, @tipeTindakan					VARCHAR(100)
		, @deskripsiTindakan				VARCHAR(1000)
		, @jumlah							INT
	;
BEGIN
	SET @tipeForm 					=	'MsKota';
	SET @deskripsiTindakan 		=	'NAMA Kota : ' + @in_namaKota + CHAR(10);
	SET @in_catatanBaru 			= 	'DIBUAT : ' +  dbo.fnAmbilNamaLengkap(@in_idPengguna) + ' , TANGGAL : ' +
											CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_catatan + CHAR(10);
	
	IF @in_tindakan='NEW'
	------------------------------------------------------------------- New Kota
		BEGIN	
			SET @tipeTindakan = 'NEW';	
			/* Cek data sudah Ada */
			-- SET @jumlah = (SELECT COUNT(namaKota) from MsKota where Status = 1 and NamaKota = @in_namaKota group by namaKota);
			-- IF @jumlah > 1
			-- 	SET @out_str = 'Kode Duplikasi'
			-- ELSE				
			BEGIN	
				INSERT INTO msKota (
							/* 1*/ namaKota,
							/* 2*/ catatan,
							/* 3*/ dibuatoleh
				) VALUES ( 				
							/* 1*/ UPPER(@in_namaKota),			  									  
							/* 2*/ @in_catatanBaru,					  
							/* 3*/ @in_idPengguna
				);																
			END
		END

	ELSE IF @in_tindakan='EDIT'
	------------------------------------------------------------------- Edit Kota
		BEGIN	
			SET @tipeTindakan 		= 	'UPDATE'; 
			SET @in_catatanTerbaru 	= 	@in_catatanBaru + CHAR(10) + '--------------------' + CHAR(10) + CHAR(10)
												+	dbo.fnAmbilCatatanKota(@in_id);	
			IF @in_catatan = ''
				BEGIN
					UPDATE msKota SET
								/* 1*/ namaKota 				= UPPER(@in_namaKota)
								/* 2*/ , dieditoleh 			= @in_idPengguna
								/* 3*/ , waktuedit	 		= CURRENT_TIMESTAMP
					WHERE id = @in_id;													
				END
			ELSE
				BEGIN
					UPDATE msKota SET
								/* 1*/ namaKota 				= UPPER(@in_namaKota)
								/* 2*/ , catatan 				= @in_catatanTerbaru
								/* 3*/ , dieditoleh 			= @in_idPengguna
								/* 4*/ , waktuedit	 		= CURRENT_TIMESTAMP
					WHERE id = @in_id;					
					SET @deskripsiTindakan =	@deskripsiTindakan + CHAR(10) +
														'CATATAN : ' + @in_catatanTerbaru + CHAR(10);
				END
		END		
	
	ELSE IF @in_tindakan='DEL'
	------------------------------------------------------------------- Delete Kota
		BEGIN
			SET @tipeTindakan = 'DELETE';	
			UPDATE msKota SET
						/* 1*/ status 			= 0,
						/* 2*/ dieditoleh 	= @in_idPengguna,
						/* 3*/ waktuedit	 	= CURRENT_TIMESTAMP
			WHERE id = @in_id;
		END
	
	------------------------------------------------------------------ Insert History Kota
	EXEC spInsMsHistory 	
		/* 1*/ @tipeForm
		/* 2*/ , @tipeTindakan
		/* 3*/ , @deskripsiTindakan
		/* 4*/ , @in_idpengguna			
							  
END
GO

--############################################################################# spMsJenisPerusahaan

IF Objectproperty(Object_Id('spMsJenisPerusahaan'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[spMsJenisPerusahaan]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE spMsJenisPerusahaan (
	/* 1*/ @in_tindakan					VARCHAR(4)
	/* 2*/ , @in_id		 				INT
	/* 3*/ , @in_namaJenisPerusahaan		VARCHAR(100)
	/* 4*/ , @in_catatan					VARCHAR(4000)
	/* 5*/ , @in_idPengguna				INT
	--/* 7*/ , @out_str					VARCHAR(500) OUTPUT
	--/* 8*/ , @out_desc					VARCHAR(500) OUTPUT	
)
AS
	DECLARE 	
		@in_catatanBaru					VARCHAR(5000)
		, @in_catatanTerbaru				VARCHAR(5000)
		, @tipeForm 						VARCHAR(100)
		, @tipeTindakan					VARCHAR(100)
		, @deskripsiTindakan				VARCHAR(1000)
		, @jumlah							INT
	;
BEGIN
	SET @tipeForm 					=	'MsJenisPerusahaan';
	SET @deskripsiTindakan 		=	'JENIS PERUSAHAAN : ' + @in_namaJenisPerusahaan + CHAR(10);
	SET @in_catatanBaru 			= 	'DIBUAT : ' +  dbo.fnAmbilNamaLengkap(@in_idPengguna) + ' , TANGGAL : ' +
											CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_catatan + CHAR(10);
	
	IF @in_tindakan='NEW'
	------------------------------------------------------------------- New JenisPerusahaan
		BEGIN	
			SET @tipeTindakan = 'NEW';	
			/* Cek data sudah Ada */
			-- SET @jumlah = (SELECT COUNT(JenisPerusahaan) from MsJenisPerusahaan where status = 1 and jenisPerusahaan = @in_jenisPerusahaan group by namaJenisPerusahaan);
			-- IF @jumlah > 1
			-- 	SET @out_str = 'Kode Duplikasi'
			-- ELSE				
			BEGIN	
				INSERT INTO msJenisPerusahaan (
							/* 1*/ namaJenisPerusahaan,
							/* 2*/ catatan,
							/* 3*/ dibuatoleh
				) VALUES ( 				
							/* 1*/ @in_namaJenisPerusahaan,			  									  
							/* 2*/ @in_catatanBaru,					  
							/* 3*/ @in_idPengguna
				);																
			END
		END

	ELSE IF @in_tindakan='EDIT'
	------------------------------------------------------------------- Edit JenisPerusahaan
		BEGIN	
			SET @tipeTindakan 		= 	'UPDATE'; 
			SET @in_catatanTerbaru 	= 	@in_catatanBaru + CHAR(10) + '--------------------' + CHAR(10) + CHAR(10)
												+	dbo.fnAmbilCatatanJenisPerusahaan(@in_id);	
			IF @in_catatan = ''
				BEGIN
					UPDATE msJenisPerusahaan SET
								/* 1*/ namaJenisPerusahaan 		= @in_namaJenisPerusahaan
								/* 2*/ , dieditoleh 					= @in_idPengguna
								/* 3*/ , waktuedit	 				= CURRENT_TIMESTAMP
					WHERE id = @in_id;													
				END
			ELSE
				BEGIN
					UPDATE msJenisPerusahaan SET
								/* 1*/ namaJenisPerusahaan 		= @in_namaJenisPerusahaan
								/* 2*/ , catatan 						= @in_catatanTerbaru
								/* 3*/ , dieditoleh 					= @in_idPengguna
								/* 4*/ , waktuedit	 				= CURRENT_TIMESTAMP
					WHERE id = @in_id;					
					SET @deskripsiTindakan =	@deskripsiTindakan + CHAR(10) +
														'CATATAN : ' + @in_catatanTerbaru + CHAR(10);
				END
		END		
	
	ELSE IF @in_tindakan='DELETE'
	------------------------------------------------------------------- Delete JenisPerusahaan
		BEGIN
			SET @tipeTindakan = 'DELETE';	
			UPDATE msJenisPerusahaan SET
						/* 1*/ status 			= 0,
						/* 2*/ dieditoleh 	= @in_idPengguna,
						/* 3*/ waktuedit	 	= CURRENT_TIMESTAMP
			WHERE id = @in_id;
		END
	
	------------------------------------------------------------------ Insert History JenisPerusahaan
	EXEC spInsMsHistory 	
		/* 1*/ @tipeForm
		/* 2*/ , @tipeTindakan
		/* 3*/ , @deskripsiTindakan
		/* 4*/ , @in_idpengguna			
							  
END
GO

--############################################################################# spMsInvATK -- 12

IF Objectproperty(Object_Id('spMsInvATK'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[spMsInvATK]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE spMsInvATK (
	/* 1*/ @in_tindakan					VARCHAR(4)
	/* 2*/ , @in_id		 				INT
	/* 3*/ , @in_kodeInvATK				VARCHAR(20)
	/* 4*/ , @in_namaInvATK				VARCHAR(100)
	/* 5*/ , @in_jenisInvATK			VARCHAR(100)
	/* 6*/ , @in_kelompokInvATK		VARCHAR(100)
	/* 7*/ , @in_satuan					VARCHAR(100)
	/* 8*/ , @in_minimum					INT
	/* 9*/ , @in_catatan					VARCHAR(4000)
	/*10*/ , @in_idPengguna				INT
	/*11*/ , @out_str					VARCHAR(500) OUTPUT
	/*12*/ , @out_desc					VARCHAR(500) OUTPUT	
)
AS
	DECLARE 	
		@in_catatanBaru					VARCHAR(5000)
		, @in_catatanTerbaru				VARCHAR(5000)
		, @tipeForm 						VARCHAR(100)
		, @tipeTindakan					VARCHAR(100)
		, @deskripsiTindakan				VARCHAR(1000)
		, @jumlah							INT
	;
BEGIN
	SET @tipeForm 					=	'MsInvATK';
	SET @deskripsiTindakan 		=	'NAMA InvATK : ' + @in_namaInvATK + CHAR(10) +
											'KODE InvATK : ' + @in_kodeInvATK + CHAR(10) +
											'JENIS InvATK : ' + @in_jenisInvATK + CHAR(10) +
											'KELOMPOK InvATK : ' + @in_kelompokInvATK + CHAR(10) +
											'SATUAN : ' + @in_satuan + CHAR(10) +
											'MINIMUM : ' + @in_minimum + CHAR(10)
											;
	SET @in_catatanBaru 			= 	'DIBUAT : ' +  dbo.fnAmbilNamaLengkap(@in_idPengguna) + ' , TANGGAL : ' +
											CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_catatan + CHAR(10);
	
	IF @in_tindakan='NEW'
	------------------------------------------------------------------- New InvATK
		BEGIN	
			SET @tipeTindakan = 'NEW';	
			/* Cek data sudah Ada */
			-- SET @jumlah = (SELECT COUNT(namaInvATK) from MsInvATK where status = 1 and kodeInvATK = @in_namaInvATK group by namaInvATK);
			-- IF @jumlah > 1
			-- 	SET @out_str = 'Kode Duplikasi'
			-- ELSE				
			BEGIN	
				INSERT INTO msInvATK (
							/* 1*/ 	kodeInvATK
							/* 2*/	, namaInvATK					
							/* 3*/ 	, jenisInvATK	   
							/* 4*/   , kelompokInvATK 
							/* 5*/   , satuan			
							/* 6*/   , minimum			
							/* 7*/	, catatan			
							/* 8*/ 	, dibuatoleh
				) VALUES ( 				
							/* 1*/ 	@in_kodeInvATK
							/* 2*/	, @in_namaInvATK					
							/* 3*/ 	, @in_jenisInvATK	   
							/* 4*/   , @in_kelompokInvATK 
							/* 5*/   , @in_satuan			
							/* 6*/   , @in_minimum			
							/* 7*/	, @in_catatan			
							/* 8*/ 	, @in_idPengguna
				);																
			END
		END

	ELSE IF @in_tindakan='EDIT'
	------------------------------------------------------------------- Edit InvATK
		BEGIN	
			SET @tipeTindakan 		= 	'UPDATE'; 
			SET @in_catatanTerbaru 	= 	@in_catatanBaru + CHAR(10) + '--------------------' + CHAR(10) + CHAR(10)
												+	dbo.fnAmbilCatatanInvATK(@in_id);	
			IF @in_catatan = ''
				BEGIN
					UPDATE msInvATK SET
						/* 1*/ 	kodeInvATK				=	@in_kodeInvATK      
						/* 2*/	, namaInvATK			=	@in_namaInvATK		
						/* 3*/ 	, jenisInvATK	      =	@in_jenisInvATK	   
						/* 4*/   , kelompokInvATK     =	@in_kelompokInvATK 
						/* 5*/   , satuan			      =	@in_satuan			
						/* 6*/   , minimum			   =	@in_minimum			
						/* 7*/ 	, dieditoleh         =	@in_idPengguna 
						/* 8*/ 	, waktuEdit 			=	CURRENT_TIMESTAMP 				         
					WHERE id = @in_id;													
				END
			ELSE
				BEGIN
					UPDATE msInvATK SET
						/* 1*/ 	kodeInvATK				=	@in_kodeInvATK      
						/* 2*/	, namaInvATK			=	@in_namaInvATK		
						/* 3*/ 	, jenisInvATK	      =	@in_jenisInvATK	   
						/* 4*/   , kelompokInvATK     =	@in_kelompokInvATK 
						/* 5*/   , satuan			      =	@in_satuan			
						/* 6*/   , minimum			   =	@in_minimum			
						/* 7*/ 	, dieditoleh         =	@in_idPengguna 
						/* 7*/ 	, catatan         	=	@in_catatanTerbaru
						/* 8*/ 	, waktuEdit 			=	CURRENT_TIMESTAMP
					WHERE id = @in_id;					
					SET @deskripsiTindakan =	@deskripsiTindakan + CHAR(10) +
														'CATATAN : ' + @in_catatanTerbaru + CHAR(10);
				END
		END		
	
	ELSE IF @in_tindakan='DELETE'
	------------------------------------------------------------------- Delete InvATK
		BEGIN
			SET @tipeTindakan = 'DELETE';	
			UPDATE msInvATK SET
						/* 1*/ status 				= 0
						/* 2*/ , dieditoleh 		= @in_idPengguna
						/* 3*/ , waktuedit	 	= CURRENT_TIMESTAMP
			WHERE id = @in_id;
		END
	
	------------------------------------------------------------------ Insert History InvATK
	EXEC spInsMsHistory 	
		/* 1*/ @tipeForm
		/* 2*/ , @tipeTindakan
		/* 3*/ , @deskripsiTindakan
		/* 4*/ , @in_idpengguna			
							  
END
GO

--############################################################################# spMsAlkes -- 12

IF Objectproperty(Object_Id('spMsAlkes'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[spMsAlkes]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE spMsAlkes (
	/* 1*/ @in_tindakan					VARCHAR(4)
	/* 2*/ , @in_id		 				INT
	/* 3*/ , @in_kodeAlkes				VARCHAR(20)
	/* 4*/ , @in_namaAlkes				VARCHAR(100)
	/* 5*/ , @in_jenisAlkes				VARCHAR(100)
	/* 6*/ , @in_kelompokAlkes			VARCHAR(100)
	/* 7*/ , @in_satuan					VARCHAR(100)
	/* 8*/ , @in_minimum					INT
	/* 9*/ , @in_catatan					VARCHAR(4000)
	/*10*/ , @in_idPengguna				INT
	/*11*/ , @out_str						VARCHAR(500) OUTPUT
	/*12*/ , @out_desc					VARCHAR(500) OUTPUT	
)
AS
	DECLARE 	
		@in_catatanBaru					VARCHAR(5000)
		, @in_catatanTerbaru				VARCHAR(5000)
		, @tipeForm 						VARCHAR(100)
		, @tipeTindakan					VARCHAR(100)
		, @deskripsiTindakan				VARCHAR(1000)
		, @jumlah							INT
	;
BEGIN
	SET @tipeForm 					=	'MsAlkes';
	SET @deskripsiTindakan 		=	'NAMA Alkes : ' + @in_namaAlkes + CHAR(10) +
											'KODE Alkes : ' + @in_kodeAlkes + CHAR(10) +
											'JENIS Alkes : ' + @in_jenisAlkes + CHAR(10) +
											'KELOMPOK Alkes : ' + @in_kelompokAlkes + CHAR(10) +
											'SATUAN : ' + @in_satuan + CHAR(10) +
											'MINIMUM : ' + @in_minimum + CHAR(10)
											;
	SET @in_catatanBaru 			= 	'DIBUAT : ' +  dbo.fnAmbilNamaLengkap(@in_idPengguna) + ' , TANGGAL : ' +
											CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_catatan + CHAR(10);
	
	IF @in_tindakan='NEW'
	------------------------------------------------------------------- New Alkes
		BEGIN	
			SET @tipeTindakan = 'NEW';	
			/* Cek data sudah Ada */
			-- SET @jumlah = (SELECT COUNT(kodeAlkes) from msAlkes where status = 1 and kodeAlkes = @in_kodeAlkes group by kodeAlkes);
			-- IF @jumlah > 1
			-- 	SET @out_str = 'Kode Duplikasi'
			-- ELSE				
			BEGIN	
				INSERT INTO msAlkes (
							/* 1*/ 	kodeAlkes
							/* 2*/	, namaAlkes					
							/* 3*/ 	, jenisAlkes	   
							/* 4*/   , kelompokAlkes 
							/* 5*/   , satuan			
							/* 6*/   , minimum			
							/* 7*/	, catatan			
							/* 8*/ 	, dibuatoleh
				) VALUES ( 				
							/* 1*/ 	@in_kodeAlkes
							/* 2*/	, @in_namaAlkes					
							/* 3*/ 	, @in_jenisAlkes	   
							/* 4*/   , @in_kelompokAlkes 
							/* 5*/   , @in_satuan			
							/* 6*/   , @in_minimum			
							/* 7*/	, @in_catatan			
							/* 8*/ 	, @in_idPengguna
				);																
			END
		END

	ELSE IF @in_tindakan='EDIT'
	------------------------------------------------------------------- Edit Alkes
		BEGIN	
			SET @tipeTindakan 		= 	'UPDATE'; 
			SET @in_catatanTerbaru 	= 	@in_catatanBaru + CHAR(10) + '--------------------' + CHAR(10) + CHAR(10)
												+	dbo.fnAmbilCatatanAlkes(@in_id);	
			IF @in_catatan = ''
				BEGIN
					UPDATE msAlkes SET
						/* 1*/ 	kodeAlkes				=	@in_kodeAlkes      
						/* 2*/	, namaAlkes				=	@in_namaAlkes		
						/* 3*/ 	, jenisAlkes	      =	@in_jenisAlkes	   
						/* 4*/   , kelompokAlkes     	=	@in_kelompokAlkes 
						/* 5*/   , satuan			      =	@in_satuan			
						/* 6*/   , minimum			   =	@in_minimum			
						/* 7*/ 	, dieditoleh         =	@in_idPengguna 
						/* 8*/ 	, waktuEdit 			=	CURRENT_TIMESTAMP 				         
					WHERE id = @in_id;													
				END
			ELSE
				BEGIN
					UPDATE msAlkes SET
						/* 1*/ 	kodeAlkes				=	@in_kodeAlkes      
						/* 2*/	, namaAlkes				=	@in_namaAlkes		
						/* 3*/ 	, jenisAlkes	      =	@in_jenisAlkes	   
						/* 4*/   , kelompokAlkes     	=	@in_kelompokAlkes 
						/* 5*/   , satuan			      =	@in_satuan			
						/* 6*/   , minimum			   =	@in_minimum			
						/* 7*/ 	, dieditoleh         =	@in_idPengguna 
						/* 7*/ 	, catatan         	=	@in_catatanTerbaru
						/* 8*/ 	, waktuEdit 			=	CURRENT_TIMESTAMP
					WHERE id = @in_id;					
					SET @deskripsiTindakan =	@deskripsiTindakan + CHAR(10) +
														'CATATAN : ' + @in_catatanTerbaru + CHAR(10);
				END
		END		
	
	ELSE IF @in_tindakan='DELETE'
	------------------------------------------------------------------- Delete Alkes
		BEGIN
			SET @tipeTindakan = 'DELETE';	
			UPDATE msAlkes SET
						/* 1*/ status 				= 0
						/* 2*/ , dieditoleh 		= @in_idPengguna
						/* 3*/ , waktuedit	 	= CURRENT_TIMESTAMP
			WHERE id = @in_id;
		END
	
	------------------------------------------------------------------ Insert History Alkes
	EXEC spInsMsHistory 	
		/* 1*/ @tipeForm
		/* 2*/ , @tipeTindakan
		/* 3*/ , @deskripsiTindakan
		/* 4*/ , @in_idpengguna			
							  
END
GO

--############################################################################# spMsInstalasi -- 8

IF Objectproperty(Object_Id('spMsInstalasi'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[spMsInstalasi]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE spMsInstalasi (
	/* 1*/ @in_tindakan					VARCHAR(4)
	/* 2*/ , @in_id		 				INT
	/* 3*/ , @in_namaInstalasi			VARCHAR(100)
	/* 4*/ , @in_catatan					VARCHAR(4000)
	/* 5*/ , @in_idPengguna				INT
	/* 7*/ , @out_str						VARCHAR(500) OUTPUT
	/* 8*/ , @out_desc					VARCHAR(500) OUTPUT	
)
AS
	DECLARE 	
		@in_catatanBaru					VARCHAR(5000)
		, @in_catatanTerbaru				VARCHAR(5000)
		, @tipeForm 						VARCHAR(100)
		, @tipeTindakan					VARCHAR(100)
		, @deskripsiTindakan				VARCHAR(1000)
		, @jumlah							INT
	;
BEGIN
	SET @tipeForm 					=	'MsInstalasi';
	SET @deskripsiTindakan 		=	'NAMA INSTALASI : ' + @in_namaInstalasi + CHAR(10);
	SET @in_catatanBaru 			= 	'DIBUAT : ' +  dbo.fnAmbilNamaLengkap(@in_idPengguna) + ' , TANGGAL : ' +
											CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_catatan + CHAR(10);
	
	IF @in_tindakan='NEW'
	------------------------------------------------------------------- New Instalasi
		BEGIN	
			SET @tipeTindakan = 'NEW';	
			/* Cek data sudah Ada */
			-- SET @jumlah = (SELECT COUNT(namaInstalasi) from MsInstalasi where Status = 1 and NamaInstalasi = @in_namaInstalasi group by namaInstalasi);
			-- IF @jumlah > 1
			-- 	SET @out_str = 'Kode Duplikasi'
			-- ELSE				
			BEGIN	
				INSERT INTO msInstalasi (
							/* 1*/ namaInstalasi,
							/* 2*/ catatan,
							/* 3*/ dibuatoleh
				) VALUES ( 				
							/* 1*/ UPPER(@in_namaInstalasi),			  									  
							/* 2*/ @in_catatanBaru,					  
							/* 3*/ @in_idPengguna
				);																
			END
		END

	ELSE IF @in_tindakan='EDIT'
	------------------------------------------------------------------- Edit Instalasi
		BEGIN	
			SET @tipeTindakan 		= 	'UPDATE'; 
			SET @in_catatanTerbaru 	= 	@in_catatanBaru + CHAR(10) + '--------------------' + CHAR(10) + CHAR(10)
												+	dbo.fnAmbilCatatanInstalasi(@in_id);	
			IF @in_catatan = ''
				BEGIN
					UPDATE msInstalasi SET
								/* 1*/ namaInstalasi 			= UPPER(@in_namaInstalasi)
								/* 2*/ , dieditoleh 			= @in_idPengguna
								/* 3*/ , waktuedit	 		= CURRENT_TIMESTAMP
					WHERE id = @in_id;													
				END
			ELSE
				BEGIN
					UPDATE msInstalasi SET
								/* 1*/ namaInstalasi 			= UPPER(@in_namaInstalasi)
								/* 2*/ , catatan 				= @in_catatanTerbaru
								/* 3*/ , dieditoleh 			= @in_idPengguna
								/* 4*/ , waktuedit	 		= CURRENT_TIMESTAMP
					WHERE id = @in_id;					
					SET @deskripsiTindakan =	@deskripsiTindakan + CHAR(10) +
														'CATATAN : ' + @in_catatanTerbaru + CHAR(10);
				END
		END		
	
	ELSE IF @in_tindakan='DEL'
	------------------------------------------------------------------- Delete Instalasi
		BEGIN
			SET @tipeTindakan = 'DELETE';	
			UPDATE msInstalasi SET
						/* 1*/ status 			= 0,
						/* 2*/ dieditoleh 	= @in_idPengguna,
						/* 3*/ waktuedit	 	= CURRENT_TIMESTAMP
			WHERE id = @in_id;
		END
	
	------------------------------------------------------------------ Insert History Instalasi
	EXEC spInsMsHistory 	
		/* 1*/ @tipeForm
		/* 2*/ , @tipeTindakan
		/* 3*/ , @deskripsiTindakan
		/* 4*/ , @in_idpengguna			
							  
END
GO

--############################################################################# spMsCaraPembayaran -- 8

IF Objectproperty(Object_Id('spMsCaraPembayaran'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[spMsCaraPembayaran]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE spMsCaraPembayaran (
	/* 1*/ @in_tindakan					VARCHAR(4)
	/* 2*/ , @in_id		 				INT
	/* 3*/ , @in_namaCaraPembayaran	VARCHAR(100)
	/* 4*/ , @in_catatan					VARCHAR(4000)
	/* 5*/ , @in_idPengguna				INT
	/* 7*/ , @out_str						VARCHAR(500) OUTPUT
	/* 8*/ , @out_desc					VARCHAR(500) OUTPUT	
)
AS
	DECLARE 	
		@in_catatanBaru					VARCHAR(5000)
		, @in_catatanTerbaru				VARCHAR(5000)
		, @tipeForm 						VARCHAR(100)
		, @tipeTindakan					VARCHAR(100)
		, @deskripsiTindakan				VARCHAR(1000)
		, @jumlah							INT
	;
BEGIN
	SET @tipeForm 					=	'MsCaraPembayaran';
	SET @deskripsiTindakan 		=	'CARA PEMBAYARAN : ' + @in_namaCaraPembayaran + CHAR(10);
	SET @in_catatanBaru 			= 	'DIBUAT : ' +  dbo.fnAmbilNamaLengkap(@in_idPengguna) + ' , TANGGAL : ' +
											CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_catatan + CHAR(10);
	
	IF @in_tindakan='NEW'
	------------------------------------------------------------------- New CaraPembayaran
		BEGIN	
			SET @tipeTindakan = 'NEW';	
			/* Cek data sudah Ada */
			-- SET @jumlah = (SELECT COUNT(namaCaraPembayaran) from MsCaraPembayaran where Status = 1 and NamaCaraPembayaran = @in_namaCaraPembayaran group by namaCaraPembayaran);
			-- IF @jumlah > 1
			-- 	SET @out_str = 'Kode Duplikasi'
			-- ELSE				
			BEGIN	
				INSERT INTO msCaraPembayaran (
							/* 1*/ namaCaraPembayaran,
							/* 2*/ catatan,
							/* 3*/ dibuatoleh
				) VALUES ( 				
							/* 1*/ UPPER(@in_namaCaraPembayaran),			  									  
							/* 2*/ @in_catatanBaru,					  
							/* 3*/ @in_idPengguna
				);																
			END
		END

	ELSE IF @in_tindakan='EDIT'
	------------------------------------------------------------------- Edit CaraPembayaran
		BEGIN	
			SET @tipeTindakan 		= 	'UPDATE'; 
			SET @in_catatanTerbaru 	= 	@in_catatanBaru + CHAR(10) + '--------------------' + CHAR(10) + CHAR(10)
												+	dbo.fnAmbilCatatanCaraPembayaran(@in_id);	
			IF @in_catatan = ''
				BEGIN
					UPDATE msCaraPembayaran SET
								/* 1*/ namaCaraPembayaran 			= UPPER(@in_namaCaraPembayaran)
								/* 2*/ , dieditoleh 					= @in_idPengguna
								/* 3*/ , waktuedit	 				= CURRENT_TIMESTAMP
					WHERE id = @in_id;													
				END
			ELSE
				BEGIN
					UPDATE msCaraPembayaran SET
								/* 1*/ namaCaraPembayaran 			= UPPER(@in_namaCaraPembayaran)
								/* 2*/ , catatan 						= @in_catatanTerbaru
								/* 3*/ , dieditoleh 					= @in_idPengguna
								/* 4*/ , waktuedit	 				= CURRENT_TIMESTAMP
					WHERE id = @in_id;					
					SET @deskripsiTindakan =	@deskripsiTindakan + CHAR(10) +
														'CATATAN : ' + @in_catatanTerbaru + CHAR(10);
				END
		END		
	
	ELSE IF @in_tindakan='DEL'
	------------------------------------------------------------------- Delete CaraPembayaran
		BEGIN
			SET @tipeTindakan = 'DELETE';	
			UPDATE msCaraPembayaran SET
						/* 1*/ status 			= 0,
						/* 2*/ dieditoleh 	= @in_idPengguna,
						/* 3*/ waktuedit	 	= CURRENT_TIMESTAMP
			WHERE id = @in_id;
		END
	
	------------------------------------------------------------------ Insert History CaraPembayaran
	EXEC spInsMsHistory 	
		/* 1*/ @tipeForm
		/* 2*/ , @tipeTindakan
		/* 3*/ , @deskripsiTindakan
		/* 4*/ , @in_idpengguna			
							  
END
GO

--############################################################################# spMsTitel -- 8

IF Objectproperty(Object_Id('spMsTitel'), N'isprocedure') = 1
DROP PROCEDURE [Dbo].[spMsTitel]
GO
------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE spMsTitel (
	/* 1*/ @in_tindakan					VARCHAR(4)
	/* 2*/ , @in_id		 				INT
	/* 3*/ , @in_namaTitel				VARCHAR(100)
	/* 4*/ , @in_catatan					VARCHAR(4000)
	/* 5*/ , @in_idPengguna				INT
	/* 7*/ , @out_str						VARCHAR(500) OUTPUT
	/* 8*/ , @out_desc					VARCHAR(500) OUTPUT	
)
AS
	DECLARE 	
		@in_catatanBaru					VARCHAR(5000)
		, @in_catatanTerbaru				VARCHAR(5000)
		, @tipeForm 						VARCHAR(100)
		, @tipeTindakan					VARCHAR(100)
		, @deskripsiTindakan				VARCHAR(1000)
		, @jumlah							INT
	;
BEGIN
	SET @tipeForm 					=	'MsTitel';
	SET @deskripsiTindakan 		=	'NAMA Titel : ' + @in_namaTitel + CHAR(10);
	SET @in_catatanBaru 			= 	'DIBUAT : ' +  dbo.fnAmbilNamaLengkap(@in_idPengguna) + ' , TANGGAL : ' +
											CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_catatan + CHAR(10);
	
	IF @in_tindakan='NEW'
	------------------------------------------------------------------- New Titel
		BEGIN	
			SET @tipeTindakan = 'NEW';	
			/* Cek data sudah Ada */
			-- SET @jumlah = (SELECT COUNT(namaTitel) from MsTitel where Status = 1 and NamaTitel = @in_namaTitel group by namaTitel);
			-- IF @jumlah > 1
			-- 	SET @out_str = 'Kode Duplikasi'
			-- ELSE				
			BEGIN	
				INSERT INTO msTitel (
							/* 1*/ namaTitel,
							/* 2*/ catatan,
							/* 3*/ dibuatoleh
				) VALUES ( 				
							/* 1*/ UPPER(@in_namaTitel),			  									  
							/* 2*/ @in_catatanBaru,					  
							/* 3*/ @in_idPengguna
				);																
			END
		END

	ELSE IF @in_tindakan='EDIT'
	------------------------------------------------------------------- Edit Titel
		BEGIN	
			SET @tipeTindakan 		= 	'UPDATE'; 
			SET @in_catatanTerbaru 	= 	@in_catatanBaru + CHAR(10) + '--------------------' + CHAR(10) + CHAR(10)
												+	dbo.fnAmbilCatatanTitel(@in_id);	
			IF @in_catatan = ''
				BEGIN
					UPDATE msTitel SET
								/* 1*/ namaTitel 				= UPPER(@in_namaTitel)
								/* 2*/ , dieditoleh 			= @in_idPengguna
								/* 3*/ , waktuedit	 		= CURRENT_TIMESTAMP
					WHERE id = @in_id;													
				END
			ELSE
				BEGIN
					UPDATE msTitel SET
								/* 1*/ namaTitel 				= UPPER(@in_namaTitel)
								/* 2*/ , catatan 				= @in_catatanTerbaru
								/* 3*/ , dieditoleh 			= @in_idPengguna
								/* 4*/ , waktuedit	 		= CURRENT_TIMESTAMP
					WHERE id = @in_id;					
					SET @deskripsiTindakan =	@deskripsiTindakan + CHAR(10) +
														'CATATAN : ' + @in_catatanTerbaru + CHAR(10);
				END
		END		
	
	ELSE IF @in_tindakan='DEL'
	------------------------------------------------------------------- Delete Titel
		BEGIN
			SET @tipeTindakan = 'DELETE';	
			UPDATE msTitel SET
						/* 1*/ status 			= 0,
						/* 2*/ dieditoleh 	= @in_idPengguna,
						/* 3*/ waktuedit	 	= CURRENT_TIMESTAMP
			WHERE id = @in_id;
		END
	
	------------------------------------------------------------------ Insert History Titel
	EXEC spInsMsHistory 	
		/* 1*/ @tipeForm
		/* 2*/ , @tipeTindakan
		/* 3*/ , @deskripsiTindakan
		/* 4*/ , @in_idpengguna			
							  
END
GO