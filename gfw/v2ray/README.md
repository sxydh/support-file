# Profile
使用v2ray

# Specification
 * 服务器   
   * 下载脚本 `wget https://install.direct/go.sh`
   * 执行脚本用于安装v2ray `sudo bash go.sh`
   * 更新 `sudo bash go.sh`
   * 编辑配置文件 `/etc/v2ray/config.json`, 参照[*此文件*](./config_server.json)
   * 启动 `sudo systemctl start v2ray` 或 `service v2ray start`
 * 客户端
   * 解压[*此文件*](./v2ray-windows-64.zip)
   * 编辑配置文件 `config.json`, 参照[*此文件*](./config_client.json)
   * 执行 `v2ray.exe` 或 `wv2ray.exe`, 后者用于后台运行
 * 其它
   * 防火墙(CentOS 7 x64)
     * 查看已开放端口 `firewall-cmd --list-ports`
     * 查看特定端口 `firewall-cmd --zone= public --query-port=80/tcp`
     * 新增端口 `firewall-cmd --zone=public --add-port=80/tcp --permanent`
     * 删除端口 `firewall-cmd --zone=public --remove-port=80/tcp --permanent`
     * 重载 `firewall-cmd --reload`