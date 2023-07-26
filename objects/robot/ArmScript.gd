extends RigidBody3D



var nextTorque = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func setTorque(value):
	nextTorque = value

func _integrate_forces(state):
	state.apply_torque(Vector3(nextTorque,0,0))
