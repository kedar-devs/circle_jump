extends CanvasLayer
func show_message(text):
	$Message.text=text
	$AnimationPlayer.play("show_message")
func _ready():
	$Message.rect_pivot_offset=$Message.rect_size/2
func hide():
	$ScoreBox.hide()
func show():
	$ScoreBox.show()
	$ScoreBox/HBoxContainer.show()
func update_score(value):
	$ScoreBox/HBoxContainer/Score.text=str(value)
	
