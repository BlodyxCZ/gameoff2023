extends StaticBody2D


func _physics_process(_delta):
	
	var weight = 0
	
	for item in $Area2D.get_overlapping_bodies():
		if item.is_in_group("pickable"):
			weight += item.mass
	
	$Panel/Label.text = str(weight).pad_decimals(2)
