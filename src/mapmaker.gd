extends Node2D

var playerScene = preload("res://scenes/player.tscn")
var hudScene = preload("res://scenes/hud.tscn")

var map = "res://maps/map1.txt"

var player: Player
var hud: Hud
var tiles = []
var items = []

var time = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var file = FileAccess.open(map, FileAccess.READ)
	var content = file.get_as_text().split("\n")
	
	for y in content.size():
		var row = []
		for x in content[y].length():
			var block = content[y][x]
			
			if block == "K":
				var tileNode = Util.make_tile(" ", x, y)
				add_child(tileNode)
				row.append(tileNode)
				
				var itemNode = Util.make_item(block, x, y)
				add_child(itemNode)
				items.append(itemNode)
				
			elif block == "L":
				var tileNode = Util.make_tile("C", x, y)
				add_child(tileNode)
				row.append(tileNode)
				
				var itemNode = Util.make_item(block, x, y)
				add_child(itemNode)
				items.append(itemNode)
			else:
				var tileNode = Util.make_tile(block, x, y)
				add_child(tileNode)
				row.append(tileNode)
			
			if block == "S":
				player = playerScene.instantiate()
				player.x = x
				player.y = y 
				
				add_child(player)
		tiles.append(row)
		
	hud = hudScene.instantiate()
	add_child(hud)



func item_at(x: int, y: int) -> Item:
	for item in items:
		if item.x == x and item.y == y:
			return item
	return null

func item_check():
	var item = item_at(player.x, player.y)
	if item != null:
		if item.collectible():
			player.items.append(item.img)
			hud.set_items(player)
			remove_child(item)

func move_player(dir: Vector2) -> bool:
	var newX = player.x + dir.x
	var newY = player.y + dir.y
	
	if newY < tiles.size() and newX < tiles[newY].size():
		var item = item_at(newX, newY)
		if tiles[newY][newX].walkable(player) or (item != null and item.walkable(player)):
			player.x += dir.x
			player.y += dir.y
			
			item_check()
			return true
		return false
	return false
	
func action(event) -> bool:
	if event.is_action_pressed("right"):
		return move_player(Vector2(1, 0))
	elif event.is_action_pressed("left"):
		return move_player(Vector2(-1, 0))
	elif event.is_action_pressed("up"):
		return move_player(Vector2(0, -1))
	elif event.is_action_pressed("down"):
		return move_player(Vector2(0, 1))
	return false 
	
func _input(event):
	if action(event):
		time += 1
		hud.write_time(time)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
 
