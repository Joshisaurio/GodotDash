extends StaticBody2D

@export var texture : String = "ground1"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Texture.texture = load("res://atlas/tiles/" + texture + ".tres")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
