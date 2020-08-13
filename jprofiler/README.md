# Profile
JProfiler guide.

# Quik Start
  * Linux
    * 安装libXrender.so.1动态库  
      ```bash
      apt-get install libxrender-dev 
      apt-get install libxtst-dev 
      ```
    * bin下启动```./jprofiler``` 
    * Tips  
      * 执行bin/jprofiler会产生文件夹/root/.jprofiler11/
      * 通过编辑jprofiler和jpenable可以指定各自jdk路径
      * (供参考)查看实际使用的jdk可以查看/root/.jprofiler11/jprofiler_config.xml
# Remote
  * 服务端
    * 必须先启动要监控的程序
    * bin下启动服务```bin/jpenable```，profiling mode选GUI mode，记住端口
  * 客户端
    * 使用服务端IP+PORT启动GUI
  * Tips  
    * 只能通过停止监控的程序来停止jpenable，若需要再次使用则重复启动步骤
    * 启动服务jpenable时若出现```No unprofiled JVMs found.```，可以尝试重启监控的程序
    * 服务端和客户端版本必须一致