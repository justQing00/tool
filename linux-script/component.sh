#!/bin/sh
# 前端组件生成

# echo 输出颜色值
color_blue="\033[36m"
color_white="\033[37m"
color_base=$color_blue
color_other=$color_white

# 组件的基本信息
project_folder=""
link=""
component_path=""
component_name=""
component_target=""

# 组件类型
component_type=""
# 只是hbs文件
component_type_h="hbs"
# 只是hbs与coffee文件
component_type_hc="hbsCoffee"
# 只是hbs、coffee、scss文件
component_type_hcs="hbsCoffeeScss"
# 仿照另外一个组件
component_type_comp="comp"

# 文件类型
component_file_coffee="view.coffee"
component_file_hbs="view.hbs"
component_file_scss="view.scss"

# 创建hbs文件
creat_h()
{
  className_hbs=${link/\//\ }
  echo "className_hbs:"$className_hbs
  # touch $component_file_hbs
}

# 创建hbs、coffee文件
creat_hc()
{
  creat_h
  className_coffee=$(echo $component_name|sed 's/_\(.\)/\U\1/g')
  echo "className_coffee:"$className_coffee
  # touch $component_file_coffee
}

# 创建hbs、coffee、scss文件
creat_hcs()
{
  creat_hc
  className_scss=${className_hbs/\ /\.}
  echo "className_scss:"$className_scss
  # touch $component_file_scss
}

# 执行创建流程
executionCreat()
{
  echo "Will create file now"
  link="/live-stock"
  component_name=${link/\//\ }
  component_name=${component_name/\-/\_}
  echo "component_name:"$component_name
  creat_hcs
}

case "$1" in
  'hbs')
    component_type=$component_type_h
    executionCreat
    ;;
  'hbsCoffee')
    component_type=$component_type_hc
    executionCreat
    ;;
  'hbsCoffeeScss')
    component_type=$component_type_hcs
    executionCreat
    ;;
  'comp')
    component_type=$component_type_comp
    executionCreat
    ;;
  *)
    echo "$color_base""Commands: "
    echo "  hbs: create hbs file."
    echo "  hbsCoffee: create hbs and coffee file."
    echo "  hbsCoffeeScss: create hbs、coffee and scss file."
    echo "  comp: create component that like another one."
    exit 1
    ;;
esac
