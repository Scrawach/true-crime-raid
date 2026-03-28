extends PanelContainer

@onready var shirma: HSeparator = $HSeparator
@onready var content: Label = $HBoxContainer/content
@onready var count: Label = $HBoxContainer/count

var l_task:Task

func listen_task(task:Task):
	if task.is_hidden or task.fail:
		hide()
	l_task = task
	content.text = task.code
	if task.required_count>0:
		count.text = str(task.count)+"/"+str(task.required_count)
	else:
		count.hide()
	if not task.is_completed:
		shirma.hide()
	task.completed.connect(shirma.show)
	task.rollbacked.connect(shirma.hide)
	task.count_changed.connect(change_count)

func change_count():
	count.text = str(l_task.count)+"/"+str(l_task.required_count)
