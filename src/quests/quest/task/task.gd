class_name Task extends Resource

signal completed
signal rollbacked
signal count_changed

var objective
var code 
var count 
var required_count 
var link 
var fail:bool = false
var is_hidden:bool
var vovl_index:String
var is_completed = false

static func create_task(data:Array):
	var t = null
	if data[0] == "link":
		t = Task.new()
		t.link = data[1]
	if data[0] == "extra":
		t = Task.new()
		t.link = "extra"
	if data[0] == "fail":
		t = Task.new()
		t.link = data[1]
		t.fail = true
	if t!= null:
		t.objective = data[2]
		t.code = data[3]
		t.count = int(data[4])
		t.required_count = t.count
		t.is_hidden = data[5] != ""
		t.vovl_index = data[6]
	return t

func _to_string() -> String:
	return str([objective, code, count, link, fail, is_hidden, str(vovl_index)])

# Метод который выполняет поставленную задачу и сообщает была ли она выполнена полностью
func perform(p_count:int = 1) -> bool:
	# Если уже выполнена, то исполнения не произошло
	if is_completed:
		return false
	if count > 0:
		# Если нужно выполнить несколько раз (НЕ РАБОТАЕТ ДЛЯ СБОРА ПРЕДМЕТОВ, КОТОРЫХ МОЖНО ЛИШИТЬСЯ)
		count -= p_count
		count_changed.emit()
	is_completed = count <= 0
	if is_completed:
		if vovl_index != "":
			pass
			#RPS.edit_variable(variable, operand, value)
		completed.emit()
	return is_completed

# Откатываем задание назад, на шаг или на сколько нужно
func rollback(b_count:int = 1):
	if not fail:
		if is_completed != false:
			is_completed = false
			rollbacked.emit()
		if required_count != 0 and count != required_count:
			count = clamp(count+b_count, 0,required_count)
			count_changed.emit()

func reset():
	is_completed = false
	count = required_count
