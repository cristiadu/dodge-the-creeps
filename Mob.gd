extends RigidBody2D

func _ready():
	$VisibilityNotifier2D.connect("screen_exited", self, "_on_VisibilityNotifier2d_screen_exited")	
	
	var mob_types = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.playing = true
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]

func _on_VisibilityNotifier2d_screen_exited():
	queue_free()
