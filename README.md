# python-cst
- 一个平台，欢迎大家在这里共享自己学习遇到的问题和解决方法，感谢各位同学支持！！

## Anaconda+VScode安装教程
- 一种简单的使用Python控制CST方法
- CST版本是2023

## update_model.py
该文件是一个用于更新CST模型的Python程序。在进行模型更新之前，需要指定CST模型文件的路径和模型中所需更新的参数值。本程序通过调用CST的接口实现参数的更新和模型计算，并获取输出结果。具体流程如下：

1. 引入了cst、cst.interface、cst.results等库。

2. 定义了CST模型路径（cst_path）、CST项目名称（cst_project）、CST项目路径（cst_project_path）以及输出结果路径（cst_result_folder）等变量。

3. 打开CST项目（cst.interface.DesignEnvironment.open_project）并更新参数（para_update），参数的值通过代码中的变量进行指定。

4. 运行CST计算（mycst1.mode1er.run_solver()）。

5. 关闭CST项目（cst.interface.DesignEnvironment.close）。

6. 通过cst.results库获取结果，包括频率值（s11_freqs）和S参数（s_11）。

7. 输出结果。

需要注意的是，由于本程序中的更新参数和运行CST计算的代码部分被注释掉了，所以程序在当前状态下无法实现CST模型的更新和计算。

===========================================================================
## Contributor
- [Treiles](https://github.com/Treslie)
特别感谢Treiles同学提供的双层贴片天线cst-python联合建模项目！！
