extends Area2D

@export var interactor : Node2D
@export var interaction_action : StringName = "interact"
@export var indicator_scene : PackedScene
@export var indicator_y_offset : float = -20.0

var selected_interactable : Interactable :
	set(value):
		if (selected_interactable == value):
			return
		
		selected_interactable = value
		
		if (selected_interactable == null):
			interacation_indicator.queue_free()
			return
		
		_add_indicator_to_interactable(selected_interactable)
		
var nearby_interactables : Array[Interactable]
var interacation_indicator : Node2D

func _ready():
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _input(event: InputEvent):
	if (event.is_action_pressed(interaction_action)):
		if (selected_interactable != null):
			selected_interactable.interact(interactor)

func _on_area_entered(area: Area2D):
	if (area is Interactable):
		nearby_interactables.push_back(area)
		
		if (selected_interactable == null): 
			selected_interactable = nearby_interactables[0]
		
func _on_area_exited(area: Area2D):
	if (area is Interactable):
		nearby_interactables.erase(area)
		
		selected_interactable.stop_interaction(interactor)
		
		if (nearby_interactables.size() > 0):
			selected_interactable = nearby_interactables[0]
		else: 
			selected_interactable = null
			
func _add_indicator_to_interactable(interactable : Interactable):
	if (interacation_indicator == null): 
		interacation_indicator = indicator_scene.instantiate()
		interactable.add_child(interacation_indicator)
	else:
		interacation_indicator.reparent(interactable)
		
	interacation_indicator.global_position = Vector2(
		interactable.global_position.x, 
		interactable.global_position.y + indicator_y_offset
	)
