extends Interactable

@export var wiresHidden = true
@onready var puzzle = $"../wirePuzzle"

func interact(user : Node2D):
	wiresHidden = not wiresHidden
	puzzle.show()

func stop_interaction(user : Node2D):
	puzzle.hide()
