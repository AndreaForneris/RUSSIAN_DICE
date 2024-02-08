extends RayCast3D

@export var val_faccia :int

func _ready():
	print()
	#rimuove le collisioni con il modello del dado
	add_exception(get_parent().get_parent())
