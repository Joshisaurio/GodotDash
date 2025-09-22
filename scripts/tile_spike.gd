extends Area2D

@export var texture : String = "spike1"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Texture.texture = load("res://atlas/tiles/" + texture + ".tres")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if has_overlapping_bodies():
		for i in get_overlapping_bodies():
			if i.is_in_group("player"):
				i.kill()
