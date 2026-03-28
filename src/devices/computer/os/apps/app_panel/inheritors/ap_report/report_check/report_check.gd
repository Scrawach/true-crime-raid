class_name ReportCheck
extends VBoxContainer

@export var evidence_line:PackedScene

@onready var tr_felon_not_ok: TextureRect = %tr_felon_not_ok
@onready var lbl_felon: Label = %lbl_felon

@onready var tr_motive_not_ok: TextureRect = %tr_motive_not_ok
@onready var lbl_motive: Label = %lbl_motive

@onready var vbc_evidences: VBoxContainer = %vbc_evidences
@onready var lbl_evidences_not_ok: Label = %lbl_evidences_not_ok

@onready var lbl_result: Label = %lbl_result
@onready var tr_approve: TextureRect = %tr_approve
@onready var tr_reject: TextureRect = %tr_reject



func update_status(data:ReportCheckData):
	show()
	#
	for child in vbc_evidences.get_children():
		child.queue_free()
	for ek in data.evidences.keys():
		var rcel = RCEvidenceLine.create()
		vbc_evidences.add_child(rcel)
		rcel.texture_rect.visible = !data.evidences[ek]
		rcel.label.text = ek.words
	#
	if data.felon != null:
		lbl_felon.text = data.felon.words
		tr_felon_not_ok.visible = !data.felon_ok
	else:
		tr_felon_not_ok.visible = true
	#
	if data.motive != null:
		lbl_motive.text = data.motive.words
		tr_motive_not_ok.visible = !data.motive_ok
	else:
		tr_motive_not_ok.visible = true
	#
	lbl_evidences_not_ok.visible = !data.evidences_ok
	tr_approve.visible = data.approved
	tr_reject.visible = !data.approved
	#
	if data.approved:
		lbl_result.text = "Рапорт принят!"
	else:
		lbl_result.text = "Отказать в пересмотре дела"
		
