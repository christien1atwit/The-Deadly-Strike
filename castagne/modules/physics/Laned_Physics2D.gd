extends "res://castagne/modules/physics/CMPhysics2D.gd"


func CreateFightingArena(stateHandle):
	# Ground
	# If two player: special walls and camera
	# If other count: normal walls
	var nbPlayers = stateHandle.GlobalGet("_NbPlayers")
	var arenaSize = stateHandle.ConfigData().Get("ArenaSize")
	var cameraSize = stateHandle.ConfigData().Get("ArenaMaxPlayerDistance")
	
	var envConstraints = [
		{"Type":ENVC_TYPES.AAPlane, "Dir":ENVC_AAPLANE_DIR.Up, "Position":5000, "StopMomentum":true, "Layer":0, "Mode":COLBOX_MODES.OwnLayer},
		{"Type":ENVC_TYPES.AAPlane, "Dir":ENVC_AAPLANE_DIR.Up, "Position":0, "StopMomentum":true, "Layer":1, "Mode":COLBOX_MODES.OwnLayer},
		{"Type":ENVC_TYPES.AAPlane, "Dir":ENVC_AAPLANE_DIR.Up, "Position":-5000, "StopMomentum":true, "Layer":2, "Mode":COLBOX_MODES.OwnLayer},
	]
	
	# TODO CAST 54 Corner steal
	if(nbPlayers == 2):
		stateHandle.PointToPlayer(0)
		var eid1 = stateHandle.PlayerGet("MainEntity")
		stateHandle.PointToEntity(eid1)
		var p1Pos = stateHandle.EntityGet("_PositionX")
		var p1OldPos = stateHandle.EntityGet("_PrevPositionX")
		
		stateHandle.PointToPlayer(1)
		var eid2 = stateHandle.PlayerGet("MainEntity")
		stateHandle.PointToEntity(eid2)
		var p2Pos = stateHandle.EntityGet("_PositionX")
		var p2OldPos = stateHandle.EntityGet("_PrevPositionX")
		
		var centerPos = (p1Pos+p2Pos)/2
		var p1Left = (p1Pos <= p2Pos)
		
		# TODO Investigate: This works when both players have the same colbox, but might not in other cases.
		# Just giving priority to the player below would be janky too
		
		if(p1Pos == p2Pos):
			p1Left = (p1OldPos <= p2OldPos)
		
		envConstraints.push_back({"Type":ENVC_TYPES.AAPlane, "Dir":ENVC_AAPLANE_DIR.Right,
		"Position":-arenaSize + (0 if p1Left else 1),
		"StopMomentum":true, "Layer":1, "Mode":COLBOX_MODES.OwnLayer})
		envConstraints.push_back({"Type":ENVC_TYPES.AAPlane, "Dir":ENVC_AAPLANE_DIR.Left,
		"Position":arenaSize - (1 if p1Left else 0),
		"StopMomentum":true, "Layer":1, "Mode":COLBOX_MODES.OwnLayer})
		
		envConstraints.push_back({"Type":ENVC_TYPES.AAPlane, "Dir":ENVC_AAPLANE_DIR.Right,
		"Position":-arenaSize + (1 if p1Left else 0),
		"StopMomentum":true, "Layer":2, "Mode":COLBOX_MODES.OwnLayer})
		envConstraints.push_back({"Type":ENVC_TYPES.AAPlane, "Dir":ENVC_AAPLANE_DIR.Left,
		"Position":arenaSize - (0 if p1Left else 1),
		"StopMomentum":true, "Layer":2, "Mode":COLBOX_MODES.OwnLayer})
		# Center pos
		
		envConstraints.push_back({"Type":ENVC_TYPES.AAPlane, "Dir":ENVC_AAPLANE_DIR.Right,
		"Position":centerPos-cameraSize, "StopMomentum":true, "Layer":1, "Mode":COLBOX_MODES.OwnLayer})
		envConstraints.push_back({"Type":ENVC_TYPES.AAPlane, "Dir":ENVC_AAPLANE_DIR.Left,
		"Position":centerPos+cameraSize, "StopMomentum":true, "Layer":1, "Mode":COLBOX_MODES.OwnLayer})
		envConstraints.push_back({"Type":ENVC_TYPES.AAPlane, "Dir":ENVC_AAPLANE_DIR.Right,
		"Position":centerPos-cameraSize, "StopMomentum":true, "Layer":2, "Mode":COLBOX_MODES.OwnLayer})
		envConstraints.push_back({"Type":ENVC_TYPES.AAPlane, "Dir":ENVC_AAPLANE_DIR.Left,
		"Position":centerPos+cameraSize, "StopMomentum":true, "Layer":2, "Mode":COLBOX_MODES.OwnLayer})
	
	envConstraints.push_back({"Type":ENVC_TYPES.AAPlane, "Dir":ENVC_AAPLANE_DIR.Right,
	"Position":-arenaSize, "StopMomentum":true, "Layer":0, "Mode":COLBOX_MODES.OwnLayer})
	envConstraints.push_back({"Type":ENVC_TYPES.AAPlane, "Dir":ENVC_AAPLANE_DIR.Left,
	"Position":arenaSize, "StopMomentum":true, "Layer":0, "Mode":COLBOX_MODES.OwnLayer})
	
	return envConstraints
