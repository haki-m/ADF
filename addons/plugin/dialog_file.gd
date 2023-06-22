tool
extends Popup

signal selected_xfile(xfile_path,file_name)
signal selected_multi_xfiles(xfiles_path,files_name)
signal selected_xfolder(xfolder_path,folder_name)
signal dialog_closed

#themes

var themes=[load("res://addons/plugin/themes/dark.tres"),load("res://addons/plugin/themes/light.tres") ]
var fnt:DynamicFont = load("res://addons/plugin/fonts/dark_font.tres")
#exported 


export (int,"select folder","select file","select_multiple_files") var dialog_type=0
export var columns=5 setget set_columns
export var font_size=16 setget font_sizex
export (bool ) var allow_back_on_android = true
export(int,"dark","light") var dialog_theme=0 setget set_themex
export var filter_files:PoolStringArray
#icons

var doc=load("res://addons/plugin/icons/doc.png")
var android=load("res://addons/plugin/icons/android.png")
var pdf=load("res://addons/plugin/icons/pdf.png")
var music=load("res://addons/plugin/icons/music.png")
var exe=load("res://addons/plugin/icons/exe.png")
var folder=load("res://addons/plugin/icons/folder.png")
var text=load("res://addons/plugin/icons/text.png")
var vid=load("res://addons/plugin/icons/vid.png")
var font=load("res://addons/plugin/icons/font.png")
var img=load("res://addons/plugin/icons/img.png")
var code=load("res://addons/plugin/icons/code.png")
var zip=load("res://addons/plugin/icons/zip.png")
var back_to=load("res://addons/plugin/icons/back.png")
var back_clicked=load("res://addons/plugin/icons/back_clicked.png")
var home_clicked=load("res://addons/plugin/icons/home_clicked.png")
var home=load("res://addons/plugin/icons/home.png")
#nodes
var top_panel=Panel.new()
var buttom_panel=Panel.new()
var scrol=ScrollContainer.new()
var grid=GridContainer.new()
var back_button=TextureButton.new()
var front_button=TextureButton.new()
var home_button=TextureButton.new()
var Select_files=Button.new()
var select_folder=Button.new()
var clos_dialog_button=Button.new()
var content
#files variables
var desktop_path=OS.get_system_dir(OS.SYSTEM_DIR_DESKTOP)
var current_path:String
var file_target=""
var global=[]
var multi_fliles=[]
var multi_files_name=[]
#settings_variables

	


#begin
func _enter_tree():
	content=load("res://addons/plugin/content.tscn")
	connect("resized",self,"size_changed")
	OS.request_permissions()
	current_path=desktop_path
	connect_childs()
	list(current_path)
	begins_settings()
	scrol.scroll_horizontal=false
	theme=themes[dialog_theme]
	#this line make allow phone to go back to folder by clicking on back systeme android button and not to quit 
	if allow_back_on_android==true:
		get_tree().set_quit_on_go_back(false)
	
	pass
#theme setget
func set_themex(new_dialog_theme):
	dialog_theme=new_dialog_theme
	theme=themes[dialog_theme]
	pass
#columns setget var
func set_columns(new_columns):
	content=load("res://addons/plugin/content.tscn")
	columns=new_columns
	grid.columns=columns
	refreshx()
	pass
#font size setget var
func font_sizex(new_size):
	font_size=new_size
	fnt.size=font_size
	pass
#add contents
func add_content(f:String):
	var new_content=content.instance()
	new_content.get_child(1).text=f
	new_content.get_child(0).connect("pressed",self,"content_clicked",[new_content,f])
	var s=rect_size.x/columns
	new_content.rect_min_size=Vector2((s-3),(s+(s/2)))
	add_icons(new_content.get_node("b"),f)
	grid.add_child(new_content)
	if dialog_type==2:
		filter_selected(new_content,current_path+"/"+f)
	pass
#clear all contents
func clear_content():
	for i in  grid.get_children():
		i.queue_free()
	pass
func add_icons(tex_button:TextureButton,n:String):
	if n.get_extension() in ["apk","aab"]:
		tex_button.texture_normal=android
	elif n.get_extension() in ["doc","docx","rtf","xml","txt"]:
		tex_button.texture_normal=doc
	elif n.get_extension() in ["exe","lnk","msi"]:
		tex_button.texture_normal=exe
	elif n.get_extension()=="":
		tex_button.texture_normal=folder
	elif n.get_extension() in ["mp3","wav","ogg"]:
		tex_button.texture_normal=music
	elif n.get_extension() in ["js","xml","cpp","html","css","php"]:
		tex_button.texture_normal=code
	elif n.get_extension()=="pdf":
		tex_button.texture_normal=pdf
	elif n.get_extension() in ["mp4","avi","3gp","MOV","WMV","webm","flv"]:
		tex_button.texture_normal=vid
	elif n.get_extension() in ["ttf","TTF","fnt"]:
		tex_button.texture_normal=font
	elif n.get_extension() in ["jpg","png","jpeg","webp"]:
		tex_button.texture_normal=img
	elif n.get_extension() in ["7z","zip","rar","zipx","cab"]:
		tex_button.texture_normal=zip
	else:
		var directory=Directory.new()
		if directory.dir_exists(current_path+"/"+n):
			tex_button.texture_normal=folder
			
			
		
		#var img=Image.new()
		#var y = ImageTexture.new()
		#y.load(current_path+"/"+n)
		#tex_button.texture_normal=y
	pass

func list(path):
	var files = []
	var directory = Directory.new()
	directory.open(path)
	directory.list_dir_begin()
	if directory.dir_exists(path):
		clear_content()
		while true:
			var file:String = directory.get_next()
			if file == "":
				break
			elif not file.begins_with("."):
				if not len(filter_files)==0:
					if file.get_extension() in filter_files or file.get_extension()=="":
						files.append(file)
						add_content(file)
				else:
					files.append(file)
					add_content(file)
					
		return files
	else:
		print("error_dir_in_list_function")
	directory.list_dir_end()
	pass
func content_clicked(yparent,file_name):
	var pathx=current_path+"/"+file_name
	var directoryx = Directory.new()
	if directoryx.dir_exists(pathx):
		current_path=current_path+"/"+file_name
		show_path()
		list(current_path)
		global.clear()
	else:
		file_target=pathx
		when_content_selected(yparent,pathx)
	pass
#android back system button
func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		back_pressed()
		return true

func back_path(pathy:String):
	if not pathy==desktop_path:
		global.append(current_path)
		var new_path=pathy.left(pathy.find_last("/"))
		current_path=new_path
		return new_path
	
	else:
		print("its a main path")

		return desktop_path
		
	pass
func show_path():
	
	pass



	
	
	
	

	pass

func size_changed():
	refreshx()
	pass
func begins_settings():
	
	popup_exclusive=true
	grid.columns=columns
	scrol.follow_focus=true
	scrol.scroll_deadzone=30
	add_childs()
	dialog_type()

	pass
func connect_childs():
	back_button.connect("pressed",self,"back_pressed")
	front_button.connect("pressed",self,"front_pressed")
	home_button.connect("pressed",self,"reload_pressed")
	Select_files.connect("pressed",self,"on_Select_files_clicked")
	clos_dialog_button.connect("pressed",self,"on_clos_dialog_clicked")
	select_folder.connect("pressed",self,"on_select_folder_clicked")
	pass
#connection_buttons
func back_pressed():
	list(back_path(current_path))
	

	pass
func front_pressed():
	if len(global)>0:
		current_path=global[-1]
		list(global[-1])
		global.remove(len(global)-1)
	pass
func reload_pressed():
	list(home_return(current_path))

	pass
func home_return(path):
	if not current_path==desktop_path:
		global.append(current_path)
		current_path=desktop_path
	return current_path
	pass
	pass
func on_Select_files_clicked():
	emit_signal("selected_multi_xfiles",multi_fliles,multi_files_name)
	pass
func on_clos_dialog_clicked():
	multi_files_name.clear()
	multi_fliles.clear()
	emit_signal("dialog_closed")
	hide()
	pass
func on_select_folder_clicked():
	emit_signal("selected_xfolder",current_path,nameofpath(current_path))
	hide()
	print("folder selected path is: "+current_path)
	print("folder selected name is: " + nameofpath(current_path))
	pass
func add_childs():

	add_child(top_panel)
	anchor_it(top_panel,0,0,1,0.1)
	
	add_child(buttom_panel)
	anchor_it(buttom_panel,0,0.9,1,1)
	
	add_child(scrol)
	anchor_it(scrol,0,0.1,1,0.9)

	scrol.add_child(grid)
	anchor_it(grid,0,1,1,1)

	button_properties(top_panel,back_button,back_to,back_clicked,0.05,0.05,0.25,0.95)
	button_properties(top_panel,front_button,back_to,back_clicked,0.3,0.05,0.5,0.95)
	button_properties(top_panel,home_button,home,home_clicked,0.7,0.05,0.9,0.95)
	
	button_properties(buttom_panel,Select_files,music,null,0.1,0.05,0.4,0.95)
	Select_files.text="SELECT FILE"
	button_properties(buttom_panel,select_folder,music,null,0.1,0.05,0.4,0.95)
	select_folder.text="SELECT FOLDER"
	button_properties(buttom_panel,clos_dialog_button,music,null,0.6,0.05,0.9,0.95)
	clos_dialog_button.text="CLOSE"
	front_button.flip_h=true
	pass
func button_properties(parent,btn,ico,icop,l,t,r,b):
	if btn is TextureButton:
		btn.expand=true
		btn.stretch_mode=TextureButton.STRETCH_KEEP_ASPECT_CENTERED
		btn.texture_normal=ico
		btn.texture_pressed=icop
	anchor_it(btn,l,t,r,b)
	if not parent==null:
		parent.add_child(btn)
	
	pass
func anchor_it(child,left,top,right,bottom):
	child.anchor_left=left
	child.anchor_top=top
	child.anchor_right=right
	child.anchor_bottom=bottom
	pass
func margin_it(child,left,top,right,bottom):
	child.margin_left=left
	child.margin_top=top
	child.margin_right=right
	child.margin_bottom=bottom
	pass
func content_pressed():
	
	pass
func refreshx():
	if Engine.editor_hint:
		#clear_content()
		#list(current_path)
		resize_content()
		var f=(rect_size.x*0.03)
		if int(f):
			fnt.size=f
		
	pass
func when_content_selected(yparent:TextureButton,yfile_path):
	if dialog_type==2:
		if yparent.is_in_group("selected"):
			erase_from_multi_file(yparent,yfile_path)
		else:
			add_to_multi_file(yparent,yfile_path)
		if len(multi_fliles)==0:
			print("should_disabled")
			Select_files.disabled=true
		else:
			Select_files.disabled=false
	if dialog_type==1:
		hide()
		print("you selected this file:  "+yfile_path)
		emit_signal("selected_xfile",yfile_path,nameofpath(yfile_path))
	if dialog_type==0:
		OS.alert("this is not a folder","Mmmmmm")
	pass
func add_to_multi_file(yparent:TextureButton,yfile_path):
	yparent.add_to_group("selected")
	yparent.disabled=false
	if not multi_fliles.has(yfile_path):
		add_file_to(yfile_path)

	pass
func erase_from_multi_file(yparent:TextureButton,yfile_path):
	yparent.remove_from_group("selected")
	yparent.disabled=true
	multi_fliles.erase(yfile_path)
	pass

func filter_selected(yparent:TextureButton,yfile_path):
	if multi_fliles.has(yfile_path):
		add_to_multi_file(yparent,yfile_path)
	pass
func dialog_type():
	if dialog_type==2:
		Select_files.show()
		select_folder.hide()
		
	if dialog_type==1:
		anchor_it(clos_dialog_button,0.3,0.05,0.7,0.95)
		select_folder.hide()
		Select_files.hide()
	if dialog_type==0:
		Select_files.hide()

	pass
func nameofpath(path):
	return path.right(path.find_last("/")+1)
	
	pass
func add_file_to(path):
	multi_fliles.append(path)
	multi_files_name.append(nameofpath(path))
	print(multi_files_name)
	pass
func resize_content():
	var s
	for i in grid.get_children():
		s=rect_size.x/columns
		i.rect_min_size=Vector2((s-3),(s+(s/2.5)))
	pass
