extends Node2D

var tile: String
var x: int
var y: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var file: String = ""
	match tile:
		"C": file = "res://img/tiles/castleCenter.png"
		" ": file = "res://img/tiles/grassCenter.png"
		"K": file = "res://img/tiles/keyBlue.png"
		"L": file = "res://img/tiles/lock_blue.png"
		"S": file = "res://img/tiles/boxAlt.png"
	
	if file == "":
		print("Error: tile not found")
		return
	
	var image = Image.load_from_file(file)
	var texture = ImageTexture.create_from_image(image)
	$Sprite2D.texture = texture
	$Sprite2D.scale = Vector2(1.42, 1.42)
	
	
	position = Util.position(x, y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
