package com.seaboxdata.etlman.sql;

/**
 * Created by xiaoy on 1/20/2017.
 */
public class JobSQLGeneratorConfig {
    public static String loadDateColName = "data_dt";
    public static String dataSrcColName = "";
    public final static String workDateVarName = "${DATA_DT}";
    public final static String workDate8VarName = "${DATA_DT_8}";
    public final static String lastWorkDateVarName = "${LAST_DATA_DT}";
    public static String workingDBName = "tmpdb";
}
