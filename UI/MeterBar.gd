extends "res://castagne/helpers/ui/widgets/CUIWidget_Bar.gd"


onready var flipProg = preload("res://Assets/MeterProgressF.png")
onready var flipUnder = preload("res://Assets/MeterUnderF.png")
onready var flipFlash = preload("res://Assets/MeterFlashF.png")
onready var playerRoot= get_parent().get_parent()
onready var flashDown= true
onready var timer = 1

func WidgetInitialize(stateHandle, battleInitData = null, caspData = null):
	.WidgetInitialize(stateHandle, battleInitData, caspData)
	if(isMirrored):
		self.texture_under=flipUnder
		self.texture_progress=flipProg
		self.texture_over=flipFlash

func WidgetUpdate(stateHandle):
	.WidgetUpdate(stateHandle)
	var viewportHeight=playerRoot.rect_size.y
	var scalingFactor=float(viewportHeight/240)#240 is the height of the screen that this was drawn for
	self.rect_scale=Vector2(scalingFactor,scalingFactor)
	if(self.value==self.max_value):
		Flash()
	else:
		self.tint_over.a=0
	
	
func Flash():
	self.tint_over.a=1
	if(flashDown):
		self.tint_over.r-=0.05
		self.tint_over.g-=0.01
		self.tint_over.b-=0.005
	else:
		self.tint_over.r+=0.05
		self.tint_over.g+=0.01
		self.tint_over.b+=0.005
	if(self.tint_over.r<=0):
		flashDown=false
	elif(self.tint_over.r>=0.99):
		flashDown=true
	
