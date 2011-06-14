-- DATABASE PLANNING SIRS : MASTER --
----------------------------------------------------------------------------------------------------------
-- Create by : Ivhan Famly Gunawan
-- Date : April 2011
-- Database : SQL Server
-- Penulisan : Indonesia
----------------------------------------------------------------------------------------------------------
USE [SIRS]
GO
----------------------------------------------------------------------------------------------------------
-- Composition Word for Table's Name 
----------------------------------------------------------------------------------------------------------
-- Example : msCoa
-- 1. ms : jenis table (master, transaksi)
-- 2. Coa : nama table
----------------------------------------------------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'mscoa') AND type in (N'U'))
DROP TABLE mscoa
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE msCoa (
	id						INT IDENTITY(1,1) NOT NULL,
	kodeCoa 				VARCHAR(20) NOT NULL,
	namaCoa 				VARCHAR(100) NOT NULL,
	tipeCoa 				VARCHAR(100),
	--------------------------------
	catatan 				TEXT DEFAULT '-',
	status 				INT DEFAULT 1,
	--------------------------------
	dibuatOleh 			INT,
	dieditOleh 			INT,
	waktuBuat 			DATETIME DEFAULT CURRENT_TIMESTAMP,
	waktuEdit 			DATETIME DEFAULT CURRENT_TIMESTAMP,
	
	PRIMARY KEY (id)	
);

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'msDiet') AND type in (N'U'))
DROP TABLE msDiet
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE msDiet (
	id						INT IDENTITY(1,1) NOT NULL,
	kodeDiet 			VARCHAR(20) NOT NULL,
	namaDiet 			VARCHAR(100) NOT NULL,
	--------------------------------
	catatan 				TEXT DEFAULT '-',
	status 				INT DEFAULT 1,
	--------------------------------
	dibuatOleh 			INT,
	dieditOleh 			INT,
	waktuBuat 			DATETIME DEFAULT CURRENT_TIMESTAMP,
	waktuEdit 			DATETIME DEFAULT CURRENT_TIMESTAMP,
	
	PRIMARY KEY (id)	
);

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'msMenuMakanan') AND type in (N'U'))
DROP TABLE msMenuMakanan
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE msMenuMakanan (
	id						INT IDENTITY(1,1) NOT NULL,
	kodeMenuMakanan 	VARCHAR(20) NOT NULL,
	id_diet 				INT NOT NULL, -- refer : id -- table : msDiet
	kelompok				VARCHAR(100),
	waktu					VARCHAR(100),
	--------------------------------
	catatan 				TEXT DEFAULT '-',
	status 				INT DEFAULT 1,
	--------------------------------
	dibuatOleh 			INT,
	dieditOleh 			INT,
	waktuBuat 			DATETIME DEFAULT CURRENT_TIMESTAMP,
	waktuEdit 			DATETIME DEFAULT CURRENT_TIMESTAMP,
	
	PRIMARY KEY (id)	
);

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'msMenuMakananDet') AND type in (N'U'))
DROP TABLE msMenuMakananDet
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE msMenuMakananDet (
	id						INT IDENTITY(1,1) NOT NULL,
	id_menuMakanan 	INT NOT NULL, -- refer : id -- table : msMenuMakanan
	id_makanan			INT NOT NULL, -- refer : id -- table : msMakanan
	jumlah				INT NOT NULL,
	--------------------------------
	status 				INT DEFAULT 1,
	--------------------------------
	dibuatOleh 			INT,
	waktuBuat 			DATETIME DEFAULT CURRENT_TIMESTAMP,
	
	PRIMARY KEY (id)	
);

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'msMakanan') AND type in (N'U'))
DROP TABLE msMakanan
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE msMakanan (
	id						INT IDENTITY(1,1) NOT NULL,
	namaMakanan 		VARCHAR(100) NOT NULL,
	--------------------------------
	catatan 				TEXT DEFAULT '-',
	status 				INT DEFAULT 1,
	--------------------------------
	dibuatOleh 			INT,
	dieditOleh 			INT,
	waktuBuat 			DATETIME DEFAULT CURRENT_TIMESTAMP,
	waktuEdit 			DATETIME DEFAULT CURRENT_TIMESTAMP,
	
	PRIMARY KEY (id)
);

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'msObat') AND type in (N'U'))
DROP TABLE msObat
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE msObat (
	id						INT IDENTITY(1,1) NOT NULL,
	kodeObat				VARCHAR(20) NOT NULL,
	namaObat 			VARCHAR(100) NOT NULL,
	golonganObat		VARCHAR(100),
	kategoryObat		VARCHAR(100),
	satuanBeli			VARCHAR(100),
	satuanJual			VARCHAR(100),
	isi					INT,
	stokMin				INT,
	--------------------------------
	catatan 				TEXT DEFAULT '-',
	status 				INT DEFAULT 1,
	--------------------------------
	dibuatOleh 			INT,
	dieditOleh 			INT,
	waktuBuat 			DATETIME DEFAULT CURRENT_TIMESTAMP,
	waktuEdit 			DATETIME DEFAULT CURRENT_TIMESTAMP,
	
	PRIMARY KEY (id)	
);

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'msKelas') AND type in (N'U'))
DROP TABLE msKelas
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE msKelas (
	id						INT IDENTITY(1,1) NOT NULL,
	kodeKelas 			VARCHAR(20) NOT NULL,
	namaKelas 			VARCHAR(100),
	--------------------------------
	catatan 				TEXT DEFAULT '-',
	status 				INT DEFAULT 1,
	--------------------------------
	dibuatOleh 			INT,
	dieditOleh 			INT,
	waktuBuat 			DATETIME DEFAULT CURRENT_TIMESTAMP,
	waktuEdit 			DATETIME DEFAULT CURRENT_TIMESTAMP,
	
	PRIMARY KEY (id)	
);

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'msAlkes') AND type in (N'U'))
DROP TABLE msAlkes
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE msAlkes (
	id						INT IDENTITY(1,1) NOT NULL,
	kodeAlkes 			VARCHAR(20) NOT NULL,
	namaAlkes 			VARCHAR(100),
	jenisAlkes 			VARCHAR(100),
	kelompokAlkes 		VARCHAR(100),
	satuan				VARCHAR(100),
	minimum				INT,
	--------------------------------
	catatan 				TEXT DEFAULT '-',
	status 				INT DEFAULT 1,
	--------------------------------
	dibuatOleh 			INT,
	dieditOleh 			INT,
	waktuBuat 			DATETIME DEFAULT CURRENT_TIMESTAMP,
	waktuEdit 			DATETIME DEFAULT CURRENT_TIMESTAMP,
	
	PRIMARY KEY (id)	
);

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'msInvAtk') AND type in (N'U'))
DROP TABLE msInvAtk
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE msInvAtk (
	id						INT IDENTITY(1,1) NOT NULL,
	kodeInvAtk 			VARCHAR(20) NOT NULL,
	namaInvAtk 			VARCHAR(100),
	jenisInvAtk 		VARCHAR(100),
	kelompokInvAtk 	VARCHAR(100),
	satuan				VARCHAR(100),
	minimum				INT,
	--------------------------------
	catatan 				TEXT DEFAULT '-',
	status 				INT DEFAULT 1,
	--------------------------------
	dibuatOleh 			INT,
	dieditOleh 			INT,
	waktuBuat 			DATETIME DEFAULT CURRENT_TIMESTAMP,
	waktuEdit 			DATETIME DEFAULT CURRENT_TIMESTAMP,
	
	PRIMARY KEY (id)	
);

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'msHistory') AND type in (N'U'))
DROP TABLE msHistory
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE msHistory (
	id INT IDENTITY(1,1) NOT NULL,
	tipeForm 			VARCHAR(100),
	tipeTindakan 		VARCHAR(100),
	deskripsiTindakan VARCHAR(1000),
	dibuatOleh 			INT,
	waktuBuat 			DATETIME DEFAULT CURRENT_TIMESTAMP,

	PRIMARY KEY (id)
);

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'msPengguna') AND type in (N'U'))
DROP TABLE msPengguna
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE msPengguna (
	id						INT IDENTITY(1,1) NOT NULL,
	id_karyawan 		INT NOT NULL, -- refer --> id : msKaryawan
	namaPengguna 		VARCHAR (20) NOT NULL,
	sandiPengguna 		VARCHAR (20) NOT NULL,
	--------------------------------
	catatan 				TEXT DEFAULT '-',
	status 				INT DEFAULT 1,
	--------------------------------
	dibuatOleh 			INT,
	dieditOleh 			INT,
	waktuBuat 			DATETIME DEFAULT CURRENT_TIMESTAMP,
	waktuEdit 			DATETIME DEFAULT CURRENT_TIMESTAMP,
	
	PRIMARY KEY (id)	
);

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'msKaryawan') AND type in (N'U'))
DROP TABLE msKaryawan
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE msKaryawan (
	id						INT IDENTITY(1,1) NOT NULL,
	nipKaryawan 		VARCHAR(20) NOT NULL, --> NIP = No Induk Pegawai
	namaLengkap 		VARCHAR (100) NOT NULL,
	tempatLahir 		VARCHAR (50),
	tglLahir 			DATETIME,
	agama 				VARCHAR(50),
	jenisKelamin 		VARCHAR(50),
	alamat 				VARCHAR(500),
	telepon 				VARCHAR(30), 
	handphone 			VARCHAR(30),
	kota 					VARCHAR(30),
	kecamatan 			VARCHAR(30),
	education 			VARCHAR(30),
	employeeStatus 	VARCHAR(30),
	--------------------------------
	id_pekerjaan 		INT, -- refer --> id : msPekerjaan
	posisiPekerjaan 	VARCHAR(30),
	--------------------------------
	statusNikah 		VARCHAR(30),
	namaBank 			VARCHAR(30),
	accountBank 		VARCHAR(20),
	--------------------------------
	catatan 				TEXT DEFAULT '-',
	status 				INT DEFAULT 1,
	--------------------------------
	dibuatOleh 			INT,
	dieditOleh 			INT,
	waktuBuat 			DATETIME DEFAULT CURRENT_TIMESTAMP,
	waktuEdit 			DATETIME DEFAULT CURRENT_TIMESTAMP,
	
	PRIMARY KEY (id)	
);

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'msTarifAmbulans') AND type in (N'U'))
DROP TABLE msTarifAmbulans
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE msTarifAmbulans (
	id							INT IDENTITY(1,1) NOT NULL,
	kodeTarifAmbulans 	VARCHAR(100) NOT NULL,
	daerah 					TEXT DEFAULT '-',
	tujuan 					INT DEFAULT 1,
	tarif						DECIMAL,
	pendampingMedis		DECIMAL,
	paraMedis				DECIMAL,
	paraMedisPP				DECIMAL,
	oksigen					DECIMAL,
	monitor					DECIMAL,
	--------------------------------
	catatan 					TEXT DEFAULT '-',
	status 					INT DEFAULT 1,
	--------------------------------
	dibuatOleh 				INT,
	dieditOleh 				INT,
	waktuBuat 				DATETIME DEFAULT CURRENT_TIMESTAMP,
	waktuEdit 				DATETIME DEFAULT CURRENT_TIMESTAMP,
	
	PRIMARY KEY (id)	
);


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'msObatHarga') AND type in (N'U'))
DROP TABLE msObatHarga
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE msObatHarga (
	id							INT IDENTITY(1,1) NOT NULL,
	id_obat 					INT NOT NULL, -- refer : id : msObat
	kodePenerimaan 		VARCHAR(10),
	tglPenerimaan 			DATETIME DEFAULT CURRENT_TIMESTAMP,
	jumlahPenerimaan		INT,
	tglKadaluarsa			DATETIME,
	hargaBeli				DECIMAL,
	hargaJual				DECIMAL,
	margin					DECIMAL,
	--------------------------------
	catatan 					TEXT DEFAULT '-',
	status 					INT DEFAULT 1,
	--------------------------------
	dibuatOleh 				INT,
	dieditOleh 				INT,
	waktuBuat 				DATETIME DEFAULT CURRENT_TIMESTAMP,
	waktuEdit 				DATETIME DEFAULT CURRENT_TIMESTAMP,
	
	PRIMARY KEY (id)	
);

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'msSAK') AND type in (N'U'))
DROP TABLE msSAK
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE msSAK(
	id							INT IDENTITY(1,1) NOT NULL,
	noSAK 					VARCHAR(20) NOT NULL,
	keterangan				VARCHAR(500),
	tujuan					VARCHAR(500),
	perencanaan				VARCHAR(500),
	implementasi			VARCHAR(500),
	evaluasi					VARCHAR(500),
	--------------------------------
	catatan 					TEXT DEFAULT '-',
	status 					INT DEFAULT 1,
	--------------------------------
	dibuatOleh 				INT,
	dieditOleh 				INT,
	waktuBuat 				DATETIME DEFAULT CURRENT_TIMESTAMP,
	waktuEdit 				DATETIME DEFAULT CURRENT_TIMESTAMP,
	
	PRIMARY KEY (id)	
);

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'msPerusahaan') AND type in (N'U'))
DROP TABLE msPerusahaan
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE msPerusahaan(
	id							INT IDENTITY(1,1) NOT NULL,
	namaPerusahaan 		VARCHAR(50) NOT NULL,
	jenisPerusahaan		VARCHAR(500),
	yangDihubungi			VARCHAR(500),
	alamat					VARCHAR(500),
	kota 						VARCHAR(50),
	provinsi					VARCHAR(50),
	negara					VARCHAR(50),
	kodePos					INT,
	telepon					INT,
	fax						INT,
	email						VARCHAR(50),
	--------------------------------------------->> kerjasama
	tglMulai					VARCHAR(500),
	tglAkhir					VARCHAR(500),
	jumlahPeserta			VARCHAR(500),
	kapasitas				VARCHAR(500),
	total						VARCHAR(500),
	plafon 					VARCHAR(500),
	pengantar				VARCHAR(500),
	rujukan					VARCHAR(500),
	noJanji					VARCHAR(500),
	--------------------------------------------->> layanan
	dokter					VARCHAR(500),
	obat						VARCHAR(500),
	biayaDokter				VARCHAR(500),
	biayaAdmin				VARCHAR(500),
	provider					VARCHAR(500),
	jenisLayanan 			VARCHAR(500),
	ijinRawatInap			INT, -- note : 1=ya, 0=tidak
	--------------------------------------------->> jenisKerjaSama
	rawatJalan				INT, -- note : 1=ya, 0=tidak 
	rawatInap				INT, -- note : 1=ya, 0=tidak
	penunjangMedis			INT, -- note : 1=ya, 0=tidak
	apotik					INT, -- note : 1=ya, 0=tidak
	ambulans					INT, -- note : 1=ya, 0=tidak
	IHC 						INT, -- note : 1=ya, 0=tidak
	MCU						INT, -- note : 1=ya, 0=tidak
	--------------------------------
	catatan 						TEXT DEFAULT '-',
	status 						INT DEFAULT 1,
	--------------------------------
	dibuatOleh 					INT,
	dieditOleh 					INT,
	waktuBuat 					DATETIME DEFAULT CURRENT_TIMESTAMP,
	waktuEdit 					DATETIME DEFAULT CURRENT_TIMESTAMP,
	
	PRIMARY KEY (id)
);

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'msJenisPerusahaan') AND type in (N'U'))
DROP TABLE msJenisPerusahaan
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE msJenisPerusahaan(
	id							INT IDENTITY(1,1) NOT NULL,
	jenisPerusahaan 		VARCHAR(50) NOT NULL,
	--------------------------------
	catatan 					TEXT DEFAULT '-',
	status 					INT DEFAULT 1,
	--------------------------------
	dibuatOleh 				INT,
	dieditOleh 				INT,
	waktuBuat 				DATETIME DEFAULT CURRENT_TIMESTAMP,
	waktuEdit 				DATETIME DEFAULT CURRENT_TIMESTAMP,
	
	PRIMARY KEY (id)
);

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'msNegara') AND type in (N'U'))
DROP TABLE msNegara
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE msNegara(
	id							INT IDENTITY(1,1) NOT NULL,
	namaNegara 				VARCHAR(50) NOT NULL,
	--------------------------------
	catatan 					TEXT DEFAULT '-',
	status 					INT DEFAULT 1,
	--------------------------------
	dibuatOleh 				INT,
	dieditOleh 				INT,
	waktuBuat 				DATETIME DEFAULT CURRENT_TIMESTAMP,
	waktuEdit 				DATETIME DEFAULT CURRENT_TIMESTAMP,
	
	PRIMARY KEY (id)
);

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'msKota') AND type in (N'U'))
DROP TABLE msKota
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE msKota(
	id							INT IDENTITY(1,1) NOT NULL,
	namaKota 				VARCHAR(50) NOT NULL,
	--------------------------------
	catatan 					TEXT DEFAULT '-',
	status 					INT DEFAULT 1,
	--------------------------------
	dibuatOleh 				INT,
	dieditOleh 				INT,
	waktuBuat 				DATETIME DEFAULT CURRENT_TIMESTAMP,
	waktuEdit 				DATETIME DEFAULT CURRENT_TIMESTAMP,
	
	PRIMARY KEY (id)
);

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'msAgama') AND type in (N'U'))
DROP TABLE msAgama
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE msAgama (
	id						INT IDENTITY(1,1) NOT NULL,
	namaAgama 		VARCHAR(100) NOT NULL,
	--------------------------------
	catatan 				TEXT DEFAULT '-',
	status 				INT DEFAULT 1,
	--------------------------------
	dibuatOleh 			INT,
	dieditOleh 			INT,
	waktuBuat 			DATETIME DEFAULT CURRENT_TIMESTAMP,
	waktuEdit 			DATETIME DEFAULT CURRENT_TIMESTAMP,
	
	PRIMARY KEY (id)
);

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'msPendidikan') AND type in (N'U'))
DROP TABLE msPendidikan
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE msPendidikan(
	id						INT IDENTITY(1,1) NOT NULL,
	namaPendidikan		VARCHAR(100) NOT NULL,
	--------------------------------
	catatan 				TEXT DEFAULT '-',
	status 				INT DEFAULT 1,
	--------------------------------
	dibuatOleh 			INT,
	dieditOleh 			INT,
	waktuBuat 			DATETIME DEFAULT CURRENT_TIMESTAMP,
	waktuEdit 			DATETIME DEFAULT CURRENT_TIMESTAMP,
	
	PRIMARY KEY (id)	
);

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'msPropinsi') AND type in (N'U'))
DROP TABLE msPropinsi
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE msPropinsi(
	id						INT IDENTITY(1,1) NOT NULL,
	namaPropinsi		VARCHAR(100) NOT NULL,
	--------------------------------
	catatan 				TEXT DEFAULT '-',
	status 				INT DEFAULT 1,
	--------------------------------
	dibuatOleh 			INT,
	dieditOleh 			INT,
	waktuBuat 			DATETIME DEFAULT CURRENT_TIMESTAMP,
	waktuEdit 			DATETIME DEFAULT CURRENT_TIMESTAMP,
	
	PRIMARY KEY (id)	
);

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'msKabupaten') AND type in (N'U'))
DROP TABLE msKabupaten
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE msKabupaten(
	id						INT IDENTITY(1,1) NOT NULL,
	namaKabupaten		VARCHAR(100) NOT NULL,
	--------------------------------
	catatan 				TEXT DEFAULT '-',
	status 				INT DEFAULT 1,
	--------------------------------
	dibuatOleh 			INT,
	dieditOleh 			INT,
	waktuBuat 			DATETIME DEFAULT CURRENT_TIMESTAMP,
	waktuEdit 			DATETIME DEFAULT CURRENT_TIMESTAMP,
	
	PRIMARY KEY (id)	
);

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'msPekerjaan') AND type in (N'U'))
DROP TABLE msPekerjaan
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE msPekerjaan(
	id						INT IDENTITY(1,1) NOT NULL,
	namaPekerjaan 		VARCHAR(100) NOT NULL,
	--------------------------------
	catatan 				TEXT DEFAULT '-',
	status 				INT DEFAULT 1,
	--------------------------------
	dibuatOleh 			INT,
	dieditOleh 			INT,
	waktuBuat 			DATETIME DEFAULT CURRENT_TIMESTAMP,
	waktuEdit 			DATETIME DEFAULT CURRENT_TIMESTAMP,
	
	PRIMARY KEY (id)	
);

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'msKecamatan') AND type in (N'U'))
DROP TABLE msKecamatan
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE msKecamatan(
	id							INT IDENTITY(1,1) NOT NULL,
	namaKecamatan 			VARCHAR(50) NOT NULL,
	--------------------------------
	catatan 					TEXT DEFAULT '-',
	status 					INT DEFAULT 1,
	--------------------------------
	dibuatOleh 				INT,
	dieditOleh 				INT,
	waktuBuat 				DATETIME DEFAULT CURRENT_TIMESTAMP,
	waktuEdit 				DATETIME DEFAULT CURRENT_TIMESTAMP,
	
	PRIMARY KEY (id)
);

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'msKelurahan') AND type in (N'U'))
DROP TABLE msKelurahan
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE msKelurahan(
	id							INT IDENTITY(1,1) NOT NULL,
	namaKelurahan 			VARCHAR(50) NOT NULL,
	--------------------------------
	catatan 					TEXT DEFAULT '-',
	status 					INT DEFAULT 1,
	--------------------------------
	dibuatOleh 				INT,
	dieditOleh 				INT,
	waktuBuat 				DATETIME DEFAULT CURRENT_TIMESTAMP,
	waktuEdit 				DATETIME DEFAULT CURRENT_TIMESTAMP,
	
	PRIMARY KEY (id)
);

INSERT INTO ms(namaPekerjaan) VALUES ('admin');
INSERT INTO msKaryawan(nipKaryawan,namaLengkap,id_pekerjaan) VALUES ('ADMIN1', 'IVHAN',1);
INSERT INTO msPengguna(id_karyawan,namaPengguna,sandiPengguna) VALUES (1,'ADMIN','ADMIN');