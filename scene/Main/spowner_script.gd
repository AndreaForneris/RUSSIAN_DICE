extends Node3D

@export var dice: PackedScene
var nDadi = 5

#vettore valore dadi
#contatore aggiunte

func _ready():
	for i in nDadi:
		var dice = dice.instantiate()
		dice.name = 'dado' + str(i+1)
		add_child(dice)

func getFacce(value) -> void:
	print("getFacce"+str(value))
	#add a vettore valore dadi
	#se contatore = nDadi
	#	get_parent().risultato(vettore)
