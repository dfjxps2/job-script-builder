## 模块说明
### job-script-lib
生成作业脚本的工具包，需要引入到清洗融合项目中。
### job-script-util
生成作业脚本的命令行工具，可以单独执行。

## 部署说明

1. 在清洗融合库所在的MySQL服务器上创建etlman_db数据库，然后执行sql/etlman_db.sql建表。


## 使用说明

* 在清洗融合库中创建sync_job_configuration存储过程（在最新的建库脚本中可以找到）。

* 配置好融合作业（转换作业）后，调用这个存储过程将作业配置导入etlman_db数据库。
``` sql
call cleanse_db.sync_job_configuration(1);
select * from trace_log;
```
其中存储过程的参数为作业ID，执行完毕后可以在trace_log表中检查一下是否有错误信息。

* 现在可以执行生成脚本的命令行程序进行生成作业脚本的测试
``` bash
java -jar job-script-util-1.0-SNAPSHOT.jar 法人 /c/tmp
```
其中'法人'为转换作业所对应的目标表的中文名称，第二个参数为生成脚本的路径。

* 在程序中调用脚本生成程序的方式可以参考job-script-util模块下的com.seaboxdata.JobScriptUtil.java中的写法。