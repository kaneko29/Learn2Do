extends Node2D

var N = 4
var rx = 200
var ry = 100
var questions = []
var ansslots = []
var answers = []

# Called when the node enters the scene tree for the first time.
func _ready():
	rx = get_viewport().size.x * 3/8
	ry = get_viewport().size.y / (0.5 + 3 * N/2)
	print("hi")
	questions.resize(N)
	answers.resize(N)
	ansslots.resize(N)
	for i in range(N):
		questions[i] = preload("res://DropZone.tscn").instance()
		questions[i].init(rx / 6, ry/2 + (ry/2 + + ry) * i, rx, ry, Color.red, false)
		add_child(questions[i])
	for i in range(N):
		ansslots[i] = preload("res://DropZone.tscn").instance()
		ansslots[i].init(rx * 3/2, ry/2 + (ry/2 + + ry) * i, rx, ry, Color.blue, true)
		add_child(ansslots[i])
	for i in range(N):
		answers[i] = preload("res://appsforzgood.tscn").instance()
		answers[i].init(rx * 3/2 + rx/2, ry + (ry/2 + + ry) * i, rx, ry, ansslots[i])
		add_child(answers[i])
	for i in range(N):
		ansslots[i].addans(answers[i])

	#var box1 = preload("res://DropZone.tscn").instance()
	#box1.init(rx, ry)
	#add_child(box1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
