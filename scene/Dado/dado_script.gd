extends RigidBody3D
class_name Dado

#forza max e min per x,y,z
@export var forzaMax = 10
@export var forzaMin = 0.5
@export var forzaRotaz = 30

var start_pos
var lancia: bool = true

func  _ready():
	start_pos = position

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept") and lancia: 
		lancia = false
		freeze = false
		visible = true
		transform.origin = start_pos
		
		linear_velocity = Vector3.ZERO
		angular_velocity = Vector3.ZERO
		
		transform.basis = Basis(Vector3.RIGHT, randf_range(forzaMin,forzaMax * PI)) * transform.basis
		transform.basis = Basis(Vector3.UP, randf_range(forzaMin,forzaMax * PI)) * transform.basis
		transform.basis = Basis(Vector3.FORWARD, randf_range(forzaMin,forzaMax * PI)) * transform.basis
		
		var vettore_lancio = Vector3(randf_range(-1,-0.5), 0, 0).normalized()
		angular_velocity = vettore_lancio * forzaRotaz/2
		apply_central_impulse(vettore_lancio * forzaRotaz)
		
		$Timer.start()

func _on_timer_timeout():
	lancia = true
