extends CharacterBody2D


@export var SPEED = 4000.0
@export var JUMP_VELOCITY = -1200.0
@export var player_num=1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("player"+str(player_num)+"_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("player"+str(player_num)+"_left", "player"+str(player_num)+"_right")
	if direction:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.flip_h =direction==-1
		$AnimatedSprite2D.play("walking")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimatedSprite2D.play("idle")

	move_and_slide()

