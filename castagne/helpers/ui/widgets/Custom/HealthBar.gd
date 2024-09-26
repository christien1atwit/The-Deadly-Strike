extends "res://castagne/helpers/ui/widgets/CUIWidget_Bar.gd"


onready var flipProg = preload("res://castagne/assets/ui/widgets/HealthBarF.png")
onready var flipUnder = preload("res://castagne/assets/ui/widgets/HealthBarUnderF.png")
onready var flipOver= preload("res://castagne/assets/ui/widgets/HealthBarBoarderF.png")
onready var playerRoot= get_parent().get_parent()

func WidgetInitialize(stateHandle, battleInitData = null, caspData = null):
	.WidgetInitialize(stateHandle, battleInitData, caspData)
	if(isMirrored):
		self.texture_under=flipUnder
		self.texture_over=flipOver
		self.texture_progress=flipProg
		self.texture_progress_offset=Vector2(2,2)

func WidgetUpdate(stateHandle):
	.WidgetUpdate(stateHandle)
	var viewportHeight=playerRoot.rect_size.y
	var scalingFactor=float(viewportHeight/240)
	self.rect_scale=Vector2(scalingFactor,scalingFactor)
	
	
