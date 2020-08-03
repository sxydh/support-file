# Profile
Git guide

# Specification
* 用户信息配置
  ```bash 
  git config --global user.name "John Doe"
  git config --global user.email johndoe@example.com
  git config --global credential.helper store #避免push时总是输入密码
  git config --list #查看所有配置信息
  
  git config --global http.proxy 'socks5://127.0.0.1:1080' #开启http代理
  git config --global https.proxy 'socks5://127.0.0.1:1080' #开启https代理
  git config --global --unset http.proxy
  git config --global --unset https.proxy
  ```
* 仓库
  ```bash
  git init #初始化仓库
  git clone url [name] #name是可选的
  git remote add origin url #添加远程，origin是自定义的
  git push --set-upstream origin master #本地关联远程分支

  # 初始化裸仓库，用来建服务器
  git init --bare reponame

  # 搭建Git服务器参考
  # * 新建一个裸仓库
  # * 添加客户端公钥到authorized_keys，该文件可在用户目录下.ssh文件夹内找到，例入root用户在/root/.ssh/，其它用户在/home/username/.ssh/，找不到则新建。公钥可以用PuTTYgen生成，本地必须保存私钥
  # * 克隆使用(建议用TortoiseGit客户端，方便load指定私钥)：sxydh@172.16.20.128:/home/repo/cprecharge.git。注意sxydh必须拥有读写cprecharge.git的权限，可在建裸仓库时就指定文件夹的拥有者
  ```
* 分支
  ```bash
  git branch #查看分支
  git branch <branch name> #创建分支
  git checkout <branch name> #切换分支
  git checkout -b <branch name> #创建并切换到新分支
  
  git merge <another branch name>
  git rebase master #用变基合并分支, 合并后分支是一条线
  
  git reset --hard <HEAD>
  
  git branch -D <branch name> #删除本地分支
  git push origin --delete <branch name> #删除远程分支, 前提是该分支不是默认分支, 否则修改远程仓库的默认分支
  ```
* 标签
  ```bash
  git tag #列出标签
  git tag -a v1.0 -m "mark" #创建标签
  git show tagName #查看标签
  git tag -d tagName #删除标签
  ```
* VPS
  ```bash
  #连接, 用来充当terminal
  ssh root@192.168.30.128 -p 22 #22是ssh端口
  #上传文件
  scp -r C:/Users/Administrator/Desktop/config.json root@192.168.30.128:/root
  #下载文件
  scp -r root@192.168.30.128:/root C:/Users/Administrator/Desktop
  ```
* 文件
  ```bash
  git add .
  git commit -m <info>
  git commit -a -m <info>
  git commit -m <info> --amend
  git push
  git push -f
  
  git pull
  git status
  git log
  
  git checkout .
  git rm -r --cached . #清空所有缓存的文件, -r 表示递归
  git clean -xdf #强制移除未跟踪的文件和目录
  ```
