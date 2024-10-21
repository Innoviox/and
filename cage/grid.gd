extends Node2D

var tileScene = preload("res://tile.tscn")

var tiles = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Make empty grid
	for i in range(5):
		var row = []
		for j in range(5):
			var tileNode = tileScene.instantiate()
			tileNode.x = j
			tileNode.y = i
			
			add_child(tileNode)
			row.append(tileNode)
		tiles.append(row)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
