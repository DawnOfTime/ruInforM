**2022-04-22**

* 本项目创建于2017年，目的是作为毕业设计练手用的，相较于现在，项目使用的技术相对来说已经较为陈旧了，且由于当时知储备不足，jar包并未使用maven进行管理。

>所用技术：struts2+spring+mybatis

**目录结构：**

>src：源码及配置文件

>WebContent：静态资源

>WebContent.WEB-INF.lib：所依赖jar包

>WebContent.sql：数据库表结构(ruInforM.sql)

**注：在使用tomcat启动该项目时应提前将javax.servlet-api-4.0.1.jar移除！（原理：因为tomcat中已经存在该jar包，两个同时存在会冲突）**

