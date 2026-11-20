extends Button

@export var type: String = "bruh"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	print(type)

	match type:
		"furnish":
			var mesh_instance = CSGBox3D.new()

			var new_mat := StandardMaterial3D.new()
			new_mat.albedo_color = Color.RED
			new_mat.roughness = 1.0
			new_mat.metallic = 0.0
			
			mesh_instance.material = new_mat

			add_child(mesh_instance)
		"measure":
			var text_instance = Label.new()
			text_instance.text = "I am here"
			add_child(text_instance)
