package com.seaboxdata;

import com.seaboxdata.etlman.JobScriptBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import javax.sql.DataSource;
import java.io.File;
import java.io.FileWriter;

@SpringBootApplication
public class JobScriptUtil implements CommandLineRunner {

    private JobScriptBuilder jobScriptBuilder;

    public static void main(String[] args) {
        SpringApplication.run(JobScriptUtil.class, args);
    }

    @Autowired
    public JobScriptUtil(DataSource dataSource) throws Exception {
        this.jobScriptBuilder = new JobScriptBuilder(dataSource);
    }

    @Override
    public void run(String... args) throws Exception {

        if (args.length == 0)
            return;

        String taskName = args[0];
        String outputDir = args[1];

        jobScriptBuilder.initETLTasks();

        String script = jobScriptBuilder.getSQLScriptForTask(taskName);
        FileWriter fileWriter = new FileWriter(outputDir + File.separator + taskName + ".sql");

        fileWriter.write(script);

        fileWriter.close();
    }
}
