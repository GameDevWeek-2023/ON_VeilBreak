extends SpringArm3D

@export var boost_camara_curve: Curve;
@export var exit_boost_camara_curve: Curve; 

@export var enter_boost_duration : float;
@export var exit_boost_duration : float;

 

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);
	
var duration : float = 0.0;
var time_remaining : float = 0.0;
var t : float = 0.0;
var from : float = self.spring_length;
var to : float = 0.0;
var usedCurve: Curve = self.boost_camara_curve;

func interpolate(from: float, to: float, curve: Curve, duration: float) -> void:
	self.duration = duration;
	self.time_remaining = duration;	
	self.from = from;
	self.to = to;
	self.usedCurve = curve;
	
func _physics_process(delta : float):
	if (time_remaining > 0):
		t = usedCurve.sample((duration-time_remaining)/duration);
		time_remaining -= delta;
		self.spring_length = from * (1 - t) +  to * t;
		print("duration : ", duration, " | time_remaining : ", time_remaining, " | t : ", t , " | from : ", from , " | to : ", to)
