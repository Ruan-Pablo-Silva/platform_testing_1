extends CharacterBody2D

@onready var plaayer = $"." 
@onready var animated_sprite_2d = $AnimatedSprite2D
@export var SPEED: int = 350
@export var GRAVITY: int = 940 # pulls him down
const JUMP_FORCE: int = 455 # how higher player can jump 
@onready var bullet_pointer = $bulletPointer
@export var bullet_speed: int  = 1000
@onready var left_side = $left_side
@onready var right_side = $right_side

var bullet = preload("res://bullet/rigid_body_2d.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.kill_player.connect(kill_player) #it receives a signal to kill the player

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if Input.is_action_just_pressed("ui_up"):
		if is_on_floor():
			animated_sprite_2d.play("juping")
			velocity.y -= JUMP_FORCE
	
	if  !is_on_floor() and velocity.y > 0:
		animated_sprite_2d.play("falling")

	if direction != null:
		
		if direction == 1:
			animated_sprite_2d.flip_h = false
			if is_on_floor():
				animated_sprite_2d.play("running")
		elif direction == -1:
			animated_sprite_2d.flip_h = true
			if is_on_floor():
				animated_sprite_2d.play("running")
			
		
		velocity.x = direction * SPEED #which means 1 or -1 multiplied by 150, which will be 150 or -150
		move_and_slide();
		
	if Input.is_action_just_pressed("shoot"):
		var shoot_direction: int
		var positionToShoot
		if animated_sprite_2d.flip_h:
			shoot_direction = -900
			positionToShoot = left_side.global_position
		else:
			shoot_direction = 900
			positionToShoot = right_side.global_position  # Corrected variable name and indentation
		var new_bullet_on_screen = bullet.instantiate()  # Changed instantiate() to instance()
		new_bullet_on_screen.position = positionToShoot
		new_bullet_on_screen.apply_impulse(Vector2(shoot_direction, 0), Vector2(bullet_speed, 0))  # Corrected apply_impulse parameters
		new_bullet_on_screen.add_to_group("bullets")  # Ensure the bullet is added to the correct group
		get_tree().root.add_child(new_bullet_on_screen)

	else:
		velocity.x = 0
		
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		print(velocity.y)
		
		
		
func kill_player():
	set_physics_process(false)
	animated_sprite_2d.play("dying")

func _on_animated_sprite_2d_animation_finished():
	if(animated_sprite_2d.animation == "dying"):
		plaayer.get_tree().set_pause(true)
