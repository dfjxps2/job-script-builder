
-- ----------------------------
-- Procedure structure for sync_job_configuration
-- ----------------------------
DROP PROCEDURE IF EXISTS `sync_job_configuration`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sync_job_configuration`(in p_task_id int)
begin
	-- variable declaration
	declare v_sqlstate, v_message_text varchar(512);
	declare v_data_tbl_cn_nm, v_db_phys_nm, v_data_tbl_phys_nm varchar(100) default null;
	declare v_data_tbl_id int default null;

	-- condition declaration

	-- cursor declaration

	-- handler declaration

	create temporary table if not exists trace_log (
		id int auto_increment,
		time timestamp,
		msg varchar(256),
		primary key(id)
	);

	delete from trace_log;

	begin
		declare exit handler for not found
		begin
			signal sqlstate '45000' set message_text = 'the specified task id is not found.';
		end;

		select t.data_tbl_cn_nm, d.db_phys_nm, t.data_tbl_phys_nm, t.data_tblid
		into v_data_tbl_cn_nm, v_db_phys_nm, v_data_tbl_phys_nm, v_data_tbl_id
		from db d, data_tbl t, data_trans_task task
		where task.data_trans_task_id = p_task_id
		and task.target_tbl_id = t.data_tblid
		and d.dbid = t.dbid
		;

	end;

	insert into trace_log (time, msg) values (now(), concat('schema name = [', v_db_phys_nm, '], table_name = [', v_data_tbl_phys_nm, ']'));

	begin
		declare exit handler for sqlexception
		begin
			get diagnostics condition 1 v_sqlstate = returned_sqlstate, v_message_text = message_text; 
			rollback;
			insert into trace_log (time, msg) values (now(), concat('sqlstate=', v_sqlstate, ', message=', v_message_text)); 
			resignal;
		end;

		start transaction;

		delete from etlman_db.etl_tasks where table_name = v_data_tbl_cn_nm and schema_name = v_db_phys_nm;
		delete from etlman_db.dw_table where table_name = v_data_tbl_cn_nm and schema_name = v_db_phys_nm;
		delete from etlman_db.dw_columns where table_name = v_data_tbl_cn_nm and schema_name = v_db_phys_nm;
		delete from etlman_db.dw_table_mapping where table_name = v_data_tbl_cn_nm and schema_name = v_db_phys_nm;
		delete from etlman_db.dw_column_mapping where table_name = v_data_tbl_cn_nm and schema_name = v_db_phys_nm;

		delete from etlman_db.src_table_analysis
		where (schema_name, table_name) in (
				select d.db_phys_nm as schema_name, 
							 t.data_tbl_cn_nm as table_name
				from data_trans_src s, data_tbl t, db d
				where s.data_trans_task_id = p_task_id
				and s.src_tbl_id = t.data_tblid
				and t.dbid = d.dbid
		);

		insert into etlman_db.etl_tasks (task_name, serial_no, sys_name, schema_name, table_name)
		values (v_data_tbl_cn_nm, 0, '数据平台', v_db_phys_nm, v_data_tbl_cn_nm);

		insert into etlman_db.dw_table (sys_name, schema_name, table_name, phy_name, load_mode, is_fact, is_single_source)
		select '数据平台', v_db_phys_nm, v_data_tbl_cn_nm, v_data_tbl_phys_nm, 
					case when load_mode = 0 then '更新' else '追加' end, 
					case when data_tbl_type = 0 then 1 else 0 end, 
					1
		from data_tbl t
		where t.data_tblid = v_data_tbl_id
		;

		insert into etlman_db.dw_columns (sys_name, schema_name, table_name, column_name, column_id, data_type, phy_name, is_pk, is_partition_key)
		select '数据平台', v_db_phys_nm, v_data_tbl_cn_nm, fld_cn_nm, fld_ord, fld_data_type, fld_phys_nm, 
		case when if_pk is null then 0 else if_pk end, is_partkey
		from data_fld f
		where f.data_tblid = v_data_tbl_id
		and f.fld_phys_nm <> 'data_dt'
		and f.del_dt is null
		;

		insert into etlman_db.src_table_analysis (sys_name, schema_name, table_name, cn_name, stbl_name)
		select distinct 
       '数据平台', 
       d_origin.db_phys_nm, 
       coalesce(t.data_tbl_cn_nm, ''),
       coalesce(t.data_tbl_cn_nm, ''),
       coalesce(s.batch_pre_target_tbl_nm, 
          concat(case s.data_ver when 0 then d_origin.db_phys_nm when 1 then d_cleanse.db_phys_nm end, '.', t.data_tbl_phys_nm))
		from 
        (select s.*, p.batch_pre_target_tbl_nm
         from data_trans_src s left join data_trans_batch_pre p
         on s.data_trans_src_id = p.data_trans_src_id
        ) s, data_tbl t, db d_origin, db d_cleanse, data_part p_origin, data_part p_cleanse
		where s.data_trans_task_id = p_task_id
		and s.src_tbl_id = t.data_tblid
		and t.dbid = d_origin.dbid
    and d_origin.partid = p_origin.partid
    and d_cleanse.partid = p_cleanse.partid
    and p_origin.tnmtid = p_cleanse.tnmtid
    and d_cleanse.db_usageid = 3 -- 清洗库
		;
	 

		insert into etlman_db.dw_table_mapping 
			(sys_name, schema_name, table_name, src_sys_name, src_schema, src_table_name, load_batch, 
			join_order, table_alias, join_type, join_condition, filter_condition)
		select '数据平台', v_db_phys_nm, v_data_tbl_cn_nm, '数据平台', 
           d.db_phys_nm, coalesce(t.data_tbl_cn_nm, ''), s.task_batch, join_order, src_tbl_alias,
					case join_type
						when 0 then 'inner join'
						when 1 then 'left outer join'
						when 2 then 'right outer join'
						when 3 then 'full outer join'
						else 'unknown'
					end,
					join_cond, filter_cond
		from data_trans_src s, data_trans_batch b, data_tbl t, db d
		where s.data_trans_task_id = p_task_id
		and s.data_trans_task_id = b.data_trans_task_id
		and s.task_batch = b.task_batch
		and b.batch_handle_mod = 0				-- 采用字段映射定义的批次
		and s.src_tbl_id = t.data_tblid
		and t.dbid = d.dbid
		;


		insert into etlman_db.dw_column_mapping (sys_name, schema_name, table_name, column_name, 
				src_sys_name, src_schema, src_table_name, src_column_name, load_batch, load_group, column_expr)
		select '数据平台', v_db_phys_nm, v_data_tbl_cn_nm, tf.fld_cn_nm,
					'数据平台', coalesce(sd.db_phys_nm, ''), coalesce(st.data_tbl_cn_nm, ''), coalesce(sf.fld_phys_nm, ''), 
					m.task_batch, map_grp, fld_asgn_expr
		from data_trans_fld_map m join data_trans_batch b
			on m.data_trans_task_id = b.data_trans_task_id
			and m.task_batch = b.task_batch
		join data_fld tf
			on tf.fldid = m.target_fld_id
		left join data_fld sf
			on sf.fldid = m.src_fld_id
		left join data_tbl st
			on sf.data_tblid = st.data_tblid
		left join db sd
			on st.dbid = sd.dbid
		where m.data_trans_task_id = p_task_id
		and tf.fld_phys_nm <> 'data_dt'
		and b.batch_handle_mod = 0
		;

		commit;
	end;
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for sync_job_configuration_4_dev
-- ----------------------------
DROP PROCEDURE IF EXISTS `sync_job_configuration_4_dev`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sync_job_configuration_4_dev`(in p_task_id int)
begin
	-- variable declaration
	declare v_sqlstate, v_message_text varchar(512);
	declare v_data_tbl_cn_nm, v_db_phys_nm, v_data_tbl_phys_nm varchar(100) default null;
	declare v_data_tbl_id int default null;

	-- condition declaration

	-- cursor declaration

	-- handler declaration

	create temporary table if not exists trace_log (
		id int auto_increment,
		time timestamp,
		msg varchar(256),
		primary key(id)
	);

	delete from trace_log;

	begin
		declare exit handler for not found
		begin
			signal sqlstate '45000' set message_text = 'the specified task id is not found.';
		end;

		select t.data_tbl_cn_nm, dev.db_phys_nm, t.data_tbl_phys_nm, t.data_tblid
		into v_data_tbl_cn_nm, v_db_phys_nm, v_data_tbl_phys_nm, v_data_tbl_id
		from db d, data_tbl t, data_trans_task task, db dev
		where task.data_trans_task_id = p_task_id
		and task.target_tbl_id = t.data_tblid
		and d.dbid = t.dbid
	  and d.dev_dbid = dev.dbid
		;

	end;

	insert into trace_log (time, msg) values (now(), concat('schema name = [', v_db_phys_nm, '], table_name = [', v_data_tbl_phys_nm, ']'));

	begin
		declare exit handler for sqlexception
		begin
			get diagnostics condition 1 v_sqlstate = returned_sqlstate, v_message_text = message_text; 
			rollback;
			insert into trace_log (time, msg) values (now(), concat('sqlstate=', v_sqlstate, ', message=', v_message_text)); 
			resignal;
		end;

		start transaction;

		delete from etlman_db.etl_tasks where table_name = v_data_tbl_cn_nm and schema_name = v_db_phys_nm;
		delete from etlman_db.dw_table where table_name = v_data_tbl_cn_nm and schema_name = v_db_phys_nm;
		delete from etlman_db.dw_columns where table_name = v_data_tbl_cn_nm and schema_name = v_db_phys_nm;
		delete from etlman_db.dw_table_mapping where table_name = v_data_tbl_cn_nm and schema_name = v_db_phys_nm;
		delete from etlman_db.dw_column_mapping where table_name = v_data_tbl_cn_nm and schema_name = v_db_phys_nm;

		delete from etlman_db.src_table_analysis
		where (schema_name, table_name) in (
				select d.db_phys_nm as schema_name, 
							 t.data_tbl_cn_nm as table_name
				from data_trans_src s, data_tbl t, db d
				where s.data_trans_task_id = p_task_id
				and s.src_tbl_id = t.data_tblid
				and t.dbid = d.dbid
		);

		insert into etlman_db.etl_tasks (task_name, serial_no, sys_name, schema_name, table_name)
		values (concat(v_data_tbl_cn_nm, '_测试'), 0, '数据平台', v_db_phys_nm, v_data_tbl_cn_nm);

		insert into etlman_db.dw_table (sys_name, schema_name, table_name, phy_name, load_mode, is_fact, is_single_source)
		select '数据平台', v_db_phys_nm, v_data_tbl_cn_nm, v_data_tbl_phys_nm, 
					case when load_mode = 0 then '更新' else '追加' end, 
					case when data_tbl_type = 0 then 1 else 0 end, 
					1
		from data_tbl t
		where t.data_tblid = v_data_tbl_id
		;

		insert into etlman_db.dw_columns (sys_name, schema_name, table_name, column_name, column_id, data_type, phy_name, is_pk, is_partition_key)
		select '数据平台', v_db_phys_nm, v_data_tbl_cn_nm, fld_cn_nm, fld_ord, fld_data_type, fld_phys_nm, 
		case when if_pk is null then 0 else if_pk end, is_partkey
		from data_fld f
		where f.data_tblid = v_data_tbl_id
		and f.fld_phys_nm <> 'data_dt'
		and f.del_dt is null
		;

		insert into etlman_db.src_table_analysis (sys_name, schema_name, table_name, cn_name, stbl_name)
		select distinct 
       '数据平台', 
       d_origin.db_phys_nm, 
       coalesce(t.data_tbl_cn_nm, ''),
       coalesce(t.data_tbl_cn_nm, ''),
       coalesce(s.batch_pre_target_tbl_nm, 
          concat(case s.data_ver when 0 then d_origin_dev.db_phys_nm when 1 then d_cleanse_dev.db_phys_nm end, '.', t.data_tbl_phys_nm))
		from 
        (select s.*, p.batch_pre_target_tbl_nm
         from data_trans_src s left join data_trans_batch_pre p
         on s.data_trans_src_id = p.data_trans_src_id
        ) s, data_tbl t, db d_origin, db d_cleanse, data_part p_origin, data_part p_cleanse,
         db d_origin_dev, db d_cleanse_dev
		where s.data_trans_task_id = p_task_id
		and s.src_tbl_id = t.data_tblid
		and t.dbid = d_origin.dbid
    and d_origin.partid = p_origin.partid
    and d_cleanse.partid = p_cleanse.partid
    and p_origin.tnmtid = p_cleanse.tnmtid
    and d_cleanse.db_usageid = 3 -- 清洗库
    and d_origin.dev_dbid = d_origin_dev.dbid
    and d_cleanse.dev_dbid = d_cleanse_dev.dbid
		;

		insert into etlman_db.dw_table_mapping 
			(sys_name, schema_name, table_name, src_sys_name, src_schema, src_table_name, load_batch, 
			join_order, table_alias, join_type, join_condition, filter_condition)
		select '数据平台', v_db_phys_nm, v_data_tbl_cn_nm, '数据平台', 
           d.db_phys_nm, coalesce(t.data_tbl_cn_nm, ''), s.task_batch, join_order, src_tbl_alias,
					case join_type
						when 0 then 'inner join'
						when 1 then 'left outer join'
						when 2 then 'right outer join'
						when 3 then 'full outer join'
						else 'unknown'
					end,
					join_cond, filter_cond
		from data_trans_src s, data_trans_batch b, data_tbl t, db d
		where s.data_trans_task_id = p_task_id
		and s.data_trans_task_id = b.data_trans_task_id
		and s.task_batch = b.task_batch
		and b.batch_handle_mod = 0				-- 采用字段映射定义的批次
		and s.src_tbl_id = t.data_tblid
		and t.dbid = d.dbid
		;


		insert into etlman_db.dw_column_mapping (sys_name, schema_name, table_name, column_name, 
				src_sys_name, src_schema, src_table_name, src_column_name, load_batch, load_group, column_expr)
		select '数据平台', v_db_phys_nm, v_data_tbl_cn_nm, tf.fld_cn_nm,
					'数据平台', coalesce(sd.db_phys_nm, ''), coalesce(st.data_tbl_cn_nm, ''), coalesce(sf.fld_phys_nm, ''), 
					m.task_batch, map_grp, fld_asgn_expr
		from data_trans_fld_map m join data_trans_batch b
			on m.data_trans_task_id = b.data_trans_task_id
			and m.task_batch = b.task_batch
		join data_fld tf
			on tf.fldid = m.target_fld_id
		left join data_fld sf
			on sf.fldid = m.src_fld_id
		left join data_tbl st
			on sf.data_tblid = st.data_tblid
		left join db sd
			on st.dbid = sd.dbid
		where m.data_trans_task_id = p_task_id
		and tf.fld_phys_nm <> 'data_dt'
		and b.batch_handle_mod = 0
		;

		commit;
	end;
end
;;
DELIMITER ;
