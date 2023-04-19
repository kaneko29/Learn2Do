extends Position2D

signal correct()
export var correct = false

var pos = Vector2(300, 0)
var x = 200
var y = 100
var occupied = false
var ans = null
var color 

func init(xp, yp, xval, yval, C, occ):
	pos[0] = xp
	pos[1] = yp
	x = xval
	y = yval
	color = C
	occupied = occ

func addans(answer):
	ans = answer

func _draw():
	draw_rect(Rect2(Vector2(pos[0], pos[1]), Vector2(x, y)), color)
	modulate.a = 0.05
	
func select():
	if correct:
		emit_signal("correct")




