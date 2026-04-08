class_name APReport
extends AppPanel

signal report_compiled_ok

@export var notification_success:Control
@export var notification_unsuccess:Control
@export var report_check:ReportCheck

#region OLD
#@onready var apbr_felon: APButtonReciever = %apbr_felon
#@onready var apbr_motive: APButtonReciever = %apbr_motive
#
#@onready var btn_add: APButtonEvidenceReciever = %btn_add
#@onready var btn_approve: Button = %btn_approve
#endregion

@onready var btn_send: Button = %btn_send

@onready var mb_felon: MenuButton = %mb_felon
@onready var mb_motive: MenuButton = %mb_motive

@onready var vbc_evidences: VBoxContainer = %vbc_evidences

#
var expected_felon:KeywordData
var current_felon:KeywordData
var felons:Dictionary[int, KeywordData]
#
var expected_motive:KeywordData
var current_motive:KeywordData
var events:Dictionary[int, KeywordData]
#
var current_evidences:Dictionary[int, KeywordData]
var evidence_lines:Dictionary[KeywordData, EvidenceLine]
var evidences:Dictionary[int, KeywordData]

var apbr_felon_text:String
var apbr_motive_text:String

func _ready() -> void:
	mb_felon.item_count = 0
	mb_motive.item_count = 0
	apbr_felon_text = mb_felon.text
	apbr_motive_text = mb_motive.text
	GameManager.keyword_found.connect(on_keyword_found)
	mb_felon.get_popup().id_pressed.connect(on_mb_felon_id_pressed)
	mb_motive.get_popup().id_pressed.connect(on_mb_motive_id_pressed)
	btn_send.pressed.connect(on_btn_approve_pressed)

func clear_data():
	mb_felon.text = apbr_felon_text
	mb_motive.text = apbr_motive_text
	for child in vbc_evidences.get_children():
		child.queue_free()


func fill_data(ekw_felon:KeywordData, ekw_motive:KeywordData, expected_evidences:Array[KeywordData]):
	expected_felon = ekw_felon
	expected_motive = ekw_motive
	for evidence_index in range(len(expected_evidences)):
		create_evidence_line(expected_evidences[evidence_index], evidence_index)

func on_keyword_found(kw:KeywordData):
	match kw.type:
		"person":
			if kw not in felons.values():
				var index = felons.size()
				mb_felon.get_popup().add_item(kw.words, index)
				felons[index] = kw
		"event":
			if kw not in events.values():
				var index = events.size()
				mb_motive.get_popup().add_item(kw.words, index)
				events[index] = kw
		"evidence":
			if kw not in evidences.values():
				var index = evidences.size()
				for el_index in evidence_lines.keys():
					evidence_lines[el_index].button.get_popup().add_item(kw.words, index)
				evidences[index] = kw
		_:
			printerr(" to do - keyword type not registred")

func on_mb_felon_id_pressed(index:int):
	var kw = felons.get(index)
	if kw != null:
		mb_felon.text = kw.words
		current_felon = kw

func on_mb_motive_id_pressed(index:int):
	var kw = events.get(index)
	if kw != null:
		mb_motive.text = kw.words
		current_motive = kw

func on_mb_evidence_id_pressed(index:int, mb_evidence:MenuButton, el_index:int):
	var kw = evidences.get(index)
	if kw != null:
		mb_evidence.text = kw.words
		current_evidences[el_index] = kw

func on_btn_approve_pressed():
	var result = check_report()
	if result.approved:
		notification_success.show()
		report_compiled_ok.emit()
	else:
		notification_unsuccess.show()
	report_check.update_status(result)

func create_evidence_line(data:KeywordData, el_index:int):
	if data is KeywordData and data not in evidence_lines.keys():
		var el = EvidenceLine.create()
		vbc_evidences.add_child(el)
		el.label.text = str(el.get_index()+1)+"."
		el.button.get_popup().id_pressed.connect(on_mb_evidence_id_pressed.bind(el.button, el_index))
		evidence_lines[data] = el
	

func check_report() -> ReportCheckData:
	var rcd = ReportCheckData.new()
	#
	rcd.felon = current_felon
	if expected_felon != current_felon:
		rcd.felon_ok = false
		rcd.approved = false
	#
	rcd.motive = current_motive
	if expected_motive != current_motive:
		rcd.motive_ok = false
		rcd.approved = false
	# 
	for evidence in current_evidences.values():
		rcd.evidences[evidence] = true
		if evidence not in evidence_lines.keys():
			rcd.evidences[evidence] = false
	#
	for evidence in evidence_lines.keys():
		if evidence not in current_evidences.values():
			rcd.evidences_ok = false
			rcd.approved = false
			break
	return rcd
