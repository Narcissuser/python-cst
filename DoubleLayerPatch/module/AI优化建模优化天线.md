


## 总体概述
完成一个用于调用CST进行电磁仿真的接口系统。程序的核心是CST_interface.py文件，它实现了参数设置、仿真运行、结果读取和保存、优化等多项功能。同时，还包含一个用于读取和保存csv文件以进行参数优化。

各文件功能：

| 文件名 | 功能 |
| --- | --- |
| CST_interface.py | 用于调用CST进行电磁仿真的接口文件。主要功能包含读取参数、修改参数、执行仿真、读取仿真结果、保存结果等功能。 |
| dataIO.py | 包含一个dataIO类，用于读取和保存csv文件以进行参数优化。主要功能包含读取和保存csv文件、生成和读取要优化的参数列表、读取指定行号的结果。 |
| ParameterOptimization.py | 对CST_interface.py进行了参数优化，主要功能是读取优化参数列表，并自动运行多次仿真。|
| CST_Visualization.py | 基于之前保存的CST仿真结果，对仿真结果进行可视化分析。主要功能是读取csv文件，生成对应的图形。 |
| ParameterOptimization_Visualization.py | 基于ParameterOptimization.py的结果，对仿真结果进行可视化分析。主要功能是读取csv文件，生成对应的图形。 |


目前完成主要功能包含读取参数、修改参数、执行仿真、读取仿真结果、保存结果等功能。具体结构和功能概述如下：

1. 导入相关的python模块，包括cst、os、re、csv、numpy等。
2. 定义一个CST_py_interface类，其中包含一些初始化操作和模块操作的方法。主要包括以下方法： 
    1) __init__：定义CST的路径、文件名和CST界面对象等属性。
    2) ModuleCreat：读取文件夹下.bas的文件建模，读取parameterList.txt文件的参数进行建模，
        并运行完成后保存并关闭。
    3) ReadFile_Bas：读取VBA代码文件，并将其格式化为CST接口代码的形式。
    4) Moduled_VBA：将读取的VBA代码写入历史树。
    5) ParameterInit：读取parameterList.txt文件中的参数列表，提取参数名和参数值，并调用ParameterModify方法修改参数。
    6) ParameterModify：根据提供的参数名和参数值，在CST界面中修改参数。
    7) CST_dataread：读取指定类型的仿真结果数据，包括s11和Farfield等。
    8) CST_Farfield2DRead：读取二维远场数据。
    9) CSTS11dataread：读取s11参数的仿真结果数据，并保存至csv文件中。
    10) save_data_to_csv：将数据保存至csv文件。
    11) optimized：进行参数优化。
    12) CSTrun：运行CST仿真。
    13) CSTclose：保存并关闭CST仿真。
    14) ParametertoResult：将参数修改后的仿真结果保存至csv文件中。
3. 定义一个dataIO类，用于读取和保存csv文件以进行参数优化。主要包含以下方法：
    1) __init__：定义相关的属性。
    2) ParameterOptimizedListBuild：读取parameterList.txt文件中的参数列表，并根据参数范围构建出参数的组合，
        并将其保存至csv文件中。
    3) save_data_to_csv：将数据保存至csv文件。
    4) read_data_from_csv：从csv文件中读取数据。
    5) read_data_from_csv_line：从csv文件中读取指定行号的数据。