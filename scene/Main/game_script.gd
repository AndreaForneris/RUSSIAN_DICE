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
			await CameraTransition.animation($PlayerCamera,$TableCamera2)
			rndNum = vet[0]
			$PlayerSpowner.lanciaDadi()
			stato = "playerGame"
		
		"playerGame":
			#$Display.setDisplay(vet, name)
			CameraTransition.animation($PlayerCamera, $TableCamera1, 1, 1)
			print(str($PlayerSpowner/DiceContainer.get_child_count()))
			var i = 0
			for ris in vet:
				i += 1
				if ris == rndNum:
						nDadiPlayer -= 1
						print("Palyer -1")
						await objectTransition($PlayerSpowner/DiceContainer.get_child(i-1), $PlayerSpowner/DiceBin)
			stato = "TrndPlayer"
		
		"TrndPlayer":#lancio dado
			loadSpawners(nDadiAI,1)
			$PlayerSpowner.lanciaDadi()
			stato = "RrndPlayer"
		
		"RrndPlayer":#lettura dado
			await CameraTransition.animation($PlayerCamera, $TableCamera1)
			rndNum = vet[0]
			$AISpowner.lanciaDadi()
			stato = "AIGame"
		
		"AIGame":
			CameraTransition.animation($PlayerCamera, $TableCamera2, 1,1)
			var i = 0
			for ris in vet:
				i += 1
				if ris == rndNum:
						nDadiAI -= 1
						print("AI -1")
						await objectTransition($AISpowner/DiceContainer.get_child(i-1), $AISpowner/DiceBin)
			stato = "TrndAI"

#func setDisplay(vet, name)-> void:
	#var slots = $SubViewport/Control.get_children()
	#for i in range(vet.size()):
		#slots[i].texture = ResourceLoader.load("res://data/img/dice_white/"+ str(vet[i]) +".png")

func objectTransition(from: Node3D, to: Node3D, AnimDuration: float = 2):
	var tween = create_tween()
	tween.tween_property(from, "global_transform", to.global_transform , AnimDuration).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.play()
	await tween.finished
	tween.stop()

func loadSpawners(lnAI, lnPlayer):
	$AISpowner.clearContainer()
	$PlayerSpowner.clearContainer()
	
	$AISpowner.loadDadi(lnAI)
	$PlayerSpowner.loadDadi(lnPlayer)
