extends RayCast3D

@export var val_faccia :int

func _ready():
	#rimuove le collisioni del raycast con il modello del dado
	add_exception(get_parent().get_parent())
