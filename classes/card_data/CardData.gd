class_name CardData extends Reference

var name : String setget ,get_name
var power : Power
var impact : Impact

func _init(new_power: Power, new_impact = null):
	self.power = new_power
	self.impact = new_impact
	
func get_name() -> String:
		assert(self.power is Power)
		return self.power.get_name()        
