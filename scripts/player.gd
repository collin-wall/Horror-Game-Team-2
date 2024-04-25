extends CharacterBody3D


@onready var head = $Head
@onready var camera = $Head/Camera3D
@onready var footstep_player = $Feet/Footsteps

const SPEED = 2.75
const MOUSE_SENSITIVITY = 0.005

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	# Hide Mouse.
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	# Get Input/Direction.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	# Apply Speed/Deceleration.
	if direction:
		if !footstep_player.playing:
			footstep_player.play()
		
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		footstep_player.stop()
		
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		# Camera Movement.
		head.rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
		camera.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))
		
	# Quit Game.
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()
