# Profile
Simple nginx guide

# Specification
  * 基本命令
    ```bash
    # Usage: nginx [-?hvVtTq] [-s signal] [-c filename] [-p prefix] [-g directives]
    # 
    # Options:
    #   -?,-h         : this help
    #   -v            : show version and exit
    #   -V            : show version and configure options then exit
    #   -t            : test configuration and exit
    #   -T            : test configuration, dump it and exit
    #   -q            : suppress non-error messages during configuration testing
    #   -s signal     : send signal to a master process: stop, quit, reopen, reload
    #   -p prefix     : set prefix path (default: /usr/share/nginx/)
    #   -c filename   : set configuration file (default: /etc/nginx/nginx.conf)
    #   -g directives : set global directives out of configuration file

    # start server
    systemctl start nginx
    # reload server
    nginx -s reload
    # stop nginx
    systemctl stop nginx
    # test configuration and exit
    nginx -t
    ```
  * 配置文件样例
    * [*CORS*](./cors.conf)
    * [*Load Balancer*](http://nginx.org/en/docs/http/load_balancing.html)
      * [*round-robin*](./lb-round-robin.conf)
      * [*weight*](./lb-weight.conf)
      * [*least-conn*](./lb-least-conn.conf)
  