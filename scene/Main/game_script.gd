extends Node3D

var rndNum: int
var nDadiPlayer = 5
var nDadiAI = 5

func _ready():
	rndNum = randi_range(1,6)
	print("rnd num: ",rndNum)

func _physics_process(delta):
	if Input.is_action_just_pressed("Lancia"): 
		loadSpawners()
		$PlayerSpowner.lanciaDadi()
		$AISpowner.lanciaDadi()

func risultato(vet, name) -> void:
	print(vet, " " ,name)
	
	for ris in vet:
		if ris == rndNum:
			if name == "AISpowner":
				nDadiPlayer -= 1
				print("palyer -1")
			else:
				nDadiAI -= 1
				print("AI -1")
	
	if nDadiAI == 0 and nDadiPlayer == 0:
		print("pareggio")
	if nDadiAI == 0:
		print("Palyer Vince")
	if nDadiPlayer == 0:
		print("AI Vince")

func loadSpawners():
	$AISpowner.clearContainer()
	$PlayerSpowner.clearContainer()
	
	$AISpowner.loadDadi(nDadiAI)
	$PlayerSpowner.loadDadi(nDadiPlayer)
