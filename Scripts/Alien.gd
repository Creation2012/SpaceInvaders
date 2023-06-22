extends KinematicBody2D

var move_x = 10
var move_speed = 20 # 20
var move_distance = 20
var drop_distance = 40
var left_wall_offset = 5

var score = 100

signal wallCollision

var shootingcount = rand_range(0, 50)
var movementTimer = Timer.new()
var delayTime = 1.0  # Adjust the delay time as needed

func _ready():
	for i in get_children():
		if i is Sprite:
			if i.texture.get_path() == "res://Art/Enemies/Alien - 1.png":
				score = 100
			elif i.texture.get_path() == "res://Art/Enemies/Alien - 2.png":
				score = 200
			elif i.texture.get_path() == "res://Art/Enemies/Alien - 3.png":
				score = 400
	add_child(movementTimer)
	movementTimer.connect("timeout", self, "_onMovementTimerTimeout")

	# Start the movement timer initially
	movementTimer.start(delayTime)

func _physics_process(delta):
	var collision = move_and_collide(Vector2(move_speed * delta * Variables.slide_direction, 0))
	#position.x += move_x * Variables.slide_direction
	if collision:
		collision.collider.free()
		kill()

	shootingcount += delta
	if shootingcount >= 50:
		var bullet = preload("res://Scenes/AlienBullet.tscn")
		var firedbullet = bullet.instance()
		firedbullet.position = Vector2(position.x, position.y)
		get_parent().call_deferred("add_child", firedbullet)

		shootingcount = rand_range(0, 50)

	if get_global_position().x < 34 or get_global_position().x >= 990:
		Variables.slide_direction *= -1
		emit_signal("wallCollision")
	
	if position.y >= get_viewport_rect().size.y:
		# Game over condition or other handling
		queue_free()

func kill():
	queue_free()
	Scorecounter.score += score
	
func _onMovementTimerTimeout():
	#position.x += move_x * Variables.slide_direction
	movementTimer.start(delayTime)  # Restart the timer for the next movement
