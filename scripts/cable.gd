extends MeshInstance3D

func _process(delta: float) -> void:
	mesh.clear_surfaces()
	
	mesh.surface_begin(Mesh.PRIMITIVE_LINES)
	
	mesh.surface_add_vertex(position)
	mesh.surface_add_vertex($"../../PinJoint3D".position)
	
	mesh.surface_end()
