class_name EnemyData
extends Resource

const EnemyType: Dictionary = { 
	BAT = "res://Enemy/Bat/BatData.tres", 
	DEMON = "res://Enemy/Demon/DemonData.tres",
	MINOTAUR = "res://Enemy/Minotaur/MinotaurData.tres",
	OGRE = "res://Enemy/Ogre/OgreData.tres",
}

@export_enum("BAT", "DEMON", "MINOTAUR", "OGRE") var enemy_type: String
@export var animation: SpriteFrames
@export var hitbox: Shape2D

var health: int
var speed: float

static func get_data(enemy_name: String) -> EnemyData:
	return load(EnemyType[enemy_name]) as EnemyData



