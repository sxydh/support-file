# Profile
Script guide
# Specification
  * $
    ```bash
    ${#str} # 字符串长度

    $? # 最后一次命令执行后的返回值

    exit # 退出

    # 算术运算
    var=$((var+1))
    ((var=var+1))
    ((var+=1))
    ((var++))

    var=($(./[file name])) # 多行转数组, you can make an array in bash by doing var=(first second third) 
    ```

  * apt
    ```bash
    apt --assume-yes install [package name] # 静默安装
    ```

  * chmod
    ```bash
    chmod +x [file name] # 给予文件执行权限
    ```

  * echo
    ```bash
    # 获取命令输出
    output="$(ls -1 2>&1)" # 或OUTPUT=`ls -1 2>&1`, "2>&1"表示标准错误重定向到标准输出
    echo "${output}"

    # 断行写法
    multiline=$(ls \
       -1 2>&1)
    echo "${multiline}"

    # 写入文件
    echo "some data for the file" > fileName # 覆盖
    echo "some data for the file" >> fileName # 追加

    # 输出颜色
    echo -e "\033[30m黑色字\033[0m"
    echo -e "\033[31m红色字\033[0m"
    echo -e "\033[32m绿色字\033[0m"
    echo -e "\033[33m黄色字\033[0m"
    echo -e "\033[34m蓝色字\033[0m"
    echo -e "\033[35m紫色字\033[0m"
    echo -e "\033[36m天蓝字\033[0m"
    echo -e "\033[37m白色字\033[0m"
    ```

  * function
    ```bash
    my_function(){
            echo "hello, function"
            echo "$1"
            echo "$2"
            echo "${10}"
            echo "total -> $#"
            echo "all -> $*"
            return ${11}
    }
    my_function 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
    val="$?"
    echo "return value -> ${val}"
    echo "length -> ${#val}"
    ```

  * fuser
    ```bash
    fuser -k -n tcp 3000 # 根据端口kill process, 3000表示端口
    ```

  * if
    ```bash
    if [ a == b ] # 注意空格, "==": 不限类型相等, "-gt": 不限类型大于, "-lt": 不限类型小于, "!=": 不限类型不等于, "&&": 且(需要[[]], 中间不加空格), "||": 或(需要[[]])
    then 
    echo "a"
    elif
    then
    echo "b"
    else
    echo "c"
    fi

    # 判断空
    if [ -z "$your_var" ] # 注意引号, -z: the length of STRING is zero, -n: the length of STRING is nonzero

    # 判断字符串是否包含另一字符串
    string="My long string"
    if [[ $string == *"My long"* ]]
    then
      echo "It's there!"
    fi

    # 查看是否安装了某软件
    if ! type "rar" > /dev/null
    then
    echo "need to intall rar"
    else
    echo "have installed rar"
    fi
    ```

  * lsof
    ```bash
    # 端口占用
    lsof -i :11120

    # 根据端口获取pid
    lsof -t -i :22 -s TCP:LISTEN # 只支持lsof支持的协议
    lsof -i :15146 | awk '$2 != "PID" { print $2 }' # 解析方案, $2表示第2个字段, 注意输出可能有多行
    ```

  * nohup
    ```bash
    # 后台运行, the & symbol, switches the program to run in the background, the nohup utility makes the command passed as an argument run in thebackground even after you log out.
    # 0 – stdin (standard input), 1 – stdout (standard output), 2 – stderr (standard error).
    nohup [command] > [file name].log 2>&1 &  

    # 另外一种后台运行
    ./[sh file name].sh > [log file name].log 2>&1 &
    ```

  * sed
    ```bash
    # 替换
    sed -i 's/original/new/g' file.txt # sed = Stream EDitor, -i = in-place (i.e. save back to the original file), s = the substitute command, original = a regular expression  describing the word to replace (or just the word itself), new = the text to replace it with, g = global (i.e. replace all and not just the first occurrence), file.txt = the file  name

    # 例a替换为b
    a="-e"
    b="echo -e"
    sed -i -e "s/${a}/${b}/g" ./test.sh

    # 输出文件特定行
    sed 'NUMq;d' file # Where NUM is the number of the line you want to print; so, for example, sed '10q;d' file to print the 10th line of file
    sed "${NUM}q;d" file # if you have NUM in a variable, you will want to use double quotes instead of single
    ```

  * select [var] in [list]
    ```bash
    # 输出选项
    PS3='Please enter your choice: ' #用于select的提示
    options=("Option 1" "Option 2" "Option 3" "Quit")
    select opt in "${options[@]}"
    do
        case $opt in
            "Option 1")
                echo "you chose choice 1"
                ;;
            "Option 2")
                echo "you chose choice 2"
                ;;
            "Option 3")
                echo "you chose choice $REPLY which is $opt"
                ;;
            "Quit")
                break
                ;;
            *) echo "invalid option $REPLY";;
        esac
    done
    ```

  * shuf
    ```bash
    shuf -i 2000-65000 -n 1 # 范围内随机数
    ```

  * uuid
    ```bash
    uuid=$(uuidgen)
    ```

  * var
    ```bash
    $[var] # 引用变量
    ```

  * wget
    ```bash
    wget [url] # 下载
    ```

  * while
    ```bash
    # while
    port=$(shuf -i 10000-40000 -n 1)
    occupy=$(lsof -i :$port)
    while [ -n "$occupy" ]
    do
    port="$(shuf -i 10000-40000 -n 1 2>&1)"
    occupy="$(lsof -i :$port 2>&1)"
    done
    ```