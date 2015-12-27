#!/bin/sh
# service执行类型
exec_type=""
exec_type_start="start"
exec_type_stop="stop"

# service相关变量
service_name=""
service_path=""
service_start=""
service_stop=""
service_isRestart=true

# echo 输出颜色值
color_blue="\033[36m"
color_base=$color_blue
# service-mysql
service_mysql()
{
  service_name="mysql"
  service_path="/Users/tanliqingcn"
  service_start="mysql.server start"
  service_stop="mysql.server stop"
  service_isRestart=true
  service_handle
}

# service-nginx
service_nginx()
{
  service_name="nginx"
  service_path="/Users/tanliqingcn"
  service_start="sudo nginx"
  service_stop="sudo nginx -s stop"
  service_isRestart=true
  service_handle
}

# service-zooKeeper
service_zooKeeper()
{
  service_name="zooKeeper"
  service_path="/Users/tanliqingcn"
  service_start="zkServer start"
  service_stop="zkServer stop"
  service_isRestart=true
  service_handle
}

# service-hadoop
service_hadoop()
{
  service_name="hadoop"
  service_path="/Users/tanliqingcn/SoftWare/settings/hadoop/hadoop-2.7.1/sbin"
  service_start="./start-all.sh"
  service_stop="./stop-all.sh"
  service_isRestart=true
  service_handle
}

# service-spark
service_spark()
{
  service_name="spark"
  service_path="/usr/local/Cellar/apache-spark/1.5.1/libexec/sbin"
  service_start="./start-all.sh"
  service_stop="./stop-all.sh"
  service_isRestart=true
  service_handle
}

# service-redis
service_redis()
{
  service_name="redis"
  service_path="/Users/tanliqingcn/SoftWare/settings/redis/data"
  service_start="redis-server"
  service_stop="echo $service_name has no stop command"
  service_isRestart=false
  service_handle
}

# service-elasticsearch
service_elasticsearch()
{
  service_name="elasticsearch"
  service_path="/Users/tanliqingcn/SoftWare/settings/elasticsearch/elasticsearch-1.6.0"
  service_start="bin/elasticsearch"
  service_stop="echo $service_name has no stop command"
  service_isRestart=false
  service_handle
}

# service-cassandra
service_cassandra()
{
  service_name="cassandra"
  service_path="/usr/local/Cellar/cassandra/2.2.2/bin"
  service_start="cassandra"
  service_stop="echo $service_name has no stop command"
  service_isRestart=false
  service_handle
}

# service-hive
service_hive()
{
  service_name="hive"
  service_path="/Users/tanliqingcn/SoftWare/settings/hive/hive-1.0.1/bin"
  service_start="./hive"
  service_stop="echo $service_name has no stop command"
  service_isRestart=false
  service_handle
}

# service-复杂的启动处理
service_start_complex()
{
  if [ "$service_isRestart" = true ];then
    service_start
  else
    echo "$color_base $service_name cannot restarted because of no stop command."
  fi
}

# service-默认的启动处理
service_start()
{
  if ps -ef | grep $service_name | egrep -v grep >/dev/null;then
    echo "$color_base $service_name is started. And $service_name will restart."
    cd $service_path
    eval $service_stop
    eval $service_start
    echo "$color_base $service_name is restarted."
  else
    echo "$color_base $service_name will start."
    echo "\033[37m"
    cd $service_path
    eval $service_start
    echo "$color_base $service_name is started."
  fi
}

# service-停止
service_stop()
{
  echo "$color_base $service_name will stop."
  cd $service_path
  eval $service_stop
  echo "$color_base $service_name is stoped."
}

# service-处理
service_handle()
{
  if [ "$exec_type" = "$exec_type_start" ];then
    service_start_complex
  else
    service_stop
  fi
}

# service-基础服务
executionSequence_base()
{
  echo "$color_base Will $exec_type the basic service."
  service_mysql
  service_nginx
  service_redis
  service_elasticsearch
}

# service-大数据相关服务
executionSequence_bigData()
{
  echo "$color_base Will $exec_type the big data service."
  service_zooKeeper
  service_hadoop
  service_spark
  service_hive
  service_cassandra
}

# service-执行顺序
executionSequence()
{
  executionSequence_base
  executionSequence_bigData
}

case "$1" in
  'start')
    exec_type=$exec_type_start
    executionSequence
    ;;
  'stop')
    exec_type=$exec_type_stop
    executionSequence
    ;;
  *)
    echo "$color_base Commands: "
    echo "   start: start all service"
    echo "   stop: stop all service"
    echo " Comments: These services include mysql、nginx、redis、elasticsearch、"
    echo "           elasticsearch、zookeeper、hadoop、spark、hive、cassandra."
    exit 1
    ;;
esac

