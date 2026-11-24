extends GridContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_lighting_pressed() -> void:
	GlobalSignals.updateFurnishPanel.emit(2)


func _on_storage_pressed() -> void:
	GlobalSignals.updateFurnishPanel.emit(2)


func _on_decoration_pressed() -> void:
	GlobalSignals.updateFurnishPanel.emit(2)


func _on_chairs_pressed() -> void:
	GlobalSignals.updateFurnishPanel.emit(2)


func _on_desks_pressed() -> void:
	GlobalSignals.updateFurnishPanel.emit(2)


func _on_electronics_pressed() -> void:
	GlobalSignals.updateFurnishPanel.emit(2)
func _on_apliances_pressed() -> void:
	GlobalSignals.updateFurnishPanel.emit(2)
