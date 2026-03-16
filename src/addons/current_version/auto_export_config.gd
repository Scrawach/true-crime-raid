extends "res://addons/AutoExportVersion/VersionProvider.gd"

func get_version(features: PackedStringArray, is_debug: bool, path: String, flags: int) -> String:
	var version := format_version_line(get_git_previous_tag(), get_git_commit_count())
	update_version_file(version)
	return "v" + version

func get_git_previous_tag() -> String:
	const DEFAULT_TAG := "0.0"
	
	var output: Array = []
	OS.execute("git", PackedStringArray(["tag", "--sort=-creatordate"]), output)
	if output.is_empty() or output[0].is_empty():
		return DEFAULT_TAG
	
	var result: String = output[0]
	var last_tag := result.split('\n')[0]
	if last_tag.is_empty():
		return DEFAULT_TAG
	return last_tag

func format_version_line(previous_tag: String, patch_version: String) -> String:
	return "%s.%s" % [previous_tag, patch_version]

func update_version_file(next_version: String) -> void:
	var error := CurrentVersion._save_to_file(next_version)
	if error != OK:
		push_error("Failed to update version file!")
