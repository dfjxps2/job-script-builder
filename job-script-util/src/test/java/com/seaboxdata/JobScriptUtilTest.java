package com.seaboxdata;


import com.seaboxdata.etlman.JobScriptBuilder;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import javax.sql.DataSource;

@RunWith(SpringRunner.class)
@SpringBootTest
public class JobScriptUtilTest {

    @Autowired
    private DataSource dataSource;

    @Value("${job-script.working.db.name}")
    private String workingDBName;

    private JobScriptBuilder jobScriptBuilder = null;

    @Before
    public void init() throws Exception {
        if (jobScriptBuilder == null)
            jobScriptBuilder = new JobScriptBuilder(dataSource);

        jobScriptBuilder.initETLTasks().setWorkingDBName(workingDBName);
    }

    @Test
    public void testJobSQLGenerator_1() throws Exception {
        String sql = jobScriptBuilder.getSQLScriptForTask("GGXY_XBZ_测试");

        System.out.println(sql);

    }

    @Test
    public void testJobSQLGenerator_2() throws Exception {
        String sql = jobScriptBuilder.getSQLScriptForTask("基础层主表2");

        System.out.println(sql);

    }

    @Test
    public void testJobSQLGenerator_3() throws Exception {
        String sql = jobScriptBuilder.getSQLScriptForTask("基础层主表3");

        System.out.println(sql);

    }

    @Test
    public void testJobSQLGenerator_4() throws Exception {
        String sql = jobScriptBuilder.getSQLScriptForTask("法人");

        System.out.println(sql);

    }

    @Test
    public void testBatchSQLGenerator_1() throws Exception {
        jobScriptBuilder.getBatchScriptForTask("基础层主表1").forEach((batchNo, sql) -> {
            System.out.println(String.format("\n批次 %d 脚本：\n%s", batchNo, sql));

        });
    }

    @Test
    public void testBatchSQLGenerator_2() throws Exception {
        jobScriptBuilder.getBatchScriptForTask("基础层主表2").forEach((batchNo, sql) -> {
            System.out.println(String.format("\n批次 %d 脚本：\n%s", batchNo, sql));

        });
    }

    @Test
    public void testBatchSQLGenerator_3() throws Exception {
        jobScriptBuilder.getBatchScriptForTask("基础层主表3").forEach((batchNo, sql) -> {
            System.out.println(String.format("\n批次 %d 脚本：\n%s", batchNo, sql));

        });
    }
    @Test
    public void testBatchSQLGenerator_4() throws Exception {
        jobScriptBuilder.getBatchScriptForTask("法人").forEach((batchNo, sql) -> {
            System.out.println(String.format("\n批次 %d 脚本：\n%s", batchNo, sql));

        });
    }
    @Test
    public void testBatchSQLGenerator_5() throws Exception {
        jobScriptBuilder.getBatchScriptForTask("法人_测试").forEach((batchNo, sql) -> {
            System.out.println(String.format("\n批次 %d 脚本：\n%s", batchNo, sql));

        });
    }

    @After
    public void cleanup() {
    }
}
