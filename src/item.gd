extends ImageNode
class_name Item 

func collectible():
	return img == "K"
	
func walkable(player: Player):
	if img == "L":
		if player.items.has("K"):
			return true
		return false
	return true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
