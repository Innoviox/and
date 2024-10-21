extends Node2D
class_name Game

var gridScene = preload("res://grid.tscn")
var playerScene = preload("res://player.tscn")

var grid
var players = []
var current_player = 0
var current_tile_type = Common.TileType.NONE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	grid = gridScene.instantiate()
	add_child(grid)
	
	for i in range(4):
		var playerNode = playerScene.instantiate()
		playerNode.player_num = i
		
		add_child(playerNode)
		players.append(playerNode)
		
	start_turn()
	
func start_turn() -> void:
	var player = players[current_player]
	if player.placed_start:
		# show "move" and "stay" buttons
		pass
	else:
		current_tile_type = Common.TileType.START
		grid.set_all_possible()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
