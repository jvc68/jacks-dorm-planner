extends Control

func _on_zoom_in_pressed() -> void:
	GlobalSignals.cameraZoom.emit("+")

func _on_zoom_out_pressed() -> void:
	GlobalSignals.cameraZoom.emit("-")

func _on_center_pressed() -> void:
	GlobalSignals.moveCam.emit(Vector3(0, 3.87, 0))