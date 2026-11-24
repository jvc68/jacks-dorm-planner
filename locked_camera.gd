extends CharacterBody3D

@export var move_speed: float = 10.0
@export var mouse_sensitivity: float = 0.003
@export var camNotsif: Label

@onready var camera: Camera3D = $Camera3D2

var moveCam = true
var position_z: float = 0.0
var position_x: float = 0.0
var multi: float = 1.0


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	GlobalSignals.cameraZoom.connect(zoomingCamera)
	GlobalSignals.moveCam.connect(setGlobalPos)


func _input(event):
	if (!camera.current):
		return
	
	# Handle mouse movement
	if event is InputEventMouseMotion:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED || moveCam:
			position.x += event.relative.x * mouse_sensitivity
			position.z += event.relative.y * mouse_sensitivity

	# Release mouse with Escape
	if event.is_action_pressed("ui_cancel"):
		if moveCam:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			camNotsif.visible = false;
			moveCam = false
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			camNotsif.visible = true;
			moveCam = true


func _physics_process(delta):
	if (!camera.current):
		return
	
	if (moveCam):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		camNotsif.visible = true
	else:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		camNotsif.visible = false
	
	var direction = Vector3.ZERO

	if Input.is_action_pressed("rightClick"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		camNotsif.visible = true;
		moveCam = true
	elif Input.is_action_just_released("rightClick"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		camNotsif.visible = false;
		moveCam = false

	if Input.is_action_pressed("ui_up"):
		direction.y += 1
	if Input.is_action_pressed("ui_down"):
		direction.y -= 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	

	if Input.is_action_pressed("camUp"):
		direction.z += 1
	if Input.is_action_pressed("camDown"):
		direction.z -= 1
	

	if Input.is_action_just_released("zoomCamIn"):
		zoomingCamera("+")

	if Input.is_action_just_released("zoomCamOut"):
		zoomingCamera("-")

	if Input.is_action_pressed("camSpeedToggle"):
		multi = 2.0
	else:
		multi = 1.0

	direction = direction.normalized()
	direction = camera.global_transform.basis * direction

	position += direction * move_speed * delta * multi


func zoomingCamera(modifier):
	match modifier:
		"+":
			if camera.fov >= 55:
				camera.fov -= 10
		"-":
			if camera.fov <= 95:
				camera.fov += 10

func setGlobalPos(pos):
	global_position = pos
