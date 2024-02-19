extends Node3D

@export var dice: PackedScene
@export var nDadi = 5

func _ready():
	for i in nDadi:
		var dice = dice.instantiate()
		dice.name = 'dado' + str(i+1)
		add_child(dice)
