extends CanvasLayer

signal start_game
var STARTING_MSG = "Dodge the\nCreeps!"

func _ready():
	$MessageTimer.connect("timeout", self, "_on_MessageTimer_timeout")
	$StartButton.connect("pressed", self, "_on_StartButton_pressed")
	$Message.text = STARTING_MSG


func _on_MessageTimer_timeout():
	$Message.hide()
	

func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")


func update_score(score):
	$ScoreLabel.text = str(score)


func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()


func show_game_over():
	show_message("Game Over")
	
	# Wait for timeout before continuing.
	yield($MessageTimer, "timeout")
	$Message.text = STARTING_MSG
	$Message.show()
	
	# Make temporary timer just for creating a delay before showing the button.
	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()
