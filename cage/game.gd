extends Node2D
class_name Game

var gridScene = preload("res://grid.tscn")
var playerScene = preload("res://player.tscn")
var stackScene = preload("res://stack.tscn")

var grid: Grid
var stack: Stack
var players = []
var current_player = 0
var current_tile = null
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
		current_tile = Common.make_start_tile()
		grid.set_all_possible()
		
func move_clicked() -> void:
	var player = players[current_player]
	grid.set_possible_from(player.x, player.y)
	
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
	
	current_tile = null
	player_moving = false
	revealing = []
	
func board_clicked(x: int, y: int):
	# Cases for board being clicked
	# * 1 - you are currently holding a tile and want to place it
	#   |* 1a - you are currently holding your start tile:
	#   |*   1+ put the start tile with the current rotation at the clicked place
	#   |*   2+ put the player at that location
	#   |*   3+ start the revealing process
	#   |* 1b - you are currently in the revealing process:
	#   |*   1+ put the currently held tile with the current rotation at the clicked place (same as 1a1)
	#   |*   2+ continue the revealing process
	# * 2 - you are currently in the move process
	#   |*   1+ set the current position
	#   |*   2+ start the revealing process
	# * 3 - todo: you are currently in the pitting process
	
	# In 1 and 2 (todo 3), if you didn't click on a "possible" tile it's a misclick
	if !grid.is_possible(x, y):
		return
		
	# get the current player
	var player = players[current_player]
	if current_tile.type != Common.TileType.NONE: # case 1
		grid.place_tile(x, y, current_tile.type, current_tile.rot) # 1a1 OR 1b1
		if current_tile.type == Common.TileType.START: # case 1a
			player.set_position(x, y) # 1a2
			player.placed_start = true
			start_revealing()
		else:
			grid.remove_possible(x, y)
			revealing.erase(Vector2(x, y))
			continue_revealing()
	elif player_moving:
		# todo flip pit if you moved off of one
		player.set_position(x, y)
		kill_unilluminated()
		start_revealing()
	
func start_revealing():
	# set the revealing list
	# set it as the current "possible"
	# deal a tile and make it current
	revealing = grid.get_revealed()
	deal_tile()
	
func continue_revealing():
	# if the revealing list is empty, 
	# todo: show secondary options menu
	# for now: pass
	# else, deal another tile
	if revealing.size() == 0:
		pass_clicked()
	else:
		deal_tile()
		
func deal_tile():
	current_tile = stack.pop()
	
func kill_unilluminated():
	# remove unilluminated tiles that are currently illuminated
	# todo: add them to the discard
	var revealed = grid.get_revealed()
	var existing = grid.get_existing()
	
	for tile in existing:
		if not revealed.has(tile):
			grid.kill(tile[0], tile[1])
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
