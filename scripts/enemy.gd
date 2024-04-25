extends CharacterBody3D

const FINAL_DETECTION_RANGE = 8.75
const KILL_RANGE = 2
const WALK_SPEED = 2
const SPRINT_SPEED = 9
const CRAWL_SPEED = 7

var player = null
var state_machine
var next_nav_point

@onready var nav : NavigationAgent3D = $NavigationAgent3D
@onready var anim_tree : AnimationTree = $AnimationTree
@onready var footstep_player : AudioStreamPlayer3D = $Feet/Footsteps
@onready var jumpscare_player : AudioStreamPlayer = $Jumpscare


func _ready():
	player = get_parent().get_node("Player")
	state_machine = anim_tree.get("parameters/playback")

func _physics_process(delta):
	
	match state_machine.get_current_node():
		"Idle":
			pass
			# look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
		"Walk":
			nav.target_position = player.global_transform.origin
			next_nav_point = nav.get_next_path_position()
			velocity = (next_nav_point - global_transform.origin).normalized() * WALK_SPEED
			# look_at(Vector3(global_position.x + velocity.x, global_position.y, global_position.z + velocity.z), Vector3.UP)
			look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
		"Run":
			nav.target_position = player.global_transform.origin
			next_nav_point = nav.get_next_path_position()
			velocity = (next_nav_point - global_transform.origin).normalized() * SPRINT_SPEED
			look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
		"Crawl":
			anim_tree.advance(delta * 2.25)
			nav.target_position = player.global_transform.origin
			next_nav_point = nav.get_next_path_position()
			velocity = (next_nav_point - global_transform.origin).normalized() * CRAWL_SPEED
			look_at(Vector3(global_position.x + velocity.x, global_position.y, global_position.z + velocity.z), Vector3.UP)
	
	anim_tree.set("parameters/conditions/sprinting", target_in_range(FINAL_DETECTION_RANGE))
	
	# Jumpscare SFX.
	if target_in_range(KILL_RANGE):
		if !jumpscare_player.playing:
			jumpscare_player.play()
	
	move_and_slide()
	
func target_in_range(_range):
	return global_position.distance_to(player.global_position) < _range
