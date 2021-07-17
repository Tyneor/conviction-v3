extends TextureRect

func set_label(new_label):
	$VBoxContainer/Label.text = new_label
	
func set_description(new_description):
	$VBoxContainer/MarginContainer/Description.text = new_description
