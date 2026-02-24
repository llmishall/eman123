extends Control

var settings_main=0
var settings_sound=0

##################
#Играть

func _on_play_pressed() -> void:
	print("pressed play")
	get_tree().change_scene_to_file("")



##################
#Продолжить

func _on_resume_pressed() -> void:
	print("pressed resume")
	get_tree().change_scene_to_file("")



##################
#Онлайн

func _on_online_pressed() -> void:
	print("pressed online")
	get_tree().change_scene_to_file("")



##################
#Достижения

func _on_achievements_pressed() -> void:
	print("pressed achivments")
	



##################
#Настройки

@onready var settingslayer = $settingslayer
@onready var mainsettingsmenu = $mainsettingsmenu
@onready var soundsettingsmenu = $soundsettingsmenu
func _on_settings_pressed() -> void: 
	print("pressed settings")
	await get_tree().create_timer(0.1).timeout #задержка на 0.1 секунду
	settingslayer.show() #(Когда-нить надо будет сделать плавное появление)
	
func _on_main_settings_menu_visibility_changeds() -> void:
	print("")
func _on_x_pressed() -> void: #Закрытие настроек
	settingslayer.hide()
	mainsettingsmenu.hide()
	soundsettingsmenu.hide()

#Настройки main
func _on_main_settings_pressed() -> void:
	print("main settings")
	
	#Прячем другие настройки
	soundsettingsmenu.hide()
	settings_sound=0
	
	
	await get_tree().create_timer(0.1).timeout
	if settings_main==0:
		mainsettingsmenu.show()
		settings_main=1
	else:
		mainsettingsmenu.hide()
		settings_main=0

#Настройки Sound
func _on_sound_settings_pressed() -> void:
	print("sound settings")
	
	#Прячем другие настройки
	mainsettingsmenu.hide()
	settings_main=0
	
	await get_tree().create_timer(0.1).timeout
	if settings_sound==0:
		settings_sound=1
		soundsettingsmenu.show()
	else:
		settings_sound=0
		soundsettingsmenu.hide()

# Получаем индекс шины "Master" (обычно это 0)
@onready var master_bus_index = AudioServer.get_bus_index("Master")

func _on_volme_value_changed(value: float) -> void:
	# Превращаем 0...1 от ползунка в децибелы (-80...0 db)
	var db_value = linear_to_db(value)
	
	# Применяем громкость к шине
	AudioServer.set_bus_volume_db(master_bus_index, db_value)
	
	# Выключаем звук совсем (Mute), если ползунок на нуле
	AudioServer.set_bus_mute(master_bus_index, value == 0)


#######################
#Выход

func _on_exit_pressed() -> void:
	pass # Replace with function body.
	print("pressed exit")
	await get_tree().create_timer(1.0).timeout #задержка на 1 секунду
	get_tree().quit()
