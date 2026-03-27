class_name Scenario
extends Resource

@export var title := "No name"
# Персонажи
@export var felon:KeywordData
@export var personas:Array[KeywordData]
# Мотивы
@export var motive:KeywordData
@export var events:Array[KeywordData]
# Улики
@export var evidences:Array[DNACluster]
@export var objects:Array[DNACluster]


func extract_keywords() -> Array[KeywordData]:
	var data:Array[KeywordData]
	data.append(felon)
	data.append_array(personas)
	data.append(motive)
	data.append_array(events)
	data.append_array(evidences.map(func(cluster:DNACluster):return cluster.evidence))
	data.append_array(objects.map(func(cluster:DNACluster):return cluster.evidence))
	return data

func cluster_to_kw(arr:Array[DNACluster]) -> Array[KeywordData]:
	var kw_arr:Array[KeywordData]
	for cl in arr:
		kw_arr.append(cl.evidence)
	return kw_arr

func extract_dna_data():
	var dna:Array[DNAData]
	for ev in evidences:
		dna.append_array(ev.dna_markers)
	for ob in objects:
		dna.append_array(ob.dna_markers)
	return dna
		
