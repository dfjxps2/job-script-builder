/*
Navicat MySQL Data Transfer

Source Server         : MySQL
Source Server Version : 50722
Source Host           : localhost:3306
Source Database       : etlman_db

Target Server Type    : MYSQL
Target Server Version : 50722
File Encoding         : 65001

Date: 2019-11-13 17:03:54
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for analysis_question
-- ----------------------------
DROP TABLE IF EXISTS `analysis_question`;
CREATE TABLE `analysis_question` (
  `sys_name` varchar(64) NOT NULL COMMENT '系统名称 -- ',
  `schema_name` varchar(64) NOT NULL COMMENT '数据区名称 -- ',
  `table_name` varchar(64) NOT NULL COMMENT '目标表名称 -- ',
  `column_name` varchar(64) NOT NULL COMMENT '字段名称 -- ',
  `serial_no` int(11) DEFAULT NULL COMMENT '序号 -- ',
  `question` varchar(512) DEFAULT NULL COMMENT '问题描述 -- ',
  `reply` varchar(512) DEFAULT NULL COMMENT '问题答复 -- ',
  `submit_date` date DEFAULT NULL COMMENT '问题提交日期 -- ',
  `reply_date` date DEFAULT NULL COMMENT '问题答复日期 -- ',
  `reply_prsn` varchar(64) DEFAULT NULL COMMENT '答复人 -- ',
  `comments` varchar(512) DEFAULT NULL COMMENT '备注 -- ',
  PRIMARY KEY (`sys_name`,`schema_name`,`table_name`,`column_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='调研问题表';

-- ----------------------------
-- Records of analysis_question
-- ----------------------------

-- ----------------------------
-- Table structure for column_stats
-- ----------------------------
DROP TABLE IF EXISTS `column_stats`;
CREATE TABLE `column_stats` (
  `sys_name` varchar(64) NOT NULL COMMENT '系统名称 -- ',
  `schema_name` varchar(64) NOT NULL COMMENT '数据区名称 -- ',
  `table_name` varchar(64) NOT NULL COMMENT '目标表名称 -- ',
  `column_name` varchar(64) NOT NULL COMMENT '字段名称 -- ',
  `collect_time` date NOT NULL COMMENT '统计时间 -- ',
  `max_value` varchar(128) DEFAULT NULL COMMENT '最大值 -- ',
  `min_value` varchar(128) DEFAULT NULL COMMENT '最小值 -- ',
  `value_count` int(11) DEFAULT NULL COMMENT '取值数目 -- ',
  `null_count` int(11) DEFAULT NULL COMMENT '空值数目 -- ',
  `value_histogram_id` varchar(20) DEFAULT NULL COMMENT '值域分布ID -- ',
  PRIMARY KEY (`sys_name`,`schema_name`,`table_name`,`column_name`,`collect_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='字段统计信息';

-- ----------------------------
-- Records of column_stats
-- ----------------------------

-- ----------------------------
-- Table structure for col_value_histogram
-- ----------------------------
DROP TABLE IF EXISTS `col_value_histogram`;
CREATE TABLE `col_value_histogram` (
  `value_histogram_id` varchar(20) NOT NULL COMMENT '值域分布ID -- ',
  `mode_value` varchar(128) NOT NULL COMMENT '特征值 -- ',
  `mode_value_freq` int(11) DEFAULT NULL COMMENT '特征值出现频率 -- ',
  PRIMARY KEY (`value_histogram_id`,`mode_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='字段值域分布';

-- ----------------------------
-- Records of col_value_histogram
-- ----------------------------

-- ----------------------------
-- Table structure for dw_columns
-- ----------------------------
DROP TABLE IF EXISTS `dw_columns`;
CREATE TABLE `dw_columns` (
  `sys_name` varchar(64) NOT NULL COMMENT '系统名称 -- ',
  `schema_name` varchar(64) NOT NULL COMMENT '数据区名称 -- ',
  `table_name` varchar(64) NOT NULL COMMENT '目标表名称 -- ',
  `column_name` varchar(64) NOT NULL COMMENT '字段名称 -- ',
  `column_id` int(11) DEFAULT NULL COMMENT '字段编号 -- ',
  `data_type` varchar(64) DEFAULT NULL COMMENT '数据类型 -- ',
  `phy_name` varchar(64) DEFAULT NULL COMMENT '物理名称 -- ',
  `agg_period` varchar(20) DEFAULT NULL COMMENT '积数计算周期 -- ',
  `is_pk` tinyint(1) DEFAULT NULL COMMENT '是否主键 -- ',
  `chain_compare` tinyint(1) DEFAULT NULL COMMENT '是否参与拉链比较 -- ',
  `is_partition_key` tinyint(1) DEFAULT NULL COMMENT '是否分区键 -- ',
  `comments` varchar(512) DEFAULT NULL COMMENT '备注 -- ',
  PRIMARY KEY (`sys_name`,`schema_name`,`table_name`,`column_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据仓库字段表';

-- ----------------------------
-- Records of dw_columns
-- ----------------------------
INSERT INTO `dw_columns` VALUES ('数据平台', 'basedb', '基础层主表1', '字段1', '1', 'string', 'c1', null, '1', null, '0', null);
INSERT INTO `dw_columns` VALUES ('数据平台', 'basedb', '基础层主表1', '字段2', '2', 'int', 'c2', null, '0', null, '0', null);
INSERT INTO `dw_columns` VALUES ('数据平台', 'basedb', '基础层主表2', '字段1', '1', 'int', 'c1', null, '1', null, '0', null);
INSERT INTO `dw_columns` VALUES ('数据平台', 'basedb', '基础层主表2', '字段2', '2', 'string', 'c2', null, '0', null, '1', null);
INSERT INTO `dw_columns` VALUES ('数据平台', 'basedb', '基础层主表2', '字段3', '3', 'date', 'c3', null, '0', null, '0', null);
INSERT INTO `dw_columns` VALUES ('数据平台', 'basedb', '基础层主表2', '字段4', '4', 'string', 'c4', null, '0', null, '0', null);
INSERT INTO `dw_columns` VALUES ('数据平台', 'basedb', '基础层主表3', '字段1', '1', 'int', 'c1', null, '1', null, '0', null);
INSERT INTO `dw_columns` VALUES ('数据平台', 'basedb', '基础层主表3', '字段2', '2', 'string', 'c2', null, '0', null, '1', null);
INSERT INTO `dw_columns` VALUES ('数据平台', 'basedb', '基础层主表3', '字段3', '3', 'date', 'c3', null, '0', null, '0', null);
INSERT INTO `dw_columns` VALUES ('数据平台', 'basedb', '基础层主表3', '字段4', '4', 'string', 'c4', null, '0', null, '0', null);
INSERT INTO `dw_columns` VALUES ('数据平台', 'basedb', '基础层主表3', '字段5', '5', 'string', 'c5', null, '0', null, '0', null);
INSERT INTO `dw_columns` VALUES ('数据平台', 'basedb', '法人', '业务更新日期', '34', 'string', 'biz_upd_dt', null, '0', null, '0', null);
INSERT INTO `dw_columns` VALUES ('数据平台', 'basedb', '法人', '主管工商机关名称', '32', 'string', 'mamge_iac_office_nm', null, '0', null, '0', null);
INSERT INTO `dw_columns` VALUES ('数据平台', 'basedb', '法人', '主管税务机关名称', '24', 'string', 'mamge_tax_office_nm', null, '0', null, '0', null);
INSERT INTO `dw_columns` VALUES ('数据平台', 'basedb', '法人', '企业名称', '13', 'string', 'corp_nm', null, '0', null, '0', null);
INSERT INTO `dw_columns` VALUES ('数据平台', 'basedb', '法人', '企业地址', '14', 'string', 'corp_addr', null, '0', null, '0', null);
INSERT INTO `dw_columns` VALUES ('数据平台', 'basedb', '法人', '企业注册号', '2', 'string', 'corp_rgst_nbr', null, '1', null, '0', null);
INSERT INTO `dw_columns` VALUES ('数据平台', 'basedb', '法人', '吊销日期', '12', 'string', 'revok_dt', null, '0', null, '0', null);
INSERT INTO `dw_columns` VALUES ('数据平台', 'basedb', '法人', '地税注销日期', '28', 'string', 'local_tax_remov_dt', null, '0', null, '0', null);
INSERT INTO `dw_columns` VALUES ('数据平台', 'basedb', '法人', '币种代码', '23', 'string', 'curr_cd_cd', null, '0', null, '0', null);
INSERT INTO `dw_columns` VALUES ('数据平台', 'basedb', '法人', '成立日期', '10', 'string', 'estb_dt', null, '0', null, '0', null);
INSERT INTO `dw_columns` VALUES ('数据平台', 'basedb', '法人', '数据来源表', '35', 'string', 'data_src_tbl', null, '0', null, '0', null);
INSERT INTO `dw_columns` VALUES ('数据平台', 'basedb', '法人', '法人信息来源机构', '33', 'string', 'corp_info_src_org', null, '0', null, '0', null);
INSERT INTO `dw_columns` VALUES ('数据平台', 'basedb', '法人', '法人状态代码', '6', 'string', 'corp_stus_cd', null, '0', null, '0', null);
INSERT INTO `dw_columns` VALUES ('数据平台', 'basedb', '法人', '法人类型代码', '5', 'string', 'corp_type_cd', null, '0', null, '0', null);
INSERT INTO `dw_columns` VALUES ('数据平台', 'basedb', '法人', '法人经济类型代码', '7', 'string', 'corp_ecmic_type_cd', null, '0', null, '0', null);
INSERT INTO `dw_columns` VALUES ('数据平台', 'basedb', '法人', '法人编号', '0', 'string', 'lpr_id', null, '0', null, '0', null);
INSERT INTO `dw_columns` VALUES ('数据平台', 'basedb', '法人', '法定代表人', '15', 'string', 'legal_pson', null, '0', null, '0', null);
INSERT INTO `dw_columns` VALUES ('数据平台', 'basedb', '法人', '注册资本', '22', 'decimal(18,2)', 'rgst_capt', null, '0', null, '0', null);
INSERT INTO `dw_columns` VALUES ('数据平台', 'basedb', '法人', '注销日期', '11', 'string', 'remov_dt', null, '0', null, '0', null);
INSERT INTO `dw_columns` VALUES ('数据平台', 'basedb', '法人', '登记日期', '9', 'string', 'reg_dt', null, '0', null, '0', null);
INSERT INTO `dw_columns` VALUES ('数据平台', 'basedb', '法人', '登记注册证类型', '31', 'string', 'reg_rgst_cert_type', null, '0', null, '0', null);
INSERT INTO `dw_columns` VALUES ('数据平台', 'basedb', '法人', '税务到期日期', '30', 'string', 'tax_due_dt', null, '0', null, '0', null);
INSERT INTO `dw_columns` VALUES ('数据平台', 'basedb', '法人', '税务发证日期', '26', 'string', 'tax_cert_dt', null, '0', null, '0', null);
INSERT INTO `dw_columns` VALUES ('数据平台', 'basedb', '法人', '税务发证机构', '29', 'string', 'tax_cert_org', null, '0', null, '0', null);
INSERT INTO `dw_columns` VALUES ('数据平台', 'basedb', '法人', '税务有效日期', '27', 'string', 'tax_valid_dt', null, '0', null, '0', null);
INSERT INTO `dw_columns` VALUES ('数据平台', 'basedb', '法人', '税务登记证号', '4', 'string', 'tax_rgst_nbr', null, '0', null, '0', null);
INSERT INTO `dw_columns` VALUES ('数据平台', 'basedb', '法人', '纳税人状态代码', '25', 'string', 'taxpayer_stus_cd', null, '0', null, '0', null);
INSERT INTO `dw_columns` VALUES ('数据平台', 'basedb', '法人', '组织机构代码', '3', 'string', 'org_cd', null, '0', null, '0', null);
INSERT INTO `dw_columns` VALUES ('数据平台', 'basedb', '法人', '经营范围', '21', 'string', 'busi_scop', null, '0', null, '0', null);
INSERT INTO `dw_columns` VALUES ('数据平台', 'basedb', '法人', '统一社会信用代码', '1', 'string', 'unfy_scty_crdt_cd', null, '0', null, '0', null);
INSERT INTO `dw_columns` VALUES ('数据平台', 'basedb', '法人', '联系电话', '18', 'string', 'cont_tel', null, '0', null, '0', null);
INSERT INTO `dw_columns` VALUES ('数据平台', 'basedb', '法人', '行业代码', '8', 'string', 'inds_cd', null, '0', null, '0', null);
INSERT INTO `dw_columns` VALUES ('数据平台', 'basedb', '法人', '行政区划代码', '20', 'string', 'admin_regn_cd', null, '0', null, '0', null);
INSERT INTO `dw_columns` VALUES ('数据平台', 'basedb', '法人', '负责人身份证件号码', '17', 'string', 'chgr_pstn_cert_num', null, '0', null, '0', null);
INSERT INTO `dw_columns` VALUES ('数据平台', 'basedb', '法人', '负责人身份证件类型', '16', 'string', 'chgr_pstn_cert_typ', null, '0', null, '0', null);
INSERT INTO `dw_columns` VALUES ('数据平台', 'basedb', '法人', '邮政编码', '19', 'string', 'zip_cd', null, '0', null, '0', null);

-- ----------------------------
-- Table structure for dw_column_mapping
-- ----------------------------
DROP TABLE IF EXISTS `dw_column_mapping`;
CREATE TABLE `dw_column_mapping` (
  `sys_name` varchar(64) NOT NULL COMMENT '系统名称 -- ',
  `schema_name` varchar(64) NOT NULL COMMENT '数据区名称 -- ',
  `table_name` varchar(64) NOT NULL COMMENT '目标表名称 -- ',
  `column_name` varchar(64) NOT NULL COMMENT '字段名称 -- ',
  `src_sys_name` varchar(64) NOT NULL COMMENT '源系统名称 -- ',
  `src_schema` varchar(64) NOT NULL COMMENT '源数据区名称 -- ',
  `src_table_name` varchar(64) NOT NULL COMMENT '源表名称 -- ',
  `src_column_name` varchar(64) NOT NULL COMMENT '源字段名称 -- ',
  `load_batch` int(11) NOT NULL COMMENT '加载批次 -- ',
  `load_group` int(11) NOT NULL COMMENT '加载组别 -- ',
  `column_expr` text COMMENT '字段计算表达式 -- ',
  `comments` varchar(512) DEFAULT NULL COMMENT '备注 -- ',
  PRIMARY KEY (`sys_name`,`schema_name`,`table_name`,`column_name`,`src_sys_name`,`src_schema`,`src_table_name`,`src_column_name`,`load_batch`,`load_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据仓库字段级映射';

-- ----------------------------
-- Records of dw_column_mapping
-- ----------------------------
INSERT INTO `dw_column_mapping` VALUES ('数据平台', 'basedb', '基础层主表1', '字段1', '数据平台', 'cleardb', '源数据表1', 'sc1', '1', '0', null, null);
INSERT INTO `dw_column_mapping` VALUES ('数据平台', 'basedb', '基础层主表1', '字段2', '数据平台', 'cleardb', '源数据表1', 'sc2', '1', '0', null, null);
INSERT INTO `dw_column_mapping` VALUES ('数据平台', 'basedb', '基础层主表2', '字段1', '数据平台', 'cleardb', '源数据表2', '源字段1', '1', '0', 'T1.s_c1+100', null);
INSERT INTO `dw_column_mapping` VALUES ('数据平台', 'basedb', '基础层主表2', '字段2', '数据平台', 'cleardb', '源数据表2', '源字段2,源字段3', '1', '0', 'coalesce(T1.s_c1,T1.s_c2)', null);
INSERT INTO `dw_column_mapping` VALUES ('数据平台', 'basedb', '基础层主表2', '字段3', '数据平台', 'cleardb', '源数据表3', 's_c2', '1', '0', 'T2.s_c2', null);
INSERT INTO `dw_column_mapping` VALUES ('数据平台', 'basedb', '基础层主表2', '字段4', '数据平台', '', '', '', '1', '0', '\'XXXX\'', null);
INSERT INTO `dw_column_mapping` VALUES ('数据平台', 'basedb', '基础层主表3', '字段1', '数据平台', 'cleardb', '源数据表2', '源字段1', '1', '0', 'T1.s_c1+100', null);
INSERT INTO `dw_column_mapping` VALUES ('数据平台', 'basedb', '基础层主表3', '字段2', '数据平台', 'cleardb', '源数据表2', '源字段2,源字段3', '1', '0', 'coalesce(T1.s_c1,T1.s_c2)', null);
INSERT INTO `dw_column_mapping` VALUES ('数据平台', 'basedb', '基础层主表3', '字段3', '数据平台', 'cleardb', '源数据表3', 's_c2', '1', '0', 'T2.s_c2', null);
INSERT INTO `dw_column_mapping` VALUES ('数据平台', 'basedb', '基础层主表3', '字段4', '数据平台', 'basedb', '维表1', 'c4', '1', '0', 'D1.c4', null);
INSERT INTO `dw_column_mapping` VALUES ('数据平台', 'basedb', '基础层主表3', '字段5', '数据平台', 'basedb', '维表2', 'c2', '1', '0', 'D2.c2', null);

-- ----------------------------
-- Table structure for dw_column_mapping_his
-- ----------------------------
DROP TABLE IF EXISTS `dw_column_mapping_his`;
CREATE TABLE `dw_column_mapping_his` (
  `column_name` varchar(18) NOT NULL COMMENT '字段名称 -- ',
  `load_batch` int(11) NOT NULL COMMENT '加载批次 -- ',
  `schema_name` varchar(18) NOT NULL COMMENT '数据区名称 -- ',
  `table_name` varchar(18) NOT NULL COMMENT '目标表名称 -- ',
  `sys_name` varchar(18) NOT NULL COMMENT '系统名称 -- ',
  `version` int(11) NOT NULL COMMENT '版本号 -- ',
  `src_column_name` varchar(18) DEFAULT NULL COMMENT '源字段名称 -- ',
  `src_table_name` varchar(18) DEFAULT NULL COMMENT '源表名称 -- ',
  `src_schema` varchar(18) DEFAULT NULL COMMENT '源数据区名称 -- ',
  `src_sys_name` varchar(18) DEFAULT NULL COMMENT '源系统名称 -- ',
  `column_expr` text COMMENT '字段计算表达式 -- ',
  `comments` varchar(512) DEFAULT NULL COMMENT '备注 -- ',
  PRIMARY KEY (`column_name`,`load_batch`,`schema_name`,`table_name`,`sys_name`,`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据仓库字段级映射历史';

-- ----------------------------
-- Records of dw_column_mapping_his
-- ----------------------------

-- ----------------------------
-- Table structure for dw_subject
-- ----------------------------
DROP TABLE IF EXISTS `dw_subject`;
CREATE TABLE `dw_subject` (
  `subject_name` varchar(64) NOT NULL COMMENT '主题名称 -- ',
  `cn_name` varchar(64) DEFAULT NULL COMMENT '中文名称 -- ',
  `phy_name` varchar(64) DEFAULT NULL COMMENT '物理名称 -- ',
  `comments` varchar(512) DEFAULT NULL COMMENT '备注 -- ',
  PRIMARY KEY (`subject_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据仓库主题';

-- ----------------------------
-- Records of dw_subject
-- ----------------------------

-- ----------------------------
-- Table structure for dw_table
-- ----------------------------
DROP TABLE IF EXISTS `dw_table`;
CREATE TABLE `dw_table` (
  `sys_name` varchar(64) NOT NULL COMMENT '系统名称 -- ',
  `schema_name` varchar(64) NOT NULL COMMENT '数据区名称 -- ',
  `table_name` varchar(64) NOT NULL COMMENT '目标表名称 -- ',
  `phy_name` varchar(64) DEFAULT NULL COMMENT '物理名称 -- ',
  `load_mode` varchar(20) DEFAULT NULL COMMENT '加载策略 -- ',
  `clear_mode` varchar(20) DEFAULT NULL COMMENT '删除策略 -- ',
  `keep_load_dt` tinyint(1) DEFAULT NULL COMMENT '是否保留首次加载日期 -- ',
  `do_aggregate` tinyint(1) DEFAULT NULL COMMENT '是否计算积数 -- ',
  `subject_name` varchar(64) DEFAULT NULL COMMENT '主题名称 -- ',
  `is_fact` tinyint(1) DEFAULT NULL COMMENT '是否主表 -- ',
  `is_single_source` tinyint(1) DEFAULT NULL COMMENT '是否分批加载 -- ',
  `comments` varchar(512) DEFAULT NULL COMMENT '备注 -- ',
  PRIMARY KEY (`sys_name`,`schema_name`,`table_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据仓库表';

-- ----------------------------
-- Records of dw_table
-- ----------------------------
INSERT INTO `dw_table` VALUES ('数据平台', 'basedb', '基础层主表1', 'dw_t1', '更新', null, null, null, null, '1', '1', null);
INSERT INTO `dw_table` VALUES ('数据平台', 'basedb', '基础层主表2', 'dw_t2', '追加', null, null, null, null, '1', '1', null);
INSERT INTO `dw_table` VALUES ('数据平台', 'basedb', '基础层主表3', 'dw_t3', '更新', null, null, null, null, '1', '1', null);
INSERT INTO `dw_table` VALUES ('数据平台', 'basedb', '法人', 'b02_corp', '更新', null, null, null, null, '1', '1', null);

-- ----------------------------
-- Table structure for dw_table_mapping
-- ----------------------------
DROP TABLE IF EXISTS `dw_table_mapping`;
CREATE TABLE `dw_table_mapping` (
  `sys_name` varchar(64) NOT NULL COMMENT '系统名称 -- ',
  `schema_name` varchar(64) NOT NULL COMMENT '数据区名称 -- ',
  `table_name` varchar(64) NOT NULL COMMENT '目标表名称 -- ',
  `src_sys_name` varchar(64) NOT NULL COMMENT '源系统名称 -- ',
  `src_schema` varchar(64) NOT NULL COMMENT '源数据区名称 -- ',
  `src_table_name` varchar(64) NOT NULL COMMENT '源表名称 -- ',
  `load_batch` int(11) NOT NULL COMMENT '加载批次 -- ',
  `join_order` int(11) NOT NULL COMMENT '表关联次序 -- ',
  `table_alias` varchar(64) DEFAULT NULL COMMENT '表别名 -- ',
  `join_type` varchar(20) DEFAULT NULL COMMENT '表关联类型 -- ',
  `join_condition` text COMMENT '表关联条件 -- ',
  `filter_condition` text COMMENT '表过滤条件 -- ',
  `comments` varchar(512) DEFAULT NULL COMMENT '备注 -- ',
  PRIMARY KEY (`sys_name`,`schema_name`,`table_name`,`src_sys_name`,`src_schema`,`src_table_name`,`load_batch`,`join_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据仓库表级映射';

-- ----------------------------
-- Records of dw_table_mapping
-- ----------------------------
INSERT INTO `dw_table_mapping` VALUES ('数据平台', 'basedb', '基础层主表1', '数据平台', 'cleardb', '源数据表1', '1', '0', null, null, null, null, null);
INSERT INTO `dw_table_mapping` VALUES ('数据平台', 'basedb', '基础层主表2', '数据平台', 'cleardb', '源数据表2', '1', '0', 'T1', null, null, null, null);
INSERT INTO `dw_table_mapping` VALUES ('数据平台', 'basedb', '基础层主表2', '数据平台', 'cleardb', '源数据表3', '1', '1', 'T2', 'inner', 'T1.s_c1 = T2.s_c1', null, null);
INSERT INTO `dw_table_mapping` VALUES ('数据平台', 'basedb', '基础层主表3', '数据平台', 'basedb', '维表1', '0', '2', 'D1', 'inner', 'T1.s_c3 = D1.c1', null, null);
INSERT INTO `dw_table_mapping` VALUES ('数据平台', 'basedb', '基础层主表3', '数据平台', 'basedb', '维表2', '0', '3', 'D2', 'inner', 'T1.s_c4 = D2.c1', null, null);
INSERT INTO `dw_table_mapping` VALUES ('数据平台', 'basedb', '基础层主表3', '数据平台', 'cleardb', '源数据表1', '1', '0', 'T1', null, null, 'T1.s_c1 > 100', null);
INSERT INTO `dw_table_mapping` VALUES ('数据平台', 'basedb', '基础层主表3', '数据平台', 'cleardb', '源数据表2', '1', '1', 'T2', 'left outer', 'T1.s_c1 = T2.s_c2', 'T2.s_c3 like \'%000\'', null);

-- ----------------------------
-- Table structure for dw_table_mapping_his
-- ----------------------------
DROP TABLE IF EXISTS `dw_table_mapping_his`;
CREATE TABLE `dw_table_mapping_his` (
  `load_batch` int(11) NOT NULL COMMENT '加载批次 -- ',
  `schema_name` varchar(18) NOT NULL COMMENT '数据区名称 -- ',
  `src_schema` varchar(18) NOT NULL COMMENT '源数据区名称 -- ',
  `table_name` varchar(18) NOT NULL COMMENT '目标表名称 -- ',
  `src_table_name` varchar(18) NOT NULL COMMENT '源表名称 -- ',
  `sys_name` varchar(18) NOT NULL COMMENT '系统名称 -- ',
  `src_sys_name` varchar(18) NOT NULL COMMENT '源系统名称 -- ',
  `version` int(11) NOT NULL COMMENT '版本号 -- ',
  `table_alias` varchar(64) DEFAULT NULL COMMENT '表别名 -- ',
  `join_order` int(11) DEFAULT NULL COMMENT '表关联次序 -- ',
  `join_type` varchar(20) DEFAULT NULL COMMENT '表关联类型 -- ',
  `join_condition` text COMMENT '表关联条件 -- ',
  `filter_condition` text COMMENT '表过滤条件 -- ',
  `comments` varchar(512) DEFAULT NULL COMMENT '备注 -- ',
  PRIMARY KEY (`load_batch`,`schema_name`,`src_schema`,`table_name`,`src_table_name`,`sys_name`,`src_sys_name`,`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据仓库表级映射历史';

-- ----------------------------
-- Records of dw_table_mapping_his
-- ----------------------------

-- ----------------------------
-- Table structure for ent_system
-- ----------------------------
DROP TABLE IF EXISTS `ent_system`;
CREATE TABLE `ent_system` (
  `sys_name` varchar(64) NOT NULL COMMENT '系统名称 -- ',
  `cn_name` varchar(64) DEFAULT NULL COMMENT '中文名称 -- ',
  `comments` varchar(512) DEFAULT NULL COMMENT '备注 -- ',
  PRIMARY KEY (`sys_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='业务系统表';

-- ----------------------------
-- Records of ent_system
-- ----------------------------

-- ----------------------------
-- Table structure for etl_developer
-- ----------------------------
DROP TABLE IF EXISTS `etl_developer`;
CREATE TABLE `etl_developer` (
  `etl_dvlpr_name` varchar(64) NOT NULL COMMENT 'ETL开发人员名称 -- ',
  `comments` varchar(512) DEFAULT NULL COMMENT '备注 -- ',
  PRIMARY KEY (`etl_dvlpr_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ETL开发人员';

-- ----------------------------
-- Records of etl_developer
-- ----------------------------

-- ----------------------------
-- Table structure for etl_tables
-- ----------------------------
DROP TABLE IF EXISTS `etl_tables`;
CREATE TABLE `etl_tables` (
  `sys_name` varchar(64) NOT NULL COMMENT '系统名称 -- ',
  `schema_name` varchar(64) NOT NULL COMMENT '数据区名称 -- ',
  `table_name` varchar(64) NOT NULL COMMENT '目标表名称 -- ',
  `cn_name` varchar(64) DEFAULT NULL COMMENT '中文名称 -- ',
  `comments` varchar(512) DEFAULT NULL COMMENT ' 备注 -- ',
  PRIMARY KEY (`sys_name`,`schema_name`,`table_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ETL目标表';

-- ----------------------------
-- Records of etl_tables
-- ----------------------------

-- ----------------------------
-- Table structure for etl_tasks
-- ----------------------------
DROP TABLE IF EXISTS `etl_tasks`;
CREATE TABLE `etl_tasks` (
  `task_name` varchar(128) NOT NULL COMMENT '任务名称 -- ',
  `serial_no` int(11) DEFAULT NULL COMMENT '序号 -- ',
  `sys_name` varchar(64) DEFAULT NULL COMMENT '系统名称 -- ',
  `schema_name` varchar(64) DEFAULT NULL COMMENT '数据区名称 -- ',
  `table_name` varchar(64) DEFAULT NULL COMMENT '目标表名称 -- ',
  `etl_dvlpr_name` varchar(64) DEFAULT NULL COMMENT 'ETL开发人员名称 -- ',
  `plan_start_dt` date DEFAULT NULL COMMENT '计划开始日期 -- ',
  `actual_start_dt` date DEFAULT NULL COMMENT '实际开始日期 -- ',
  `plan_finish_dt` date DEFAULT NULL COMMENT '计划完成日期 -- ',
  `actual_finish_dt` date DEFAULT NULL COMMENT '实际完成日期 -- ',
  `task_status` varchar(20) DEFAULT NULL COMMENT '任务状态 -- ',
  `comments` varchar(512) DEFAULT NULL COMMENT '备注 -- ',
  PRIMARY KEY (`task_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ETL任务表';

-- ----------------------------
-- Records of etl_tasks
-- ----------------------------
INSERT INTO `etl_tasks` VALUES ('基础层主表1', '1', '数据平台', 'basedb', '基础层主表1', null, null, null, null, null, null, 'dw_t1');
INSERT INTO `etl_tasks` VALUES ('基础层主表2', '2', '数据平台', 'basedb', '基础层主表2', null, null, null, null, null, null, 'dw_t2');
INSERT INTO `etl_tasks` VALUES ('基础层主表3', '3', '数据平台', 'basedb', '基础层主表3', null, null, null, null, null, null, 'dw_t3');
INSERT INTO `etl_tasks` VALUES ('法人加载', '0', '数据平台', 'basedb', '法人', null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for etl_tasks_his
-- ----------------------------
DROP TABLE IF EXISTS `etl_tasks_his`;
CREATE TABLE `etl_tasks_his` (
  `version` int(11) NOT NULL COMMENT '版本号 -- ',
  `task_name` varchar(128) NOT NULL COMMENT '任务名称 -- ',
  `schema_name` varchar(18) DEFAULT NULL COMMENT '数据区名称 -- ',
  `src_table_name` varchar(20) DEFAULT NULL COMMENT '目标表名称 -- ',
  `etl_dvlpr_name` varchar(18) DEFAULT NULL COMMENT 'ETL开发人员名称 -- ',
  `comments` varchar(512) DEFAULT NULL COMMENT '备注 -- ',
  `timestamp` varchar(20) DEFAULT NULL COMMENT '时间戳 -- ',
  `sys_name` varchar(64) DEFAULT NULL COMMENT '系统名称 -- ',
  PRIMARY KEY (`version`,`task_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ETL任务历史表';

-- ----------------------------
-- Records of etl_tasks_his
-- ----------------------------

-- ----------------------------
-- Table structure for src_column_analysis
-- ----------------------------
DROP TABLE IF EXISTS `src_column_analysis`;
CREATE TABLE `src_column_analysis` (
  `sys_name` varchar(64) NOT NULL COMMENT '系统名称 -- ',
  `schema_name` varchar(64) NOT NULL COMMENT '数据区名称 -- ',
  `table_name` varchar(64) NOT NULL COMMENT '目标表名称 -- ',
  `column_name` varchar(64) NOT NULL COMMENT '字段名称 -- ',
  `data_type` varchar(20) DEFAULT NULL COMMENT '数据类型 -- ',
  `allow_null` tinyint(1) DEFAULT NULL COMMENT '允许为空 -- ',
  `is_pk` tinyint(1) DEFAULT NULL COMMENT '是否主键 -- ',
  `cn_name` varchar(64) DEFAULT NULL COMMENT '中文名称 -- ',
  `null_count` int(11) DEFAULT NULL COMMENT '空值数量 -- ',
  `uv_count` int(11) DEFAULT NULL COMMENT '唯一值数量 -- ',
  `doc_data_type` varchar(20) DEFAULT NULL COMMENT '文档数据类型 -- ',
  `doc_cn_name` varchar(64) DEFAULT NULL COMMENT '文档中文名称 -- ',
  `doc_allow_null` tinyint(1) DEFAULT NULL COMMENT '文档允许为空 -- ',
  `doc_is_pk` tinyint(1) DEFAULT NULL COMMENT '文档是否主键 -- ',
  `column_len` int(11) DEFAULT NULL COMMENT '字段长度 -- ',
  `column_id` int(11) DEFAULT NULL COMMENT '字段编号 -- ',
  `ref_table` varchar(64) DEFAULT NULL COMMENT '引用表 -- ',
  `ref_column` varchar(64) DEFAULT NULL COMMENT '引用字段 -- ',
  `doc_col_len` int(11) DEFAULT NULL COMMENT '文档字段长度 -- ',
  `doc_ref_tbl` varchar(64) DEFAULT NULL COMMENT '文档引用表 -- ',
  `doc_ref_col` varchar(64) DEFAULT NULL COMMENT '文档引用字段 -- ',
  `uv_check` tinyint(1) DEFAULT NULL COMMENT '唯一值分析 -- ',
  `null_check` tinyint(1) DEFAULT NULL COMMENT '空值分析 -- ',
  `value_check` tinyint(1) DEFAULT NULL COMMENT '值域分析 -- ',
  `ref_check` tinyint(1) DEFAULT NULL COMMENT '参考完整性分析 -- ',
  `ref_ok` tinyint(1) DEFAULT NULL COMMENT '参考完整性 -- ',
  `unique_values` text COMMENT '值域 -- ',
  `comments` varchar(512) DEFAULT NULL COMMENT '备注 -- ',
  PRIMARY KEY (`sys_name`,`schema_name`,`table_name`,`column_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='源系统字段级分析结果表';

-- ----------------------------
-- Records of src_column_analysis
-- ----------------------------

-- ----------------------------
-- Table structure for src_column_analysis_his
-- ----------------------------
DROP TABLE IF EXISTS `src_column_analysis_his`;
CREATE TABLE `src_column_analysis_his` (
  `column_name` varchar(64) NOT NULL COMMENT '字段名称 -- ',
  `schema_name` varchar(18) NOT NULL COMMENT '数据区名称 -- ',
  `table_name` varchar(18) NOT NULL COMMENT '目标表名称 -- ',
  `sys_name` varchar(18) NOT NULL COMMENT '系统名称 -- ',
  `version` int(11) NOT NULL COMMENT '版本号 -- ',
  `data_type` varchar(20) DEFAULT NULL COMMENT '数据类型 -- ',
  `allow_null` tinyint(1) DEFAULT NULL COMMENT '允许为空 -- ',
  `is_pk` tinyint(1) DEFAULT NULL COMMENT '是否主键 -- ',
  `cn_name` varchar(64) DEFAULT NULL COMMENT '中文名称 -- ',
  `null_count` int(11) DEFAULT NULL COMMENT '空值数量 -- ',
  `uv_count` int(11) DEFAULT NULL COMMENT '唯一值数量 -- ',
  `doc_data_type` varchar(20) DEFAULT NULL COMMENT '文档数据类型 -- ',
  `doc_cn_name` varchar(64) DEFAULT NULL COMMENT '文档中文名称 -- ',
  `doc_allow_null` tinyint(1) DEFAULT NULL COMMENT '文档允许为空 -- ',
  `doc_is_pk` tinyint(1) DEFAULT NULL COMMENT '文档是否主键 -- ',
  `comments` varchar(512) DEFAULT NULL COMMENT '备注 -- ',
  `column_len` int(11) DEFAULT NULL COMMENT '字段长度 -- ',
  `column_id` int(11) DEFAULT NULL COMMENT '字段编号 -- ',
  `ref_table` varchar(64) DEFAULT NULL COMMENT '引用表 -- ',
  `ref_column` varchar(64) DEFAULT NULL COMMENT '引用字段 -- ',
  `doc_col_len` int(11) DEFAULT NULL COMMENT '文档字段长度 -- ',
  `doc_ref_tbl` varchar(64) DEFAULT NULL COMMENT '文档引用表 -- ',
  `doc_ref_col` varchar(64) DEFAULT NULL COMMENT '文档引用字段 -- ',
  `uv_check` tinyint(1) DEFAULT NULL COMMENT '唯一值分析 -- ',
  `null_check` tinyint(1) DEFAULT NULL COMMENT '空值分析 -- ',
  `value_check` tinyint(1) DEFAULT NULL COMMENT '值域分析 -- ',
  `ref_check` tinyint(1) DEFAULT NULL COMMENT '参考完整性分析 -- ',
  `unique_values` text COMMENT '值域 -- ',
  `ref_ok` tinyint(1) DEFAULT NULL COMMENT '参考完整性 -- ',
  PRIMARY KEY (`column_name`,`schema_name`,`table_name`,`sys_name`,`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='源系统字段级分析结果历史表';

-- ----------------------------
-- Records of src_column_analysis_his
-- ----------------------------

-- ----------------------------
-- Table structure for src_table_analysis
-- ----------------------------
DROP TABLE IF EXISTS `src_table_analysis`;
CREATE TABLE `src_table_analysis` (
  `sys_name` varchar(64) NOT NULL COMMENT '系统名称 -- ',
  `schema_name` varchar(64) NOT NULL COMMENT '数据区名称 -- ',
  `table_name` varchar(64) NOT NULL COMMENT '目标表名称 -- ',
  `cn_name` varchar(64) DEFAULT NULL COMMENT '中文名称 -- ',
  `row_count` int(11) DEFAULT NULL COMMENT '记录数目 -- ',
  `need_ext` tinyint(1) DEFAULT NULL COMMENT '是否采集 -- ',
  `need_int` tinyint(1) DEFAULT NULL COMMENT '是否整合 -- ',
  `no_int_cmt` varchar(512) DEFAULT NULL COMMENT '不整合原因 -- ',
  `ext_cycle` varchar(64) DEFAULT NULL COMMENT '抽取周期 -- ',
  `is_inc_ext` tinyint(1) DEFAULT NULL COMMENT '是否增量 -- ',
  `stbl_name` varchar(64) DEFAULT NULL COMMENT '接口名称 -- ',
  `serial_no` int(11) DEFAULT NULL COMMENT '序号 -- ',
  `load_to_fact` tinyint(1) DEFAULT NULL COMMENT '是否入主实体 -- ',
  `ext_condition` text COMMENT '抽取条件 -- ',
  `description` varchar(512) DEFAULT NULL COMMENT '业务描述 -- ',
  `no_ext_cmt` varchar(512) DEFAULT NULL COMMENT '不采集原因 -- ',
  `comments` varchar(512) DEFAULT NULL COMMENT '备注 -- ',
  PRIMARY KEY (`sys_name`,`schema_name`,`table_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='源系统表级分析结果表';

-- ----------------------------
-- Records of src_table_analysis
-- ----------------------------
INSERT INTO `src_table_analysis` VALUES ('数据平台', 'basedb', '维表1', null, null, null, null, null, null, null, 's99_t1', null, null, null, null, null, null);
INSERT INTO `src_table_analysis` VALUES ('数据平台', 'basedb', '维表2', null, null, null, null, null, null, null, 's99_t2', null, null, null, null, null, null);
INSERT INTO `src_table_analysis` VALUES ('数据平台', 'basedb', '维表3', null, null, null, null, null, null, null, 's99_t3', null, null, null, null, null, null);
INSERT INTO `src_table_analysis` VALUES ('数据平台', 'cleardb', '源数据表1', null, null, null, null, null, null, null, 'p_s_t1', null, null, null, null, null, null);
INSERT INTO `src_table_analysis` VALUES ('数据平台', 'cleardb', '源数据表2', null, null, null, null, null, null, null, 'p_s_t2', null, null, null, null, null, null);
INSERT INTO `src_table_analysis` VALUES ('数据平台', 'cleardb', '源数据表3', null, null, null, null, null, null, null, 'p_s_t3', null, null, null, null, null, null);
INSERT INTO `src_table_analysis` VALUES ('数据平台', 'historydb', '市工商局-经营异常名录信息', '市工商局-经营异常名录信息', null, null, null, null, null, null, 'h_bj18_frk_sgsj_jyycmlxx', null, null, null, null, null, null);

-- ----------------------------
-- Table structure for src_table_analysis_his
-- ----------------------------
DROP TABLE IF EXISTS `src_table_analysis_his`;
CREATE TABLE `src_table_analysis_his` (
  `schema_name` varchar(18) NOT NULL COMMENT '数据区名称 -- ',
  `table_name` varchar(18) NOT NULL COMMENT '目标表名称 -- ',
  `sys_name` varchar(18) NOT NULL COMMENT '系统名称 -- ',
  `version` int(11) NOT NULL COMMENT '版本号 -- ',
  `cn_name` varchar(64) DEFAULT NULL COMMENT '中文名称 -- ',
  `row_count` int(11) DEFAULT NULL COMMENT '记录数目 -- ',
  `comments` varchar(512) DEFAULT NULL COMMENT '备注 -- ',
  `description` varchar(512) DEFAULT NULL COMMENT '业务描述 -- ',
  `need_ext` tinyint(1) DEFAULT NULL COMMENT '是否采集 -- ',
  `no_ext_cmt` varchar(512) DEFAULT NULL COMMENT '不采集原因 -- ',
  `need_int` tinyint(1) DEFAULT NULL COMMENT '是否整合 -- ',
  `no_int_cmt` varchar(512) DEFAULT NULL COMMENT '不整合原因 -- ',
  `ext_cycle` varchar(64) DEFAULT NULL COMMENT '抽取周期 -- ',
  `is_inc_ext` tinyint(1) DEFAULT NULL COMMENT '是否增量 -- ',
  `ext_condition` text COMMENT '抽取条件 -- ',
  `stbl_name` varchar(64) DEFAULT NULL COMMENT '接口名称 -- ',
  `serial_no` int(11) DEFAULT NULL COMMENT '序号 -- ',
  `load_to_fact` tinyint(1) DEFAULT NULL COMMENT '是否入主实体 -- ',
  PRIMARY KEY (`schema_name`,`table_name`,`sys_name`,`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='源系统表级分析结果历史表';

-- ----------------------------
-- Records of src_table_analysis_his
-- ----------------------------

-- ----------------------------
-- Table structure for src_tbl_subject
-- ----------------------------
DROP TABLE IF EXISTS `src_tbl_subject`;
CREATE TABLE `src_tbl_subject` (
  `sys_name` varchar(64) NOT NULL COMMENT '系统名称 -- ',
  `schema_name` varchar(64) NOT NULL COMMENT '数据区名称 -- ',
  `table_name` varchar(64) NOT NULL COMMENT '目标表名称 -- ',
  `subject_name` varchar(64) NOT NULL COMMENT '主题名称 -- ',
  PRIMARY KEY (`sys_name`,`schema_name`,`table_name`,`subject_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='源系统表主题划分';

-- ----------------------------
-- Records of src_tbl_subject
-- ----------------------------

-- ----------------------------
-- Table structure for system_properties
-- ----------------------------
DROP TABLE IF EXISTS `system_properties`;
CREATE TABLE `system_properties` (
  `property_name` varchar(36) NOT NULL COMMENT '参数名称 -- ',
  `peroperty_value` varchar(36) DEFAULT NULL COMMENT '参数值 -- ',
  PRIMARY KEY (`property_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统参数表';

-- ----------------------------
-- Records of system_properties
-- ----------------------------

-- ----------------------------
-- Table structure for table_schema
-- ----------------------------
DROP TABLE IF EXISTS `table_schema`;
CREATE TABLE `table_schema` (
  `sys_name` varchar(64) NOT NULL COMMENT '系统名称 -- ',
  `schema_name` varchar(64) NOT NULL COMMENT '数据区名称 -- ',
  `schema_type` varchar(64) DEFAULT NULL COMMENT '数据区类别 -- ',
  `comments` varchar(512) DEFAULT NULL COMMENT '备注 -- ',
  PRIMARY KEY (`sys_name`,`schema_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据区';

-- ----------------------------
-- Records of table_schema
-- ----------------------------

-- ----------------------------
-- Table structure for table_stats
-- ----------------------------
DROP TABLE IF EXISTS `table_stats`;
CREATE TABLE `table_stats` (
  `sys_name` varchar(64) NOT NULL COMMENT '系统名称 -- ',
  `schema_name` varchar(64) NOT NULL COMMENT '数据区名称 -- ',
  `table_name` varchar(64) NOT NULL COMMENT '目标表名称 -- ',
  `collect_time` date NOT NULL COMMENT '统计时间 -- ',
  `row_count` int(11) DEFAULT NULL COMMENT '记录数目 -- ',
  PRIMARY KEY (`sys_name`,`schema_name`,`table_name`,`collect_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='表统计信息';

-- ----------------------------
-- Records of table_stats
-- ----------------------------

-- ----------------------------
-- Table structure for value_histogram
-- ----------------------------
DROP TABLE IF EXISTS `value_histogram`;
CREATE TABLE `value_histogram` (
  `value_histogram_id` varchar(20) NOT NULL COMMENT '值域分布ID -- ',
  PRIMARY KEY (`value_histogram_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='值域分布';

-- ----------------------------
-- Records of value_histogram
-- ----------------------------

-- ----------------------------
-- Table structure for vocabulary
-- ----------------------------
DROP TABLE IF EXISTS `vocabulary`;
CREATE TABLE `vocabulary` (
  `cn_word` varchar(64) NOT NULL COMMENT '中文词汇 -- ',
  `comments` varchar(512) DEFAULT NULL COMMENT '备注 -- ',
  `en_word` varchar(64) DEFAULT NULL COMMENT '英文词汇 -- ',
  PRIMARY KEY (`cn_word`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='词汇表';

-- ----------------------------
-- Records of vocabulary
-- ----------------------------
