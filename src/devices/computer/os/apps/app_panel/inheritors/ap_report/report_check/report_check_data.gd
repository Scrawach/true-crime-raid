class_name ReportCheckData
extends Resource

@export var approved:bool = true

@export var felon:KeywordData
@export var felon_ok:bool = true

@export var motive:KeywordData
@export var motive_ok:bool = true

@export var evidences:Dictionary[KeywordData, bool]
@export var evidences_ok:bool = true
