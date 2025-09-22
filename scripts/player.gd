extends CharacterBody2D


const SPEED : float = 390.0
const JUMP_VELOCITY : float = -1050.0

var dead : bool = false

func _physics_process(delta: float) -> void:
	if not dead:
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta

		# Handle jump.
		if Input.is_action_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			
		print(velocity.y)
		
		$Sprite2D.rotate(velocity.y/2000)
		$Sprite2D.rotation_degrees = velocity.y/2000

		velocity.x = SPEED * delta * 100
		
		if Input.is_action_just_pressed("restart"):
			kill()
			
		if $DamageHitbox.has_overlapping_bodies():
			for i in $DamageHitbox.get_overlapping_bodies():
				if i.is_in_group("tile"):
					kill()

		move_and_slide()

func kill():
	if not dead:
		$Dead.start()
		$AudioStreamPlayer.stop()
		dead = true

func _on_dead_timeout() -> void:
	position = Vector2(32.0, 544.0)
	$AudioStreamPlayer.play()
	dead = false
