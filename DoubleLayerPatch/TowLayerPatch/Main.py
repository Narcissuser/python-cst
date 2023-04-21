
import module.CST_interface as CST_PY
import module.ParameterCreat as Parameterbuild
# moduleme=Parameterbuild.ParameterCreat('TowLayerPatch')
# moduleme.ParameterOptimizedListBuildfull()


pcp=CST_PY.CST_py_interface('TowLayerPatch',1,[9,9.5,10])
pcp.ModuleCreat()
pcp.openMSW(pcp.CSTpath+'\\TowLayerPatch.cst')

pcp.DataBaseBuild(208)

import module.performance_evaluation as performance

calculate=performance.performace('TowLayerPatch')
calculate.BandwidthRun()