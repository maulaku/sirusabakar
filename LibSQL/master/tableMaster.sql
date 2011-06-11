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

DROP TABLE msCoa;
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

DROP TABLE msDiet;
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

DROP TABLE msMenuMakanan;
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

DROP TABLE msMenuMakananDet;
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

DROP TABLE msMakanan;
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

DROP TABLE msObat;
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

DROP TABLE msKelas;
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

DROP TABLE msAlkes;
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

DROP TABLE msInvAtk;
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

DROP TABLE msHistory;
CREATE TABLE msHistory (
	id INT IDENTITY(1,1) NOT NULL,
	tipeForm 			VARCHAR(100),
	tipeTindakan 		VARCHAR(100),
	deskripsiTindakan VARCHAR(1000),
	dibuatOleh 			INT,
	waktuBuat 			DATETIME DEFAULT CURRENT_TIMESTAMP,

	PRIMARY KEY (id)
);

DROP TABLE msPengguna;
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

DROP TABLE msKaryawan;
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
	subDistrict 		VARCHAR(30),
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

DROP TABLE msPekerjaan;
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

DROP TABLE msTarifAmbulans;
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


DROP TABLE msObatHarga;
CREATE TABLE msObatHarga (
	id							INT IDENTITY(1,1) NOT NULL,
	id_obat 					INT NOT NULL, -- refer : id : ms_obat
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


INSERT INTO msPekerjaan(namaPekerjaan) VALUES ('admin');
INSERT INTO msKaryawan(nipKaryawan,namaLengkap,id_pekerjaan) VALUES ('ADMIN1', 'IVHAN',1);
INSERT INTO msPengguna(id_karyawan,namaPengguna,sandiPengguna) VALUES (1,'ADMIN','ADMIN');