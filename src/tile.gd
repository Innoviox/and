extends ImageNode
class_name Tile

func slm(n: int):
	set_light_mask(n)
	$Sprite2D.set_light_mask(n)
	$LightOccluder2D.set_light_mask(n)
	
func add_occluders(player: Player, tiles):
	var j = 38
	var rect = ($Sprite2D.get_transform()) * ($Sprite2D.get_rect())
	var tl = Vector2(rect.position.x - j, rect.position.y - j)
	var tr = Vector2(rect.end.x - j, rect.position.y - j)
	var br = Vector2(rect.end.x - j, rect.end.y - j)
	var bl = Vector2(rect.position.x - j, rect.end.y - j)
	
	var points = [bl, tl, tr, br]
	#
	#var tile_left = x - 1 >= 0 and !tiles[y][x - 1].seethrough(player)
	#var tile_right = x + 1 < tiles[y].size() and !tiles[y][x + 1].seethrough(player)
	#var tile_above = y - 1 >= 0 and !tiles[y - 1][x].seethrough(player)
	#var tile_below = y + 1 < tiles.size() and !tiles[y + 1][x].seethrough(player)
	#
	#var left = x < player.x
	#var below = y > player.y
	#if left:
		#if below:
			#if tile_left and tile_below:
				#points = []
			#elif tile_left:
				#points = [br, bl]
			#elif tile_below:
				#points = [bl, tl]
			#else:
				#points = [br, bl, tl]
		#elif y == player.y:
			#if tile_left:
				#points = []
			#else:
				#points = [bl, tl]
		#else:
			#if tile_left and tile_above:
				#points = []
			#elif tile_left:
				#points = [tl, tr]
			#elif tile_above:
				#points = [bl, tl]
			#else:
				#points = [bl, tl, tr]
	#elif x == player.x:
		#if below:
			#points = [br, bl]
		#elif y == player.y:
			#pass # impossible...?
		#else:
			#points = [tl, tr]
	#else:
		#if below:
			#points = [tr, br, bl]
		#elif y == player.y:
			#points = [tr, br]
		#else:
			#points = [tl, tr, br]
			
	var occluder_polygon = OccluderPolygon2D.new()
	occluder_polygon.set_polygon(PackedVector2Array(points))
	occluder_polygon.closed = false
	$LightOccluder2D.set_occluder_polygon(occluder_polygon)
	#$LightOccluder2D.occlu/

func walkable(player: Player) -> bool:
	if img == " " or img == "S":
		return true
	if img == "L" and player.items.has("K"):
		return true
	return false
	
func seethrough(player: Player) -> bool:
	if img == " " or img == "S":
		return true
	return false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	
	#if img == "C":
		#var rect = $Sprite2D.get_rect()
		#var occluder_polygon = OccluderPolygon2D.new()
		#
		#var i = 70 * 1.42
		#var j = 0
		#var points = PackedVector2Array([
			#Vector2(-i - j, -i - j),  
			#Vector2(-i - j, i - j),    
			#Vector2(i - j, i - j),
			#Vector2(i - j, -i - j)
		#])
		#
		#print("got polygon", points)
				#
		#occluder_polygon.set_polygon(points)
		#occluder_polygon.closed = true
		##occluder_polygon.closed = true
		##occluder_polygon.set_cull_mode(OccluderPolygon2D.CULL_CLOCKWISE)
		#
		##$LightOccluder2D.set_occluder_polygon(occluder_polygon)
		#
		#$Sprite2D.set_light_mask(2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
