
import sys
import os

res = os.path.dirname(os.path.dirname(__file__))
sys.path.append(res)
print(res)
print('模块环境添加成功')