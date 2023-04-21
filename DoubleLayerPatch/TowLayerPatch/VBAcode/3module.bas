CST History Data Exchange Format V1

'@ 3module.bas

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
