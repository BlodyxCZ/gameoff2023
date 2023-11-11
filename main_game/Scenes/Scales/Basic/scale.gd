extends Node2D


var held_object = null

func _ready():
	for node in get_tree().get_nodes_in_group("pickable"):
		node.connect("clicked", _on_pickable_clicked)


func _on_pickable_clicked(object):
	if !held_object:
		held_object = object
		held_object.pickup()


func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if held_object and !event.pressed:
			held_object.drop(Input.get_last_mouse_velocity())
			held_object = null


func _physics_process(_delta):
	var a = float($Platform1/Panel/Label.text)
	var b = float($Platform2/Panel/Label.text)
	
	if a > b:
		$Panel/OP.text = ">"
	elif b > a:
		$Panel/OP.text = "<"
	else:
		$Panel/OP.text = "="
