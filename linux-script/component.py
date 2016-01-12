#!/usr/bin/python
# -*- coding: UTF-8 -*-

import os;

# 组件的基本信息
link = ""
component_path = ""
component_name = ""
component_target = ""

# 组件类型
component_type = ""
# 只是hbs文件
component_type_h = "hbs"
# 只是hbs与coffee文件
component_type_hc = "hbsCoffee"
# 只是hbs、coffee、scss文件
component_type_hcs = "hbsCoffeeScss"
# 仿照另外一个组件
component_type_comp = "comp"

# 文件类型
component_file_coffee = "view.coffee"
component_file_hbs = "view.hbs"
component_file_scss = "view.scss"

# 文件备注
file_author = "  author by terminus.io (tanlq)"

# 创建文件
def create_file(file_name, folder_name):
  print "Create "+ file_name + " in " + folder_name
  file_create = open(file_name, 'w');
  write_file(file_create, file_name)
  file_create.close();
  return

# 写入文件
def write_file(file_create, file_name):
  link = "/live-stock"
  str_empty = get_file_content(file_name, link);
  file_create.write(str_empty);
  return

# 获得文件内容
def get_file_content(file_name, link):
  str_empty = ""
  className = get_class_name(file_name, link);
  if file_name == component_file_hbs:
    str_empty = '{{#component "js-comp '+ className + '"}}\n\n{{/component}}';
  elif file_name == component_file_coffee:
    str_empty = '###\n' + file_author + '\n###\n class ' + className + '\n  constructor: ($) -> \n    @bindEvents()\n\n  bindEvents: ->\n\nmodule.exports = ' + className;
  elif file_name == component_file_scss:
    str_empty = className + ' {\n\n}'
  return str_empty

# 获得类名
def get_class_name(file_name, link):
  className = ""
  className = ''.join(link.split('/'))
  if file_name == component_file_hbs:
    className = className
  elif file_name == component_file_coffee:
    className = str_capitalize(className)
  elif file_name == component_file_scss:
    className = "." + className
  return className

# 首字母大写
def str_capitalize(link):
  className = ""
  strList = link.split('-')
  for word in strList:
    print word
    className = className + word.capitalize()
  return className

# 创建hbs文件
def create_file_h(folder_name):
  create_file(component_file_hbs, folder_name)
  return

# 创建hbs、coffee文件
def create_file_hc(folder_name):
  create_file(component_file_coffee, folder_name)
  create_file(component_file_hbs, folder_name)
  return

# 创建hbs、coffee、scss文件
def create_file_hcs(folder_name):
  create_file(component_file_scss, folder_name)
  create_file(component_file_coffee, folder_name)
  create_file(component_file_hbs, folder_name)
  return

# 创建文件夹
def create_folder(folder_name):
  print "Create folder " + folder_name;
  try:
    os.mkdir(folder_name);
  except:
    print folder_name + " already exist"
  return

# 创建组件
def createComponent(component_path, component_type):
  if component_type == component_type_h:
    create_file_h(component_path);
  elif component_type == component_type_hc:
    create_file_hc(component_path);
  elif component_type == component_type_hcs:
    create_file_hcs(component_path);
  return

# 初始化组件方法
def init_component():
  component_path = raw_input('Component Path: ');
  component_type = raw_input('Component Type["hbs", "hbsCoffee", "hbsCoffeeScss", "comp"]: ');
  linkList = []
  EnterFlag = True

  while EnterFlag:
    link = raw_input('Link: ');
    linkList.append(link);
    if len(linkList) > 0:
      flag = raw_input('Still Enter Link [y/n]?: ');
      flag = flag.lower();
    if flag == 'n':
      EnterFlag = False;
      createComponent(component_path, component_type);
  return

init_component();


