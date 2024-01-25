extends RigidBody3D
class_name Dado

#forza max e min per x,y,z
@export var forzaMax = Vector3(-0.5,0,0.5)
@export var forzaMin = Vector3(-2,-0.2,-0.5)

var forza = Vector3()
var posizione= Vector3()

var lancia: bool = true

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept") and lancia: 
		lancia = false
		freeze = false
		visible = true
		
		forza = Vector3(randf_range(forzaMin[0], forzaMax[0]),
		randf_range(forzaMin[1], forzaMax[1]),
		randf_range(forzaMin[2], forzaMax[2]))
		
		print(forza)
		
		apply_impulse(forza, Vector3(0,1,0))
		$Timer.start()

func _on_timer_timeout():
	lancia = true
	print("yoyo")
