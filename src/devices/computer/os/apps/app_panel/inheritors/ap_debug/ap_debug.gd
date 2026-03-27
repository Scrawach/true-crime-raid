class_name APDebug
extends AppPanel

signal start_scenario(scenario:Scenario)

@onready var hfc_kw: HFlowContainer = %hfc_kw
@onready var hfc_scenario: HFlowContainer = %hfc_scenario
@onready var hfc_dna: HFlowContainer = %hfc_dna


func fill_container(kws:Array[KeywordData]):
	for child in hfc_kw.get_children():
		child.queue_free()
	
	for kw in kws:
		if kw != null:
			var btn = Button.new()
			btn.text = kw.words
			btn.pressed.connect(GameManager.keyword_found.emit.bind(kw))
			hfc_kw.add_child(btn)

func fill_dna(dna:Array[DNAData]):
	for child in hfc_dna.get_children():
		child.queue_free()
	
	for dna_data in dna:
		if dna_data != null:
			var btn = Button.new()
			btn.text = dna_data.id
			btn.pressed.connect(GameManager.dna_investigated.emit.bind(dna_data))
			hfc_dna.add_child(btn)
	

func fill_scenarios_list(scenarios:Array[Scenario]):
	for child in hfc_scenario.get_children():
		child.queue_free()
	
	for scenario in scenarios:
		var btn = Button.new()
		btn.text = scenario.title
		btn.pressed.connect(start_scenario.emit.bind(scenario))
		hfc_scenario.add_child(btn)
