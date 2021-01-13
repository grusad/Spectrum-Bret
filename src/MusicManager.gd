extends Node

onready var spectrum = AudioServer.get_bus_effect_instance(1,0)
onready var audio_stream_player = $AudioStreamPlayer

var min_freq = 20
var max_freq = 20000
var max_db = 0
var min_db = -40
var accel = 20
var histogram = []
var definition = 40

func _ready():
	max_db += audio_stream_player.volume_db
	min_db += audio_stream_player.volume_db
	
	for i in range(definition):
		histogram.append(0)

func _process(delta):
	process_spectrum_analyzer(delta)
	
	
func process_spectrum_analyzer(delta):
	var freq = min_freq
	var interval = (max_freq - min_freq) / definition
	
	for i in range(definition):
		
		var freqrange_low = float(freq - min_freq) / float(max_freq - min_freq)
		freqrange_low = freqrange_low * freqrange_low * freqrange_low * freqrange_low
		freqrange_low = lerp(min_freq, max_freq, freqrange_low)
		
		freq += interval
		
		var freqrange_high = float(freq - min_freq) / float(max_freq - min_freq)
		freqrange_high = freqrange_high * freqrange_high * freqrange_high * freqrange_high
		freqrange_high = lerp(min_freq, max_freq, freqrange_high)
		
		var mag = spectrum.get_magnitude_for_frequency_range(freqrange_low, freqrange_high)
		mag = linear2db(mag.length())
		mag = (mag - min_db) / (max_db - min_db)
		
		mag += 0.3 * (freq - min_freq) / (max_freq - min_freq)
		mag = clamp(mag, 0.05, 1)
		
		histogram[i] = lerp(histogram[i], mag, accel * delta)
