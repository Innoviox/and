extends Node2D

var tile = preload("res://scenes/tile.tscn")
var playerScene = preload("res://scenes/player.tscn")
var item = preload("res://scenes/item.tscn")

var map = "res://maps/map1.txt"

var player: Player
var tiles = []
var items = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var file = FileAccess.open(map, FileAccess.READ)
	var content = file.get_as_text().split("\n")
	
	for y in content.size():
		var row = []
		for x in content[y].length():
			var block = content[y][x]
			
			if block == "K":
				var tileNode = make_tile(" ", x, y)
				row.append(tileNode)
				
				var itemNode = make_item(block, x, y)
				items.append(itemNode)
				
			elif block == "L":
				var tileNode = make_tile("C", x, y)
				row.append(tileNode)
				
				var itemNode = make_item(block, x, y)
				items.append(itemNode)
			else:
				var tileNode = make_tile(block, x, y)
				row.append(tileNode)
			
			if block == "S":
				player = playerScene.instantiate()
				player.x = x
				player.y = y 
				
				add_child(player)
		tiles.append(row)

func make_tile(block: String, x: int, y: int) -> Tile:
	var tileNode = tile.instantiate()
	tileNode.img = block
	tileNode.x = x
	tileNode.y = y
	
	add_child(tileNode)
	return tileNode
	
func make_item(block: String, x: int, y: int) -> Item:
	var itemNode = item.instantiate()
	itemNode.img = block
	itemNode.x = x 
	itemNode.y = y 
	
	add_child(itemNode)
	return itemNode

func item_at(x: int, y: int) -> Item:
	for item in items:
		if item.x == x and item.y == y:
			return item
	return null

func item_check():
	item = item_at(player.x, player.y)
	if item != null:
		if item.collectible():
			player.items.append(item.img)
			remove_child(item)

func move_player(dir: Vector2) -> bool:
	var newX = player.x + dir.x
	var newY = player.y + dir.y
	
	if newY < tiles.size() and newX < tiles[newY].size():
		item = item_at(newX, newY)
		if tiles[newY][newX].walkable(player) or (item != null and item.walkable(player)):
			player.x += dir.x
			player.y += dir.y
			
			item_check()
			return true
		return false
	return false

func _input(event):
	if event.is_action_pressed("right"):
		move_player(Vector2(1, 0))
	elif event.is_action_pressed("left"):
		move_player(Vector2(-1, 0))
	elif event.is_action_pressed("up"):
		move_player(Vector2(0, -1))
	elif event.is_action_pressed("down"):
		move_player(Vector2(0, 1))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
 
