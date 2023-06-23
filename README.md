# ADF
> ## **A**ndroid **D**ialog **F**ile
> ### By Abdelhakim Mahha

![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhQYF6HC16pqmlsiRh8aHfMm7Z-nYpjPKZqhD2Ej-efG0UBPALQmow4d2lu8YxJucxto3hKfvoz8beTc2fxXm8Al1xuIBkgqGaNHD08QlvfjrMHqd1rYg9eS6chd25KaKe-nCaTBtmPmPZU1-kEk15eJ1bInui92mJvyxy297_S7kSfnhEuw3zo8xobq3ET/s696/MN.JPG)

!this is not a android plugin it's a godot addons plugin
is a diloge file plugin for godot _we can use it for all template_ but it created for android because we have already a dialoge file popup in godot.

## How to use :
1. Download ADF-main.zip [Here](https://github.com/haki-m/ADF) and extract files
2. Copy `addons` folder from ADF-mai into your godot project in the following path _res://_
3. go to:  _Project > Project Setting > Plugins_ and press "enable"
4. Now when you click on _Add new child_ you will see an other node added tou your godot nodes

![IMG4](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhMU_pOLXa4zxUb-oG-gQOJpNfVnrg7iaNCWsGQcxZBV-640cNVxmZUE3ZmFSLO8Oh_1iA3h-ETj0Jbr41V7QOGwlADbVFqduIqf-2WhfYfSWskhJzhLJPeMUI0uHw85UYIuoj1vRhajpR0GMjnrjvH60_sIzGBuxxSyOKqBV-OfLneLbhprFeQNvGxuDzE/s678/ADF.JPG)

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

## Settings

![image settings](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh-dbm7MU3tBPRbi_l0nYtc30PiobmlQJc_32N0gF7l2gMEoK97BOjGDqXGyP_a7Av507cuJvg71Odi3PMReOd0EvDOuN7jGEKbs8iY8rFZ-RCUknD0OaDKa9EOcm_EiSPRi0ZokRUM8rs7WdbkXyU1G021o_JEDrE1OA_eJB0eYA0PFB5N-QtLojiVd6NA/s360/settings.JPG)

## Dialog Type

* Select File
* Select Folder
* Select more than one file

## Columns
* Number of columns showen in dialog file

## Font Size
* Font size for the foldes and files name

## Allow back on android
* if this bool is thrue the button system for android device do the back function to the previous folder

## Dialog Theme
Dark theme
Light theme

## Files filter
it is an Array of file format that you one to see on your dialog file if it empty (default) you will see all files types 

for example : if i chose _pdf_

![img](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjUNmLgDdsjCdvBxO9qTdyZO0nOLMPrriqAZ55aYZ6kuvMoeSR4HM-xzXi5JdEaTCMtgrNoeMttHtoXgixxVT3ntnOv-C688t8UuTRzas7TT4hbv6xcEyYQhA2QY5QG3N3wOTOda9FJilCPc1lGVFglkXcyja5Oy7TgpX5aI8JkMvXdatsc2XB3yrZ4bZ3p/s344/filters.JPG)

the Result is :

![img](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiLvmIGNFT32UJlUowu3nj0a_ZxAL2n0buGDYLS1RhwZ68BSw_kU-P_Tc9VLh3eR0dW7S-WtD0yOQBt4wEu5fYgwGLCmRZE_wMcKjGgxTYZuqTNWLfmiLswh4h84fWdmF1JgI2X9S4OrAAV30myNtW6_KAcBitVFcPm2ot605NCbdrnfjUf_Jn64GTKgPIg/s1002/pdf.JPG)


Ceated By Abdelhakim Mahha
