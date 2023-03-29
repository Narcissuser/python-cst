# 双层贴片天线cst-python联合建模

采用CST-python联合建模并仿真口径耦合的双层贴片天线。采用时域求解器，GPU加速。  
天线工作于9.6GHz。

- 运行环境    
CST2023  python3.9
- 运行方式  
运行Main.py启动程序。


- 运行逻辑：  
通过cst-python库文件，将目录下的bas文件导入CST建模。运行并读取仿真结果，输出s11结果至终端。  


# CSTPY_Build.py文件概述

该文件提供了对CST软件（电磁仿真软件）的建模、模拟和数据读取等功能的模块和函数。主要实现以下4个功能：

1. 读取文件夹下.bas的文件建模，读取parameterList.txt文件的参数进行建模。

2. 读取历史树中VBA代码并写入历史树

3. 修改参数

4. 读取CST的仿真数据

## 函数列表

|函数名称|函数功能|
|-|-|
|ModuleCreat()|读取文件夹下.bas的文件建模，读取parameterList.txt文件的参数进行建模。|
|ReadFile_Bas()|读取历史树中VBA代码|
|Moduled_VBA()|将VBA代码写入历史树|
|ParameterInit()|根据parameterList.txt进行初始化|
|ParameterModify()|修改模型参数|
|CST_dataread()|读取CST仿真数据|
|CST_dataread_test()|测试读取CST仿真数据|
|CST_Farfield2DRead()|读取CST二维远场数据|
|S11dataread()|读取CST回波损耗数据|
|save_data_to_csv()|将读取到的数据保存到CSV文件中|



