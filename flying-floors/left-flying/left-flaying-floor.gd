extends StaticBody2D

@onready var left_flaying_floor = $"."
@onready var sprite_2d = $Sprite2D
@onready var collision_shape_2d = $CollisionShape2D
@onready var area_2d = $Area2D
@onready var collision_shape_of_aread_2d = $Area2D/CollisionShapeOfAread2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position.x -= 290 * delta


func _on_some_body2d_has_entered_area2d(body):
	print(body)
	if body.is_in_group("bullet"):
		queue_free()
	elif body.is_in_group("plaayer"):
		SignalManager.kill_player.emit()
