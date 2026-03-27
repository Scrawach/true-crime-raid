class_name InspectTooltipPanel
extends PanelContainer

@onready var dna_count_label: Label = %"DNA Count Label"
@onready var keywords_panel: KeywordsPanel = %"Keywords Panel"

func initialize(item: BaseItem) -> void:
	show()

func clear() -> void:
	hide()
