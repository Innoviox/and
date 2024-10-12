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
	
	if img == "C":
		var rect = $Sprite2D.get_rect()
		var occluder_polygon = OccluderPolygon2D.new()
		
		var i = 70 * 1.42
		var j = 0
		var points = PackedVector2Array([
			Vector2(-i - j, -i - j),  
			Vector2(-i - j, i - j),    
			Vector2(i - j, i - j),
			Vector2(i - j, -i - j)
		])
		
		print("got polygon", points)
				
		occluder_polygon.set_polygon(points)
		occluder_polygon.closed = true
		#occluder_polygon.closed = true
		#occluder_polygon.set_cull_mode(OccluderPolygon2D.CULL_CLOCKWISE)
		
		#$LightOccluder2D.set_occluder_polygon(occluder_polygon)
		
		$Sprite2D.set_light_mask(2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
