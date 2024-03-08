extends Node3D

var rndNum: int
var nDadiPlayer = 5
var nDadiAI = 5

func _ready():
	rndNum = randi_range(1,6)
	impostaLabel(1, true, "Il numero estratto è : " + str(rndNum))

func _physics_process(delta):
	if Input.is_action_just_pressed("Lancia"): 
		impostaLabel(1, false, "")
		loadSpawners()
		$PlayerSpowner.lanciaDadi()
		$AISpowner.lanciaDadi()

func risultato(vet, name) -> void:
	if name == "AISpowner":
		impostaLabel(1, true, name + " " + str(vet))
	else: 
		impostaLabel(2, true, name + " " + str(vet))
	
	for ris in vet:
		if ris == rndNum:
			if name == "AISpowner":
				nDadiPlayer -= 1
				impostaLabel(2, true, "Palyer -1")
			else:
				nDadiAI -= 1
				impostaLabel(2, true, "AI -1")
	
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

func impostaLabel(lbl, value, txt):
	if lbl == 1:
		$CanvasLayer/HUD/Label1.visible = value
		$CanvasLayer/HUD/Label1.set_text(txt)
	if lbl == 2:
		$CanvasLayer/HUD/Label2.visible = value
		$CanvasLayer/HUD/Label2.set_text(txt)
