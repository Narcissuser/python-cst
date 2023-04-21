import cst
import cst.interface
import cst.results
import numpy as np
import shutil

# CST文件路径
cst_path = r'E:\PythonCSTProject\test20230327\cst_file'  # path
cst_project = '\element'  # CST project

cst_project_path = cst_path + cst_project + '.cst'
cst_result_folder = cst_path + cst_project + '\Result'

# 删除已有结果
try:
    shutil.rmtree(cst_result_folder)
except OSError as e:
    print(e)
else:
    print("The results directory is deleted successfully")

# 打开CST文件
mycst = cst.interface.DesignEnvironment()
mycst1 = cst.interface.DesignEnvironment.open_project(mycst, cst_project_path)

# 更新参数
para_update = 'Sub Main() \nStoreParameter("patchone_width", ' + str(
    9
) + ') \nStoreParameter("patchtwo_width", ' + str(
    11
) + ') \nRebuildOnParametricChange(bfullRebuild,bShowErrorMsgBox) \nEnd Sub'

mycst1.schematic.execute_vba_code(para_update, timeout=None)

# 运行程序
mycst1.modeler.run_solver()

#关闭CST文件
cst.interface.DesignEnvironment.close(mycst)

#获取结果
s11_path = r'1D Results\S-Parameters\S1,1'
project = cst.results.ProjectFile(cst_project_path, allow_interactive=True)
s11 = project.get_3d().get_result_item(s11_path, 1)
s11_freqs = s11.get_xdata()
s_11 = s11.get_ydata()
print('Freq:', s11_freqs)
print('S11:', s_11)