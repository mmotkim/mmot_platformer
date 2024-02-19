extends Node2D
# This is a hacky way of doing animation
# I do not advise you using this in real projects
# Instead learn how to use a STATE MACHINE
# https://www.youtube.com/results?search_query=godot+state+machine
# Choose a video of your liking

@export var player_path : NodePath
@onready var Player := get_node(player_path)
@onready var Animator := $AnimatedSprite2D

var previous_frame_velocity := Vector2(0,0)


# Avoid errors
func _ready() -> void:
	if Player == null:
		print("Sprite.gd is missing player_path")
		set_process(false)


func _process(_delta: float) -> void:
	#if previous_frame_velocity.y >= 0 and Player.velocity.y < 0: just jump
	if Player.velocity.y < 0:
		Animator.play("jump")
		print("jump")
	elif previous_frame_velocity.y < Player.velocity.y:
		Animator.play("fall")
	#elif previous_frame_velocity.y > 0 and Player.is_on_floor(): land
	elif Player.is_on_floor() and Player.velocity.x == 0:
		Animator.play("idle")
	elif Player.velocity.x != 0:
		Animator.play("run")
	#else:
		#Animator.play("idle")
	
	# It's important that this is the last thing done
	previous_frame_velocity = Player.velocity