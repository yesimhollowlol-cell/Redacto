extends Node2D
@onready var text_display = $"../text"
@onready var redact_prompt = $"../redaction_popup/Window"
@onready var unwanted = $"../redaction_popup/Window/redacted text"
@onready var replacement = $"../redaction_popup/Window/redaction text"


func load_from_file():
	var file = FileAccess.open(Globals.path, FileAccess.READ)
	var content = file.get_as_text()
	return content

func save_to_file():
	var file = FileAccess.open(Globals.path, FileAccess.WRITE)
	if not Globals.path.is_empty():
		file.store_string(Globals.redacted_text)

func _on_file_dialog_file_selected(path: String) -> void:
	Globals.path = path
	Globals.unredacted_text = load_from_file()
	text_display.text = Globals.unredacted_text


func _on_redact_pressed() -> void:
	if redact_prompt.visible == true:
		redact_prompt.hide()
	else:
		redact_prompt.show()


func _on_button_pressed() -> void:
	Globals.unwanted_text = unwanted.text
	Globals.unwanted_text = Globals.unwanted_text.split(",")
	print(Globals.unwanted_text)
	Globals.replacement_text = replacement.text
	Globals.repeat_amount = Globals.unwanted_text.size()
	Globals.part = 0
	if not Globals.repeat_amount == -1:
		Globals.redacted_text = Globals.unredacted_text.replace(Globals.unwanted_text[Globals.part],Globals.replacement_text)
		Globals.part += 1
		Globals.repeat_amount -= 1
		text_display.text = Globals.redacted_text


func _on_save_pressed() -> void:
	save_to_file()
