class_name Draw3D

static func line(from: Vector3, to: Vector3, color: Color, parent: Node, thickness := 0.05) -> MeshInstance3D:
	var instance := MeshInstance3D.new()
	var mesh := CylinderMesh.new()
	var material := StandardMaterial3D.new()

	var dir := to - from
	var len := dir.length()
	if len == 0.0:
		return instance

	mesh.top_radius = thickness
	mesh.bottom_radius = thickness
	mesh.height = len
	mesh.radial_segments = 8

	instance.mesh = mesh
	instance.material_override = material

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = color
	
	parent.add_child(instance)
	var mid := (from + to) * 0.5
	instance.global_transform.origin = mid
	instance.look_at(to)
	instance.rotate_object_local(Vector3.RIGHT, deg_to_rad(90))

	return instance
