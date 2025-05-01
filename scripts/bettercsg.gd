extends StaticBody3D

func _ready() -> void:
	$CSGCombiner3D.visible = false
	for i in $CSGCombiner3D.get_children():
		var col = CollisionShape3D.new()
		var mes = MeshInstance3D.new()
		if i is CSGBox3D:
			col.shape = BoxShape3D.new()
			col.shape.size = Vector3(max(0.5, round(i.size.x * 2.0) * 0.5), max(0.5, round(i.size.y * 2.0) * 0.5), max(0.5, round(i.size.z * 2.0) * 0.5))
			mes.mesh = BoxMesh.new()
			mes.mesh.size = Vector3(max(0.5, round(i.size.x * 2.0) * 0.5), max(0.5, round(i.size.y * 2.0) * 0.5), max(0.5, round(i.size.z * 2.0) * 0.5))
		if i is CSGCylinder3D:
			col.shape = CylinderShape3D.new()
			col.shape.height = i.height
			col.shape.radius = i.radius
			mes.mesh = CylinderMesh.new()
			mes.mesh.top_radius = i.radius
			mes.mesh.bottom_radius = i.radius
			mes.mesh.height = i.height
			mes.mesh.radial_segments = i.sides
		mes.position = Vector3(round(i.position.x * 2.0) * 0.5, round(i.position.y * 2.0) * 0.5, round(i.position.z * 2.0) * 0.5)
		mes.rotation = i.rotation
		mes.scale = i.scale
		mes.mesh.material = i.material
		col.position = Vector3(round(i.position.x * 2.0) * 0.5, round(i.position.y * 2.0) * 0.5, round(i.position.z * 2.0) * 0.5)
		col.rotation = i.rotation
		col.scale = i.scale
		add_child(col)
		add_child(mes)
