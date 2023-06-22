tool
extends EditorPlugin


func _enter_tree():
	add_custom_type("ADF", "Popup", preload("dialog_file.gd"), preload("icon1.png"))

	pass


func _exit_tree():
	remove_custom_type("ADF")
	pass
