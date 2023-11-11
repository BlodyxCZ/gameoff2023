class_name DragItem
extends RigidBody2D


signal clicked

var held = false

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			emit_signal("clicked", self)
			


func _physics_process(delta):
	if held:
		global_transform.origin = get_global_mouse_position()


func pickup():
	if held:
		return
	freeze_mode = RigidBody2D.FREEZE_MODE_STATIC
	freeze = true
	held = true


func drop(impulse=Vector2.ZERO):
	if held:
		freeze_mode = RigidBody2D.FREEZE_MODE_KINEMATIC
		apply_central_impulse(impulse)
		freeze = false
		held = false
