PS3='Please enter your choice: '
options=("V2Ray" "SSR" "Show" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "V2Ray")
            echo -e "\033[33myou chose choice $REPLY which is $opt \033[0m"

            systemctl stop v2ray
            systemctl disable v2ray
            rm -rf /etc/v2ray
            rm -rf /usr/bin/v2ray
            rm -rf /var/log/v2ray
            rm -rf /lib/systemd/system/v2ray.service
            rm -rf /etc/init.d/v2ray

            rm -f go.sh
            wget https://install.direct/go.sh
            sudo bash go.sh

            rm -f config_server.json
            wget https://raw.githubusercontent.com/sxydh/other-data/master/gfw/v2ray/config_server.json
            service v2ray stop
            rm -f /etc/v2ray/config.json
            mv config_server.json /etc/v2ray/config.json

            port_dy="$(shuf -i 10000-40000 -n 1 2>&1)"
            occupy="$(lsof -i :$port_dy 2>&1)"
            while [ -n "$occupy" ]
            do
            port_dy="$(shuf -i 10000-40000 -n 1 2>&1)"
            occupy="$(lsof -i :$port_dy 2>&1)"
            done
            replace_string="\"port\": 11111"
            replace_with="\"port\": $port_dy"
            sed -i "s/$replace_string/$replace_with/g" /etc/v2ray/config.json

            port_al="$(shuf -i 10000-40000 -n 1 2>&1)"
            occupy="$(lsof -i :$port_al 2>&1)"
            while [[ -n "$occupy" ]] || [[ port_al == port_dy ]]
            do
            port_al="$(shuf -i 10000-40000 -n 1 2>&1)"
            occupy="$(lsof -i :$port_al 2>&1)"
            done
            replace_string="\"port\": 22222"
            replace_with="\"port\": $port_al"
            sed -i "s/$replace_string/$replace_with/g" /etc/v2ray/config.json

            uuid="$(uuidgen 2>&1)"
            replace_string="\"id\": \"uuid\""
            replace_with="\"id\": \"$uuid\""
            sed -i "s/$replace_string/$replace_with/g" /etc/v2ray/config.json

            echo -e "\033[32mport_dy -> $port_dy\033[0m"
            echo -e "\033[32mport_al -> $port_al\033[0m"
            echo -e "\033[32muuid -> $uuid\033[0m"

            service v2ray start

            break
            ;;
        "SSR")
            echo -e "\033[33myou chose choice $REPLY which is $opt\033[0m"

            shadowsocksr/shadowsocks/stop.sh
            rm -rf shadowsocksr

            git clone https://github.com/shadowsocksrr/shadowsocksr.git

            pyth="$(python --version 2>&1)"
            if [[ $pyth == *"found"* ]]
            then
            echo -e "\033[33mwill install python\033[0m"
            apt update
            apt --assume-yes install python
            fi

            cd shadowsocksr
            bash initcfg.sh

            rm -f user-config.json
            wget https://raw.githubusercontent.com/sxydh/other-data/master/gfw/ssr/user-config.json

            port="$(shuf -i 10000-40000 -n 1 2>&1)"
            occupy="$(lsof -i :$port 2>&1)"
            while [ -n "$occupy" ]
            do
            port="$(shuf -i 10000-40000 -n 1 2>&1)"
            occupy="$(lsof -i :$port 2>&1)"
            done
            replace_string="\"server_port\": 11111"
            replace_with="\"server_port\": $port"
            sed -i "s/$replace_string/$replace_with/g" user-config.json

            password="$(uuidgen 2>&1)"
            replace_string="\"password\": \"uuid\""
            replace_with="\"password\": \"$password\""
            sed -i "s/$replace_string/$replace_with/g" user-config.json

            cd shadowsocks
            chmod +x *.sh
            ./stop.sh
            ./logrun.sh

            echo -e "\033[32mport -> $port\033[0m"
            echo -e "\033[32mpassword -> $password\033[0m"

            break
            ;;
        "Show")
            echo -e "\033[33myou chose choice $REPLY which is $opt\033[0m"
            
            v2ray=`cd /etc/v2ray 2>&1`
            if [[ $v2ray == *"such"* ]]
            then
            echo -e "\033[31mv2ray is not installed\033[0m"
            else
            v2ray_port=`sed '8q;d' /etc/v2ray/config.json 2>&1`
            v2ray_id=`sed '13q;d' /etc/v2ray/config.json 2>&1`
            echo -e "\033[32mv2ray ->\033[0m"
            echo -e "\033[32m${v2ray_port}\033[0m"
            echo -e "\033[32m${v2ray_id}\033[0m"
            fi

            ssr=`cd shadowsocksr 2>&1`
            if [[ $ssr == *"such"* ]]
            then
            echo -e "\033[31mssr is not installed\033[0m"
            else
            ssr_port=`sed '4q;d' shadowsocksr/user-config.json 2>&1`
            ssr_password=`sed '8q;d' shadowsocksr/user-config.json 2>&1`
            echo -e "\033[32mssr ->\033[0m"
            echo -e "\033[32m${ssr_port}\033[0m"
            echo -e "\033[32m${ssr_password}\033[0m"
            fi

            break
            ;;
        "Quit")
            break
            ;;
        *) echo -e "\033[33minvalid option $REPLY\033[0m";;
    esac
done
