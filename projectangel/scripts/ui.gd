extends CanvasLayer

func _ready():
	$WaveNum.text = "Wave 0"
	$Souls.text = "Souls: 0"

func update_wave_num(wave_num: int):
	$WaveNum.text = "Wave " + str(wave_num)

func update_score_label(souls: int):
	$Souls.text = "Souls: " + str(souls)
