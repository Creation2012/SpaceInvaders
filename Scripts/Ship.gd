extends KinematicBody2D

var speler = AudioStreamPlayer.new()

var moveSpeed = 400  # Adjust this value to change the movement speed
var velocity = Vector2.ZERO

var fired = 0
var shotTimer = Timer.new()
var delayTime = 2.0  # Adjust the delay time as needed

func _ready():
	self.add_child(speler)
	speler.stream = load("res://Sfx/shoot.wav")
	speler.volume_db = -20.0
	
	add_child(shotTimer)
	shotTimer.connect("timeout", self, "_onShotTimer")

	# Start the movement timer initially
	shotTimer.start(delayTime)

func _physics_process(delta):
	
	if Input.is_action_pressed("move_left"):
		velocity.x = -moveSpeed
	elif Input.is_action_pressed("move_right"):
		velocity.x = moveSpeed
	else:
		velocity.x = 0

	move_and_slide(velocity)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.name == "Alien":
			Scorecounter.score = 0
			get_tree().reload_current_scene()
	#var collision = move_and_collide(Vector2(delta, 0))
	
	#if collision and collision.collider.has_method("kill"):
	#	print("GAME OVER")

	if Input.is_action_just_pressed("ui_accept") and fired != 1:
		speler.play()
		fire()

func fire():
	var bullet = preload("res://Scenes/Bullet.tscn")
	var firedbullet = bullet.instance()
	firedbullet.position = Vector2(position.x, 0)
	get_parent().call_deferred("add_child", firedbullet)
	fired = 1
	#for b in firedbullet.get_children():
		#fired = 1
		#b.connect("release", self, "allowToShot")
	
func allowToShot():
	fired = 0

func _onShotTimer():
	fired = 0
	shotTimer.start(delayTime) 
