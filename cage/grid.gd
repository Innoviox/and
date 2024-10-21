extends Node2D
class_name Grid

var tiles = []
var possible = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Make empty grid
	for i in range(5):
		var row = []
		for j in range(5):
			row.append(null)
		tiles.append(row)
		
func set_possible():
	pass
	
func set_all_possible():
	for i in range(5):
		for j in range(5):
			possible.append(Vector2(i, j))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
