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

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'trHistory') AND type in (N'U'))
DROP TABLE trHistory
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE trHistory (
	id 					INT IDENTITY(1,1) NOT NULL,
	tipeForm 			VARCHAR(100),
	tipeTindakan 		VARCHAR(100),
	deskripsiTindakan VARCHAR(1000),
	dibuatOleh 			INT,
	waktuBuat 			DATETIME DEFAULT CURRENT_TIMESTAMP,

	PRIMARY KEY (id)
);

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'trLayMRDaftar') AND type in (N'U'))
DROP TABLE trLayMRDaftar
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE trLayMRDaftar (
	id								INT IDENTITY(1,1) NOT NULL,
	noMR							VARCHAR(20),
	titleID 						INT,
	NamePasien	 				VARCHAR(200),
	panggilan		 			VARCHAR(100),
	sex		 					CHAR(1),
	tempatLahir					VARCHAR(100),
	tglLahir						DATETIME,	
	agamaID						INT,
	sukuBangsa					VARCHAR(100),
	wargaNegara					VARCHAR(100),
	golDarah						CHAR(2),
	statusMR						CHAR(1),
	pendidikanID				INT,
	pekerjaanID					INT,	
	alamat						VARCHAR(1000),
	propinsiID						INT,
	kota              		VARCHAR(100),
	kodePos						VARCHAR(5),
	telepon						VARCHAR(100),
	handphone					VARCHAR(100),
	kabupatenID					INT,
	kecamatanID					INT,
	kelurahanID					INT,
	namaIstri					VARCHAR(100),
	namaSuami					VARCHAR(100),
	namaAyah						VARCHAR(100),
	namaIbu						VARCHAR(100),
	statusPenanggung			INT,
	namaPenanggung				VARCHAR(100),
	HubKelID						INT,
	HubKelLain					VARCHAR(100),
	alamatPenanggung			VARCHAR(1000),
	teleponPenanggung			VARCHAR(100),
	handphonePenanggung		VARCHAR(100),
	--------------------------------
	catatan						TEXT DEFAULT '-',
	status 						INT DEFAULT 1,
	--------------------------------
	dibuatOleh 					INT,
	dieditOleh 					INT,
	waktuBuat 					DATETIME DEFAULT CURRENT_TIMESTAMP,
	waktuEdit 					DATETIME DEFAULT CURRENT_TIMESTAMP,
	
	PRIMARY KEY (id)	
);

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'trLayMRRegis') AND type in (N'U'))
DROP TABLE trLayMRRegis
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE trLayMRRegis (
	id								INT IDENTITY(1,1) NOT NULL
	, idLayMRDaftar			INT NOT NULL
	, noMR						VARCHAR(20) NOT NULL
	, tglRegis					DATETIME
	, noRegis					VARCHAR(10)
	, asalPasien				VARCHAR(10)
	, tujuanBerobat			VARCHAR(100)
	, namaPerujuk				VARCHAR(100)
	, namaDokter				VARCHAR(100)
	, caraPembayaran			VARCHAR(100)
	, namaAsuransi				VARCHAR(100)
	, namaPerusahaan			VARCHAR(100)
	, noKartu					VARCHAR(100)
	, noPolis					VARCHAR(100)
	--------------------------------
	, catatan 					TEXT DEFAULT '-'
	, status 					INT DEFAULT 1
	--------------------------------
	, dibuatOleh 				INT
	, dieditOleh 				INT
	, waktuBuat 				DATETIME DEFAULT CURRENT_TIMESTAMP
	, waktuEdit 				DATETIME DEFAULT CURRENT_TIMESTAMP
	
	, PRIMARY KEY (id)  
);


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'msHistoryLayanan') AND type in (N'U'))
DROP TABLE msHistoryLayanan
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE msHistoryLayanan (
	id 							INT IDENTITY(1,1) NOT NULL
	, formType 					VARCHAR(100) 
	, actionType 				VARCHAR(100)
	, actionDesc 				VARCHAR(1000)
	, createBy 					INT
	, createTime 				DATETIME DEFAULT CURRENT_TIMESTAMP

	, PRIMARY KEY (id)
);

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'tr_log_client_permintaan_hdr') AND type in (N'U'))
DROP TABLE tr_log_client_permintaan_hdr
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE tr_log_client_permintaan_hdr(
	[id] [int] IDENTITY(1,1) NOT NULL,
	[no_permintaan] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[tgl_permintaan] [datetime] NOT NULL,
	[id_bagian] [int] NOT NULL,
	[status] [int] NULL,
	[createby] [int] NULL,
	[updateby] [int] NULL,
	[createtime] [datetime] NULL,
	[updatetime] [datetime] NULL,
 CONSTRAINT [PK_tr_log_client_permintaaan_hdr] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY];

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'tr_log_client_permintaan_det') AND type in (N'U'))
DROP TABLE tr_log_client_permintaan_det
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE tr_log_client_permintaan_det(
	[id] [int] IDENTITY(1,1) NOT NULL,
	[permintaanid] [int] NOT NULL,
	[itemcat_id] [int] NOT NULL,
	[itemkel_id] [int] NOT NULL,
	[itemjenis_id] [int] NOT NULL,
	[item_id] [int] NOT NULL,
	[item_kode] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[item_name] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[uom] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY];