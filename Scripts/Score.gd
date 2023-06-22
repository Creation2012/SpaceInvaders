extends Node2D

func _ready():
	$CountLabel.text = String(Scorecounter.score)
	
func _physics_process(delta):
	$CountLabel.text = String(Scorecounter.score)
