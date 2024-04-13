extends Node3D

func setDisplay(vet, name)-> void:
	var slots = $SubViewport/Control.get_children()
	for i in range(vet.size()):
		slots[i].texture = ResourceLoader.load("res://data/img/dice_white/"+ str(vet[i]) +".png")
