class_name CSVReader 
extends Node

static func read_all(csv_path, line_index := 0) -> Array:
	#
	var result = []
	var file = FileAccess.open(csv_path, FileAccess.READ)
	# Пропускаем указанное количество строчек
	for i in range(line_index):
		if !file.eof_reached():
			file.get_line()
	#
	while not file.eof_reached():
		var line = file.get_line().split(",")
		if line[0] != "":
			result.append(line)
	return result
