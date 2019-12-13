package com.seaboxdata.etlman;

import com.seaboxdata.etlman.metastore.ETLTask;
import com.seaboxdata.etlman.metastore.ETLEntity;
import com.seaboxdata.etlman.sql.JobSQLGenerator;
import com.seaboxdata.etlman.sql.hive.HiveJobSQLGenerator;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class JobScriptBuilder {

    private Connection metaDBConn;

    private List<ETLTask> etlTaskList = new ArrayList<ETLTask>();

    public JobScriptBuilder(DataSource aDataSource) throws Exception {
        metaDBConn = aDataSource.getConnection();
    }

    public void initETLTasks() throws Exception {
        Statement statement = metaDBConn.createStatement();

        ResultSet rs = statement.executeQuery("select * from etl_tasks where sys_name = '数据平台'");
        while (rs.next()) {
            ETLTask etlTask = new ETLTask();
            etlTask.setTaskName(rs.getString("task_name"));
            etlTask.setComments(rs.getString("comments"));
            etlTask.setDeveloperName(rs.getString("etl_dvlpr_name"));
            etlTask.setSchemaName(rs.getString("schema_name"));

            String tableName = rs.getString("table_name");

            ETLEntity etlEntity = new ETLEntity(etlTask.getSchemaName(), tableName).initialize(metaDBConn);

            etlTask.setEtlEntity(etlEntity);

            etlTaskList.add(etlTask);
        }
        rs.close();
    }


    public String getSQLScriptForTask(String taskName) throws Exception {

        String[] res = new String[]{String.format("\n-- Job Script for %s\n", taskName)};

        Map<Integer, String> scripts = getBatchScriptForTask(taskName);

        scripts.values()
                .stream()
                .reduce((x, y) -> x + "\n -- 批次分割线 -- " + y)
                .ifPresent(s -> res[0] += s);

        return res[0];
    }

    public Map<Integer, String> getBatchScriptForTask(String taskName) throws Exception {

        for (ETLTask task : etlTaskList) {
            if (task.getTaskName().equals(taskName)) {
                JobSQLGenerator sqlGenerator = new HiveJobSQLGenerator(task);

                return sqlGenerator.genJobScript();

            }
        }

        return null;
    }
}
