extends Node3D

var rndNum: int
var nDadiPlayer = 5
var nDadiAI = 5

func _ready():
	rndNum = randi_range(1,6)
	print("rnd num: ",rndNum)
	$AISpowner.loadDadi(nDadiAI)
	$PlayerSpowner.loadDadi(nDadiPlayer)

func _physics_process(delta):
	if Input.is_action_just_pressed("Lancia"): 
		$PlayerSpowner.lanciaDadi()
		$AISpowner.lanciaDadi()

func risultato(value, name) -> void:
	print(value, " " ,name)
