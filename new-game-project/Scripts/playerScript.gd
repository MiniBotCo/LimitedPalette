extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -600.0
var time_last_pressed = 0 #gonna use for coyote time for jump
var time_now_pressed = 0 #gonna use for coyote time for jump

var can_increase_height = true


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		$PlayerSprite.animation = "InAir"
	else:
		can_increase_height = true

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		$PlayerSprite.play("Jump")
		#$PlayerSprite.scale = Vector2(0.7, 1.3)
		velocity.y = JUMP_VELOCITY
		$JumpHeightTimer.start()
		
	if Input.is_action_just_released("jump") and can_increase_height:
		velocity.y *= 0.4 #The longer you hold for jump, the higher you go

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if velocity.x != 0 and is_on_floor():
		$PlayerSprite.animation = "Walk"
	elif is_on_floor():
		$PlayerSprite.animation = "Idle"
	
	if velocity.x > 0:
		$PlayerSprite.flip_h = false
	elif velocity.x < 0:
		$PlayerSprite.flip_h = true
		$RayCast2D.target_position = Vector2i(-256, 0)
		
	
	move_and_slide()
	
	#$PlayerSprite.x = move_toward($PlayerSprite.scale.x, 1, 1 * delta)
	#$PlayerSprite.y = move_toward($PlayerSprite.scale.y, 1, 1 * delta)

func _on_jump_height_timer_timeout() -> void:
	can_increase_height = false
