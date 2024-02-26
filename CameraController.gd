extends Node3D

@export var sensitivity : int = 5
@export var character : Node3D
@export var camera : Node3D
@export var lookAt : Node3D

# Called when the node
# enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position = character.global_position
	
	var lookPos = lookAt.global_position
	lookPos.y = character.global_position.y
	character.look_at(lookPos)
	character.rotate_object_local(Vector3(0,1,0), 3.14)
	pass

func _input(event):
	if event is InputEventMouseMotion:
		rotation = Vector3(
			clamp(rotation.x + event.relative.y / 1000 * sensitivity, -0.2, 0.75),
			rotation.y - event.relative.x / 1000 * sensitivity, 
			0
		)
	pass
