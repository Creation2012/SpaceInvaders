extends Area2D

var bullet_speed = 5

func _physics_process(delta):
	position.y += bullet_speed

func _on_Area2D_body_entered(body):
	if body.name == "Ship":
		Livecounter.lives -= 1
		queue_free()
		# GAME OVER
	if body.name == "Bullet":
		queue_free()
