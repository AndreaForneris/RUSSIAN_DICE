extends RigidBody3D

@onready var faccie = $Raycasts.get_children()
signal valFaccia(value)

@onready var start_pos = position
var forzaMax = -3
var forzaMin = -2.0
var forzaRotaz = 5

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept"): 
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


func _on_sleeping_state_changed():
	if sleeping:
		for faccia in faccie:
			if faccia.is_colliding():
				getFacce(faccia.val_faccia)
				#emit_signal("valFaccia", faccia.val_faccia)
