class_name FindDNACountTutorial
extends QuestSubstageData

@export var target_count: int

var dna_analyzer: Node3D
var marker: TutorialMarker

var invesitaged_dna: Array[DNAData]

func start() -> void:
	GameManager.dna_investigated.connect(_on_dna_investigated)

func activate() -> void:
	super.activate()
	marker.follow(dna_analyzer, "ДНК-анализатор")

func finish() -> void:
	marker.hide()
	super.finish()

func _on_dna_investigated(dna: DNAData) -> void:
	if dna in invesitaged_dna:
		return
	
	invesitaged_dna.append(dna)
	
	update()
	
	if  get_found_count() >= target_count:
		finish()

func get_found_count() -> int:
	return invesitaged_dna.size()

func stop() -> void:
	GameManager.dna_investigated.disconnect(_on_dna_investigated)

func get_result_string() -> String:
	return "%s / %s" % [ get_found_count(), target_count]

static func create(description: String, target: int, analyzer: Node3D, tutorial_marker: TutorialMarker) -> FindDNACountTutorial:
	var data := FindDNACountTutorial.new()
	data.name = description
	data.target_count = target
	data.dna_analyzer = analyzer
	data.marker = tutorial_marker
	return data
