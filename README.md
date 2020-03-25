## 模块说明
### job-script-lib
生成作业脚本的工具包，需要引入到清洗融合项目中。
### job-script-util
生成作业脚本的命令行工具，可以单独执行。

## 部署说明

1. 在清洗融合库所在的MySQL服务器上创建etlman_db数据库，然后执行sql/etlman_db.sql建表。


## 使用说明

* 在清洗融合库中创建sync_job_configuration和sync_job_configuration_4_dev存储过程（在最新的建库脚本中可以找到）。

* 配置好融合作业（转换作业）后，根据运行方式调用不同的存储过程将作业配置导入etlman_db数据库。

正式提交作业
``` sql
call cleanse_db.sync_job_configuration(1); -- 将正式作业配置导入etlman_db
select * from trace_log;
```

作业试运行
``` sql
call cleanse_db.sync_job_configuration_4_dev(1); -- 将试运行作业配置导入etlman_db
select * from trace_log;
```

其中存储过程的参数为作业ID，执行完毕后可以在trace_log表中检查一下是否有错误信息。

* 现在可以执行生成脚本的命令行程序进行生成作业脚本的测试
``` bash
# 生成正式作业脚本，“法人”为正式作业名称（=目标表名称）
java -jar job-script-util-1.0-SNAPSHOT.jar 法人 /c/tmp

# 生成试运行作业脚本，“法人_测试”为试运行作业名称（=目标表名称+“_测试”）
java -jar job-script-util-1.0-SNAPSHOT.jar 法人_测试 /c/tmp

```
上述命令第二个参数为生成脚本的路径。

* 在程序中调用脚本生成程序的方式可以参考job-script-util模块下的com.seaboxdata.JobScriptUtil.java中的写法。

## 关于作业试运行
由于目前调度系统尚未定义作业提交接口，作业可用的参数也无法确定，为方便系统测试，目前可以支持不带参数的作业试运行，具体做法为：
1. 操作员配置完成作业并保存后，点击“试运行”按钮。
2. 系统根据上述流程生成试运行的作业脚本。
3. 系统将生成的脚本存放在可配置的目录下，文件名可以使用作业名称。
4. 系统提示“试运行作业脚本已生成，存放路径为 ... ...”。
5. 操作员到指定目录下提取脚本手工执行测试。

## FAQ
1. sync_job_configuration报：
    ```
    [Err] 1062 - Duplicate entry '数据平台-<db-name>-<table-name>-<column-name>' for key 'PRIMARY'
    ```
    检查融合作业目标表的字段中文名是否有重复（data_fld.fld_cn_name）
