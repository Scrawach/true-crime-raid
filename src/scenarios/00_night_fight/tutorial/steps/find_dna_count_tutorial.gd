class_name FindDNACountTutorial
extends QuestSubstageData

@export var target_count: int

var found_count: int

func start() -> void:
	GameManager.dna_investigated.connect(_on_dna_investigated)

func _on_dna_investigated(_dna: DNAData) -> void:
	found_count += 1
	
	update()
	
	if found_count >= target_count:
		finish()

func stop() -> void:
	GameManager.dna_investigated.disconnect(_on_dna_investigated)

func get_result_string() -> String:
	return "%s / %s" % [found_count, target_count]

static func create(description: String, target: int) -> FindDNACountTutorial:
	var data := FindDNACountTutorial.new()
	data.name = description
	data.target_count = target
	return data
