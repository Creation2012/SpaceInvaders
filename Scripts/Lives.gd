extends Node2D


func _ready():
	Livecounter.lives = 3
	
func _physics_process(delta):
	if Livecounter.lives == 2:
		$Live3.hide()
		
	if Livecounter.lives == 1:
		$Live2.hide()
		
	if Livecounter.lives == 0:
		Scorecounter.score = 0
		get_tree().reload_current_scene()
