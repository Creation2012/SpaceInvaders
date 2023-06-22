extends ParallaxBackground

func _process(delta):
	# maybe jakies kurde ten zmiana kierunku paralaxy
	scroll_base_offset -= Vector2(100,0) * delta
