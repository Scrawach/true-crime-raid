class_name APReport
extends AppPanel

signal report_compiled_ok

@export var notification_success:Control
@export var notification_unsuccess:Control

@onready var apbr_felon: APButtonReciever = %apbr_felon
@onready var apbr_motive: APButtonReciever = %apbr_motive
@onready var vbc_evidences: VBoxContainer = %vbc_evidences
@onready var btn_add: APButtonEvidenceReciever = %btn_add
@onready var btn_approve: Button = %btn_approve

var expected_evidences:Array[KeywordData]
var current_evidence_lines:Dictionary[KeywordData, EvidenceLine]

var apbr_felon_text:String
var apbr_motive_text:String

func _ready() -> void:
	super._ready()
	btn_approve.pressed.connect(on_btn_approve_pressed)
	btn_add.data_dropped.connect(on_btn_add_data_dropped)
	apbr_felon_text = apbr_felon.text
	apbr_motive_text = apbr_motive.text

func clear_data():
	#
	apbr_felon.expected_keyword = null
	apbr_felon.text = apbr_felon_text
	apbr_motive.expected_keyword = null
	apbr_motive.text = apbr_motive_text
	#
	for child in vbc_evidences.get_children():
		child.queue_free()


func fill_data(ekw_felon:KeywordData, ekw_motive:KeywordData, _expected_evidences:Array[KeywordData]):
	apbr_felon.expected_keyword = ekw_felon
	apbr_motive.expected_keyword = ekw_motive
	expected_evidences = _expected_evidences

func on_btn_approve_pressed():
	if check_report():
		notification_success.show()
		report_compiled_ok.emit()
	else:
		notification_unsuccess.show()

func on_btn_add_data_dropped(data):
	var el = EvidenceLine.create()
	vbc_evidences.add_child(el)
	el.label.text = data.words
	el.button.pressed.connect(delete_evidence_line.bind(data))
	current_evidence_lines[data] = el
	
func delete_evidence_line(kw:KeywordData):
	current_evidence_lines[kw].queue_free()
	current_evidence_lines.erase(kw)

func check_report():
	if apbr_felon.expected_keyword != apbr_felon.current_keyword:
		return false
	if apbr_motive.expected_keyword != apbr_motive.current_keyword:
		return false
	for evidence in current_evidence_lines.keys():
		if evidence not in expected_evidences:
			return false
	for evidence in expected_evidences:
		if evidence not in current_evidence_lines.keys():
			return false
	return true
