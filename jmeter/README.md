# Profile
Jmeter guide.

# HTTP Request
  * 建立Header
    * 线程组 -> 编辑 -> 添加 -> 配置元件 -> HTTP信息头管理器
    * 添加[*常用的Header*](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Headers)
  * 建立Request
    * 线程组 -> 编辑 -> 添加 -> 取样器 -> HTTP请求

# Custom variable
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