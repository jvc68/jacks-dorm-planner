extends CharacterBody3D

@export var move_speed: float = 10.0
@export var mouse_sensitivity: float = 0.002

@onready var camera: Camera3D = $Camera3D

var rotateCam = true
var rotation_x: float = 0.0
var rotation_y: float = 0.0


func _ready():
    Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _input(event):
    # Handle mouse movement
    if event is InputEventMouseMotion:
        if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
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
            rotateCam = false
        else:
            Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
            rotateCam = true


func _physics_process(delta):
    var direction = Vector3.ZERO

    if Input.is_action_pressed("ui_up"):
        direction.x -= 1
    if Input.is_action_pressed("ui_down"):
        direction.x += 1
    if Input.is_action_pressed("ui_left"):
        direction.z += 1
    if Input.is_action_pressed("ui_right"):
        direction.z -= 1

    direction = direction.normalized()
    direction = transform.basis * direction

    global_position += direction * move_speed * delta
