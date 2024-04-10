extends RigidBody3D

@onready var facce = $Raycasts.get_children()
@onready var lancio = false

@onready var start_pos = position
@export var forzaMax = -4
@export var forzaMin = -3
@export var forzaRotaz = 5

func lanciaDado():
		lancio = true
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
	if sleeping: #or bug():
		for faccia in facce:
			if faccia.is_colliding() and lancio and $Timer.is_stopped():
				$Timer.start()
				get_parent().get_parent().get_parent().getFacce(faccia.val_faccia)

#func bug(): #pezza per bug collisioni dado->tavolo
	#if int(angular_velocity[0]) < 0 and int(angular_velocity[0]) > -0.1:
		#return true
