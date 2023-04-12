extends Node2D

var selected = false
var rest_point
var rest_nodes = []
var x = 300
var y = 100
var rectx = 200
var recty = 100
var currentslot 
var beginning = true
func init(xval, yval, rx, ry, curr):
	x = xval
	y = yval
	rectx = rx
	recty = ry
	currentslot = curr

func _ready():
	var collision_box = get_node("Icon/Area2D/collision_box")
	var shape = collision_box.shape as RectangleShape2D
	var size = shape.extents * 2
	scale.x = 0.7 * rectx / size.x
	scale.y = 0.7 * recty / size.y
	rest_nodes = get_tree().get_nodes_in_group("zone")
	rest_point = rest_nodes[0].pos + Vector2(rectx/2, recty/2)
	rest_nodes[0].select()
	global_position = Vector2(x,y)

func _on_Area2D_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
		selected = true
		beginning = false
		
func _physics_process(delta):
	if not beginning:
		if selected:
			global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
#			look_at(get_global_mouse_position())
		else:
			global_position = lerp(global_position, rest_point, 10 * delta)
#			rotation = lerp_angle(rotation, 0, 10 * delta)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.pressed:
			selected = false
			var shortest_dist = 10000
			for child in rest_nodes:
				var distance = global_position.distance_to(child.pos +  Vector2(rectx/2, recty/2) )
				if distance < shortest_dist:
					child.select()
					rest_point = child.pos + Vector2(rectx/2, recty/2)
					shortest_dist = distance


func topple():
	$AnimationPlayer.play("topple")
