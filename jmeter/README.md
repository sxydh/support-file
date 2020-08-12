# Profile
Jmeter guide.

# HTTP Request
  * 建立Header
    * 线程组 -> 编辑 -> 添加 -> 配置元件 -> HTTP信息头管理器
    * 添加[*常用的Header*](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Headers)
  * 建立Request
    * 线程组 -> 编辑 -> 添加 -> 取样器 -> HTTP请求

# Custom Variable
  * 变量引用方式
    * ${var name}
  * 使用CSV文件作为数据源
    * 编辑 -> 添加 -> 配置元件 -> CSV数据文件设置
    * 设置变量名称，分隔符，循环模式等
    * 引用  
    以上是顺序引用CSV，随机引用可参考此方案
      * 建循环控制器
      * 建CSV数据文件和if控制器，两者同级且必须位于循环控制器内，if控制器条件设置为${__Random(1,1000)}==${csv rownum}
      * 建HTTP请求，且位于if控制器内
      * 引用
  * 用户自定义变量
    * 编辑 -> 添加 -> 配置元件 -> 用户自定义的变量
    * 添加键值对(值可以引用Jmeter的function)，[*Jmeter支持的function*](https://jmeter.apache.org/usermanual/functions.html#functions)
    * 引用

# Remote And Cluster
  * Slave(Ubuntu)  
    jmeter.properties
    * 设置服务端口```server_port=40100```
    * 禁用ssl```server.rmi.ssl.disable=true```
    * 启动服务```./jmeter-server -Djava.rmi.server.hostname=localhost```
  * Master(Windows)  
    jmeter.properties
    * 禁用ssl```server.rmi.ssl.disable=true```
    * 设置远程服务器```remote_hosts=192.168.243.129:40100,192.168.243.129:40200```
    * 启动slave
      [*启动参数见*](https://jmeter.apache.org/usermanual/get-started.html#options)
      [*报告参数见*](https://jmeter.apache.org/usermanual/generating-dashboard.html#sample_configuration)
      ```bash
      # 只生成jtl，不生成report
      jmeter -n -t C:\Users\Administrator\Desktop\test.jmx -r -l C:\Users\Administrator\Desktop\rt.jtl
      # 生成jtl和report
      jmeter -n -t C:\Users\Administrator\Desktop\test.jmx -r -l C:\Users\Administrator\Desktop\rt.jtl -e -o C:\Users\Administrator\Desktop\report
      # 根据jtl文件生成report
      jmeter -g C:\Users\Administrator\Desktop\rt.jtl -o C:\Users\Administrator\Desktop\report
      # 手动停止测试，第一个参数是命令，第二个参数是端口号，端口号在master命令行启动时显示
      java -cp ApacheJMeter.jar org.apache.jmeter.util.ShutdownClient StopTestNow 4445
      ```

# Report
  * [*术语表*](https://jmeter.apache.org/usermanual/glossary.html)