extends Node3D

var rndNum: int

func _ready():
	rndNum = randi_range(1,6)
	print(rndNum)
	
	#for dado in $PlayerSpowner.get_children():
		#print(str(dado) +": "+ str(dado.valore))
