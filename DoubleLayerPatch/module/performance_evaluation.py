import module.FileRead as FileRead
import os

class performace():
    def __init__(self, ProgectName):
        self.name = ProgectName
        self.address=os.path.join(self.name,'data')
        self.addresslist=[]
        root_path = self.address
        for dirpath, dirnames, filenames in os.walk(root_path):
            for dirname in dirnames:
                full_path = os.path.join(dirpath, dirname)
                self.addresslist.append(full_path)
        self.addresslist.append( self.address)

    # 计算相对带宽。第一列是频率，第二列是参数
    @staticmethod
    def s11Bandwidth(data):
        ##s11的带宽评价，也就是计算相对带宽。相对带宽越宽越好。-10dB。
        step = data[0][0] - data[0][1]
        BandWidth = 0
        for i in range(len(data[1])):
            if data[1][i] < -10:
                BandWidth = BandWidth + step / data[0][i]
        return BandWidth


    def BandwidthRun(self):
        s11file="s11dB.csv"
        # 计算主目录data下所有文件二级目录
        print(self.addresslist)
        for datafile in self.addresslist:
            s11addres=os.path.join(datafile,s11file)
            if not FileRead.checkfile(s11addres):
                a=1
                print(s11addres)
                continue

            freq,data=FileRead.read_CSTS11_csv(s11addres)
            bandwidthlist=[]
            # 计算带宽
            for teps11 in data:
                datame=[freq,teps11]
                bandwidth=self.s11Bandwidth(datame)
                bandwidthlist.append(bandwidth)
                numlist=[]
            for i in range(len(bandwidthlist)):
                numlist.append(i+1)
            bandwidthname=os.path.join(datafile,'s11bandwith')
            FileRead.save_data_to_csv(bandwidthname,[numlist,bandwidthlist])

        