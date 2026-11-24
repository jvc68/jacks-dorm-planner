extends Control

@onready var anim_player: AnimationPlayer = $AnimationPlayer

var animationPlaying

func _ready() -> void:
	$Genres.hide()
	$assetTemplate.hide()
	anim_player.animation_finished.connect(animationDone)


func handleAnimations(state) -> void:
	print("State: ", state)
	match state:
		1:
			$Genres.show()
			anim_player.play("slideIn")
			state = 2
		2:
			anim_player.play_backwards("slideIn")
			state = 3
			await $AnimationPlayer.animation_finished
			$Genres.hide()
			$assetTemplate.show()
			anim_player.play("slideIn")
		3:
			anim_player.play_backwards("slideIn")
			state = 1

func animationDone():
	$Genres.hide()
	$assetTemplate.hide()
