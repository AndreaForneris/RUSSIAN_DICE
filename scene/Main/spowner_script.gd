extends Node3D

@export var dice: PackedScene

var nDadi:int
#vettore valore dadi
var vetFacce :Array
#contatore aggiunte
var vetIndex:int
var vetNomi :Array

func loadDadi(value):
	nDadi = value
	vetFacce.resize(nDadi)
	vetNomi.resize(nDadi)
	vetIndex = 0
	for i in nDadi:
		var dice = dice.instantiate()
		dice.name = 'dado' + str(i+1)
		$DiceContainer.add_child(dice)

func clearContainer():
	var dadi = $DiceContainer.get_children()
	for node in dadi:
		node.queue_free()

func lanciaDadi():
	vetIndex = 0
	var child = $DiceContainer.get_children()
	for dado in child:
		dado.get_node("RigidBody3D").lanciaDado()

func getFacce(value, name) -> void:
	vetFacce[vetIndex] = value
	vetNomi[vetIndex] = name
	if vetIndex == nDadi-1 :
		get_parent().risultato(vetFacce, $".".name, vetNomi)
	else:
		vetIndex += 1
