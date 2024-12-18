# ScriptPin

一键部署服务的脚本

## 安装使用
通过 curl 安装脚本
```bash
curl -fsSL https://raw.githubusercontent.com/MindMorbius/ScriptPin/main/scriptpin.sh -o scriptpin.sh && chmod +x scriptpin.sh && ./scriptpin.sh
```

## 一级菜单
1. 系统检测
2. 安装与配置
3. 脚本更新

## 二级菜单
### 1. 系统检测
- 检测系统版本
- 检测系统架构
- 检测系统内核
- 检测系统内存
- 检测系统磁盘
- 检测系统网络
- 检测系统服务

### 2. 安装与配置
1. 更新依赖:update、upgrade
2. 安装git
3. 配置ssh：引导生成ssh公钥，并将公钥展示
4. 安装nodejs
5. 安装python：提供Python版本选择，并安装指定版本
