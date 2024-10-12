extends Node2D

var tile = preload("res://scenes/tile.tscn")

var map = "res://maps/map1.txt"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var file = FileAccess.open(map, FileAccess.READ)
	var content = file.get_as_text().split("\n")
	
	for y in content.size():
		for x in content[y].length():
			var tileNode = tile.instantiate()
			tileNode.tile = content[y][x]
			tileNode.X = 50 + x * 100
			tileNode.Y = 50 + y * 100
			
			add_child(tileNode)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
 
