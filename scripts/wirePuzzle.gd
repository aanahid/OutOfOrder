extends CanvasLayer

@onready var puzzle = $"."

func _on_close_button_pressed():
	puzzle.hide()
