extends CharacterBody2D


const SPEED : float = 365.0
const JUMP_VELOCITY : float = -1050.0

var dead : bool = false

# Used for jumping, made with Gemini  bc I'm bad with maths
func get_closest_angle(current_angle: float, target_angles: Array) -> float:
	var closest_target_angle: float = 0.0
	var min_diff: float = INF

	for target_angle in target_angles:
		# Calculate the shortest angular difference, accounting for wrapping
		var diff = fmod(target_angle - current_angle + 180.0, 360.0) - 180.0
		var abs_diff = abs(diff)

		if abs_diff < min_diff:
			min_diff = abs_diff
			closest_target_angle = target_angle

	return closest_target_angle

func _physics_process(delta: float) -> void:
	visible = not dead
	print($Camera2D.global_position.y)
	if not dead:
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta

		# Handle jump.
		if Input.is_action_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			
		#print(velocity.y)
		
		#$Sprite2D.rotate(abs(velocity.y)/(1050*4.8))
		
		if is_on_floor():
			$Sprite2D.rotation = lerp_angle($Sprite2D.rotation, deg_to_rad(get_closest_angle($Sprite2D.rotation_degrees, [-360, -270, -180, -90, 0, 90, 180, 270, 360])), 0.2)
			if snappedi($Sprite2D.rotation, 10) % 90 == 0:
				$Sprite2D.rotation = 0
		
		else:
			$Sprite2D.rotate(deg_to_rad(6))
			
		print($Sprite2D.rotation_degrees)
			
		#$Sprite2D.rotation_degrees = velocity.y/2000

		velocity.x = SPEED * delta * 100
		
		if Input.is_action_just_pressed("restart"):
			kill()
			
		if $DamageHitbox.has_overlapping_bodies():
			for i in $DamageHitbox.get_overlapping_bodies():
				if i.is_in_group("tile"):
					kill()

		move_and_slide()
	else:
		$Sprite2D.rotation = 0

func kill():
	if not dead:
		$Dead.start()
		$AudioStreamPlayer.stop()
		dead = true

func _on_dead_timeout() -> void:
	position = Vector2(32.0, 544.0)
	$AudioStreamPlayer.play()
	dead = false
	
