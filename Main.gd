extends Node

export(PackedScene) var mob_scene
var score

func _ready():
	# If player was hit, then it's game over.
	$Player.connect("hit", self, "game_over")
	$HUD.connect("start_game", self, "new_game")
	
	# StartTimer controls when the game starts
	# ScoreTimer when the score is counted.
	# MobTimer the timer for when more enemies spawn.
	$StartTimer.connect("timeout", self, "start_game_instance")
	$ScoreTimer.connect("timeout", self, "add_score")
	$MobTimer.connect("timeout", self, "spawn_mob")
	randomize()


func game_over():
	$DeathSound.play()
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$BackgroundSong.stop()


func new_game():
	# Clears up any remaining mob before starting the game.
	get_tree().call_group("mobs", "queue_free")
	
	score = 0
	$BackgroundSong.play()
	$Player.start($StartingPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")

	
	
func start_game_instance():
	$MobTimer.start()
	$ScoreTimer.start()
	
	
func add_score():
	score += 1
	$HUD.update_score(score)


func spawn_mob():
	$MobPath/MobSpawnLocation.offset = randi()
	
	var mob = mob_scene.instance()
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2 + rand_range(-PI / 4, PI / 4)
	
	mob.position = $MobPath/MobSpawnLocation.position
	mob.rotation = direction
	
	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)
