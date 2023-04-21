'# MWS Version: Version 2023.0 - Sep 12 2022 - ACIS 32.0.1 -

'# length = mm
'# frequency = GHz
'# time = ns
'# frequency range: fmin = 4 fmax = 18
'# created = '[VERSION]2023.0|32.0.1|20220912[/VERSION]


'@ ParameterModify

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
StoreParameter("size", "18")
StoreParameter("layer1_Hight", "0.002")
StoreParameter("layer2_Hight", "0.813")
StoreParameter("layer3_Hight", "0.002")
StoreParameter("layer4_Hight", "2")
StoreParameter("layer5_Hight", "0.002")
StoreParameter("layer6_Hight", "0.813")
StoreParameter("layer7_Hight", "0.002")
StoreParameter("Patch1_x", "7.8585695667088")
StoreParameter("Patch1_y", "Patch1_x")
StoreParameter("Patch2_x", "10")
StoreParameter("Patch2_y", "Patch2_x")
StoreParameter("feed1w", "1.78")
StoreParameter("feed1_extend", "2.3442578166024")
StoreParameter("feed1slot_w", "1")
StoreParameter("feed1slot_l", "6.7744882398659")
StoreParameter("feed1posx", "0.90940738757907")
StoreParameter("feed1posy", "-0.094201667379551")
StoreParameter("Dielectric4003_Hight", "0.813")
StoreParameter("Copper_Hight", "0.002")
StoreParameter("datanumber", "0")

'@ 1environment.bas

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Units 
    .SetUnit "Length", "mm" 
    .SetUnit "Frequency", "GHz" 
    .SetUnit "Voltage", "V" 
    .SetUnit "Resistance", "Ohm" 
    .SetUnit "Inductance", "nH" 
    .SetUnit "Temperature",  "degC" 
    .SetUnit "Time", "ns" 
    .SetUnit "Current", "A" 
    .SetUnit "Conductance", "S" 
    .SetUnit "Capacitance", "pF" 
End With 
ThermalSolver.AmbientTemperature "0" 
Solver.FrequencyRange "4", "18" 
Plot.DrawBox True 
With Background 
     .Type "Normal" 
     .Epsilon "1.0" 
     .Mu "1.0" 
     .XminSpace "0.0" 
     .XmaxSpace "0.0" 
     .YminSpace "0.0" 
     .YmaxSpace "0.0" 
     .ZminSpace "0.0" 
     .ZmaxSpace "0.0" 
End With 
With Boundary 
     .Xmin "expanded open" 
     .Xmax "expanded open" 
     .Ymin "expanded open" 
     .Ymax "expanded open" 
     .Zmin "expanded open" 
     .Zmax "expanded open" 
     .Xsymmetry "none" 
     .Ysymmetry "none" 
     .Zsymmetry "none" 
End With 
With Mesh 
     .MergeThinPECLayerFixpoints "True" 
     .RatioLimit "20" 
     .AutomeshRefineAtPecLines "True", "6" 
     .FPBAAvoidNonRegUnite "True" 
     .ConsiderSpaceForLowerMeshLimit "False" 
     .MinimumStepNumber "5" 
     .AnisotropicCurvatureRefinement "True" 
     .AnisotropicCurvatureRefinementFSM "True" 
End With 
With MeshSettings 
     .SetMeshType "Hex" 
     .Set "RatioLimitGeometry", "20" 
     .Set "EdgeRefinementOn", "1" 
     .Set "EdgeRefinementRatio", "6" 
End With 
With MeshSettings 
     .SetMeshType "HexTLM" 
     .Set "RatioLimitGeometry", "20" 
End With 
With MeshSettings 
     .SetMeshType "Tet" 
     .Set "VolMeshGradation", "1.5" 
     .Set "SrfMeshGradation", "1.5" 
End With 
MeshAdaption3D.SetAdaptionStrategy "Energy" 
FDSolver.ExtrudeOpenBC "True" 
PostProcess1D.ActivateOperation "vswr", "true" 
PostProcess1D.ActivateOperation "yz-matrices", "true" 
With FarfieldPlot 
	.ClearCuts ' lateral=phi, polar=theta 
	.AddCut "lateral", "0", "1" 
	.AddCut "lateral", "90", "1" 
	.AddCut "polar", "90", "1" 
End With 
With MeshSettings 
     .SetMeshType "Hex" 
     .Set "Version", 1% 
End With 
With Mesh 
     .MeshType "PBA" 
End With 
ChangeSolverType("HF Time Domain") 
ChangeSolverType "HF Time Domain" 
With Solver  
     .UseParallelization "True" 
     .MaximumNumberOfThreads "256" 
     .MaximumNumberOfCPUDevices "8" 
     .RemoteCalculation "False" 
     .UseDistributedComputing "False" 
     .MaxNumberOfDistributedComputingPorts "64" 
     .DistributeMatrixCalculation "True" 
     .MPIParallelization "False" 
     .AutomaticMPI "False" 
     .HardwareAcceleration "True" 
     .MaximumNumberOfGPUs "1" 
End With 
UseDistributedComputingForParameters "False" 
MaxNumberOfDistributedComputingParameters "2" 
UseDistributedComputingMemorySetting "False" 
MinDistributedComputingMemoryLimit "0" 
UseDistributedComputingSharedDirectory "False" 
OnlyConsider0D1DResultsForDC "False" 
With Solver 
     .SteadyStateDurationType "Number of pulses" 
     .NumberOfPulseWidths "2000" 
     .SteadyStateDurationTime "1.99862" 
     .SteadyStateDurationTimeAsDistance "599.585" 
     .StopCriteriaShowExcitation "False" 
     .RemoveAllStopCriteria 
     .AddStopCriterion "All S-Parameters", "0.004", "1", "False" 
     .AddStopCriterion "Transmission S-Parameters", "0.004", "1", "False" 
     .AddStopCriterion "Reflection S-Parameters", "0.004", "1", "False" 
     .AddStopCriterion "All Probes", "0.004", "1", "False" 
     .AddStopCriterion "All Radiated Powers", "0.004", "1", "False" 
     .AddStopCriterion "All Voltage-Current Monitors", "0.004", "1", "False" 
End With 
With Solver 
     .TimeStepStabilityFactor "1.0" 
     .RestartAfterInstabilityAbort "True" 
     .AutomaticTimeSignalSampling "True" 
     .SuppressTimeSignalStorage "False" 
     .ConsiderExcitationForFreqSamplingRate "False" 
     .UseBroadBandPhaseShift "False" 
     .SetBroadBandPhaseShiftLowerBoundFac "0.1" 
     .SetPortShieldingType "NONE" 
     .FrequencySamples "1001" 
     .FrequencyLogSamples "0" 
     .ConsiderTwoPortReciprocity "True" 
     .EnergyBalanceLimit "0.03" 
     .TDRComputation "False" 
     .TDRShift50Percent "False" 
     .AutoDetectIdenticalPorts "False" 
End With 
With Solver 
     .SetPMLType "CONVPML" 
     .UseVariablePMLLayerSizeStandard "False" 
     .KeepPMLDepthDuringMeshAdaptationWithVariablePMLLayerSize "False" 
     .SetSubcycleState "Automatic" 
     .NormalizeToReferenceSignal "False" 
     .SetEnhancedPMLStabilization "Automatic" 
     .SimplifiedPBAMethod "False" 
     .SParaAdjustment "True" 
     .PrepareFarfields "True" 
     .MonitorFarFieldsNearToModel "True" 
     .DiscreteItemUpdate "Distributed" 
End With 
With Solver 
     .SurfaceImpedanceOrder "10" 
     .ActivatePowerLoss1DMonitor "True" 
     .PowerLoss1DMonitorPerSolid "False" 
     .Use3DFieldMonitorForPowerLoss1DMonitor "True" 
     .UseFarFieldMonitorForPowerLoss1DMonitor "False" 
     .UseExtraFreqForPowerLoss1DMonitor "False" 
     .ResetPowerLoss1DMonitorExtraFreq 
     .SetDispNonLinearMaterialMonitor "False" 
     .ActivateDispNonLinearMaterialMonitor "0.0",  "0.02",  "0.0",  "False" 
     .SetTimePowerLossSIMaterialMonitor "False" 
     .ActivateTimePowerLossSIMaterialMonitor "0.0",  "0.02",  "0.0",  "False" 
     .SetTimePowerLossSIMaterialMonitorAverage "False" 
     .SetTimePowerLossSIMaterialMonitorAverageRepPeriod "0.0" 
     .TimePowerLossSIMaterialMonitorPerSolid "False" 
     .ActivateSpaceMaterial3DMonitor "False" 
     .Use3DFieldMonitorForSpaceMaterial3DMonitor "True" 
     .UseExtraFreqForSpaceMaterial3DMonitor "False" 
     .ResetSpaceMaterial3DMonitorExtraFreq 
     .SetHFTDDispUpdateScheme "Automatic" 
End With 
With Solver 
     .UseArfilter "False" 
     .ArMaxEnergyDeviation "0.1" 
     .ArPulseSkip "1" 
End With 
With Solver 
     .WaveguidePortGeneralized "True" 
     .WaveguidePortModeTracking "False" 
     .WaveguidePortROM "False" 
     .DispEpsFullDeembedding "False" 
     .SetSamplesFullDeembedding "20" 
     .AbsorbUnconsideredModeFields "Automatic" 
     .SetModeFreqFactor "0.5" 
     .AdaptivePortMeshing "True" 
     .AccuracyAdaptivePortMeshing "1" 
     .PassesAdaptivePortMeshing "4" 
End With 
With Solver 
     .AnisotropicSheetSurfaceType "0" 
     .MultiStrandedCableRoute "False" 
     .UseAbsorbingBoundary "True" 
     .UseDoublePrecision "False" 
     .AllowMaterialOverlap "True" 
     .ExcitePlanewaveNearModel "False" 
     .SetGroundPlane "False" 
     .GroundPlane "x", "0.0" 
     .NumberOfLayers "5" 
     .AverageFieldProbe "False" 
     .NormalizeToGaussian "True" 
     .TimeSignalSamplingFactor "1" 
     .SurfaceCurrentOnMesh "False" 
     .LossyMetalAsTranslucent "False" 
End With 
With Solver 
     .ResetSettings 
     .CalculateNearFieldOnCylindricalSurfaces "false", "Coarse"  
     .CylinderGridCustomStep "1"  
     .CalculateNearFieldOnCircularCuts "false"  
     .CylinderBaseCenter "0", "0", "0"  
     .CylinderRadius "3"  
     .CylinderHeight "3"  
     .CylinderSpacing "1"  
     .CylinderResolution "2.0"  
     .CylinderAllPolarization "true"  
     .CylinderRadialAngularVerticalComponents "false"  
     .CylinderMagnitudeOfTangentialConponent "false"  
     .CylinderVm "true"  
     .CylinderDBVm "false"  
     .CylinderDBUVm "false"  
     .CylinderAndFrontAxes "+y", "+z"  
     .ApplyLinearPrediction "false"  
     .Windowing "None"  
     .LogScaleFrequency "false"  
     .AutoFreqStep "true", "1" 
     .SetExcitationSignal ""  
     .SaveSettings 
End With 
Mesh.SetCreator "High Frequency"  
With Solver  
     .Method "Hexahedral" 
     .CalculationType "TD-S" 
     .StimulationPort "All" 
     .StimulationMode "All" 
     .SteadyStateLimit "-40" 
     .MeshAdaption "False" 
     .AutoNormImpedance "False" 
     .NormingImpedance "50" 
     .CalculateModesOnly "False" 
     .SParaSymmetry "False" 
     .StoreTDResultsInCache  "False" 
     .RunDiscretizerOnly "False" 
     .FullDeembedding "False" 
     .SuperimposePLWExcitation "False" 
     .UseSensitivityAnalysis "False" 
End With 
With Monitor 
          .Reset  
          .Domain "Frequency" 
          .FieldType "Farfield" 
          .ExportFarfieldSource "False"  
          .UseSubvolume "False"  
          .Coordinates "Structure"  
          .SetSubvolume "-8", "8", "-8", "8", "-1.626", "5.445"  
          .SetSubvolumeOffset "10", "10", "10", "10", "10", "10"  
          .SetSubvolumeInflateWithOffset "False"  
          .SetSubvolumeOffsetType "FractionOfWavelength"  
          .EnableNearfieldCalculation "True"  
          .CreateUsingLinearStep "9", "11", "0.1" 
End With

'@ 2init.bas

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Component.New "Patch" 
Component.New "component1" 
With Material 
     .Reset 
     .Name "Copper (pure)" 
     .Folder "" 
     .FrqType "all" 
     .Type "Lossy metal" 
     .MaterialUnit "Frequency", "GHz" 
     .MaterialUnit "Geometry", "mm" 
     .MaterialUnit "Time", "s" 
     .MaterialUnit "Temperature", "Kelvin" 
     .Mu "1.0" 
     .Sigma "5.96e+007" 
     .Rho "8930.0" 
     .ThermalType "Normal" 
     .ThermalConductivity "401.0" 
     .SpecificHeat "390", "J/K/kg" 
     .MetabolicRate "0" 
     .BloodFlow "0" 
     .VoxelConvection "0" 
     .MechanicsType "Isotropic" 
     .YoungsModulus "120" 
     .PoissonsRatio "0.33" 
     .ThermalExpansionRate "17" 
     .ReferenceCoordSystem "Global" 
     .CoordSystemType "Cartesian" 
     .NLAnisotropy "False" 
     .NLAStackingFactor "1" 
     .NLADirectionX "1" 
     .NLADirectionY "0" 
     .NLADirectionZ "0" 
     .FrqType "static" 
     .Type "Normal" 
     .SetMaterialUnit "Hz", "mm" 
     .Epsilon "1" 
     .Mu "1.0" 
     .Kappa "5.96e+007" 
     .TanD "0.0" 
     .TanDFreq "0.0" 
     .TanDGiven "False" 
     .TanDModel "ConstTanD" 
     .KappaM "0" 
     .TanDM "0.0" 
     .TanDMFreq "0.0" 
     .TanDMGiven "False" 
     .TanDMModel "ConstTanD" 
     .DispModelEps "None" 
     .DispModelMu "None" 
     .DispersiveFittingSchemeEps "Nth Order" 
     .DispersiveFittingSchemeMu "Nth Order" 
     .UseGeneralDispersionEps "False" 
     .UseGeneralDispersionMu "False" 
     .Colour "1", "1", "0" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "True" 
     .Transparentoutline "False" 
     .Transparency "0" 
     .Create 
End With 
With Material 
     .Reset 
     .Name "Rogers RO4003C (lossy)" 
     .Folder "" 
     .FrqType "all" 
     .Type "Normal" 
     .SetMaterialUnit "GHz", "mm" 
     .Epsilon "3.55" 
     .Mu "1.0" 
     .Kappa "0.0" 
     .TanD "0.0027" 
     .TanDFreq "10.0" 
     .TanDGiven "True" 
     .TanDModel "ConstTanD" 
     .KappaM "0.0" 
     .TanDM "0.0" 
     .TanDMFreq "0.0" 
     .TanDMGiven "False" 
     .TanDMModel "ConstKappa" 
     .DispModelEps "None" 
     .DispModelMu "None" 
     .DispersiveFittingSchemeEps "General 1st" 
     .DispersiveFittingSchemeMu "General 1st" 
     .UseGeneralDispersionEps "False" 
     .UseGeneralDispersionMu "False" 
     .Rho "0.0" 
     .ThermalType "Normal" 
     .ThermalConductivity "0.64" 
     .SetActiveMaterial "all" 
     .Colour "0.94", "0.82", "0.76" 
     .Wireframe "False" 
     .Transparency "0" 
     .Create 
End With

'@ 3module.bas

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Brick 
     .Reset  
     .Name "layer2_dielect"  
     .Component "component1"  
     .Material "Rogers RO4003C (lossy)"  
     .Xrange "size/2", "-size/2"  
     .Yrange "size/2", "-size/2"  
     .Zrange "layer1_Hight", "layer1_Hight+layer2_Hight"  
     .Create 
End With 
With Brick 
     .Reset  
     .Name "layer3_coppergnd"  
     .Component "component1"  
     .Material "Copper (pure)"  
     .Xrange "size/2", "-size/2"  
     .Yrange "size/2", "-size/2"  
     .Zrange "layer1_Hight+layer2_Hight", "layer1_Hight+layer2_Hight+layer3_Hight"  
     .Create 
End With 
With Brick 
     .Reset  
     .Name "layer4_AirGate1"  
     .Component "component1"  
     .Material "Vacuum"  
     .Xrange "size/2", "-size/2"  
     .Yrange "size/2", "-size/2"  
     .Zrange "layer1_Hight+layer2_Hight+layer3_Hight", "layer1_Hight+layer2_Hight+layer3_Hight+layer4_Hight"  
     .Create 
End With 
With Brick 
     .Reset  
     .Name "layer5_Patch1"  
     .Component "patch"  
     .Material "Copper (pure)"  
     .Xrange "Patch1_x/2", "-Patch1_x/2"  
     .Yrange "Patch1_y/2", "-Patch1_y/2"  
     .Zrange "layer1_Hight+layer2_Hight+layer3_Hight+layer4_Hight", "layer1_Hight+layer2_Hight+layer3_Hight+layer4_Hight+layer5_Hight"  
     .Create 
End With 
With Brick 
     .Reset  
     .Name "layer6_dielect"  
     .Component "component1"  
     .Material "Rogers RO4003C (lossy)"  
     .Xrange "size/2", "-size/2"  
     .Yrange "size/2", "-size/2"  
     .Zrange "layer1_Hight+layer2_Hight+layer3_Hight+layer4_Hight+layer5_Hight", "layer1_Hight+layer2_Hight+layer3_Hight+layer4_Hight+layer5_Hight+layer6_Hight"  
     .Create 
End With 
With Brick 
     .Reset  
     .Name "layer7_Patch2"  
     .Component "patch"  
     .Material "Copper (pure)"  
     .Xrange "Patch2_x/2", "-Patch2_x/2"  
     .Yrange "Patch2_y/2", "-Patch2_y/2"  
     .Zrange "layer1_Hight+layer2_Hight+layer3_Hight+layer4_Hight+layer5_Hight+layer6_Hight", "layer1_Hight+layer2_Hight+layer3_Hight+layer4_Hight+layer5_Hight+layer6_Hight+layer7_Hight"  
     .Create 
End With

'@ 4feed.bas

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Component.New "feed" 
With Brick 
     .Reset  
     .Name "feedLine1"  
     .Component "feed"  
     .Material "Copper (pure)"  
     .Xrange "size/2", "-feed1_extend+feed1posx"  
     .Yrange "feed1w/2+feed1posy", "-feed1w/2+feed1posy"  
     .Zrange "layer1_Hight", "0"  
     .Create 
End With 
With Brick 
     .Reset  
     .Name "layer3_feedslot"  
     .Component "feed"  
     .Material "Copper (pure)"  
     .Xrange "feed1slot_w/2+feed1posx", "-feed1slot_w/2+feed1posx"  
     .Yrange "feed1slot_l/2+feed1posy", "-feed1slot_l/2+feed1posy"  
     .Zrange "layer1_Hight+layer2_Hight", "layer1_Hight+layer2_Hight+layer3_Hight"  
     .Create 
End With 
Solid.Subtract "component1:layer3_coppergnd", "feed:layer3_feedslot"

'@ 5por.bas

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.PickEdgeFromId "feed:feedLine1", "5", "5" 
With Port  
     .Reset  
     .PortNumber "1"  
     .Label "" 
     .Folder "" 
     .NumberOfModes "1" 
     .AdjustPolarization "False" 
     .PolarizationAngle "0.0" 
     .ReferencePlaneDistance "0" 
     .TextSize "50" 
     .TextMaxLimit "0" 
     .Coordinates "Picks" 
     .Orientation "xmax" 
     .PortOnBound "False" 
     .ClipPickedPortToBound "False" 
     .Xrange "8", "8" 
     .Yrange "-0.89", "0.89" 
     .Zrange "0", "0" 
     .XrangeAdd "0.0", "0.0" 
     .YrangeAdd "feed1w*1.5", "feed1w*1.5" 
     .ZrangeAdd "layer2_Hight*2", "layer2_Hight+layer1_Hight+layer3_Hight" 
     .SingleEnded "False" 
     .WaveguideMonitor "False" 
     .Create  
End With

