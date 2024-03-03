extends Node3D

var rndNum: int

func _ready():
	rndNum = randi_range(1,6)
	print("rnd num: "+str(rndNum))
	
	#for dado in $PlayerSpowner.get_children():
		#print(str(dado) +": "+ str(dado.valore))

func risultato(value) -> void:
	
