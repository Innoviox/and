extends Node2D
class_name Player

var player_num: int
var placed_start: bool
var nerve: int = 0
var nerve_gained_this_turn: bool = false
var x = 0
var y = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func gain_nerve():
	if nerve < 2:
		nerve += 1
		nerve_gained_this_turn = true

func clean():
	nerve_gained_this_turn = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
