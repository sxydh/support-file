PS3='Please enter your choice: '
options=("Start all" "Stop all" "Clear" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Start all")
            # check status
            output=`ls -l sample_to_run 2>&1`
            if [[ $output == *"pid.log"* ]]
            then
            echo -e "\033[31mplease stop all processes first\033[0m"
            exit
            fi

            # jdk
            echo -e "\033[33mstart\033[0m"
            jdk_version=`java -version 2>&1`
            count=0
            while [[ $jdk_version == *"found"* ]]
            do
                    ((count++))
                    if [ $count -gt 3 ]
                    then 
                    echo -e "\033[31mno jdk8, stop trying, current times: $count\033[0m"
                    exit
                    fi

                    echo -e "\033[33mwill install jdk8\033[0m"
                    apt-get update
                    apt-get --assume-yes install openjdk-8-jdk
                    jdk_version=`java -version 2>&1`

                    if [[ $jdk_version == *"found"* ]]
                    then
                    echo -e "\033[31mno jdk8, will try again, current times: $count\033[0m"
                    continue
                    else
                    echo -e "\033[32m$jdk_version\033[0m"
                    fi
            done

            # mysql
            output=`mysql --version 2>&1`
            count=0
            while [[ $output != *"8.0.18"* ]]
            do
                    ((count++))
                    if [ $count -gt 3 ]
                    then 
                    echo -e "\033[31mno mysql8.0.18, stop trying, current times: $count\033[0m"
                    exit
                    fi

                    echo -e "\033[33mwill install mysql8.0.18\033[0m"
                    wget https://github.com/sxydh/other-data/raw/master/mysql/mysql-apt-config_0.8.14-1_all.deb
                    dpkg -i mysql-apt-config_0.8.14-1_all.deb
                    apt update
                    apt --assume-yes install mysql-server
                    output=`mysql --version 2>&1`

                    if [[ $output != *"8.0.18"* ]]
                    then
                    echo -e "\033[31mno mysql8.0.18, will try again, current times: $count\033[0m"
                    continue
                    else
                    echo -e "\033[32m$output\033[0m"
                    rm -f mysql-apt-config_0.8.14-1_all.deb
                    fi
            done

            # mysql -> database
            rootpasswd="123"
            output=`mysql -uroot -p${rootpasswd} -e "SHOW DATABASES" 2>&1`
            if [[ $output != *"charging_system"* ]]
            then
                    echo -e "\033[33mcreate database: charging_system\033[0m"
                    mysql -uroot -p${rootpasswd} -e "CREATE SCHEMA \`charging_system\`"
                    output=`mysql -uroot -p${rootpasswd} -e "SHOW DATABASES" 2>&1`
            fi
            echo -e "\033[33mSHOW DATABASES -> $output\033[0m"

            # mysql -> user
            output=`mysql --user="root" --password="123" --execute="SELECT user FROM mysql.user" 2>&1`
            if [[ $output != *"keep"* ]]
            then
                    echo -e "\033[33mcreate user: keep\033[0m"
                    mysql --user="root" --password="123" --execute="CREATE USER keep IDENTIFIED BY '123'"
                    mysql --user="root" --password="123" --execute="GRANT ALL ON *.* TO keep"
                    mysql --user="root" --password="123" --execute="FLUSH PRIVILEGES"
                    output=`mysql --user="root" --password="123" --execute="SELECT user FROM mysql.user" 2>&1`
            fi
            echo -e "\033[33mSELECT user FROM mysql.user -> $output\033[0m"

            # redis
            output=`redis-cli --version 2>&1`
            count=0
            while [[ $output == *"found"* ]]
            do
                    ((count++))
                    if [ $count -gt 3 ]
                    then 
                    echo -e "\033[31mno redis, stop trying, current times: $count\033[0m"
                    exit
                    fi

                    echo -e "\033[33mwill install redis\033[0m"
                    apt-get update
                    apt-get --assume-yes install redis-server
                    output=`redis-cli --version 2>&1`

                    if [[ $output == *"found"* ]]
                    then
                    echo -e "\033[31mno redis, will try again, current times: $count\033[0m"
                    continue
                    else
                    echo -e "\033[32m$output\033[0m"
                    fi

                    status=`service redis-server status 2>&1`
                    if [[ $status == *"running"* ]]
                    then
                            service redis-server stop
                    fi
                    rm -f redis.conf
                    wget https://raw.githubusercontent.com/sxydh/other-data/master/redis/redis.conf
                    output=`ls -l 2>&1`
                    if [[ $output != *"redis.conf"* ]]
                    then
                    echo -e "\033[31mfailed to wget redis.conf\033[0m"
                    exit
                    fi
                    rm -f /etc/redis/redis.conf
                    mv redis.conf /etc/redis/
                    service redis-server restart
                    output=`redis-cli --version 2>&1`
                    setpwd=`echo config set requirepass "123" | redis-cli`
                    echo -e "\033[33mconfig set requirepass "123" -> $setpwd\033[0m"
            done
            
            # unrar
            output=`unrar -version 2>&1`
            count=0
            while [[ $output == *"not found"* ]]
            do
                    ((count++))
                    if [ $count -gt 3 ]
                    then 
                    echo -e "\033[31mno unrar, stop trying, current times: $count\033[0m"
                    exit
                    fi

                    echo -e "\033[33mwill intall unrar\033[0m"
                    apt-get --assume-yes install unrar
                    output=`unrar -version 2>&1`

                    if [[ $output == *"found"* ]]
                    then
                    echo -e "\033[31mno unrar, will try again, current times: $count\033[0m"
                    continue
                    else
                    echo -e "\033[32m$output\033[0m"
                    fi
            done
            
            rm -f sample_to_run.part*
            output=`ls -l 2>&1`
            count=0
            while [[ $output != *"sample_to_run.part1.rar"* ]] || [[ $output != *"sample_to_run.part2.rar"* ]]
            do
                    ((count++))
                    if [ $count -gt 3 ]
                    then 
                    echo -e "\033[31mfailed to wget sample_to_run.rar, stop trying, current times: $count\033[0m"
                    exit
                    fi
            
                    rm -f sample_to_run.part*
                    wget https://github.com/sxydh/other-data/raw/master/utils/sample-shell/sample_to_run.part1.rar
                    wget https://github.com/sxydh/other-data/raw/master/utils/sample-shell/sample_to_run.part2.rar
                    output=`ls -l 2>&1`
            
                    if [[ $output != *"sample_to_run.part1.rar"* ]] || [[ $output != *"sample_to_run.part2.rar"* ]]
                    then
                    echo -e "\033[31mfailed to wget sample_to_run.rar, will try again, current times: $count\033[0m"
                    continue
                    else
                    echo -e "\033[32m$output\033[0m"
                    fi
            done

            # extract sample_to_run.rar
            rm -rf sample_to_run
            unrar x sample_to_run.part1.rar
            
            # tomcat9
            echo -e "\033[33mstart tomcat9\033[0m"
            cd sample_to_run
            chmod +x tomcat9/bin/*.sh
            output=`tomcat9/bin/startup.sh 2>&1`
            echo -e "\033[33mtomcat9/bin/startup.sh -> $output\033[0m"
            count=0
            while true
            do 
            ((count++))
            sleep 3
            pids=`lsof -i :80 | awk '$2 != "PID" { print $2 }' 2>&1`
            if [ -n "$pids" ]
            then
            echo "$pids" >> pid.log
            break
            elif [ $count -gt 10 ]
            then
            fuser -k -n tcp 80
            echo -e "\033[31mfailed to start tomcat9\033[0m"
            exit
            fi
            done

            # mechat server
            echo -e "\033[33mstart mechat server\033[0m"
            chmod +x mechat_server.jar
            nohup java -jar mechat_server.jar &
            count=0
            while true
            do 
            ((count++))
            sleep 3
            pids=`lsof -i :8887 | awk '$2 != "PID" { print $2 }' 2>&1`
            if [ -n "$pids" ]
            then
            echo "$pids" >> pid.log
            break
            elif [ $count -gt 10 ]
            then
            fuser -k -n tcp 8887
            echo -e "\033[31mfailed to start mechat server\033[0m"
            exit
            fi
            done

            # mysql -> tables
            mysql --user="keep" --password="123" --database="charging_system" < charging_system.sql
            mysql --user="root" --password="123" --execute="ALTER USER 'keep' IDENTIFIED BY '123' PASSWORD EXPIRE NEVER"
            mysql --user="root" --password="123" --execute="ALTER USER 'keep' IDENTIFIED WITH mysql_native_password BY '123'"
            mysql --user="root" --password="123" --execute="FLUSH PRIVILEGES"

            # char-server-app
            echo -e "\033[33mstart char-server-app\033[0m"
            chmod +x char-server-app/bin/*.sh
            output=`char-server-app/bin/startup.sh 2>&1`
            echo -e "\033[33mchar-server-app/bin/startup.sh -> $output\033[0m"
            count=0
            while true
            do 
            ((count++))
            sleep 3
            pids=`lsof -i :50100 | awk '$2 != "PID" { print $2 }' 2>&1`
            if [ -n "$pids" ]
            then
            echo "$pids" >> pid.log
            break
            elif [ $count -gt 10 ]
            then
            fuser -k -n tcp 50100
            echo -e "\033[31mfailed to start char-server-app\033[0m"
            exit
            fi
            done

            # char-server-manage
            echo -e "\033[33mstart char-server-manage\033[0m"
            chmod +x char-server-manage.jar
            nohup java -jar char-server-manage.jar &
            count=0
            while true
            do 
            ((count++))
            sleep 3
            pids=`lsof -i :50200 | awk '$2 != "PID" { print $2 }' 2>&1`
            if [ -n "$pids" ]
            then
            echo "$pids" >> pid.log
            break
            elif [ $count -gt 40 ]
            then
            fuser -k -n tcp 50200
            echo -e "\033[31mfailed to start char-server-manage\033[0m"
            exit
            fi
            done

            # done
            tomcat=`lsof -i :80 2>&1`
            echo -e "\033[32mtomcat ->\033[0m"
            echo -e "\033[32m${tomcat}\033[0m"
            
            mechat=`lsof -i :8887 2>&1`
            echo -e "\033[32mmechat ->\033[0m"
            echo -e "\033[32m${mechat}\033[0m"

            char_server_app=`lsof -i :50100 2>&1`
            echo -e "\033[32mchar-server-app ->\033[0m"
            echo -e "\033[32m${char_server_app}\033[0m"

            char_server_manage=`lsof -i :50200 2>&1`
            echo -e "\033[32mchar-server-manage ->\033[0m"
            echo -e "\033[32m${char_server_manage}\033[0m"

            break
            ;;
        "Stop all")
            echo -e "you chose choice $REPLY which is $opt"

            # check
            output=`cd sample_to_run 2>&1`
            if [[ $output == *"such"* ]]
            then
            echo -e "\033[31mno such directory: sample_to_run\033[0m"
            exit
            fi

            cd sample_to_run
            output=`ls -l`
            if [[ $output != *"pid.log"* ]]
            then
            echo -e "\033[31mno such file: pid.log\033[0m"
            exit
            fi

            # kill
            ROWNUM=1
            port=`sed "${ROWNUM}q;d" pid.log`
            while [ -n "$port" ]
            do
            kill $port
            echo -e "\033[33mkill -> $port\033[0m"
            ROWNUM=$(($ROWNUM+1))
            port=`sed "${ROWNUM}q;d" pid.log`
            done

            # done
            rm -f pid.log
            echo -e "\033[33mdone\033[0m"

            break
            ;;
        "Clear")
            echo -e "you chose choice $REPLY which is $opt"
            rm -f sample_to_run*
            echo -e "\033[33mrm -f sample_to_run.* -> $?\033[0m"
            rm -rf sample_to_run
            echo -e "\033[33mrm -rf sample_to_run -> $?\033[0m"
            break
            ;;
        "Quit")
            break
            ;;
        *) echo -e "invalid option $REPLY";;
    esac
done