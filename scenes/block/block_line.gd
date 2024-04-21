extends Node2D

const BLOCK := preload("res://scenes/block/block.tscn")


#func _ready() -> void:
	#add_blocks(19)


func add_blocks(amount: int, type: int):
	var block_position: Vector2 = Vector2(20, 0)
	for i in range(amount):
		var this_block: Block = BLOCK.instantiate()
		add_child(this_block)
		this_block.position = block_position
		this_block.block_points = type
		block_position += Vector2(40,0)
		

