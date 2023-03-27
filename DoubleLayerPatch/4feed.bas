
'@ define brick: feed:feedLine1

Component.New "feed"

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
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

'@ define brick: feed:layer3_feedslot

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
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
'@ boolean subtract shapes: feed:layer3_coppergnd, feed:layer3_feedslot

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Solid.Subtract "component1:layer3_coppergnd", "feed:layer3_feedslot"
