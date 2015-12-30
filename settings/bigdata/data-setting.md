# 大数据安装配置教程
                              By tanlq@terminus.io
## 1、基本知识
### 1、1 数据流向：

    SQLServer/MySQL等 -> sqoop -> hadoop -> hive -> spark -> cassandra
### 1、2 所用到的服务及启动命令：

#### 基本服务
##### 1）mysql

    mysql.server start

##### 2）nginx

    sudo nginx

##### 3）redis

    redis-server

##### 4）elasticsearch-v1.6.0

    ./elasticsearch

##### 5）zookeeper

    zkServer start

#### 大数据服务
* pigmall_members为MySql数据库hive中的一个table，是为了演示操作安装配置过程
* 各版本均为官网下载或者brew 安装的合适版本，不可过低或者过高
* 依据cd 打开的目录判断配置方式

##### 1）sqoop v1.4.5_hadoop-2.0.4
将数据库中的数据导出为hdfs

    > cd /Users/tanliqingcn/SoftWare/settings/hadoop/sqoop-1.4.5_hadoop-2.0.4/bin
    > ./sqoop import --connect jdbc:mysql://127.0.0.1:3306/hive --username root --password '' --table pigmall_members --fields-terminated-by : -m 1
##### 2）hadoop v2.7.1
启动hadoop

     > cd /Users/tanliqingcn/SoftWare/settings/hadoop/hadoop-2.7.1/sbin
    > ./start-all.sh

hdfs的有关命令
进入 hdfs

    > cd  /Users/tanliqingcn/SoftWare/settings/hadoop/hadoop-2.7.1/bin

* sqoop导出后即可生成以下文件

删除

    > ./hdfs dfs -rm -r  /user/tanliqingcn/pigmall_members

查看

    > ./hdfs dfs -cat /user/tanliqingcn/pigmall_members/part-m-00000


##### 3）hive v1.0.1
进入hive

    > cd /Users/tanliqingcn/SoftWare/settings/hive/hive-1.0.1/bin

启动hive

    > ./hive --service metastore
进入hive命令行

    > ./hive
##### 4）spark v1.5.1
进入spark服务

    > cd /usr/local/Cellar/apache-spark/1.5.1/libexec/sbin

启动spark

    > ./start-all.sh
进入spark命令行

    > cd /usr/local/Cellar/apache-spark/1.5.1/libexec/bin/spark-shell
    > ./hive

##### 5）cassandra v2.2.2
进入cassandra服务

    > cd /usr/local/Cellar/cassandra/2.2.2/bin

启动 cassandra

    > cassandra

进入cassandra命令行

    > cqlsh

## 2、安装教程
### 2、1 sqoop v1.4.5_hadoop-2.0.4
1）[安装参考链接][1]
  [1]: http://www.blogjava.net/redhatlinux/archive/2014/05/31/414291.html
2）安装成功后，即可从MySql中拉取数据

### 2、2 hadoop v2.7.1
1）[安装参考链接][2]
  [2]: http://www.itnose.net/detail/6182168.html
2）依据参考链接，测试安装成功后，读取sqoop导出的数据

### 2、3 hive v1.0.1
1）[安装参考链接1][3]
  [3]: http://www.micmiu.com/bigdata/hive/hive-default-setup/
2）[安装参考链接2][4]
  [4]: http://autumnice.blog.163.com/blog/static/55520020131140120137/
####   注意不要使用derby数据源，换成mysql
3）[我的hive-site.xml文件][5]
  [5]: https://github.com/justQing00/tool/blob/master/settings/hive-site.xml
4）启动metastore服务
* 注意hive-site这个地方

...
    <property>
    <name>hive.metastore.uris</name>
    <value>thrift://127.0.0.1:9083</value>
    </property>
...


* 命令

...
    > ./hive --service metastore
...

5）依据参考链接，测试安装成功后，读取hdfs中的数据
hive创建数据库

    > CREATE DATABASE sqltest01;
    > USE sqltest01;

hive创建数据表

    hive> CREATE TABLE IF NOT EXISTS pigmall_members (
        > id string,
        > user_mobile string,
        > created_at string,
        > updated_at string)
        > row format delimited
        > fields terminated by ':'
        > lines terminated by '\n';

从hdfs导入到hive:

    > load data inpath '/user/tanliqingcn/pigmall_members/part-m-00000' into table pigmall_members;

### 2、4 spark v1.5.1
1）[安装参考链接1][6]
  [6]: http://www.micmiu.com/bigdata/hive/hive-default-setup/

2）[安装参考链接2][7]
  [7]: http://ju.outofmemory.cn/entry/177769

3）将hive-site.xml复制到spark的conf里面

4）spark启动后，然后进入spark命令行

    > cd /usr/local/Cellar/apache-spark/1.5.1/libexec/bin/spark-shell

5）spark读取hive数据

    > cd /usr/local/Cellar/apache-spark/1.5.1/libexec/bin
    > ./spark-shell
    > val sqlContext = new org.apache.spark.sql.hive.HiveContext(sc);
    > import sqlContext._;
    //指定数据库
    > sqlContext.sql("use sqltest01");
    > sqlContext.sql("SELECT * FROM pigmall_members").collect().foreach(println)

### 2、5 cassandra v2.2.2
1）待总结，以前保存的链接没有了

