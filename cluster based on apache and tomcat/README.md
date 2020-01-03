# Profile
Deploy a cluster based on apache and tomcat.

# Specification
  * 准备[*Apache*](https://www.apachelounge.com/download/)
    * 修改配置文件[*httpd.conf*](./demo/Apache24/conf/httpd.conf)中的SRVROOT路径
    * 给Windows添加服务 (cmd到bin目录, 需管理员权限)
      ```bash
      httpd -k install #添加Apache服务
      sc delete <服务名> #删除服务命令
      ```
    * 添加两个配置文件到conf文件夹下
      * [*mod_jk.conf*](./demo/Apache24/conf/mod_jk.conf)
      * [*workers.properties*](./demo/Apache24/conf/workers.properties)
    * modules文件夹中添加[*mod_jk.so*](./demo/Apache24/modules/mod_jk.so), 并在 [*httpd.conf*](./demo/Apache24/conf/httpd.conf)中加入`include conf/mod_jk.conf`
  * 准备[*Tomcat*](https://tomcat.apache.org/download-90.cgi)
    * 拷贝两份
    * 修改配置文件[*server.xml*](./demo/apache-tomcat-9.0.12-1/conf/server.xml), 注意要和 [*workers.properties*](./demo/Apache24/conf/workers.properties)相对应
    * 部署相同的项目[*HelloWorld*](./demo/apache-tomcat-9.0.12-1/webapps/HelloWorld.war)
  * 测试
    * 开启apache服务
    * 启动三个tomcat
    * 多次加载`localhost/HelloWorld/`, 负荷会随机分配到一个tomcat(分配策略和配置有关)