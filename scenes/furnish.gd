extends Button

@export var furnishPanels: Control
var state = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalSignals.hideUI.connect(hideUI)
	GlobalSignals.updateFurnishPanel.connect(updateUI)

func _process(_delta: float) -> void:
	if state != 1:
		disabled = true
	else:
		disabled = false

func hideUI():
	if state != 1:
		furnishPanels.handleAnimations(3)
		state = 1

func updateUI(newState):
	state = newState
	furnishPanels.handleAnimations(state)

func _on_pressed() -> void:
	furnishPanels.handleAnimations(state)
	state += 1
	if state > 3:
		state = 1