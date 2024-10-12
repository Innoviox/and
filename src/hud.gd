extends Node2D
class_name Hud


func write_time(time: int):
	$CanvasLayer/Clock.text = "Time: %d" % time

func set_items(player: Player):
	for y in player.items.size():
		print("got item", player.items[y])
		var item = Util.make_item(player.items[y], 0, y)
		$CanvasLayer.add_child(item)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
