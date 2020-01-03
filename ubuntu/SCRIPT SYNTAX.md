```bash
# 获取命令输出
OUTPUT="$(ls -1)"
echo "${OUTPUT}"
# 断行写法
MULTILINE=$(ls \
   -1)
echo "${MULTILINE}"

$[var] # 引用变量

apt --assume-yes install [package name] # 静默安装

chmod +x [file name] # 给予文件执行权限
echo [string] # 输出字符串

fuser -k -n tcp 3000 # 根据端口kill process, 3000表示端口

if [ a == b ] # 注意空格, "==": 不限类型相等, "-gt": 不限类型大于, "-lt": 不限类型小于, "!=": 不限类型不等于, "&&": 且(需要[[]], 中间不加空格), "||": 或(需要[[]])
then 
echo "a"
elif
then
echo "b"
else
echo "c"
fi

nohup [command] & # 后台运行, the & symbol, switches the program to run in the background, the nohup utility makes the command passed as an argument run in thebackground even after you log out

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

# 替换
sed -i 's/original/new/g' file.txt # sed = Stream EDitor, -i = in-place (i.e. save back to the original file), s = the substitute command, original = a regular expression describing the word to replace (or just the word itself), new = the text to replace it with, g = global (i.e. replace all and not just the first occurrence), file.txt = the file name

shuf -i 2000-65000 -n 1 # 范围内随机数

wget [url] # 下载

# while
port=$(shuf -i 10000-40000 -n 1)
occupy=$(lsof -i :$port)
while [ -n "$occupy" ]
do
port=$(shuf -i 10000-40000 -n 1)
occupy=$(lsof -i :$port)
done
```