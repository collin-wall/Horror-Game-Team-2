extends MultiMeshInstance3D


func _ready():
	var s_body = StaticBody3D.new()
	
	for index in multimesh.instance_count:
		var mesh_tran = multimesh.get_instance_transform(index)
		var shape = CollisionShape3D.new()
		var shape_mesh = CylinderMesh.new()
		
		shape.shape = shape_mesh.create_trimesh_shape()
		
		shape.transform.origin.x = mesh_tran.origin.x
		shape.transform.origin.z = mesh_tran.origin.z
		shape.transform.origin.y = mesh_tran.origin.y
		
		shape.scale = Vector3(0.25,1,0.25)
		
		s_body.add_child(shape)
		
	add_child(s_body)
