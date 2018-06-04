typedef AuthorData = {
	style: {
		tiles: TileStyle,
		startZoom: Int,
		speed: Int,
	},
	stops: Array<Stop>
}

typedef Stop = {
	date: String,
	city: String,
	region: String,
	coordinates: Array<Float>
}

@:enum abstract TileStyle(String) {
	var basic = "basic";
	var streets = "streets";
	var bright = "bright";
	var light = "light";
	var dark = "dark";
	var satellite = "satellite";
	var satelliteStreets = "satellite-streets";
}