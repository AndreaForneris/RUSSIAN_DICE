extends Node3D

@export var dice: PackedScene
@export var nDadi = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	#if mioturno: 
		for i in nDadi:
			var dice = dice.instantiate()
			add_child(dice)
	
