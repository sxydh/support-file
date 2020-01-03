# Profile
使用ssr

# Specification
  * 服务端
    * `git clone https://github.com/shadowsocksrr/shadowsocksr.git`
    * `apt install python`
    * `cd shadowsocksr`, `bash initcfg.sh`
    * `vim user-config.json` [*参考*](https://doubibackup.com/0f4p8oki-3.html)
    * 调试: `cd shadowsocks`, `python server.py`
    * 设为后台服务: `chmod +x *.sh`, `./logrun.sh`; 停止后台服务: `./stop.sh`
    * 查看日志: `./tail.sh`
  * 客户端
    * [*下载解压即用*](https://github.com/shadowsocksrr/shadowsocksr-csharp/releases)
