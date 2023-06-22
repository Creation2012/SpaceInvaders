extends KinematicBody2D

signal release

var Move_speed = 300
var Life_time = 2
var Life_spawn = 0

func _physics_process(delta):
	var collision = move_and_collide(Vector2.UP  * delta * Move_speed)
	
	#if collision and collision.collider.has_method("kill"):
	if collision: #and collision.collider.has_method("kill"):
		emit_signal("release")
		queue_free()
		collision.collider.kill()
	else:
		Life_spawn += delta
		if Life_spawn > Life_time:
			emit_signal("release")
			queue_free() 
