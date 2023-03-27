# 双层贴片天线cst-python联合建模

采用CST-python联合建模并仿真口径耦合的双层贴片天线。采用时域求解器，GPU加速。  
天线工作于9.6GHz。

- 运行环境    
CST2023  python3.9
- 运行方式  
运行Main.py启动程序。


- 运行逻辑：  
通过cst-python库文件，将目录下的bas文件导入CST建模。运行并读取仿真结果，输出s11结果至终端。  

- 文件介绍  
.bas文件完成cst环境配置、建模、端口配置。  
parameterList是参数变量列表  