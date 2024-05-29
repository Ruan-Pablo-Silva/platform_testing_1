extends CharacterBody2D

@onready var plaayer = $"." 
@onready var animated_sprite_2d = $AnimatedSprite2D


@export var SPEED: int = 350
@export var GRAVITY: int = 940 # pulls him down
const JUMP_FORCE: int = 455 # how higher player can jump 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if Input.is_action_just_pressed("ui_up"):
		if is_on_floor():
			velocity.y -= JUMP_FORCE
	
	if direction != null:
		
		if direction == 1:
			animated_sprite_2d.flip_h = false
		elif direction == -1:
			animated_sprite_2d.flip_h = true
		
		velocity.x = direction * SPEED #which means 1 or -1 multiplied by 150, which will be 150 or -150
		move_and_slide();
	else:
		velocity.x = 0
		
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		print(velocity.y)
