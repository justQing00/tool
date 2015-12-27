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
  echo "service_nginx"
  service_name="nginx"
  service_path="/Users/tanliqingcn"
  service_start="sudo nginx"
  service_stop="sudo nginx -s stop"
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

exec_type=$exec_type_start
service_mysql
service_nginx

exit 0
