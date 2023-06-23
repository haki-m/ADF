# ADF
> ## **A**ndroid **D**ialog **F**ile
!this is not a android plugin it's a godot addons plugin
is a diloge file plugin for godot _we can use it for all template_ but it created for android because we have already a dialoge file popup in godot.

## How to use it :
1. Download the addons file from Here ant put it into your godot project in the following path _res://_
2. go to:  _Project > Project Setting > Plugins_ and press "enable"
3. Now when you click on _Add new child_ you will see an other node added tou your godot nodes
4. Add (enable) permessions in the android export

- [x] Read Externale Storage
   
- [x] Write External Storage

![read external storage image](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiGe60BGCAsottQhWE9y-5vshUVFcmc3F1MvyM55_2UZE_oxvNE_uita44eL4e4u-Xgfqf-lLtIyrlRoKuWXjBJIhN2PdhEAdK1MiFE6tX58kQcps2YgV6pFrKwcA0EgoI0x5dQgU94pS5ONYuUbh1DdW5L-l1OnTSRYkiyyGfKz84snfVNhNRqMx_pcxZ0/s693/readexternalestorage.JPG)

## Signals (Connections):
there is 4 signals for this node

![image](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEimtASun8rPIKxkEl-CJ8jz8tU8BOxhbRbZWlLkKR95AaWXiCIQ26kY7Re-yJEqlhSOVt7olR1-KHZRCi_kY2espExc5TEXpjLgRTfpuXtbOY7Hr_UoqOGoGTl33eEa1Q-zTuz8hSTlJ39w_-cM4oRqFz8dQHvtdqCxZQ5si0YBajw1QN-NA7NdunGogRD8/s571/signals.JPG)

### selected_xfile(xfile_path,file_name)

xfile_path == is the path to the file for example _storage/0/DCI/myimage.png_
file_name == myimage.png

### selected_multi_xfiles(xfiles_path,files_name)

* xfiles_paths == is an Array of paths for the selected files
* files_name == is an Array for the selected files name
Note : every file_path has the same order for the file name in Arrays received 

for example:
- xfiles_paths = ["/.../.../image.jpg","/.../.../son.mp3"]
- files_name = ["image.jpg","son.mp3"]
  
### selected_xfolder(xfolder_path,folder_name)

This signal send the folder directory _(xfolder_path)_ and the folder name _(folder_name)_

### dialog_closed
Note : This signal is when the popup closed from the close button and you should use `close bullon` to hide the dialog file it is note like "Hide() function"
```
## Functions

func _on_ADF_selected_xfile(xfile_path, file_name):

	pass # Replace with function body.


func _on_ADF_selected_multi_xfiles(xfiles_path, files_name):

	pass # Replace with function body.


func _on_ADF_selected_xfolder(xfolder_path, folder_name):
	
	pass # Replace with function body.


func _on_ADF_dialog_closed():
	
	pass # Replace with function body.
```

