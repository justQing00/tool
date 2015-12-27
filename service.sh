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

# service-mysql
service_mysql()
{
  service_name="mysql"
  service_path="/Users/tanliqingcn"
  service_start="mysql.server start"
  service_stop="mysql.server stop"
  service_handle
}

# service-nginx
service_nginx()
{
  service_name="nginx"
  service_path="/Users/tanliqingcn"
  service_start="sudo nginx"
  service_stop="sudo nginx -s stop"
  service_handle
}

# service-zooKeeper
service_zooKeeper()
{
  service_name="zooKeeper"
  service_path="/Users/tanliqingcn"
  service_start="zkServer start"
  service_stop="zkServer stop"
  service_handle
}

# service处理
service_handle()
{
  if [ "$exec_type" = "$exec_type_start" ];then
    service_start
  else
    service_stop
  fi
}

# service启动
service_start()
{
  if ps -ef | grep $service_name | egrep -v grep >/dev/null;then
    echo "$service_name is started. And $service_name will restart."
    cd $service_path
    eval $service_stop
    eval $service_start
    echo "$service_name is restarted."
  else
    echo "$service_name will start."
    cd $service_path
    eval $service_start
    echo "$service_name is started."
  fi
}

# service停止
service_stop()
{
  echo "$service_name will stop."
  cd $service_path
  eval $service_stop
  echo "$service_name is stoped."
}

# service-执行顺序
executionSequence()
{
  echo "$exec_type"
  # service_mysql
  # service_nginx
  # service_zooKeeper
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
    echo "Commands: "
    echo "  start: start all service"
    echo "  stop: stop all service"
    echo "Comments: These services include mysql、nginx、redis、elasticsearch、"
    echo "          elasticsearch、zookeeper、hadoop、spark、hive、cassandra."
    exit 1
    ;;
esac
