extends "res://castagne/helpers/ui/widgets/CUIWidget_Bar.gd"


onready var flipProg = preload("res://Assets/UI/HealthBarF.png")
onready var flipUnder = preload("res://Assets/UI/HealthBarUnderF.png")
onready var flipOver= preload("res://Assets/UI/HealthBarBoarderF.png")
onready var playerRoot= get_parent().get_parent()
onready var portrait = $Portrait
onready var flashDown = true

func WidgetInitialize(stateHandle, battleInitData = null, caspData = null):
	_FetchVariableNamesFromCASPData(caspData)
	
	var fillMode = null
	if(VariableName_Sub.empty()):
		if(rootMain == null):
			rootMain = get_node(".")
	else:
		if(rootMain == null):
			rootMain = get_child(0)
		if(rootSub == null):
			rootSub = get_node(".")
			fillMode = rootSub.get_fill_mode()
	if(fillMode == null):
		fillMode = rootMain.get_fill_mode()
	
	if(caspData != null):
		if(caspData.has("Direction")):
			var d = caspData["Direction"]
			if(d >= 0 and d < directions.size()):
				fillMode = directions[d]
				rootMain.set_fill_mode(fillMode)
				if(rootSub != null):
					rootSub.set_fill_mode(fillMode)
	
	if(_HasAsset(caspData, "Asset1")):#Asset 1 is the portrait, (32x32)
		var t = _LoadAsset(caspData, "Asset1")
		if(t != null):
			portrait.texture=t
	
	
	if(isMirrored):
		if(fillMode == TextureProgress.FILL_LEFT_TO_RIGHT):
			fillMode = TextureProgress.FILL_RIGHT_TO_LEFT
		elif(fillMode == TextureProgress.FILL_RIGHT_TO_LEFT):
			fillMode = TextureProgress.FILL_LEFT_TO_RIGHT
		elif(fillMode == TextureProgress.FILL_CLOCKWISE):
			fillMode = TextureProgress.FILL_COUNTER_CLOCKWISE
		elif(fillMode == TextureProgress.FILL_COUNTER_CLOCKWISE):
			fillMode = TextureProgress.FILL_CLOCKWISE
		rootMain.set_fill_mode(fillMode)
		if(rootSub != null):
			rootSub.set_fill_mode(fillMode)
	
	if(isMirrored):
		self.texture_under=flipUnder
		self.texture_over=flipOver
		self.texture_progress=flipProg
		self.texture_progress_offset=Vector2(2,2)
		portrait.position.x=144

func WidgetUpdate(stateHandle):
	.WidgetUpdate(stateHandle)
	var viewportHeight=playerRoot.rect_size.y
	var scalingFactor=float(viewportHeight/240)#240 is the height of the screen that this was drawn for
	self.rect_scale=Vector2(scalingFactor,scalingFactor)
	var hp_percent=float(self.value/self.max_value)
	if(hp_percent<0.301):
		Flash()
	else:
		self.tint_progress=Color(1,1,1,1)
		
	

func Flash():
	if(flashDown):
		self.tint_progress.r-=0.10
	else:
		self.tint_progress.r+=0.10
	self.tint_progress.g=0.0
	self.tint_progress.b=0.0
	if(self.tint_progress.r<=0):
		flashDown=false
	elif(self.tint_progress.r>=0.99):
		flashDown=true
	

