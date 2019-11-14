package com.seaboxdata;


import com.seaboxdata.etlman.JobScriptBuilder;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import javax.sql.DataSource;

@RunWith(SpringRunner.class)
@SpringBootTest
public class JobScriptUtilTest {

    @Autowired
    private DataSource dataSource;

    private JobScriptBuilder jobScriptBuilder = null;

    @Before
    public void init() throws Exception {
        if (jobScriptBuilder == null)
            jobScriptBuilder = new JobScriptBuilder(dataSource);

        jobScriptBuilder.initETLTasks();
    }

    @Test
    public void testJobSQLGenerator_1() throws Exception {
        String sql = jobScriptBuilder.getSQLScriptForEntity("基础层主表1");

        System.out.println(sql);

    }

    @Test
    public void testJobSQLGenerator_2() throws Exception {
        String sql = jobScriptBuilder.getSQLScriptForEntity("基础层主表2");

        System.out.println(sql);

    }

    @Test
    public void testJobSQLGenerator_3() throws Exception {
        String sql = jobScriptBuilder.getSQLScriptForEntity("基础层主表3");

        System.out.println(sql);

    }

    @Test
    public void testJobSQLGenerator_4() throws Exception {
        String sql = jobScriptBuilder.getSQLScriptForEntity("法人");

        System.out.println(sql);

    }

    @Test
    public void testBatchSQLGenerator_1() throws Exception {
        jobScriptBuilder.getBatchScriptForEntity("基础层主表1").forEach((batchNo, sql) -> {
            System.out.println(String.format("\n批次 %d 脚本：\n%s", batchNo, sql));

        });
    }

    @Test
    public void testBatchSQLGenerator_2() throws Exception {
        jobScriptBuilder.getBatchScriptForEntity("基础层主表2").forEach((batchNo, sql) -> {
            System.out.println(String.format("\n批次 %d 脚本：\n%s", batchNo, sql));

        });
    }

    @Test
    public void testBatchSQLGenerator_3() throws Exception {
        jobScriptBuilder.getBatchScriptForEntity("基础层主表3").forEach((batchNo, sql) -> {
            System.out.println(String.format("\n批次 %d 脚本：\n%s", batchNo, sql));

        });
    }
    @Test
    public void testBatchSQLGenerator_4() throws Exception {
        jobScriptBuilder.getBatchScriptForEntity("法人").forEach((batchNo, sql) -> {
            System.out.println(String.format("\n批次 %d 脚本：\n%s", batchNo, sql));

        });
    }

    @After
    public void cleanup() {
    }
}
