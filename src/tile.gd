extends ImageNode
class_name Tile

func walkable(player: Player) -> bool:
	if img == " " or img == "S":
		return true
	if img == "L" and player.items.has("K"):
		return true
	return false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass