extends Node2D

#Number of tasks
var N = 7

#Size of screen
var rx 
var ry 

#Questions and ansslots store the dropzones, one for the left column the 
#other for the right
var questions = []
var ansslots = []

#Stores all the tasks
var answers = []

#The name of the current activity
var activity = "tooth"

#Gets the button 
onready var childButton: Button = self.get_child(0) 

#Starts the program!
func _ready():
	#connects to the button
	childButton.connect("pressed", self, "anscheck")
	
	#Gets the size of the viewport/screen
	rx = get_viewport().size.x * 3/8
	ry = get_viewport().size.y / (0.5 + 3 * N/2)
	
	#makes the array a certain length
	questions.resize(N)
	answers.resize(N)
	ansslots.resize(N)
	
	#Loads the dropzones in, creates instance and initiliazes them
	for i in range(N):
		print("hi")
		questions[i] = preload("res://AK/DropZone.tscn").instance()
		questions[i].init(rx / 6, ry/2 + (ry/2 + ry) * i, rx, ry, Color.blue, true)
		add_child(questions[i])
	for i in range(N):
		ansslots[i] = preload("res://AK/DropZone.tscn").instance()
		ansslots[i].init(rx * 3/2, ry/2 + (ry/2 + ry) * i, rx, ry, Color.red, false)
		add_child(ansslots[i])	
	
	#Random initial ordering of the images
	var imgorder = [4, 1, 6, 5, 3, 7, 2]
	
	#Creates array of image links
	var imgarray=[]
	for i in range(N):
		imgarray.append("res://AK/" + activity + "/" + activity + str(imgorder[i]) + ".png")
	
	#Loads the task stuff and initializes it
	for i in range(N):
		answers[i] = preload("res://AK/appsforzgood.tscn").instance()
		answers[i].init(rx / 6, ry/2 + (ry/2 + ry) * i, rx, ry, questions[i], imgarray[i], imgorder[i])
		add_child(answers[i])
	for i in range(N):
		questions[i].addans(answers[i])

#Checks if the answers are correct, called when the button is pressed
func anscheck():
	var counter = 0
	for i in range(N):
		#checks if the dropzone is not empty and the task inside of it
		#is in the correct location
		if ansslots[i].ans != null and ansslots[i].ans.ordernum == i+1:
			ansslots[i].change_color(Color.green)
			counter += 1
		else:
			ansslots[i].change_color(Color.red)
	#if everything is correct
	if counter == N:
		print("you got everything correct!")

