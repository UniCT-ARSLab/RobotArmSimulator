extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	#$giuntoangolare.set_param(HingeJoint3D.PARAM_MOTOR_TARGET_VELOCITY, 1)
	

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$part_1.apply_torque(Vector3(0,0,-1.7 ))
	pass
