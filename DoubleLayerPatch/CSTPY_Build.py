
import cst
import cst.interface
import cst.results
import os
import re

## 读取文件夹下.bas的文件建模，读取parameterList.txt文件的参数进行建模。
def ModuleCreat(FileMain):
    CSTpath = ''
    FileName = FileMain + '.cst'

    CSTfileFullName = os.path.join(CSTpath, FileName)
    cstme = cst.interface.DesignEnvironment()
    CSTMSW = cstme.new_mws()
    #构建环境
    CSTHand = CSTMSW.modeler
    ParameterInit(CSTHand, FileMain)
    ##读取目录下的bas文件并以此建模
    file_ext = ".bas"
    file_list = os.listdir(FileMain)
    print(file_list)
    pattern = re.compile(r".*{}$".format(re.escape(file_ext)))
    bas_file_list = [f for f in file_list if pattern.match(f)]
    print(bas_file_list)
    # bas建模
    for filem in bas_file_list:
        VBAinitFileName = FileMain + "\\" + filem
        Moduled_VBA(CSTHand, VBAinitFileName, filem)

    #运行
    CSTHand.run_solver()
    #保存关闭
    CSTMSW.save(CSTfileFullName)


def ReadFile_Bas(VBAFileName):
    #    fullname = os.path.join(Path, FileName)
    File = open(VBAFileName, 'r')
    basdata = File.readlines()
    builddata = []
    for row in basdata:
        if row[0] == '\'' or row[0] == '\n' or (row[0] == 'C' and row[1] == 'S'
                                                and row[2] == 'T'):
            continue
        builddata.append(row.replace("\n", " "))
    line_break = '\n'  # 换行符，后面用于VBA代买的拼接用
    builddata = line_break.join(builddata)
    return builddata


# 将此VBA代码写入历史树
def Moduled_VBA(MwsHand, VBACodeFile, ModuleName):
    data = ReadFile_Bas(VBACodeFile)
    MwsHand.add_to_history(ModuleName, data)


def ParameterInit(Hand, FileAddres):
    with open(FileAddres + "\\parameterList.txt", "r") as file:
        # 读取文件内容到一个字符串
        data = file.read()
    # 初始化变量以存储提取的数据
    name = []
    value = []
    # 定义正则表达式以匹配所需的数据
    pattern = re.compile(r"([a-zA-Z1-9_]+)=\"([-0-9.]+)\"")

    # 使用 findall() 函数在字符串中查找所有匹配项
    matches = pattern.findall(data)

    # 遍历匹配项列表，将值分配给相应的变量
    for match in matches:
        name.append(match[0])
        value.append(match[1])
    ParameterModify(Hand, name, value)

##修改参数
def ParameterModify(Hand, Name, Value, type=2):
    i = 0
    data = []
    if type== 1:
        data.append('Sub Main ()')

        for parameter in Name:
            data.append('StoreParameter("%s", "%s")' % (Name[i], Value[i]))
            i = i + 1
            line_break = '\n'  # 换行符，后面用于VBA代买的拼接用
        data = line_break.join(data)
        Hand.schematic.execute_vba_code(data, timeout=None)
    elif type== 2:
        for parameter in Name:
            data.append('StoreParameter("%s", "%s")' % (Name[i], Value[i]))
            i = i + 1
            line_break = '\n'  # 换行符，后面用于VBA代买的拼接用
        data = line_break.join(data)
        Hand.add_to_history("ParameterModify", data)
    
def CSTdataread(Fileaddress):

    s11_path = r'1D Results\S-Parameters\S1,1'
    project = cst.results.ProjectFile(Fileaddress, allow_interactive=True)
    s11 = project.get_3d().get_result_item(s11_path, 1)
    s11_freqs = s11.get_xdata()
    s_11 = s11.get_ydata()

def DataSave(FileName,parametername,data):  
    1

