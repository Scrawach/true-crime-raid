class_name KeywordRichTextInfo
extends RefCounted

var id: String
var is_clicked: bool

var start: Vector2
var end: Vector2
var color: Color

static func make_from(char_fx: CharFXTransform) -> KeywordRichTextInfo:
	var offset := KeywordRichTextInfo.new()
	offset.id = char_fx.env.get("id", "none")
	offset.start = char_fx.transform.origin
	offset.end = char_fx.transform.origin
	offset.color = char_fx.env.get("color", "red")
	return offset
	
