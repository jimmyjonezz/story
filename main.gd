extends Node2D

var first := []
var second := []
var third := []

func _ready():
	randomize()
	load_file()
	
func load_file():
	var data_file = File.new()
	
	if data_file.open("res://data.json", File.READ) != OK:
		return
	
	var data = {}
	data = parse_json(data_file.get_as_text())

	if typeof(data) == TYPE_DICTIONARY:
		first = data.first
		second = data.second
		third = data.third

		randomstory()
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		randomstory()
	
func randomstory():
	var one = randi() % first.size()
	var two = randi() % second.size()
	var three = randi() % third.size()
	$gui/Label.text = "%s %s %s" % [first[one], second[two], third[three]]

func _on_Timer_timeout():
	randomstory()

func _on_CheckBox_pressed():
	if $gui/CheckBox.is_pressed():
		$Timer.start()
	else:
		$Timer.stop()

func _on_SpinBox_value_changed(value):
	$Timer.wait_time = value
