extends Control

func set_label(auditor_name, auditor_index):
	$Label.text = "%s %d" % [auditor_name, auditor_index]
