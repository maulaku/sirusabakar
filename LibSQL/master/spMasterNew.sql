Create PROCEDURE [dbo].[sp_coa]
	/* 1*/ @in_action					VARCHAR(4),
	/* 2*/ @in_id_coa 					INT,
	/* 3*/ @in_kode_coa 				VARCHAR(20),
	/* 4*/ @in_nama_coa					VARCHAR(1000),
	/* 5*/ @in_tipe_coa					VARCHAR(100),
	/* 6*/ @in_note						VARCHAR(4000),
	/* 7*/ @in_user						INT
AS
	DECLARE 	
		@in_new_note					VARCHAR(5000),
		@in_new_note_update				VARCHAR(5000),
		@form_type 						VARCHAR(100),
		@action_type					VARCHAR(100),
		@action_desc					VARCHAR(1000);
BEGIN
	SET @in_new_note = 'Dibuat : ' +  dbo.fn_get_full_name_user(@in_user) + ' , tanggal : ' +
		CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_note + CHAR(10);

	IF @in_action='NEW'
		BEGIN			
			INSERT INTO ms_coa (
						/* 1*/ kode_coa,
						/* 2*/ nama_coa,
						/* 3*/ tipe_coa,
						/* 4*/ note,
						/* 5*/ create_by,
						/* 6*/ update_by
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
		END
	---------------------------------------------------
	ELSE IF @in_action='EDIT'
		BEGIN
--			SET @in_note=(SELECT note from ms_coa where id = @in_id_coa);

			SET @in_new_note = 'Dibuat : ' +  dbo.fn_get_full_name_user(@in_user) + ' , tanggal : ' +
			CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 103) + CHAR(10) + CHAR(10) + @in_note + CHAR(10);
			
			SET @in_new_note_update = @in_new_note + CHAR(10) + '--------------------' + CHAR(10) + CHAR(10)
			+ dbo.fn_get_note_coa(@in_id_coa);

			IF @in_note = ''
				BEGIN
					UPDATE ms_coa SET
								/* 1*/ kode_coa 			= @in_kode_coa,
								/* 2*/ nama_coa 			= @in_nama_coa,
								/* 3*/ tipe_coa 			= @in_tipe_coa,
								/* 4*/ update_by 			= @in_user,
								/* 5*/ update_time 		= CURRENT_TIMESTAMP
					WHERE id = @in_id_coa;
									
					SET @action_desc =	'KODE COA : ' + @in_kode_coa + CHAR(10) +
													'NAMA COA : ' + @in_nama_coa + CHAR(10) +
													'TIPE COA : ' + @in_tipe_coa + CHAR(10);													
				END
			ELSE
				BEGIN
					UPDATE ms_coa SET
								/* 1*/ kode_coa 			= @in_kode_coa,
								/* 2*/ nama_coa 			= @in_nama_coa,
								/* 3*/ tipe_coa 			= @in_tipe_coa,
								/* 3*/ note 				= @in_new_note_update,
								/* 4*/ update_by 			= @in_user,
								/* 5*/ update_time 		= CURRENT_TIMESTAMP
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
			UPDATE ms_coa SET
				/* 1*/ status 			= 0,
				/* 2*/ update_by 		= @in_user,
				/* 3*/ update_time 	= CURRENT_TIMESTAMP
			WHERE id = @in_id_coa;

			SET @form_type = 'msCOA';
			SET @action_type = 'DELETE';
			SET @action_desc =	'KODE COA : ' + @in_kode_coa + CHAR(20) +
								'NAMA COA : ' + @in_nama_coa + CHAR(1000) +
								'TIPE COA : ' + @in_tipe_coa + CHAR(100);
		END

	INSERT INTO ms_history (
				/* 1*/ form_type,
				/* 2*/ action_type,
				/* 3*/ action_desc,
				/* 4*/ create_by
	) VALUES (
				/* 1*/ @form_type,
				/* 2*/ @action_type,
				/* 3*/ @action_desc,
				/* 4*/ @in_user	
	);
							  
END

