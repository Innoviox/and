extends Node2D
class_name Game

var gridScene = preload("res://grid.tscn")
var playerScene = preload("res://player.tscn")
var stackScene = preload("res://stack.tscn")

var grid: Grid
var stack: Stack
var players = []
var current_player = 0
var current_tile_type = Common.TileType.NONE
var current_tile_rot = 0
var player_moving = false
var revealing = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	grid = gridScene.instantiate()
	add_child(grid)
	
	stack = stackScene.instantiate()
	add_child(stack)
	
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
		
func move_clicked() -> void:
	var player = players[current_player]
	grid.set_possible(player.x, player.y)
	
func stay_clicked() -> void:
	# give player 1 nerve
	players[current_player].gain_nerve()
	# burn 1 tile from stack
	var tile = stack.pop() # todo: add to discard
	# todo: show secondary options menu
	# for now: auto-pass
	pass_clicked()
	
func pass_clicked() -> void:
	clean()
	
	current_player = (current_player + 1) % players.size()
	
	start_turn()
	
func clean():
	# prepare the state for the beginning of the next turn
	# clear any variables that only applied to this turn
	players[current_player].clean()
	
	current_tile_type = Common.TileType.NONE
	current_tile_rot = 0
	player_moving = false
	revealing = []
	
func board_clicked(x: int, y: int):
	if !grid.is_possible(x, y):
		return
		
	var player = players[current_player]
	if current_tile_type == Common.TileType.START || player_moving:
		player.set_position(x, y)
	elif current_tile_type != Common.TileType.NONE:
		grid.place_tile(x, y, current_tile_type, current_tile_rot)		
		
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
