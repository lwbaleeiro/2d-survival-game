extends CharacterBody2D

@onready var last_direction = "front"
@onready var player_sprite = $player_sprite
@onready var is_attacking = false
@onready var timer = $Timer

func _physics_process(delta):
	
	if not is_attacking:
		var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		velocity = direction * (100 + delta)

		if direction.x < 0:
			player_sprite.play("left_walk")
			last_direction = "left"
		elif direction.x > 0:
			player_sprite.play("right_walk")
			last_direction = "right"
		elif direction.y < 0:
			player_sprite.play("back_walk")
			last_direction = "back"
		elif direction.y > 0:
			player_sprite.play("front_walk")
			last_direction = "front"
		else:
			player_sprite.play(last_direction + "_idle")
			
		move_and_slide()

func _input(event):
	if Input.is_action_pressed("attack") and not is_attacking:
		timer.start(0.5)
		is_attacking = true
		player_sprite.play(last_direction + "_attack")

func _on_timer_timeout():
	is_attacking = false
