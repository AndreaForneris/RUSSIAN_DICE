extends Node3D

@onready var camera3D: Camera3D = $GlobalCamera
var transitioning: bool = false

func _ready() -> void:
	camera3D.current = false

func animation(from: Camera3D, to: Camera3D, duration: float = 1.0) -> void:
	if transitioning: return
	
	var tween = create_tween()
	camera3D.fov = from.fov
	camera3D.cull_mask = from.cull_mask
	
	# Move our transition camera to the first camera position
	camera3D.global_transform = from.global_transform
	
	# Make our transition camera current
	camera3D.current = true
	
	transitioning = true
	
	# Move to the second camera, while also adjusting the parameters to
	# match the second camera
	tween.stop()
	tween.tween_property(camera3D, "global_transform", to.global_transform , duration).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(camera3D, "fov", to.fov , duration).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC).set_delay(duration)
	tween.tween_property(camera3D, "global_transform", from.global_transform , duration).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(camera3D, "fov", from.fov , duration).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.play()
	
	# Wait for the tween to complete
	await tween.finished
	
	# Make the second camera current
	from.current = true
	transitioning = false
