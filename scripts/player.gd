extends CharacterBody3D

const SPEED = 5.0
const MOUSE_SENSITIVITY = 0.5;

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		if $Camera3D/RayCast3D.is_colliding() and $Camera3D/RayCast3D.get_collider().get_meta("content") != null:
			$Control.visible = true
			$Control/RichTextLabel.text = $Camera3D/RayCast3D.get_collider().get_meta("content")
	if Input.is_action_just_pressed("zoom"):
		var tween := create_tween()
		tween.tween_property($Camera3D, "fov", 30, 0.25)
	if Input.is_action_just_released("zoom"):
		var tween := create_tween()
		tween.tween_property($Camera3D, "fov", 90, 0.25)
	#if event.is_action("exit"):
		#get_tree().quit()
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * MOUSE_SENSITIVITY;
		$Camera3D.rotation_degrees.x -= event.relative.y * MOUSE_SENSITIVITY;
		$Camera3D.rotation_degrees.x = clampf($Camera3D.rotation_degrees.x, -90.0, 90.0)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		$Control.visible = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
