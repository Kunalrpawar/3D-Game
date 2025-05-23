extends Node


var state={
	"Idle":preload("res://Scenes/Monsters/AI Melee/IdleState.gd"),
	"Run":preload("res://Scenes/Monsters/AI Melee/RunState.gd"),
	"Attack":preload("res://Scenes/Monsters/AI Melee/AttackState.gd"),
	"Death":preload("res://Scenes/Monsters/AI Melee/DeathState.gd"),
}

func change_state(new_state:String):
	if get_child_count()!=0:
		if!("Death" in get_child(0).name):
			get_child(0).queue_free()
	if state.has(new_state):
		var state_temp=state[new_state].new()
		state_temp.name=new_state
		add_child(state_temp)
