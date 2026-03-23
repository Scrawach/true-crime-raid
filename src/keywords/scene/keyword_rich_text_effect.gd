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

func clear() -> void:
	clicked_keywords.clear()
	hovered_keywords.clear()

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
	var id: String = char_fx.env.get("id", "")
	
	if clicked_keywords.has(id):
		char_fx.color = clicked_color
	elif hovered_keywords.has(id):
		char_fx.color = hover_color
	else:
		char_fx.color = normal_color
	
	return true
