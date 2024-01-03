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
static var enemy_data_cache = {}


static func preload_enemy_data():
	for enemy_name in EnemyType.keys():
		var path = EnemyType[enemy_name]
		enemy_data_cache[enemy_name] = ResourceLoader.load(path)

static func get_data(enemy_name: String) -> EnemyData:
	return enemy_data_cache.get(enemy_name)



