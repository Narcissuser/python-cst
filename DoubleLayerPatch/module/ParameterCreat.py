import csv
import numpy as np
import os
import re
import itertools

#数据集构建：给定优化范围，生成参数表，表格包括参数和编号。导出数据每个都包括编号命名。
#参数表包括数值和范围。仿真范围应该是带宽在6-14GHz。

class ParameterCreat():
    def __init__(
        self,
        Progectname,
    ):  # 初始化一个属性r（不要忘记self参数，他是类下面所有方法必须的参数）
        self.ProgectName = Progectname
        self.parmteterfilm = os.path.join(self.ProgectName, 'parameterList.txt')
        self.Outputfilm = os.path.join(self.ProgectName, 'parameterModifylist')

    def ParameterOptimizedListBuild(self):
        ##读取参数表
        with open(self.parmteterfilm, "r") as file:
            # 读取文件内容到一个字符串
            data = file.read()
        # 初始化变量以存储提取的数据
        name = []
        initvalue = []
        parameterfulllist = []
        # 定义正则表达式以匹配所需的数据
        pattern = re.compile(
            r"([a-zA-Z0-9_]+)=\"([-0-9.]+)\" \"([-.0-9]+) to ([-.0-9]+) step ([-.0-9]+)\""
        )
        # 使用 findall() 函数在字符串中查找所有匹配项
        matches = pattern.findall(data)
        # 遍历匹配项列表，将值分配给相应的变量
        print('match success')

        for match in matches:
            teplist = []
            tepvalue = []
            name.append(match[0])
            initvalue.append(float(match[1]))
        j = 0
        for match in matches:
            tepvalue = initvalue.copy()
            print(tepvalue)

            teplist = [
                round(i, 2) for i in list(
                    np.arange(float(match[2]), float(match[3]), float(
                        match[4])))
            ]
            for value in teplist:
                tepvalue[j] = float(value)
                parameterfulllist.append(tepvalue.copy())
                print(tepvalue)
            j = j + 1
        print('list over')
        print('Addnumber over')
        print(name)
        self.save_data_to_csv(self.Outputfilm, name)
        for parameterlist in parameterfulllist:
            self.save_data_to_csv(self.Outputfilm, parameterlist)

    def ParameterOptimizedListBuildfull(self):
        ##读取参数表
        with open(self.parmteterfilm, "r") as file:
            # 读取文件内容到一个字符串
            data = file.read()
        # 初始化变量以存储提取的数据
        name = []
        initvalue = []
        parameterfulllist = []
        # 定义正则表达式以匹配所需的数据
        pattern = re.compile(
            r"([a-zA-Z0-9_]+)=\"([-0-9.]+)\" \"([-.0-9]+) to ([-.0-9]+) step ([-.0-9]+)\""
        )
        # 使用 findall() 函数在字符串中查找所有匹配项
        matches = pattern.findall(data)
        # 遍历匹配项列表，将值分配给相应的变量
        print('match success')

        for match in matches:
            teplist = []
            tepvalue = []
            name.append(match[0])
            initvalue.append(float(match[1]))
        j = 1
        for match in matches:
            tepvalue = initvalue.copy()
            print(tepvalue)
            ##由变化范围生成数值
            parameterN = [
                round(i, 2) for i in list(
                    np.arange(float(match[2]), float(match[3]), float(
                        match[4])))
            ]
            teplist.append(parameterN)
        parameterfulllist=[list(comb) for comb in self.cartesian_product(teplist)]

        print('list over')
        print(name)
        name.insert(0, 'number') 
        self.save_data_to_csv(self.Outputfilm, name)
        j=0
        for parameterlist in parameterfulllist:
            j=j+1
            parameterlist.insert(0, j) 
            self.save_data_to_csv(self.Outputfilm, parameterlist)

    def cartesian_product(self,arrays):
        return itertools.product(*arrays)   

    def generate_nd_array(self,n, arrays):
        if not n:
            return [[]]
        lower_dimension_array = self.generate_nd_array(n-1, arrays)
        return [subarray + [element] for element in arrays[n-1] for subarray in lower_dimension_array]

    def save_data_to_csv(self, Filename, data):

        with open(Filename + '.csv', 'a', newline='') as csvfile:
            writer = csv.writer(csvfile)
            writer.writerow(data)

    def read_data_from_csv(self, Filename):
        parameterlist = []
        with open(Filename + '.csv', newline='') as csvfile:
            reader = csv.reader(csvfile)

            # 打印每行数据
            for row in reader:
                parameterlist.append(row)
        return parameterlist

    def read_data_from_csv_line(self, Filename, linenumber):

        with open(Filename+ '.csv', newline='') as csvfile:
            reader = csv.reader(csvfile)

            # 跳过前n-1行数据
            for i in range(linenumber-1):
                next(reader)

            # 读取第n行数据
            row = next(reader)

        return row