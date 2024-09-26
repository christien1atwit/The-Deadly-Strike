extends "res://castagne/helpers/ui/widgets/CUIWidget_Bar.gd"


func WidgetInitialize(stateHandle, battleInitData = null, caspData = null):
	.WidgetInitialize(stateHandle, battleInitData, caspData)
	if(isMirrored):
		self.visible=true

func WidgetUpdate(stateHandle):
	.WidgetUpdate(stateHandle)
	
	
	
