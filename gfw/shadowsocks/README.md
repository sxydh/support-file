# Profile
如何搭建一个可用的梯子
# Specification
* 建立虚拟主机, [*Vultr*](https://my.vultr.com/) 为例(建议修改ssh端口, 即修改/etc/ssh/sshd_config文件的port, 修改后记得重启ssh服务, 即"service ssh restart") 
* 安装Xshell并连接到虚拟主机
* 搭建SS
  * Xshell连接成功后, 运行命令
    ```Shell
	  wget --no-check-certificate -O shadowsocks-libev.sh https://raw.githubusercontent.com/uxh/shadowsocks_bash/master/shadowsocks-libev.sh && bash shadowsocks-libev.sh
	  ```
  * 接下来按提示操作: 
    * 安装Shadowsocks服务; 
    * 设置SS密码; 
    * 设置SS端口, 范围`1024-65535`; 
    * 设置SS加密方式, 一般用aes-256-cfb; 
    * 安装完毕后，记录对应信息
* 安装 [*Shadowsocks*](./Shadowsocks-4.1.2.zip), 输入相关信息, 开启全局代理即可
