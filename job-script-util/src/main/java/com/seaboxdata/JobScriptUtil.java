package com.seaboxdata;

import com.seaboxdata.etlman.JobScriptBuilder;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import javax.sql.DataSource;
import java.io.File;
import java.io.FileWriter;

@Slf4j
@SpringBootApplication
public class JobScriptUtil implements CommandLineRunner {

    private JobScriptBuilder jobScriptBuilder;

    @Value("${job-script.working.db.name}")
    private String workingDBName;

    @Value("${job-script.data.src.col.name}")
    private String dataSrcColName;

    @Value("${job-script.load.date.col.name}")
    private String loadDateColName;

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

        log.info("Building job script for table {} ...", taskName);
        jobScriptBuilder.initETLTasks()
                .setWorkingDBName(workingDBName)
                .setLoadDateColName(loadDateColName)
                .setDataSrcColName(dataSrcColName);

        String script = jobScriptBuilder.getSQLScriptForTask(taskName);
        FileWriter fileWriter = new FileWriter(outputDir + File.separator + taskName + ".sql");

        fileWriter.write(script);

        fileWriter.close();
    }
}
