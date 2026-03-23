class_name BBCodeParser

static func get_all(code: String, text: String) -> Array[Dictionary]:
	var found: Array[Dictionary]
	var pos := 0
	while pos < text.length():
		if text[pos] != "[":
			pos += 1
			continue
		
		var end_code_pos := text.find("]", pos)
		if end_code_pos == -1:
			break
		
		var header := text.substr(pos + 1, end_code_pos - pos - 1).strip_edges()
		if header.begins_with("/"):
			pos = end_code_pos + 1
			continue
		
		var code_name: String
		var attributes_raw: String
		var space_pos := header.find(" ")
		if space_pos == -1:
			code_name = header
		else:
			code_name = header.substr(0, space_pos)
			attributes_raw = header.substr(space_pos + 1)
		
		if code_name != code:
			pos = end_code_pos + 1
			continue
		
		var close_code := "[/%s]" % code_name
		var close_pos := text.find(close_code, end_code_pos + 1)
		if close_pos == -1:
			break
		
		var content := text.substr(end_code_pos + 1, close_pos - end_code_pos - 1)
		var data := {"code": code_name, "text": content}
		data.merge(parse_attributes(attributes_raw))
		found.append(data)
		pos = close_pos + close_code.length()
		
	return found

static func parse_attributes(line: String) -> Dictionary:
	var attributes := { }
	var pos := 0
	
	while pos < line.length():
		while pos < line.length() and line[pos] == " ":
			pos += 1
		if pos >= line.length():
			break
		
		var equal_pos := line.find("=", pos)
		if equal_pos == -1:
			break
		
		var key := line.substr(pos, equal_pos - pos).strip_edges()
		pos = equal_pos + 1
		
		var value: String
		if pos < line.length() and line[pos] == '"':
			pos += 1
			var end := line.find('"', pos)
			if end == -1:
				value = line.substr(pos)
				pos = line.length()
			else:
				value = line.substr(pos, end - pos)
				pos = end + 1
		else:
			var next_space := line.find(" ", pos)
			if next_space == -1:
				value = line.substr(pos)
				pos = line.length()
			else:
				value = line.substr(pos, next_space - pos)
				pos = next_space + 1
		
		attributes[key] = value
	return attributes
