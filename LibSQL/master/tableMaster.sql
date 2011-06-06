-- DATABASE PLANNING SIRS : MASTER --
----------------------------------------------------------------------------------------------------------
-- Create by : Ivhan Famly Gunawan
-- Date : April 2011
-- Database : SQL Server
-- Penulisan : Campur (English + Indonesia)
----------------------------------------------------------------------------------------------------------
USE [SIRS]
GO
----------------------------------------------------------------------------------------------------------
-- Composition Word for Table's Name 
----------------------------------------------------------------------------------------------------------
-- Example : ms_coa
-- 1. ms : jenis table (master, transaksi)
-- 2. coa : nama table
----------------------------------------------------------------------------------------------------------

DROP TABLE ms_coa;
CREATE TABLE ms_coa (
	id						INT IDENTITY(1,1) NOT NULL,
	kode_coa 			VARCHAR(20) NOT NULL,
	nama_coa 			VARCHAR (100) NOT NULL,
	tipe_coa 			VARCHAR (100),
	--------------------------------
	note 					TEXT 			DEFAULT '-',
	status 				INT DEFAULT 1, --> if u delete data then status = 0, else status = 1
	--------------------------------
	create_by 			INT,
	update_by 			INT,
	create_time 		DATETIME DEFAULT CURRENT_TIMESTAMP,
	update_time 		DATETIME DEFAULT CURRENT_TIMESTAMP,
	
	PRIMARY KEY (id)	
);

DROP TABLE ms_diet;
CREATE TABLE ms_diet (
	id						INT IDENTITY(1,1) NOT NULL,
	kode_diet 			VARCHAR(20) NOT NULL,
	nama_diet 			VARCHAR(100) NOT NULL,
	--------------------------------
	note 					TEXT DEFAULT '-',
	status 				INT DEFAULT 1, --> if u delete data then status = 0, else status = 1
	--------------------------------
	create_by 			INT,
	update_by 			INT,
	create_time 		DATETIME DEFAULT CURRENT_TIMESTAMP,
	update_time 		DATETIME DEFAULT CURRENT_TIMESTAMP,
	
	PRIMARY KEY (id)	
);

DROP TABLE ms_menu_makanan;
CREATE TABLE ms_menu_makanan (
	id						INT IDENTITY(1,1) NOT NULL,
	kode_menu 			VARCHAR(20) NOT NULL,
	id_diet 				INT NOT NULL, -- refer : id -- table : ms_diet
	kelompok				VARCHAR(100),
	waktu					VARCHAR(100),
	--------------------------------
	note 					TEXT DEFAULT '-',
	status 				INT DEFAULT 1, --> if u delete data then status = 0, else status = 1
	--------------------------------
	create_by 			INT,
	update_by 			INT,
	create_time 		DATETIME DEFAULT CURRENT_TIMESTAMP,
	update_time 		DATETIME DEFAULT CURRENT_TIMESTAMP,
	
	PRIMARY KEY (id)	
);

DROP TABLE ms_menu_makanan_det;
CREATE TABLE ms_menu_makanan_det (
	id						INT IDENTITY(1,1) NOT NULL,
	id_menu_makanan 	INT NOT NULL, -- refer : id -- table : ms_menu_makanan
	id_makanan			INT NOT NULL, -- refer : id -- table : ms_makanan
	jumlah				INT NOT NULL,
	--------------------------------
	status 				INT DEFAULT 1, --> if u delete data then status = 0, else status = 1
	--------------------------------
	create_by 			INT,
	create_time 		DATETIME DEFAULT CURRENT_TIMESTAMP,
	
	PRIMARY KEY (id)	
);

DROP TABLE ms_makanan;
CREATE TABLE ms_makanan (
	id						INT IDENTITY(1,1) NOT NULL,
	nama_makanan 		VARCHAR(100) NOT NULL,
	--------------------------------
	note 					TEXT DEFAULT '-',
	status 				INT DEFAULT 1, --> if u delete data then status = 0, else status = 1
	--------------------------------
	create_by 			INT,
	update_by 			INT,
	create_time 		DATETIME DEFAULT CURRENT_TIMESTAMP,
	update_time 		DATETIME DEFAULT CURRENT_TIMESTAMP,
	
	PRIMARY KEY (id)	
);

DROP TABLE ms_obat;
CREATE TABLE ms_obat (
	id						INT IDENTITY(1,1) NOT NULL,
	kode_obat			VARCHAR(20) NOT NULL,
	nama_obat 			VARCHAR(100) NOT NULL,
	golongan_obat		VARCHAR(100),
	kategory_obat		VARCHAR(100),
	satuan_beli			VARCHAR(100),
	satuan_jual			VARCHAR(100),
	isi					INT,
	stok_min				INT,
	--------------------------------
	note 					TEXT DEFAULT '-',
	status 				INT DEFAULT 1, --> if u delete data then status = 0, else status = 1
	--------------------------------
	create_by 			INT,
	update_by 			INT,
	create_time 		DATETIME DEFAULT CURRENT_TIMESTAMP,
	update_time 		DATETIME DEFAULT CURRENT_TIMESTAMP,
	
	PRIMARY KEY (id)	
);

DROP TABLE ms_kelas;
CREATE TABLE ms_kelas (
	id						INT IDENTITY(1,1) NOT NULL,
	kode_kelas 			VARCHAR(20) NOT NULL,
	nama_kelas 			VARCHAR(100),
	--------------------------------
	note 					TEXT DEFAULT '-',
	status 				INT DEFAULT 1, --> if u delete data then status = 0, else status = 1
	--------------------------------
	create_by 			INT,
	update_by 			INT,
	create_time 		DATETIME DEFAULT CURRENT_TIMESTAMP,
	update_time 		DATETIME DEFAULT CURRENT_TIMESTAMP,
	
	PRIMARY KEY (id)	
);

DROP TABLE ms_alkes;
CREATE TABLE ms_alkes (
	id						INT IDENTITY(1,1) NOT NULL,
	kode_alkes 			VARCHAR(20) NOT NULL,
	nama_alkes 			VARCHAR(100),
	jenis_alkes 		VARCHAR(100),
	group_alkes 		VARCHAR(100),
	satuan				VARCHAR(100),
	minimum				INT,
	--------------------------------
	note 					TEXT DEFAULT '-',
	status 				INT DEFAULT 1, --> if u delete data then status = 0, else status = 1
	--------------------------------
	create_by 			INT,
	update_by 			INT,
	create_time 		DATETIME DEFAULT CURRENT_TIMESTAMP,
	update_time 		DATETIME DEFAULT CURRENT_TIMESTAMP,
	
	PRIMARY KEY (id)	
);

DROP TABLE ms_inv_atk;
CREATE TABLE ms_inv_atk (
	id						INT IDENTITY(1,1) NOT NULL,
	kode_inv_atk 		VARCHAR(20) NOT NULL,
	nama_inv_atk 		VARCHAR(100),
	jenis_inv_atk 		VARCHAR(100),
	group_inv_atk 		VARCHAR(100),
	satuan				VARCHAR(100),
	minimum				INT,
	--------------------------------
	note 					TEXT DEFAULT '-',
	status 				INT DEFAULT 1, --> if u delete data then status = 0, else status = 1
	--------------------------------
	create_by 			INT,
	update_by 			INT,
	create_time 		DATETIME DEFAULT CURRENT_TIMESTAMP,
	update_time 		DATETIME DEFAULT CURRENT_TIMESTAMP,
	
	PRIMARY KEY (id)	
);

DROP TABLE ms_history;
CREATE TABLE ms_history (
	id INT IDENTITY(1,1) NOT NULL,
	form_type 			VARCHAR(100),
	action_type 		VARCHAR(100),
	action_desc 		VARCHAR(1000),
	create_by 			INT,
	create_time 		DATETIME DEFAULT CURRENT_TIMESTAMP,

	PRIMARY KEY (id)
);

DROP TABLE ms_user;
CREATE TABLE ms_user (
	id					INT IDENTITY(1,1) NOT NULL,
	id_employee 	INT NOT NULL, -- refer --> id : ms_employee
	user_name 		VARCHAR (20) NOT NULL,
	pass 				VARCHAR (20) NOT NULL,
	--------------------------------
	note 				TEXT DEFAULT '-',
	status 			INT DEFAULT 1,
	--------------------------------
	create_by 		INT,
	update_by 		INT,
	create_time 	DATETIME DEFAULT CURRENT_TIMESTAMP,
	update_time 	DATETIME DEFAULT CURRENT_TIMESTAMP,
	
	PRIMARY KEY (id)	
);

DROP TABLE ms_employee;
CREATE TABLE ms_employee (
	id						INT IDENTITY(1,1) NOT NULL,
	nip_employee 		VARCHAR(20) NOT NULL, --> NIP = No Induk Pegawai
	full_name 			VARCHAR (100) NOT NULL,
	birth_place 		VARCHAR (50),
	birth_date 			DATETIME,
	religion 			VARCHAR(50),
	gender 				VARCHAR(50),
	address 				VARCHAR(500),
	phone_no 			VARCHAR(30), 
	mobile_no 			VARCHAR(30),
	city 					VARCHAR(30),
	sub_district 		VARCHAR(30),
	education 			VARCHAR(30),
	employee_status 	VARCHAR(30),
	--------------------------------
	job_id 				INT, -- refer --> id : ms_job
	job_position 		VARCHAR(30),
	--------------------------------
	maritaal_status 	VARCHAR(30),
	bank_id 				INT,
	bank_account 		VARCHAR(20),
	--------------------------------
	note 					TEXT DEFAULT '-',
	status 				INT DEFAULT 1,
	--------------------------------
	create_by 			INT,
	update_by 			INT,
	create_time 		DATETIME DEFAULT CURRENT_TIMESTAMP,
	update_time 		DATETIME DEFAULT CURRENT_TIMESTAMP,
	
	PRIMARY KEY (id)	
);

DROP TABLE ms_job;
CREATE TABLE ms_job (
	id					INT IDENTITY(1,1) NOT NULL,
	job_name 		VARCHAR(100) NOT NULL,
	--------------------------------
	note 				TEXT DEFAULT '-',
	status 			INT DEFAULT 1,
	--------------------------------
	create_by 		INT,
	update_by 		INT,
	create_time 	DATETIME DEFAULT CURRENT_TIMESTAMP,
	update_time 	DATETIME DEFAULT CURRENT_TIMESTAMP,
	
	PRIMARY KEY (id)	
);

DROP TABLE msTarifAmbulance;
CREATE TABLE msTarifAmbulance (
	id								INT IDENTITY(1,1) NOT NULL,
	kodeTarif 				VARCHAR(100) NOT NULL,
	daerah 						TEXT DEFAULT '-',
	tujuan 						INT DEFAULT 1,
	tarif							DECIMAL,
	pendampingMedis		DECIMAL,
	paraMedis					DECIMAL,
	paraMedisPP				DECIMAL,
	oksigen						DECIMAL,
	monitor						DECIMAL,
	--------------------------------
	note 							TEXT DEFAULT '-',
	status 						INT DEFAULT 1,
	--------------------------------
	create_by 				INT,
	update_by 				INT,
	create_time 			DATETIME DEFAULT CURRENT_TIMESTAMP,
	update_time 			DATETIME DEFAULT CURRENT_TIMESTAMP,
	
	PRIMARY KEY (id)	
);

DROP TABLE tr_log_client_permintaaan_hdr;
CREATE TABLE tr_log_client_permintaaan_hdr(
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

INSERT INTO ms_job (job_name) VALUES ('admin');
INSERT INTO ms_employee (nip_employee,full_name,job_id) VALUES ('ADMIN1', 'NAMA ADMIN',1);
INSERT INTO ms_user (id_employee,user_name,pass) VALUES (1,'ADMIN','ADMIN');