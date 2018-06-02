# README

## 该项目为APP提供数据以及后台管理数据

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## Gem

devise-sms-登录注册（支持手机号）https://github.com/giano/devise_sms_activable/pull/8

权限/角色/审计 [cancancan](https://github.com/CanCanCommunity/cancancan)

布局 AdminLTE   & slim

分页 [kaminari](https://github.com/kaminari/kaminari)

carriewave & upyun

表格WiceGrid

simple_form

daemon-spawn

figaro

postgres

mina

[puma](https://github.com/puma/puma)

文件上传 [paperclip](https://github.com/thoughtbot/paperclip)

提供API [grape](https://github.com/ruby-grape/grape)

## rails 数据库对应的字段类型

:binary TINYBLOB, BLOB, MEDIUMBLOB, or LONGBLOB2 :limit => 1 to 4294967296 (default = 65536)2

:boolean TINYINT(1)

:date DATE

:datetime DATETIME

:decimal DECIMAL :precision => 1 to 63 (default = 10) :scale => 0 to 30 (default = 0)3

:float FLOAT

:integer INT :limit => 1 to 11 (default = 11)

:primary_key INT(11) AUTO_INCREMENT PRIMARY KEY

:string VARCHAR :limit => 1 to 255 (default = 255)

:text TINYTEXT, TEXT, MEDIUMTEXT, or LONGTEXT2 :limit => 1 to 4294967296 (default = 65536)2

:time TIME

:timestamp DATETIME

:attachment FILE

## 部分数据来源

  [极速数据](https://www.jisuapi.com/)

  [多云数据](http://www.duoyun.io/)

  [古诗文网](https://www.gushiwen.org/)

## 数据接口

* ===============================星座运势====================================

* [星座列表 :GET请求](http://101.200.174.126:8898/api/v1/astros/list)

* [星座运势 :GET请求](http://101.200.174.126:8898/api/v1/astros/fortune_details?astro_id=1)

* [指定日期星座运势 :GET请求](http://101.200.174.126:8898/api/v1/astros/fortune_details?astro_id=1&select_date=2018-01-01)

* ===============================文学=========================================

* [三字经 :GET](http://101.200.174.126:8898/api/v1/educations/sanzijing)

* [百家姓列表 :GET](http://101.200.174.126:8898/api/v1/educations/baijiaxing)

* [百家姓介绍 :GET](http://101.200.174.126:8898/api/v1/educations/baijiaxing_detail?id=343)

* [千字文 :GET](http://101.200.174.126:8898/api/v1/educations/qianziwen)

* [弟子规 :GET](http://101.200.174.126:8898/api/v1/educations/dizigui)

* [弟子规 :GET](http://101.200.174.126:8898/api/v1/educations/dizigui_detail?id=1)

待完善

















#
