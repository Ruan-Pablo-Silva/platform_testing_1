extends StaticBody2D
@onready var right_flaying_floor = $"."
@onready var sprite_2d = $Sprite2D
@onready var collision_shape_2d = $CollisionShape2D
@onready var visible_on_screen_notifier_2d = $VisibleOnScreenNotifier2D
@onready var area_2d = $Area2D
@onready var collision_shape_of_area_2d = $Area2D/CollisionShapeOfArea2d


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position.x += 290 * delta


func _on_area_2d_body_entered(body):
	if body.is_in_group("bullet"):
		queue_free()
	elif body.is_in_group("plaayer"):
		SignalManager.kill_player.emit()
