extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var my_file=File.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass
	
# Save file

func _on_save_file_pressed():
	$CanvasLayer/Control/ADF_save_file.popup_centered()
	pass 
	
func _on_ADF_save_file_selected_xfolder(xfolder_path, folder_name):
	my_file.open(xfolder_path+"myfile.txt",File.WRITE)
	my_file.store_string(" This is the data stored into myfile.txt ")
	my_file.close()
	print("file stored in this directory"+xfolder_path+"myfile.txt")
	$CanvasLayer/Control/Label.text= "file stored in this directory"+xfolder_path+"myfile.txt"
	pass 
	
#open file

func _on_open_file_pressed():
	$CanvasLayer/Control/ADF_open_file.popup_centered()
	pass 

func _on_ADF_open_file_selected_xfile(xfile_path, file_name):
	my_file.open(xfile_path,File.READ)
	var file_data = my_file.get_as_text()
	$CanvasLayer/Control/Label.text="your file path is: "+xfile_path
	pass 
#open folder is the same function of "save_file"
func _on_open_folder_pressed():
	$CanvasLayer/Control/ADF_open_folder.popup_centered()
	pass 
func _on_ADF_open_folder_selected_xfolder(xfolder_path, folder_name):
	$CanvasLayer/Control/Label.text="the folder path is: " + xfolder_path
	pass # Replace with function body.

#open multi files


func _on_open_multifiles_pressed():
	$CanvasLayer/Control/ADF_open_multi_files.popup_centered()
	pass 
	
func _on_ADF_open_multi_files_selected_multi_xfiles(xfiles_path, files_name):
	$CanvasLayer/Control/Label.text="the files paths are :" + str(xfiles_path)
	pass 

# this fonctions for filtering only format that declared in ADF Setting 
func _on_open_img_file_pressed():
	$CanvasLayer/Control/ADF_open_images.popup_centered()
	pass # Replace with function body.


func _on_ADF_open_images_selected_xfile(xfile_path, file_name):
	$CanvasLayer/Control/Label.text="image path is: " + xfile_path
	pass # Replace with function body.
