extends Node3D

@onready var motorBase:HingeJoint3D = $motorBase
@onready var motorArm1:HingeJoint3D = $motorArm1
@onready var motorArm2:HingeJoint3D = $motorArm2
@onready var motorWrist:HingeJoint3D = $motorWrist
var motorBaseSpeed = 1 #m/s
var motorArm1Speed = 2 #m/s
#var dir = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	motorBase["motor/enable"] = true
	motorArm1["motor/enable"] = false
	motorArm2["motor/enable"] = false
	motorWrist["motor/enable"] = false
	
	
	motorBase.set_param(HingeJoint3D.PARAM_MOTOR_TARGET_VELOCITY,0)
	motorArm1.set_param(HingeJoint3D.PARAM_MOTOR_TARGET_VELOCITY,0)
	motorArm2.set_param(HingeJoint3D.PARAM_MOTOR_TARGET_VELOCITY,0)
	motorWrist.set_param(HingeJoint3D.PARAM_MOTOR_TARGET_VELOCITY,0)


func _physics_process(delta):
	
	var motorBaseDirection = Input.get_axis("ui_left", "ui_right")
	var motorArm1Direction = Input.get_axis("ui_down", "ui_up")
	
	motorBase.set_param(HingeJoint3D.PARAM_MOTOR_TARGET_VELOCITY,motorBaseSpeed * motorBaseDirection)
	$Arm1.setTorque(motorArm1Direction )
	#motorArm1.set_param(HingeJoint3D.PARAM_MOTOR_TARGET_VELOCITY,motorArm1Speed * motorArm1Direction)

	#print(motorBase["motor/target_velocity"])

