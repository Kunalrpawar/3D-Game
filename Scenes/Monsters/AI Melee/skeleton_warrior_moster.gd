extends CharacterBody3D

@export var speed: float = 1.0
@onready var state_controller = get_node("StateMachine")
@export var player: CharacterBody3D
var direction: Vector3 = Vector3()
var Awakening: bool = false
var Attacking: bool = false
var health: int = 4
var damage: int = 2
var dying: bool = false
var just_hit: bool = false
var gravity: float = 9.8  # Initialize gravity

func _ready() -> void:
	state_controller.change_state("Idle")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	

	if player:
		direction = (player.global_transform.origin - global_transform.origin).normalized()
		
		
		move_and_slide()  # Pass the up direction vector



func _on_chase_player_detection_body_entered(body):
	if body.is_in_group("player") and !dying:
		state_controller.change_state("Run")
	

func _on_chase_player_detection_body_exited(body):
	if body.is_in_group("player") and !dying:
		state_controller.change_state("Idle")

func _on_attack_player_detection_body_entered(body):
	if body.is_in_group("player") and !dying:
		state_controller.change_state("Attack")

func _on_attack_player_detection_body_exited(body):
	if body.is_in_group("player") and !dying:
		state_controller.change_state("Run")

func _on_animation_tree_animation_finished(anim_name):
	if "Awaken" in anim_name:
		Awakening =false
	elif "Attack" in anim_name:
		if(player in get_node("attack_player_detection").get_overlapping_boddies())  and !dying:
			state_controller.change_state("Attack")
	elif "Death" in anim_name:
		death()

func death():
	self.queue_free()
