extends Node

@warning_ignore("unused_signal")
signal cameraZoom(modifier)

@warning_ignore("unused_signal")
signal moveCam(pos)

@warning_ignore("unused_signal")
signal updateFurnishPanel(state)

signal hideUI()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		hideUI.emit()