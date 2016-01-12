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

# 创建文件
def create_file(file_name, folder_name):
  print "Create "+ file_name + " in " + folder_name
  file_create = open(file_name, 'w');
  file_create.close();
  return

# 创建hbs文件
def create_file_h(file_name, folder_name):
  create_file(component_file_hbs, folder_name)
  return

# 创建hbs、coffee文件
def create_file_hc(file_name, folder_name):
  create_file(component_file_hbs, folder_name)
  create_file(component_file_coffee, folder_name)
  return

# 创建hbs、coffee、scss文件
def create_file_hcs(file_name, folder_name):
  create_file(component_file_hbs, folder_name)
  create_file(component_file_coffee, folder_name)
  create_file(component_file_scss, folder_name)
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
      createComponent(component_path, component_type)
  return

init_component()


