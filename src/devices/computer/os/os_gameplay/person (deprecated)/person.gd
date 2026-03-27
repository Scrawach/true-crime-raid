class_name Person
extends Resource

@export var id := "NO_ID"
@export var first_name := "NO_FIRST_NAME"
@export var last_name := "NO_LAST_NAME"
@export var sex := "NO_SEX"
@export var blood := "NO_BLOOD"
@export var age := "NO_AGE"
@export var evidences :Array[String]

# Данные для генерации - заменить на csv
static var data = [
		["James","Carter","I Rh−","Male",23],
		["Emily","Johnson","I Rh+","Female",32],
		["Michael","Anderson","II Rh−","Male",12],
		["Olivia","Brown","II Rh+","Female",26],
		["Daniel","Miller","III Rh−","Male",19],
		["Sophia","Davis","III Rh+","Female",37],
		["William","Wilson","IV Rh−","Male",42],
		["Ava","Taylor","IV Rh+","Female",65],
	]

static var letters := "abcdefghijklmnopqrstuvwxyz"

static var markers := [
	"blood_stain",
	"fingerprint",
	"hair_strand",
	"saliva_trace",
	"skin_cells",
	"semen_sample",
	"sweat_residue",
	"tooth",
	"bone_fragment",
	"nail_clipping",
	"cigarette_butt",
	"chewing_gum",
	"drinking_glass",
	"utensil_handle",
	"door_handle",
	"weapon_grip",
	"clothing_fiber",
	"mask_inner",
	"bandage",
	"tissue_paper",
	"earwax",
	"bite_mark",
	"lipstick_trace",
	"footprint_blood"
]

static func create(
	_id: String,
	_first_name: String,
	_last_name: String,
	_sex: String,
	_blood: String,
	_age: String, 
	_evidences:Array[String]
) -> Person:
	var instance = Person.new()
	instance.id = _id
	instance.first_name = _first_name
	instance.last_name = _last_name
	instance.sex = _sex
	instance.blood = _blood
	instance.age = _age
	instance.evidences = _evidences
	return instance


static func generate(count: int) -> Array[Person]:
	var result: Array[Person] = []
	var used_ids := []

	data.shuffle()

	count = min(count, data.size())

	var evidences_pool: Array[String] = markers.duplicate()
	evidences_pool.shuffle()
	
	for i in count:
		var row = data[i]
		# Генерация случайного id
		var _id := ""
		while true:
			_id = letters[randi() % letters.length()] + str(randi() % 10) + str(randi() % 10)
			if not used_ids.has(_id):
				used_ids.append(_id)
				break
		#Генерация улик
		var _evidences: Array[String] = []
		for j in range(3):
			if evidences_pool.is_empty():
				break
			_evidences.append(evidences_pool.pop_back())	
		#
		result.append(Person.create(
			_id, row[0], row[1], row[3], row[2], str(row[4]), _evidences
		))

	return result
