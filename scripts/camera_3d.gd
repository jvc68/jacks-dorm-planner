extends CharacterBody3D

@export var move_speed: float = 10.0
@export var mouse_sensitivity: float = 0.002
@export var camNotsif: Label

@onready var camera: Camera3D = $Camera3D

var rotateCam = true
var rotation_x: float = 0.0
var rotation_y: float = 0.0
var multi: float = 1.0


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	camNotsif.visible = true;
	GlobalSignals.cameraZoom.connect(zoomingCamera)
	GlobalSignals.moveCam.connect(setGlobalPos)


func _input(event):
	# Handle mouse movement
	if event is InputEventMouseMotion:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED || rotateCam:
			rotation_y -= event.relative.x * mouse_sensitivity
			rotation_x -= event.relative.y * mouse_sensitivity

			# Clamp vertical rotation
			rotation_x = clamp(rotation_x, deg_to_rad(-89), deg_to_rad(89))

			# Apply rotation
			rotation.y = rotation_y
			camera.rotation.x = rotation_x

	# Release mouse with Escape
	if event.is_action_pressed("ui_cancel"):
		if rotateCam:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			camNotsif.visible = false;
			rotateCam = false
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			camNotsif.visible = true;
			rotateCam = true


func _physics_process(delta):
	var direction = Vector3.ZERO

	if Input.is_action_pressed("rightClick"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		camNotsif.visible = true;
		rotateCam = true
	elif Input.is_action_just_released("rightClick"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		camNotsif.visible = false;
		rotateCam = false

	if Input.is_action_pressed("ui_up"):
		direction.z -= 1
	if Input.is_action_pressed("ui_down"):
		direction.z += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1

	if Input.is_action_pressed("camUp"):
		direction.y += 1
	if Input.is_action_pressed("camDown"):
		direction.y -= 1

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

	global_position += direction * move_speed * delta * multi
	global_position.y = max(global_position.y, 0.5)
	global_position.y = minf(global_position.y, 25.0)


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
