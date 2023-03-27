CST History Data Exchange Format V1

'@ pick edge

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.PickEdgeFromId "feed:feedLine1", "5", "5"

'@ define port: 1

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
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
