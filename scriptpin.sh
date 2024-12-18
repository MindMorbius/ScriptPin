#!/bin/bash

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# 脚本URL和路径变量
SCRIPT_URL="https://raw.githubusercontent.com/MindMorbius/ScriptPin/main/scriptpin.sh"
SCRIPT_PATH="$0"

# 新增更新函数
update_script() {
    echo -e "${GREEN}正在检查更新...${NC}"
    
    # 下载新脚本到临时文件
    if curl -fsSL "$SCRIPT_URL" -o /tmp/scriptpin.new; then
        # 比较文件差异
        if ! cmp -s "$SCRIPT_PATH" /tmp/scriptpin.new; then
            cp /tmp/scriptpin.new "$SCRIPT_PATH"
            chmod +x "$SCRIPT_PATH"
            echo -e "${GREEN}脚本已更新，重启生效${NC}"
            rm /tmp/scriptpin.new
            exit 0
        else
            echo -e "${GREEN}已是最新版本${NC}"
            rm /tmp/scriptpin.new
        fi
    else
        echo -e "${RED}更新失败，请检查网络连接${NC}"
    fi
    read -p "按任意键继续..."
}

# 主菜单
show_main_menu() {
    clear
    echo -e "${GREEN}=== ScriptPin 主菜单 ===${NC}"
    echo "1. 系统状态检测"
    echo "2. 安装常用软件"
    echo "3. 脚本更新"
    echo "0. 退出"
}

# 系统状态检测
system_check() {
    clear
    echo -e "${GREEN}=== 系统状态检测 ===${NC}"
    echo "系统版本: $(cat /etc/os-release | grep PRETTY_NAME | cut -d'"' -f2)"
    echo "系统架构: $(uname -m)"
    echo "系统内核: $(uname -r)"
    echo "内存使用: $(free -h | grep Mem)"
    echo "磁盘使用: $(df -h / | tail -n1)"
    echo "网络状态: $(ping -c 1 8.8.8.8 >/dev/null && echo '正常' || echo '异常')"
    echo "运行服务: $(systemctl list-units --type=service --state=running | wc -l) 个"
    read -p "按任意键返回主菜单..."
}

# 安装软件
install_software() {
    clear
    echo -e "${GREEN}=== 软件安装菜单 ===${NC}"
    echo "1. 更新系统依赖"
    echo "2. 安装Git"
    echo "3. 配置SSH"
    echo "4. 安装NodeJS"
    echo "5. 安装Python"
    echo "0. 返回主菜单"
    
    read -p "请选择: " choice
    case $choice in
        1)
            sudo apt update && sudo apt upgrade -y
            ;;
        2)
            sudo apt install git -y
            ;;
        3)
            configure_ssh
            ;;
        4)
            curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
            sudo apt install -y nodejs
            ;;
        5)
            install_python
            ;;
        0)
            return
            ;;
        *)
            echo "无效选择"
            ;;
    esac
    read -p "按任意键继续..."
}

# 新增SSH配置函数
configure_ssh() {
    if [ ! -f ~/.ssh/id_rsa ]; then
        read -p "请输入邮箱地址: " email
        ssh-keygen -t rsa -b 4096 -C "$email"
    fi
    echo -e "\n${GREEN}您的SSH公钥如下：${NC}"
    cat ~/.ssh/id_rsa.pub
}

# 新增Python版本选择安装函数
install_python() {
    echo -e "${GREEN}可选Python版本:${NC}"
    echo "1. Python 3.8"
    echo "2. Python 3.9"
    echo "3. Python 3.10"
    echo "4. Python 3.11"
    
    read -p "请选择版本[1-4]: " ver
    case $ver in
        1)
            sudo apt install python3.8 python3.8-venv -y
            ;;
        2)
            sudo apt install python3.9 python3.9-venv -y
            ;;
        3)
            sudo apt install python3.10 python3.10-venv -y
            ;;
        4)
            sudo apt install python3.11 python3.11-venv -y
            ;;
        *)
            echo "无效选择"
            return
            ;;
    esac
    echo "Python安装完成"
}

# 主循环
while true; do
    show_main_menu
    read -p "请选择: " choice
    case $choice in
        1)
            system_check
            ;;
        2)
            install_software
            ;;
        3)
            update_script
            ;;
        0)
            echo "感谢使用!"
            exit 0
            ;;
        *)
            echo -e "${RED}无效选择${NC}"
            sleep 1
            ;;
    esac
done 