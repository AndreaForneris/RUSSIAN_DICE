extends RayCast3D

@export var val_faccia :int

func _ready():
	#rimuove le collisioni con il modello del dado
	add_exception(owner)
