extends Area2D

@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.
var velocity = Vector2()
var sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	sprite = $AnimatedSprite2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_player(delta)

@warning_ignore("unused_parameter")
func move_player(delta):
	# Handle input and calculate velocity
	velocity = Vector2()

	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	
	if velocity.x != 0: # If moving horizontally
		sprite.play("walk")
		# Flip the sprite horizontally if moving left
		sprite.flip_h = velocity.x < 0
	else:
		sprite.play("idle")

	# Normalize the velocity vector if moving diagonally
	if velocity.length() > 0:
		velocity = velocity.normalized()

	# Move the player
	translate(velocity)
