extends Node3D

func _ready():
	for i in get_children():
		var point = OmniLight3D.new()
		point.light_bake_mode = Light3D.BAKE_STATIC
		point.position = i.position
		point.position.y -= 7
		add_child(point)
