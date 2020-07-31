# Profile
Jmeter guide.

# HTTP测试
  * 建立Header
    * 线程组 -> 编辑 -> 添加 -> 配置元件 -> HTTP信息头管理器
    * 添加[*常用的Header*](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Headers)
  * 建立Request
    * 线程组 -> 编辑 -> 添加 -> 取样器 -> HTTP请求

# 用户自定义变量
  * 变量引用方式
    * ${var name}
  * 使用CSV文件作为数据源
    * 测试计划 -> 编辑 -> 添加 -> 配置元件 -> CSV数据文件设置
    * 设置变量名称，分隔符，循环模式等
    * 引用