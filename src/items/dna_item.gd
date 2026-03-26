class_name DNAItem
extends BaseItem

@export var dna_data: DNAData

func get_description() -> String:
	var base_info := data.description
	if dna_data:
		base_info += "\n\n%s" % dna_data.description
	if dna_data.is_processed:
		base_info += "\n\nРезультаты анализа:\nИмя: %s\nСовпадение: %.2f%%" % [dna_data.database_name, dna_data.overlap_percentage]
	return base_info
	
