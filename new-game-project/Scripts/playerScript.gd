extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -600.0
var prevVelocity: Vector2 = Vector2.ZERO #Tried to implement air friction
var time_last_pressed = 0 #gonna use for coyote time for jump
var time_now_pressed = 0 #gonna use for coyote time for jump





func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if Input.is_action_just_released("ui_accept"):
		velocity.y *= 0.4 #The longer you hold W for jump, the higher you go

	if not is_on_floor():
		velocity.x = lerp(prevVelocity.x, velocity.x, 1) 

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	
	move_and_slide()
	