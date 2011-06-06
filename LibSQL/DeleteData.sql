-- RANCANGAN DELETE DATA--
----------------------------------------------------------
-- Create by : Ivhan Famly Gunawan....
-- Date : April 2011
-- Database : SQL Server
-- Penulisan : Campur
----------------------------------------------------------
USE [SIRS]
GO
----------------------------------------------------------------------------------------------------------
---------- DELETE TABLE
----------------------------------------------------------------------------------------------------------

DROP TABLE ms_coa;
DROP TABLE ms_diet;
DROP TABLE ms_menu_makanan;
DROP TABLE ms_menu_makanan_det;
DROP TABLE ms_makanan;
DROP TABLE ms_kelas;
DROP TABLE ms_alkes;
DROP TABLE ms_inv_atk;
DROP TABLE ms_history;
DROP TABLE ms_user;
DROP TABLE ms_employee;
DROP TABLE ms_job;

----------------------------------------------------------------------------------------------------------
---------- DELETE DATA
----------------------------------------------------------------------------------------------------------

DELETE FROM ms_coa;
DELETE FROM ms_diet;
DELETE FROM ms_menu_makanan;
DELETE FROM ms_menu_makanan_det;
DELETE FROM ms_makanan;
DELETE FROM ms_kelas;
DELETE FROM ms_alkes;
DELETE FROM ms_inv_atk;
DELETE FROM ms_history;
DELETE FROM ms_user;
DELETE FROM ms_employee;
DELETE FROM ms_job;