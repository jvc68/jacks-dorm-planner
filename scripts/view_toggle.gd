extends Button

var cam_1: Camera3D
var cam_2: Camera3D

func _ready() -> void:
	cam_1 = get_tree().get_first_node_in_group("cam_1")
	cam_2 = get_tree().get_first_node_in_group("cam_2")
	pressed.connect(toggle_camera)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_camera"):
		toggle_camera()

func toggle_camera() -> void:
	if not cam_1 or not cam_2:
		return
	if cam_1.current:
		cam_2.make_current()
	else:
		cam_1.make_current()
