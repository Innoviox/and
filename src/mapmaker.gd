extends Node2D

var tile = preload("res://scenes/tile.tscn")
var player = preload("res://scenes/player.tscn")

var map = "res://maps/map1.txt"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var file = FileAccess.open(map, FileAccess.READ)
	var content = file.get_as_text().split("\n")
	
	for y in content.size():
		for x in content[y].length():
			var block = content[y][x]
			
			var tileNode = tile.instantiate()
			tileNode.tile = block
			tileNode.x = x
			tileNode.y = y
			
			add_child(tileNode)
			
			if block == "S":
				var playerNode = player.instantiate()
				
				


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
 
