extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	var h_rot = get_tree().get_nodes_in_group("CameraController")[0].global_transform.basis.get_euler().y
	
	var direction = Vector3(Input.get_action_strength("ui_left") - Input.get_action_strength("ui_right"), 0, Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down"))
	$AnimationTree.set("parameters/BlendSpace2D/blend_position", Vector2(-direction.x, direction.z))
	
	velocity = $AnimationTree.get_root_motion_position() / delta
	
	move_and_slide()
