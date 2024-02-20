extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@export var blend_weight = 0.1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var blend_position : Vector2

func _physics_process(delta):
	# Add the gravity.
	var h = Input.get_action_strength("ui_left") - Input.get_action_strength("ui_right")
	var v = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
	var boost = Input.get_action_strength("boost")
	var boost_mult = 1 if boost > 0 else 0.5
	var h_rot = get_tree().get_nodes_in_group("CameraController")[0].global_transform.basis.get_euler().y
	var direction = Vector3(h * boost_mult, 0, v * boost_mult)
	blend_position = lerp(blend_position, Vector2(-direction.x, direction.z), blend_weight)
	$AnimationTree.set("parameters/Movement/blend_position", blend_position)
	if Input.is_action_pressed("ui_accept"):
		$AnimationTree.set("parameters/conditions/jump", true)
		$AnimationTree.set("parameters/Jump/blend_position", blend_position.y)
	else:
		$AnimationTree.set("parameters/conditions/jump", false)
	velocity = $AnimationTree.get_root_motion_position() / delta
	var rotatedVel  = -velocity.rotated(Vector3.UP, h_rot)
	velocity = Vector3(rotatedVel.x, -gravity, rotatedVel.z)
	move_and_slide()
