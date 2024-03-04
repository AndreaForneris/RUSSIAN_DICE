extends Node3D

@export var dice: PackedScene

var nDadi
#vettore valore dadi
var vetFacce :Array
#contatore aggiunte
var vetIndex

func loadDadi(value):
	nDadi = value
	vetFacce.resize(nDadi)
	vetIndex = 0
	for i in nDadi:
		var dice = dice.instantiate()
		dice.name = 'dado' + str(i+1)
		add_child(dice)

func lanciaDadi():
	vetIndex = 0
	var child = $".".get_children()
	for dado in child:
		dado.get_node("RigidBody3D").lanciaDado()

func getFacce(value) -> void:
	#print("val Faccia: " + str(value))
	vetFacce[vetIndex] = value
	if vetIndex == nDadi:
		print(vetFacce)
		get_parent().risultato(vetFacce)
	else:
		vetIndex += 1
