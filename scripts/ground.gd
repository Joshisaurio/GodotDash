extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.y = 576.0
	position.x = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_tree().get_first_node_in_group("player"):
		position.x = get_tree().get_first_node_in_group("player").position.x
