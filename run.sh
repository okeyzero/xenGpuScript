#!/bin/bash

# 检查参数是否为空
if [ -z "$2" ]; then
  echo "请提供账户地址作为参数"
  exit 1
fi

# 安装依赖
sudo apt install -y ocl-icd-opencl-dev
sudo apt-get install -y cmake make g++

# 克隆代码并编译
git clone https://github.com/shanhaicoder/XENGPUMiner.git
cd XENGPUMiner
chmod +x build.sh
if [ -n "$1" ]; then
  ./build.sh -cuda_arch $1
else
  ./build.sh
fi

# 启动矿工程序
nohup ./xengpuminer -b 1024 > miner.out 2>&1 &

# 安装Python依赖并启动Python脚本
pip3 install -U -r requirements.txt
nohup python3 ./miner.py --gpu=true --account=$2 > miner_python.out 2>&1 &

echo "脚本执行完毕"
