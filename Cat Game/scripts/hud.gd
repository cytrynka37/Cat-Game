extends Control

@onready var score = $Score

func set_score(new_score):
	score.text = "score: " + str(new_score)
