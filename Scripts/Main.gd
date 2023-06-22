extends Node

var drop_distance = 20

func _ready():
	for child in get_tree().get_nodes_in_group("Alien"):
		for alienNode in child.get_children():
			alienNode.connect("wallCollision", self, "dropDownAllAliens")

func dropDownAllAliens():
	# Adjust the Y position of all Alien instances
	for alien in get_tree().get_nodes_in_group("Alien"):
		alien.position.y += drop_distance
