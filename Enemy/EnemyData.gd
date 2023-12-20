class_name EnemyData
extends Resource

enum AttackType { PROJECTILE, MELEE }

@export
var attack_type: AttackType = AttackType.MELEE

@export
var health: int = 1

@export
var speed: float = 100

@export
var animation: SpriteFrames

@export
var hitbox: Shape2D
