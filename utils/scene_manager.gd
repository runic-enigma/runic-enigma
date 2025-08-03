class_name SceneManager extends Node

signal content_finished_loading()
signal content_invalid(content_path: String)
signal content_failed_to_load(content_path: String)

var loading_screen: LoadingScreen
var _loading_screen_scene: PackedScene = preload("res://screens/loading_screen/loading_screen.tscn")
var _transition: String
var _content_path: String
var _load_progress_timer: Timer


func _ready() -> void:
	print()

func load_new_scene(content_path: String, transition_type: String = "fade_to_black") -> void:
	_transition = transition_type


	loading_screen = _loading_screen_scene.instantiate() as LoadingScreen
	get_tree().root.add_child(loading_screen)
	loading_screen.start_transition(transition_type)
	_load_content(content_path)

func _load_content(content_path: String) -> void:

	if loading_screen != null:
		await loading_screen.transition_in_complete

	_content_path = content_path
	var loader: int = ResourceLoader.load_threaded_request(content_path)
	if not ResourceLoader.exists(content_path) or loader == null:
		content_invalid.emit(content_path)
		return

	_load_progress_timer = Timer.new()
	_load_progress_timer.wait_time = 0.1
	_load_progress_timer.timeout.connect(monitor_load_status)
	get_tree().root.add_child(_load_progress_timer)
	_load_progress_timer.start()

func monitor_load_status() -> void:
	var load_progress: Array[float] = []
	var load_status: int = ResourceLoader.load_threaded_get_status(_content_path, load_progress)

	match load_status:
		ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
			content_invalid.emit(_content_path)
			_load_progress_timer.stop()
			return
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			if loading_screen != null:
				loading_screen.update_bar(load_progress[0] * 100)
		ResourceLoader.THREAD_LOAD_FAILED:
			content_failed_to_load.emit(_content_path)
			_load_progress_timer.stop()
			return
		ResourceLoader.THREAD_LOAD_LOADED:
			_load_progress_timer.stop()
			_load_progress_timer.queue_free()
			content_finished_loading.emit((ResourceLoader.load_threaded_get(_content_path) as PackedScene).instantiate())
			return



func on_content_failed_to_load(path: String) -> void:
	printerr("error: Cannot load content: '%s'" % [path])

func on_content_invalid(path: String) -> void:
	printerr("error: Cannot load content: '%s'" % [path])

func on_content_finished_loading(content: Node) -> void:
	var outgoing_scene: Node = get_tree().current_scene

	var incoming_data: String
	if get_tree().current_scene is Level:
		incoming_data = (get_tree().current_scene as Level).data

	if content is Level:
		(content as Level).data = incoming_data

	outgoing_scene.queue_free()

	get_tree().root.call_deferred("add_child", content)
	get_tree().set_deferred("current_scene", content)

	if loading_screen != null:
		loading_screen.finish_transition()

		if content is Level:
			print()
			# Set all the things

		await loading_screen.anim_player.animation_finished
		loading_screen = null

		if content is Level:
			(content as Level).enter_level()


	

