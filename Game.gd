class_name  Game
extends Node

@onready var _hud := $Hud
@onready var _menu := $Menu
@onready var _world: Node2D = $World
@onready var _camera: Camera2D = $World/Camera

var _curr_level: Node2D
var _curr_menu: Control

func _ready():
	Global.game = self
	load_menu("MainMenu")

func unload_level():
	if (is_instance_valid(_curr_level)):
		_curr_level.queue_free()
	_curr_level = null

func load_level(level_name: String):
	unload_level()
	var level_path := "res://Level/%s.tscn" % level_name
	var level_resource: PackedScene = load(level_path)
	if level_resource:
		_curr_level = level_resource.instantiate()
		_world.add_child(_curr_level)
		
func unload_menu():
	if (is_instance_valid(_curr_menu)):
		_curr_menu.queue_free()
	_curr_menu = null

func load_menu(menu_name: String):
	unload_level()
	var menu_path := "res://Menu/%s.tscn" % menu_name
	var menu_resource: PackedScene = load(menu_path)
	if menu_resource:
		_curr_menu = menu_resource.instantiate()
		_menu.add_child(_curr_menu)
