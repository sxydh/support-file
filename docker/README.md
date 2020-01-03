# Profile
Docker guide.

# Specification
  * 镜像
    ```bash
    docker pull <name> # 拉取镜像，修改国内镜像源settings -> Daemon -> Registry mirrors -> http://724ffc86.m.daocloud.io
    docker images # 列出所有镜像，或docker image ls
    docker image rm <image id> # 删除镜像

    docker build ./ -t <目标镜像名称> # 用Dockerfile构建自定义镜像，具体参考https://yeasy.gitbooks.io/docker_practice/image/build.html和https://blog.csdn.net/wanglei_storage/article/details/48602717
    ```

  * 容器
    ```bash
    docker run -d -p 8080:8080 tomcat # 根据镜像创建容器，-d表示后台，-p表示主机和容器端口映射，若需要可视化（即前台）则将-d换为-it即可，具体参数含义可用docker run --help查看
    docker ps -a # 查看所有容器状态
    docker start <container id> # 启动容器
    docker exec -it <container id> /bin/bash # 进入容器（仅针对tomcat容器）
    docker stop <container id> # 停止容器
    docker stop $(docker ps -aq) # 停止所有容器，windows仅在PowerShell下生效
    docker rm <container id> # 删除容器
    docker rm $(docker ps -aq) # 删除所有容器，windows仅在PowerShell下生效
    ```

  * 文件操作
    ```bash
    docker cp b9609b7059cf:/root / # docker cp --help
    ```