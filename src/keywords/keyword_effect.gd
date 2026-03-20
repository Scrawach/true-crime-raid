@tool
# Having a class name is handy for picking the effect in the Inspector.
class_name RichTextKeywordEffect
extends RichTextEffect


# To use this effect:
# - Enable BBCode on a RichTextLabel.
# - Register this effect on the label.
# - Use [keyword_effect param=2.0]hello[/keyword_effect] in text.
var bbcode := "keyword_effect"


func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	var param: float = char_fx.env.get("param", 1.0)
	char_fx.offset += Vector2.ONE
	return true
