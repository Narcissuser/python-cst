import cst
import cst.interface
import cst.results
import os
import re
import csv
import numpy as np
import shutil
import module.FileRead as fileRead
import logging


class CST_py_interface():
    def __init__(self, ProgectName, Portnumber,
                 freqlist):  # 初始化一个属性r（不要忘记self参数，他是类下面所有方法必须的参数）
        self.ProgectName = ProgectName

        fileRead.checkfile('E:\\builds\\CST\\pycst')
        #self.CSTpath ='E:\\builds\\CST\\pycst'
        #CST文件的路径需要完整路径，当前路径会报错。
        path = os.getcwd()
        self.CSTpath = os.path.join( path,self.ProgectName,
                                        'cst')
        self.CSTFile = os.path.join(self.CSTpath,
                                        self.ProgectName + '.cst')
        
        self.CSTMSW = 0
        self.CSTmodeler = 0
        self.ModuleVBAPath = os.path.join(self.ProgectName, 'VBAcode')
        fileRead.checkfile(self.ModuleVBAPath)
        self.port = Portnumber
        self.dataFileinit = os.path.join(self.ProgectName, 'data')
        fileRead.checkfile(self.dataFileinit)
        self.dataFile = self.dataFileinit
        self.freqlist = freqlist
        self.Dataparameterfilm = 'parameterModifylist.csv'
        self.Dataparameterfilmlist = os.path.join(self.ProgectName,
                                                  self.Dataparameterfilm)
        print(self.ModuleVBAPath)

    def openMSW(self):
        self.CSTMSW = self.CSTINTERFACE.open_project(self.CSTFile)
        self.CSTmodeler = self.CSTMSW.modeler

    def ModuleCreat(self):
        if os.path.exists(os.path.join(self.CSTpath, self.ProgectName)):
            os.remove(self.CSTFile)
            shutil.rmtree(os.path.join(self.CSTpath, self.ProgectName))

        shutil.copyfile(self.CSTpath + '\\StandardRadiation.cst',
                        self.CSTFile)
        
        self.CSTINTERFACE = cst.interface.DesignEnvironment()
        self.openMSW()
        ## 读取文件夹下.bas的文件建模，读取parameterList.txt文件的参数进行建模。
        self.ParameterInit()
        ##读取目录下的bas文件并以此建模
        file_ext = ".bas"
        file_list = os.listdir(self.ModuleVBAPath)
        print(file_list)
        pattern = re.compile(r".*{}$".format(re.escape(file_ext)))
        bas_file_list = [f for f in file_list if pattern.match(f)]
        print(bas_file_list)
        # bas建模
        for filem in bas_file_list:
            VBAinitFileName = self.ModuleVBAPath + "\\" + filem
            self.CST_VBAfileToHistory(VBACodeFile=VBAinitFileName,
                                      Historyname=filem)
        #运行
        # self.CSTrun()
        #保存关闭
        # self.CSTclose()

    def ReadFile_Bas(self, VBAFileName):
        #    fullname = os.path.join(Path, FileName)
        File = open(VBAFileName, 'r')
        basdata = File.readlines()
        builddata = []
        for row in basdata:
            if row[0] == '\'' or row[0] == '\n' or (row[0] == 'C'
                                                    and row[1] == 'S'
                                                    and row[2] == 'T'):
                continue
            builddata.append(row.replace("\n", " "))
        line_break = '\n'  # 换行符，后面用于VBA代买的拼接用
        builddata = line_break.join(builddata)
        return builddata

    # 将此VBA代码写入历史树
    def CST_VBAfileToHistory(self, VBACodeFile, Historyname):
        data = self.ReadFile_Bas(VBACodeFile)
        self.CSTmodeler.add_to_history(Historyname, data)

    def CST_VBAcodeToHistory(self, data, Historyname):

        self.CSTmodeler.add_to_history(Historyname, data)

    ##参数初始化
    def ParameterInit(self):
        parmteterfilm = os.path.join(self.ProgectName, 'parameterList.txt')
        with open(parmteterfilm, "r") as file:
            # 读取文件内容到一个字符串
            data = file.read()
        # 初始化变量以存储提取的数据
        name = []
        value = []
        # 定义正则表达式以匹配所需的数据
        pattern = re.compile(r"([a-zA-Z0-9_.]+)=\"([a-zA-Z0-9_.-]+)\"")
        # 使用 findall() 函数在字符串中查找所有匹配项
        matches = pattern.findall(data)
        # 遍历匹配项列表，将值分配给相应的变量
        for match in matches:
            name.append(match[0])
            value.append(match[1])
        self.ParameterModify(name, value)

    ##修改参数
    def ParameterModify(self, Name, Value, type=2):
        i = 0
        data = []
        if type == 1:
            data.append('Sub Main ')
            for parameter in Name:
                data.append('StoreParameter("%s", "%s")' % (Name[i], Value[i]))
                i = i + 1
            data.append('End Sub')
            line_break = '\n'  # 换行符，后面用于VBA代买的拼接用
            data = line_break.join(data)
            self.CSTMSW.schematic.execute_vba_code(data, timeout=None)
        elif type == 2:
            for parameter in Name:
                data.append('StoreParameter("%s", "%s")' % (Name[i], Value[i]))
                i = i + 1
                line_break = '\n'  # 换行符，后面用于VBA代买的拼接用
            data = line_break.join(data)
            self.CSTmodeler.add_to_history("ParameterModify", data)

    ##构建数据集
    def DataBaseBuild(self, numberoflist):
        with open(self.Dataparameterfilmlist, 'r') as file:
            parameterlist = csv.reader(file)
            # skip the header row
            name = next(parameterlist)
            logging.basicConfig(filename=self.ProgectName + '\\example.log',
                                level=logging.ERROR)
            for i in range(numberoflist):
                next(parameterlist)
            i=0
            for row in parameterlist:
                try:
                    if i % 100 == 0:
                        self.CSTclose()
                        self.ModuleCreat()
                        self.dataFile = self.dataFileinit + int(i / 100)
                        if not os.path.exists(self.dataFile):
                            os.makedirs(self.dataFile)
                            logging.exception(f"文件夹 {self.dataFile} 创建成功.")
                    self.ParameterModify(name, row, 1)
                    self.CSTrun()
                    self.CSTfulldataoutput()
                    i=i+1
                
                    with open(self.dataFile+'\\parameter' + '.csv', 'a', newline='') as csvfile:
                        writer = csv.writer(csvfile)
                        writer.writerow(row)
                except Exception as e:
                    logging.exception(str(e))
                    logging.exception(f"error number={row[0]}")
            print(f"完成了{i}个模型的建模")
            self.CSTclose()

    def CST_dataread(self, Result_type):
        if Result_type == 's11':
            data_path = r'1D Results\S-Parameters\S1,1'
        else:
            data_path = 'Tables\\1D Results\\' + Result_type

        project = cst.results.ProjectFile(self.CSTFile,
                                          allow_interactive=True)
        cst_data = project.get_3d().get_tree_items()
        print(cst_data)
        cst_data = project.get_3d().get_result_item(data_path)
        x_axis = cst_data.get_xdata()
        value = cst_data.get_ydata()
        return x_axis, value

    def CST_Farfield(self):
        type = self.farfiletype.GainAbs
        Angle, Value = self.CST_dataread(type)
        fildname = os.path.join(self.dataFile, type)
        self.CSTsave_data_to_csv(fildname, [Angle, Value])
        type = self.farfiletype.AxisRate
        Angle, Value = self.CST_dataread(type)
        fildname = os.path.join(self.dataFile, type)
        self.CSTsave_data_to_csv(fildname, [Angle, Value])

    def CSTS11data(self):
        phase = []
        amplitude_dB = []
        s11_freqs, s11_values = self.CST_dataread(Result_type='s11')

        for complex_val in zip(s11_values):
            amplitude = np.abs(complex_val)
            phase.append(np.angle(complex_val) / (3.14159) * 180)
            amplitude_dB.append(20 * np.log10(amplitude))
        s11_freqs_re = np.reshape(s11_freqs, (len(s11_freqs), 1))
        data = np.hstack([s11_freqs_re, amplitude_dB, phase])

        listtep = [data[:, 0], data[:, 1]]

        self.CSTsave_data_to_csv(self.dataFile + '\\s11dB', listtep)
        listtep = [data[:, 0], data[:, 2]]
        self.CSTsave_data_to_csv(self.dataFile + '\\s11phase', listtep)

    @staticmethod
    def CSTsave_data_to_csv(Fileoutpuname, data):
        file = Fileoutpuname + '.csv'
        if os.path.exists(file):
            with open(file, 'a', newline='') as csvfile:
                writer = csv.writer(csvfile)
                writer.writerow(data[1])
        else:
            with open(file, 'w', newline='') as csvfile:
                writer = csv.writer(csvfile)
                writer.writerow(data[0])
                writer.writerow(data[1])

    def CSTfulldataoutput(self):
        self.CSTS11data()
        self.CST_Farfield()

    def CSTrun(self):
        self.CSTmodeler.run_solver()

    def CSTclose(self):
        self.CSTMSW.save(self.CSTFile)

    def ParametertoResult(self, parameterlist):
        self.ParameterModify(parameterlist[0], parameterlist[1], type=1)
        self.CSTrun()
        data_s11 = self.CSTS11data()

    class farfiletype():
        LCP = 'Gain_LCP'
        RCP = 'Gain_RCP'
        AxisRate = 'AxisRate'
        GainAbs = 'Gain'
