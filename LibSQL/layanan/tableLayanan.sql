-- DATABASE PLANNING SIRS : LAYANAN --
----------------------------------------------------------------------------------------------------------
-- Create by : Ivhan Famly Gunawan
-- Date : April 2011
-- Database : SQL Server
-- Penulisan : Campur
----------------------------------------------------------------------------------------------------------
USE [SIRS]
GO
----------------------------------------------------------------------------------------------------------
-- Composition Word for Table's Name 
----------------------------------------------------------------------------------------------------------
-- Example : msLayMRDaftar
-- 1. ms : jenis table (master, transaksi)
-- 2. LayMRDaftar : nama table
----------------------------------------------------------------------------------------------------------


DROP TABLE trLayMRDaftar;
CREATE TABLE trLayMRDaftar (
	id								INT IDENTITY(1,1) NOT NULL,
	noMR							VARCHAR(20),
	title 						VARCHAR(8),
	patientName 			VARCHAR(100),
	panggilan		 			VARCHAR(100),
	sex		 						VARCHAR(10),
	tempatLahir				VARCHAR(100),
	tglLahir					DATETIME,
	umur							INT,		
	agama							VARCHAR(100),
	sukuBangsa				VARCHAR(100),
	wargaNegara				VARCHAR(100),
	golDarah					VARCHAR(8),
	statusMR					VARCHAR(50),
	pendidikan				VARCHAR(20),
	pekerjaan					VARCHAR(100),	
	alamat						VARCHAR(1000),
	provinsi					VARCHAR(100),
	kota              VARCHAR(100),
	kodePos						VARCHAR(100),
	telepon						VARCHAR(100),
	handphone					VARCHAR(100),
	kabupaten					VARCHAR(100),
	kecamatan					VARCHAR(100),
	kelurahan					VARCHAR(100),
	namaIstri					VARCHAR(100),
	namaSuami					VARCHAR(100),
	namaAyah					VARCHAR(100),
	namaIbu						VARCHAR(100),
	statusPenanggung	INT,
	namaP							VARCHAR(100),
	hubunganP					VARCHAR(100),
	hubunganPLain			VARCHAR(100),
	alamatP						VARCHAR(1000),
	teleponP					VARCHAR(100),
	handphoneP				VARCHAR(100),
	--------------------------------
	note 							TEXT DEFAULT '-',
	status 						INT DEFAULT 1,
	--------------------------------
	createBy 				INT,
	updateBy 				INT,
	createTime 			DATETIME DEFAULT CURRENT_TIMESTAMP,
	updateTime 			DATETIME DEFAULT CURRENT_TIMESTAMP,
	
	PRIMARY KEY (id)	
);

DROP TABLE msHistoryLayanan;
CREATE TABLE msHistoryLayanan (
	id 							INT IDENTITY(1,1) NOT NULL,
	formType 			VARCHAR(100),
	actionType 		VARCHAR(100),
	actionDesc 		VARCHAR(1000),
	createBy 			INT,
	createTime 		DATETIME DEFAULT CURRENT_TIMESTAMP,

	PRIMARY KEY (id)
);

