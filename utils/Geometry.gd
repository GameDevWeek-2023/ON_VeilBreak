static func project_on_plane(vec : Vector3, normal : Vector3) -> Vector3:
	var onto_normal = vec.project(normal);
	return vec - onto_normal;
	
