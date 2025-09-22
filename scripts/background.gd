extends CanvasLayer

@onready var texture : TextureRect = $Texture

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture.position.x = 0
	texture.position.y = -568.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_tree().get_first_node_in_group("player"):
		if not get_tree().get_first_node_in_group("player").dead:
			texture.position.y = lerpf(texture.position.y, -568, 0.2)
			texture.position.x -= delta * 33
			if texture.position.x < -1217.0:
				texture.position.x = 0
				texture.position.y += 2
