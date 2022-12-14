extends Node

onready var credits = $Credits
onready var programmer = $Programmer
onready var zero = $Zero
onready var one = $One
onready var two = $Two
onready var three = $Three
onready var four = $Four
onready var five = $Five

var interface = false
var control = true
var dron_zone = false
var change_zone = false
var chrom_dead = true
var final = false
var inputstr = ""
var send:bool = false

func _ready():
	$Camera2D.current = true
	programmer.initialize(self)
	$Zero/ColorRect.visible = false
	$Zero/Label.visible = false
	$One/ColorRect.visible = false
	$One/Label.visible = false
	$Two/ColorRect.visible = false
	$Two/Label.visible = false
	$Three/ColorRect.visible = false
	$Three/Label.visible = false
	$Four/ColorRect.visible = false
	$Four/Label.visible = false
	$Five/ColorRect.visible = false
	$Five/Label.visible = false
	$Sent.visible = false
	$AudioStreamEnding.play()
	credits.initialize(self)
	$Button.visible = false
	$Click.visible = false

func _input(event):
	if event is InputEventKey and event.pressed:
		var s = OS.get_scancode_string(event.scancode)
		if s == "BackSpace":
			inputstr = ""
			$Button.visible = false
			$Click.visible = false
		elif s == "Space":
			inputstr = inputstr + " "
		elif !["Left", "Up", "Right", "Down", "Enter"].has(s):
			inputstr = inputstr + s
			$Button.visible = true
			$Click.visible = true
		$Name.set_text(inputstr)

func jump():
	pass

func _on_Zero_body_entered(_body):
	$Zero/ColorRect.visible = true
	$Zero/Label.visible = true
	CheckpointsMenu.check = 0

func _on_Zero_body_exited(_body):
	$Zero/ColorRect.visible = false
	$Zero/Label.visible = false

func _on_One_body_entered(_body):
	$One/ColorRect.visible = true
	$One/Label.visible = true
	CheckpointsMenu.check = 1

func _on_One_body_exited(_body):
	$One/ColorRect.visible = false
	$One/Label.visible = false

func _on_Two_body_entered(_body):
	$Two/ColorRect.visible = true
	$Two/Label.visible = true
	CheckpointsMenu.check = 2

func _on_Two_body_exited(_body):
	$Two/ColorRect.visible = false
	$Two/Label.visible = false

func _on_Three_body_entered(_body):
	$Three/ColorRect.visible = true
	$Three/Label.visible = true
	CheckpointsMenu.check = 3

func _on_Three_body_exited(_body):
	$Three/ColorRect.visible = false
	$Three/Label.visible = false

func _on_Four_body_entered(_body):
	$Four/ColorRect.visible = true
	$Four/Label.visible = true
	CheckpointsMenu.check = 4

func _on_Four_body_exited(_body):
	$Four/ColorRect.visible = false
	$Four/Label.visible = false

func _on_Five_body_entered(_body):
	$Five/ColorRect.visible = true
	$Five/Label.visible = true
	CheckpointsMenu.check = 5

func _on_Five_body_exited(_body):
	$Five/ColorRect.visible = false
	$Five/Label.visible = false

func _on_Start_body_entered(_body):
	$Zero/ColorRect.visible = false
	$Zero/Label.visible = false
	CheckpointsMenu.check = 0
	
func _on_AudioStreamEnding_finished():
	$AudioStreamEnding.play()

func _on_Button_pressed():
	send = true
	$Name.visible = false
	$NameTitle.visible = false
	$Button.visible = false
	$Click.visible = false
	$Sent.visible = true
	$HTTPRequest.request("https://futbolenvivo.herokuapp.com/game?name=" + inputstr)

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	pass
#	var json = JSON.parse(body.get_string_from_utf8())
#	print(json.result)
