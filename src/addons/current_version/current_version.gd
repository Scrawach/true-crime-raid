class_name CurrentVersion

const PATH_TO_DATA: String = "res://addons/current_version/version.json"

static var _date_line: String
static var _time_line: String
static var _version_line: String

static func _static_init() -> void:
	_load_from_file(PATH_TO_DATA)

## YYYY-MM-DD HH:MM:SS format
static func get_datetime_string() -> String:
	return get_date_string() + " " + get_time_string()

static func get_date_string() -> String:
	return _date_line

static func get_time_string() -> String:
	return _time_line

## MAJOR.MINOR.PATCH format
## Where PATCH is commit number
static func get_version_string() -> String:
	return _version_line

static func _load_from_file(path: String) -> void:
	if not FileAccess.file_exists(path):
		return
	
	var raw_string := FileAccess.get_file_as_string(path)
	var json := JSON.parse_string(raw_string)
	
	if json == null:
		return
	
	_date_line = json["Date"]
	_time_line = json["Time"]
	_version_line = json["Version"]

static func _save_to_file(next_version: String) -> int:
	var version_data := {
		"Date": Time.get_date_string_from_system(true),
		"Time": Time.get_time_string_from_system(true),
		"Version": next_version
	}
	
	if not FileAccess.file_exists(PATH_TO_DATA):
		return ERR_BUG
	
	var access := FileAccess.open(PATH_TO_DATA, FileAccess.WRITE)
	var is_success := access.store_string(JSON.stringify(version_data) + "\n")
	access.close()
	return OK
