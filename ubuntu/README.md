# Profile
Ubuntu guide
# Specification
  * 基本
    ```bash
    #更新, root用户下
    apt-get update #updates the list of available packages and their versions, but it does not install or upgrade any packages
    apt-get upgrade #actually installs newer versions of the packages you have

    #清屏
    clear

    #查看内网ip
    ifconfig -a

    #显示所有进程
    ps -e
    ```

  * 用户
    ```bash
    # 新增用户
    adduser sxydh
    # 为用户设置密码
    passwd sxydh

    # 指定资源拥有者
    # user : 新的文件拥有者的使用者 ID
    # group : 新的文件拥有者的使用者组(group)
    # -c : 显示更改的部分的信息
    # -f : 忽略错误信息
    # -h :修复符号链接
    # -v : 显示详细的处理信息
    # -R : 处理指定目录以及其子目录下的所有文件
    # --help : 显示辅助说明
    # --version : 显示版本
    # sample : chown -R sxydh cprecharge
    chown [-cfhvR] [--help] [--version] user[:group] file...
    ```

  * 文件
    ```bash
    #文件权限
    #u 表示该文件的拥有者, g 表示与该文件的拥有者属于同一个群体(group)者, o 表示其他以外的人, a 表示这三者皆是
    #+ 表示增加权限, - 表示取消权限, = 表示唯一设定权限
    #r 表示可读取, w 表示可写入, x 表示可执行, X 表示只有当该文件是个子目录或者该文件已经被设定过为可执行
    chmod ugo+r file.txt
    chmod 777 [name] #权限修改为可读可写可执行

    #复制文件
    cp ./app.war /root/Desktop/keep/apache/tomcat-server/webapps/

    #复制文件夹
    cp -r ./tomcat-server ./tomcat-client

    #Linux export 命令用于设置或显示环境变量
    export [-fnp][变量名称]=[变量设置值]

    #查找文件
    find . -name 'container_debug' -print # 查找当前目录及所有子目录名为container_debug的文件

    #列出所有文件
    ls -a

    #以每行一个文件的长格式列出文件的类型, 访问权限, 链接数, 用户属主, 用户组, 文件大小, 最后修改时间和文件名等信息
    ls -l

    #创建目录
    mkdir tomcat

    #重命名文件或文件夹
    mv old.? new.?

    #移动文件
    mv source target

    #显示当前工作目录
    pwd

    #删除文件
    rm fileName.suffix

    #强制删除文件
    rm -f fileName.suffix

    #删除目录及文件
    rm -r directory

    #删除空目录
    rmdir directory

    #监控文件最后200行
    tail -200f char-server-app.log

    #解压tar
    #-z, --gzip, --gunzip, --ungzip   filter the archive through gzip
    #-j, --bzip2                filter the archive through bzip2
    #-v, --verbose              verbosely list files processed
    #-c, --create               create a new archive
    #-x, --extract, --get       extract files from an archive
    #-f, --file=ARCHIVE         use archive file or device ARCHIVE
    tar -xvf apache-tomcat-9.0.22.tar.gz #解压
    tar -zvcf uri_30100productcheck.gz uri_30100productcheck #压缩

    #创建文件
    touch fileName

    #解压rar
    unrar x [file name] #保持文件结构

    #解压zip
    unzip [file name]
    ```

  * 软件
    ```bash
    #安装JDK8
    sudo apt-get install openjdk-8-jdk

    #运行jar并保持后台
    nohup java -jar <file name>

    #下载文件
    wget 
    ```

  * 文本
    ```bash
    #到行首
    0

    #前进
    ctrl + r
    
    #到文件首
    gg

    #进入编辑模式
    i

    #退出编辑模式
    Esc键

    #到行末
    $

    #删除所有
    :%d

    #剪切一行
    dd

    #删除行光标余下的部分并处于command模式
    D

    #到最后一行
    G

    #光标后粘贴
    p

    #回退
    u

    #复制一行
    yy

    #保存但不退出
    :w

    #保存并退出
    :wq

    #强制退出
    :q!
    ```

  * [*脚本*](./SCRIPT%20SYNTAX.md)
  
  * 其它
    ```bash
    #Mirror
    http://mirrors.aliyun.com/ubuntu #阿里

    #Xshell
    apt-get install -y lrzsz #安装lrzsz

    rz #上传

    sz fileName.suffix #下载
    ```
