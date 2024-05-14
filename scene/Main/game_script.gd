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
		risultato([0], "", "")
	
	if Input.is_action_just_pressed("Esci"):
		get_tree().change_scene_to_file("res://scene/HUD/main_menu.tscn")

func risultato(vet, name, Dname) -> void:
	print(vet," ", Dname , " ", name)
	
	match stato:
		"TrndAI":#lancio dado 
			loadSpawners(1, nDadiPlayer)
			$AISpowner.lanciaDadi()
			stato = "RrndAI"
		
		"RrndAI":#lettura dado 
			await CameraTransition.animation($PlayerCamera,$TableCamera2)
			rndNum = vet[0]
			$PlayerSpowner.lanciaDadi()
			CameraTransition.animation($PlayerCamera, $TableCamera1, 1, 1)
			stato = "playerGame"
		
		"playerGame":
			#$Display.setDisplay(vet, name)
			var i = 0
			#while i < nDadiPlayer:
			for ris in vet:
				i += 1
				if ris == rndNum:
						nDadiPlayer -= 1
						print("Palyer -1")
						objectTransition(get_node("PlayerSpowner/DiceContainer/"+Dname[i-1]), $PlayerSpowner/DiceBin, "playerGame")
			stato = "TrndPlayer"
		
		"TrndPlayer":#lancio dado
			loadSpawners(nDadiAI,1)
			$PlayerSpowner.lanciaDadi()
			stato = "RrndPlayer"
		
		"RrndPlayer":#lettura dado
			await CameraTransition.animation($PlayerCamera, $TableCamera1)
			rndNum = vet[0]
			$AISpowner.lanciaDadi()
			CameraTransition.animation($PlayerCamera, $TableCamera2, 1,1)
			stato = "AIGame"
		
		"AIGame":
			var i = 0
			#while i < nDadiAI:
			for ris in vet:
				i += 1
				if ris == rndNum:
						nDadiAI -= 1
						print("AI -1")
						objectTransition(get_node("AISpowner/DiceContainer/"+Dname[i-1]), $AISpowner/DiceBin, "AIGame")
			stato = "TrndAI"

#func setDisplay(vet, name)-> void:
	#var slots = $SubViewport/Control.get_children()
	#for i in range(vet.size()):
		#slots[i].texture = ResourceLoader.load("res://data/img/dice_white/"+ str(vet[i]) +".png")

func objectTransition(from: Node3D, to: Node3D, nextStato):
	var tween = create_tween()
	tween.tween_property(from, "global_transform", to.global_transform , 1).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.play()
	await tween.finished
	stato = nextStato
	#risultato([0], "", "")
	tween.stop()

#func cameraAnim(from: Camera3D, to: Camera3D, AnimDuration: float = 1, DelayDuration : float = 0):
#
	#var tween = create_tween()
	#camera3D.fov = from.fov
	#camera3D.cull_mask = from.cull_mask
	#
	## Move our transition camera to the first camera position
	#camera3D.global_transform = from.global_transform
	#
	## Make our transition camera current
	#camera3D.current = true
	#
	#transitioning = true
	#
	## Move to the second camera, while also adjusting the parameters to
	## match the second camera
	#tween.stop()
	#tween.tween_property(camera3D, "global_transform", to.global_transform , AnimDuration).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	#tween.tween_property(camera3D, "fov", to.fov , AnimDuration).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC).set_delay(DelayDuration)
	#tween.tween_property(camera3D, "global_transform", from.global_transform , AnimDuration).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	#tween.tween_property(camera3D, "fov", from.fov , AnimDuration).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	#tween.play()
	#
	## Wait for the tween to complete
	#await tween.finished
	#
	## Make the second camera current
	#from.current = true
	#transitioning = false

func loadSpawners(lnAI, lnPlayer):
	$AISpowner.clearContainer()
	$PlayerSpowner.clearContainer()
	
	$AISpowner.loadDadi(lnAI)
	$PlayerSpowner.loadDadi(lnPlayer)
