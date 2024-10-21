extends Node2D
class_name Player

var x: float
var y: float
var goal_x: float
var goal_y: float
var items = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var image = Image.load_from_file("res://img/hud_p3.png")
	var texture = ImageTexture.create_from_image(image)
	$Sprite2D.texture = texture
	
	z_index = 2
	
	goal_x = x
	goal_y = y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = Util.position(x, y)
	
