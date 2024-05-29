extends Node2D

@onready var static_body_2d = $StaticBody2D
@onready var static_body_2d_2 = $StaticBody2D2
@onready var static_body_2d_3 = $StaticBody2D3
@onready var plaayer = $plaayer
@onready var left_down_marker = $"left-down-Marker"
@onready var left_upper_marker = $"left-upper-Marker"
@onready var right_upper_marker = $"right-upper-Marker"
@onready var right_down_marker = $"right-down-Marker"
@onready var wall_1 = $wall1
@onready var collision_shape_wall_1 = $wall1/CollisionShapeWall1
@onready var wall_2 = $wall2
@onready var collision_shape_wall_2 = $wall2/CollisionShapeWall2

@export var packedBLockLeft: PackedScene #goes left
@export var packedBlockRight: PackedScene #goes right
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var leftToRightBlocks = packedBlockRight.instantiate()
	var y_left_to_right_spawn_position = randf_range(left_upper_marker.position.y, left_down_marker.position.y )
	leftToRightBlocks.position = Vector2(left_down_marker.position.x, y_left_to_right_spawn_position)
	add_child(leftToRightBlocks)
