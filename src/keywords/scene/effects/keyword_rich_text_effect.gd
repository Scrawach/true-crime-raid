@tool
# Having a class name is handy for picking the effect in the Inspector.
class_name KeywordRichTextEffect
extends RichTextEffect


# To use this effect:
# - Enable BBCode on a RichTextLabel.
# - Register this effect on the label.
# - Use [keyword id="00"]hello[/keyword] in text.
var bbcode := "keyword"

var normal_color: Color
var hover_color: Color
var clicked_color: Color

var clicked_keywords: Array[String]
var hovered_keywords: Array[String]

var last_start_range: int = -1
var last_relative_index: int = -1
var offsets: Array[KeywordRichTextInfo]
var current_offset: int = -1

var font_size: int = 16

func clear() -> void:
	clicked_keywords.clear()
	hovered_keywords.clear()
	offsets.clear()

func click(id: String) -> void:
	if clicked_keywords.has(id):
		return
	clicked_keywords.append(id)

func hover(id: String) -> void:
	if hovered_keywords.has(id):
		return
	hovered_keywords.append(id)

func unhover(id: String) -> void:
	hovered_keywords.erase(id)

func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	_process_custom_clicks_fx(char_fx)
	_process_custom_underline_fx(char_fx)
	return true

func _process_custom_clicks_fx(char_fx: CharFXTransform) -> void:
	var id: String = char_fx.env.get("id", "")
	if clicked_keywords.has(id):
		char_fx.color = clicked_color
	elif hovered_keywords.has(id):
		char_fx.color = hover_color
	else:
		char_fx.color = normal_color

func _process_custom_underline_fx(char_fx: CharFXTransform) -> void:
	var start_range := char_fx.range.x
	var relative_index := char_fx.relative_index
	
	if last_start_range > start_range:
		offsets.clear()
		current_offset = -1
	
	if relative_index == 0:
		var info := KeywordRichTextInfo.make_from(char_fx)
		if clicked_keywords.has(info.id):
			info.is_clicked = true
		if hovered_keywords.has(info.id):
			info.color = hover_color
		else:
			info.color = normal_color
		offsets.append(info)
		current_offset = offsets.size() - 1
		last_relative_index = -1
	elif last_relative_index <= relative_index:
		offsets[current_offset].end = char_fx.transform.origin + Vector2(get_glyph_width(char_fx), 0)
	last_start_range = start_range
	last_relative_index = relative_index

func get_glyph_width(char_fx: CharFXTransform) -> float:
	var server: TextServer = TextServerManager.get_primary_interface()
	return server.font_get_glyph_advance(char_fx.font, font_size, char_fx.glyph_index).x
