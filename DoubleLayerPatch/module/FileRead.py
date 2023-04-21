import os
import shutil
import csv

def checkdocument(filename):
    if not os.path.exists(filename):
        os.makedirs(filename)
        print(f"文件夹 { filename} 创建成功！")
        return False
    return True

def checkfile(filename):
    if  os.path.exists(filename):
        return True
    else:
        print(f'没有相关结果文件{filename}\n')
        return False

def save_data_to_csv(Fileoutpuname, data):
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

#按行读取CST存储的数据
def read_CSTS11_csv(filename):
    file = filename 
    data=[]
    xaxis=[]
    if os.path.exists(file):
        with open(file, 'r', newline='') as csvfile:
           
            spamreader = csv.reader(csvfile, delimiter=',', quotechar='"')
            xaxis=list(map(float, next(spamreader) ))
            for row in spamreader:
                floatlist = list(map(float, row))
                data.append(floatlist)

    else:
        print(f'没有相关结果文件{filename}\n')
    #返回数据中第一行是y轴，比如s11数据 是
    return xaxis,data