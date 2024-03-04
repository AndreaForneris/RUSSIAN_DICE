extends Node3D

@export var dice: PackedScene

var nDadi:int
#vettore valore dadi
var vetFacce :Array
#contatore aggiunte
var vetIndex:int

func loadDadi(value):
	nDadi = value
	vetFacce.resize(nDadi)
	vetIndex = 0
	for i in nDadi:
		var dice = dice.instantiate()
		dice.name = 'dado' + str(i+1)
		$DiceContainer.add_child(dice)

func lanciaDadi():
	vetIndex = 0
	var child = $DiceContainer.get_children()
	for dado in child:
		dado.get_node("RigidBody3D").lanciaDado()
	#$Timer.start()

func getFacce(value) -> void:
	vetFacce[vetIndex] = value
	if vetIndex == nDadi-1 :#and $Timer.is_stopped():
		get_parent().risultato(vetFacce, $".".name)
	else:
		vetIndex += 1
