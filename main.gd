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
	
	var data = parse_json(data_file.get_as_text())
	data_file.close()
	
	if typeof(data) == TYPE_DICTIONARY:
		first = data.first
		second = data.second
		third = data.third

		randomstory()

func save_file(first: Array, second: Array, third: Array):
	var save_game = File.new()
	save_game.open("res://data.json", File.WRITE)
	
	var a = {"first" : first, "second" : second, "third" : third}
	
	save_game.store_line(to_json(a))
	save_game.close()
	
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

func _on_Button_pressed():
	var value1 = $gui/lines/line1.text as String
	var value2 = $gui/lines/line2.text as String
	var value3 = $gui/lines/line3.text as String
	
	if value1 == "" || value2 == "" || value3 == "":
		$gui/Label2.show()
		yield(get_tree().create_timer(2), "timeout")
		$gui/Label2.hide()
		return
	
	first.push_back(value1)
	second.push_back(value2)
	third.push_back(value3)
	save_file(first, second, third)
	
	$gui/lines/line1.text = ""
	$gui/lines/line2.text = ""
	$gui/lines/line3.text = ""
