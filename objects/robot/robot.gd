extends Node3D

@export var udpPort: int = 4444

@onready var waist:Arm = $Waist
@onready var arm1:Arm = $Arm1
@onready var arm2:Arm = $Arm2
@onready var wrist:Arm = $Wrist

var server: UDPServer

var torque_waist = 0
var torque_arm_1 = 0
var torque_arm_2 = 0
var torque_wrist = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	
	server = UDPServer.new()
	server.listen(udpPort)
	$motorBase["motor/enable"] = true
	$motorArm1["motor/enable"] = false
	#$motorArm2["motor/enable"] = true
	#$motorWrist["motor/enable"] = true
	
	
	$motorBase.set_param(HingeJoint3D.PARAM_MOTOR_TARGET_VELOCITY,0)
	#motorArm1.set_param(HingeJoint3D.PARAM_MOTOR_TARGET_VELOCITY,0)
	#$motorArm2.set_param(HingeJoint3D.PARAM_MOTOR_TARGET_VELOCITY,0)
	#$motorWrist.set_param(HingeJoint3D.PARAM_MOTOR_TARGET_VELOCITY,0)
	pass


func _physics_process(delta):
	server.poll()
	if server.is_connection_available():
		var peer: PacketPeerUDP = server.take_connection()
		var packet = peer.get_packet()
		torque_waist = packet.decode_float(0)
		torque_arm_1 = packet.decode_float(4)
		torque_arm_2 = packet.decode_float(8)
		torque_wrist = packet.decode_float(12)
		
		waist.setTorque(torque_waist)
		arm1.setTorque(torque_arm_1)
		arm2.setTorque(torque_arm_2)
		wrist.setTorque(torque_wrist)
		
		var tosend =  PackedFloat32Array()
		tosend.append(delta)
		
		tosend.append(waist.global_rotation.x)
		tosend.append(waist.angular_velocity.x)
		
		tosend.append(arm1.global_rotation.x)
		tosend.append(arm1.angular_velocity.x)
		
		tosend.append(arm2.global_rotation.x)
		tosend.append(arm2.angular_velocity.x)
		
		tosend.append(wrist.global_rotation.x)
		tosend.append(wrist.angular_velocity.x)
		#print(tosend)
		peer.put_var(tosend)
	#var motorBaseDirection = Input.get_axis("ui_left", "ui_right")
	#var motorArm1Direction = Input.get_axis("ui_down", "ui_up")
	
	#motorBase.set_param(HingeJoint3D.PARAM_MOTOR_TARGET_VELOCITY,motorBaseSpeed * motorBaseDirection)
	#waist.setTorque(motorBaseDirection *.1)
	#arm1.setTorque(motorArm1Direction *.4)
	#motorArm1.set_param(HingeJoint3D.PARAM_MOTOR_TARGET_VELOCITY,motorArm1Speed * motorArm1Direction)

	#print(motorBase["motor/target_velocity"])

