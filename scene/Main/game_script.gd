extends Node3D

var rndNum: int
@onready var nDadiPlayer = 5
@onready var nDadiAI = 5
@onready var stato = "TrndAI"

func _ready():
	$PlayerCamera.current = true

func _physics_process(delta):
	var end:bool = false
	if nDadiAI == 0:
		print("Palyer Vince")
		end = true
	if nDadiPlayer == 0:
		print("AI Vince")
		end = true
	
	if Input.is_action_just_pressed("Lancia") and !end: 
		risultato([0], "")
	
	if Input.is_action_just_pressed("Esci"):
		get_tree().change_scene_to_file("res://scene/HUD/main_menu.tscn")

func risultato(vet, name) -> void:
	print(vet, " ", name)
	
	match stato:
		"TrndAI":#lancio dado 
			loadSpawners(1, nDadiPlayer)
			$AISpowner.lanciaDadi()
			stato = "RrndAI"
		
		"RrndAI":#lettura dado
			rndNum = vet[0]
			#print("rnd: " + str(rndNum))
			$Timer.start
			if $Timer.is_stopped():
				$PlayerSpowner.lanciaDadi()
			stato = "playerGame"
		
		"playerGame":
			#$Display.setDisplay(vet, name)
			CameraTransition.animation($PlayerCamera, $TableCamera1)
			for ris in vet:
				if ris == rndNum:
						nDadiPlayer -= 1
						print("Palyer -1")
			stato = "TrndPlayer"
		
		"TrndPlayer":#lancio dado 
			loadSpawners(nDadiAI,1)
			$PlayerSpowner.lanciaDadi()
			stato = "RrndPlayer"
		
		"RrndPlayer":#lettura dado
			rndNum = vet[0]
			#print("rnd: " + str(rndNum))
			stato = "AIGame"
			$Timer.start
			if $Timer.is_stopped():
				$AISpowner.lanciaDadi()
		
		"AIGame":
			for ris in vet:
				if ris == rndNum:
						nDadiAI -= 1
						print("AI -1")
			stato = "TrndAI"
	
#func setDisplay(vet, name)-> void:
	#var slots = $SubViewport/Control.get_children()
	#for i in range(vet.size()):
		#slots[i].texture = ResourceLoader.load("res://data/img/dice_white/"+ str(vet[i]) +".png")

func loadSpawners(lnAI, lnPlayer):
	$AISpowner.clearContainer()
	$PlayerSpowner.clearContainer()
	
	$AISpowner.loadDadi(lnAI)
	$PlayerSpowner.loadDadi(lnPlayer)
