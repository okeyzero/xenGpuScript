#!/bin/bash

# 检查参数是否提供
if [ $# -ne 1 ]; then
  echo "Error: Please provide the account address."
  echo "Usage: $0 <account_address>"
  exit 1
fi

# 接收参数
account_address=$1

# 安装依赖
sudo apt install ocl-icd-opencl-dev
sudo apt-get install cmake make g++

# 克隆代码
git clone https://github.com/shanhaicoder/XENGPUMiner.git
cd XENGPUMiner

# 编译
chmod +x build.sh
./build.sh

# 启动矿工和挖矿程序
nohup ./xengpuminer -b 1024 &
pip3 install -U -r requirements.txt
nohup python3 ./miner.py --gpu=true --account=$account_address > miner.out 2>&1 &

# 查看 gpu计算日志 tail -f nohup.out
# 查看 挖矿日志  tail -f miner.out
