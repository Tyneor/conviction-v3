extends Control

func set_label(nb_cards_remaining, is_for_player):
	$Label.text = "%s deck\n%d cards remaining" % ["Player" if is_for_player else "Opponent", nb_cards_remaining]
