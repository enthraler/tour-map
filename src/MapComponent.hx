import react.ReactMacro.jsx;
import react.ReactComponent;
import js.html.DivElement;
import MapBox;
import AuthorData;

class MapComponent extends ReactComponentOf<AuthorData, {
	currentStop: Stop,
}, {}> {
	var mapContainer: DivElement;
	var map: Map;
	var currentPopup: Popup;

	public function new(props: AuthorData) {
		super(props);
		this.state = {
			currentStop: props.stops[0]
		};
	}

	override public function render() {
		return jsx('<div className=${Styles.TourMap}>
			<div
				className=${Styles.MapContainer}
				ref=${div -> this.mapContainer = div}
			/>
			<ShowList stops=${props.stops} current=${state.currentStop} onSelect=${selectStop} />
		</div>');
	}

	override public function componentDidMount() {
		this.map = new Map({
			container: this.mapContainer,
			style: 'mapbox://styles/mapbox/${props.style.tiles}-v9',
			center: props.stops[0].coordinates,
			zoom: props.style.startZoom,
			pitch: 45,
			bearing: 0,
		});
		map.addControl(new MapBox.NavigationControl(), CornerPosition.TopLeft);
		map.on(MapEvents.load, function() {
			if (props.style.tiles != satellite && props.style.tiles != satelliteStreets) {
				add3D();
			}
			addPins(props.stops);
			flyToStop(state.currentStop);
		});
	}

	function add3D() {
		// The 'building' layer in the mapbox-streets vector source contains building-height data from OpenStreetMap.
		// Insert the layer beneath any symbol layer.
		var layers: Array<Dynamic> = map.getStyle().layers;

		var labelLayerId = null;
		for (i in 0...layers.length) {
			var layer = layers[i];
			var textField = Reflect.field(layer.layout, 'text-field');
			if (layer.type == 'symbol' && textField != null && textField != false) {
				labelLayerId = layer.id;
				break;
			}
		}

		map.addLayer({
			'id': '3d-buildings',
			'source': 'composite',
			'source-layer': 'building',
			'filter': ['==', 'extrude', 'true'],
			'type': 'fill-extrusion',
			'minzoom': 15,
			'paint': {
				'fill-extrusion-color': '#aaa',

				// use an 'interpolate' expression to add a smooth transition effect to the
				// buildings as the user zooms in
				'fill-extrusion-height': ([
					"interpolate", ["linear"], ["zoom"],
					15, 0,
					15.05, ["get", "height"]
				]: Array<Dynamic>),
				'fill-extrusion-base': ([
					"interpolate", ["linear"], ["zoom"],
					15, 0,
					15.05, ["get", "min_height"]
				]: Array<Dynamic>),
				'fill-extrusion-opacity': 0.6
			}
		}, labelLayerId);
	}

	function addPins(stops: Array<Stop>) {
		var features = [for (stop in stops) {
			type: "Feature",
			properties: {
				index: stops.indexOf(stop),
			},
			geometry: {
				type: "Point",
				coordinates: stop.coordinates
			}
		}];

		map.addLayer({
			"id": "stops",
			"type": "circle",
			"source": {
				"type": "geojson",
				"data": {
					"type": "FeatureCollection",
					"features": features
				}
			},
			"paint": {
				"circle-radius": props.style.circleRadius,
				"circle-color": props.style.circleColor
			},
		});

		// Center the map on the coordinates of any clicked symbol from the 'stops' layer.
		map.on(MapEvents.click, 'stops', function (e) {
			var stop = stops[e.features[0].properties.index];
			selectStop(stop, e);
		});

		// Change the cursor to a pointer when the it enters a feature in the 'stops' layer.
		map.on(MapEvents.mouseenter, 'stops', function () {
			map.getCanvas().style.cursor = 'pointer';
		});

		// Change it back to a pointer when it leaves.
		map.on(MapEvents.mouseleave, 'stops', function () {
			map.getCanvas().style.cursor = '';
		});

		map.on(MapEvents.dblclick, function (e) {
			var lngLat: LngLat = e.lngLat;
			trace([lngLat.lng, lngLat.lat]);
		});

		map.on(MapEvents.dblclick, 'stops', function () {
			zoomIn();
		});
	}

	function selectStop(stop: Stop, ?clickEvent: Dynamic) {
		var previousStop = state.currentStop;
		this.setState({
			currentStop: stop
		});

		// TODO: the fly to should probably happen in response to the state updating.
		flyToStop(stop, clickEvent);

		if (stop == previousStop) {
			zoomIn();
		}
	}

	function flyToStop(stop: Stop, ?clickEvent: Dynamic) {
		map.flyTo({
			center: stop.coordinates,
			speed: props.style.speed
		});

		// Open a popup at the location of the feature
		if (currentPopup != null) {
			currentPopup.remove();
		}

		var coordinates: Array<Float> = stop.coordinates.copy();
		var description = '
			<div>
				<strong>${stop.city}</strong>
				<br /><em>${stop.byline}</em>
				<br />Date: ${stop.date}
			</div>';

		if (clickEvent != null) {
			// Ensure that if the map is zoomed out such that multiple
			// copies of the feature are visible, the popup appears
			// over the copy being pointed to.
			while (Math.abs(clickEvent.lngLat.lng - coordinates[0]) > 180) {
				coordinates[0] += clickEvent.lngLat.lng > coordinates[0] ? 360 : -360;
			}
		}

		currentPopup = new MapBox.Popup({
				offset: 15
			})
			.setLngLat(coordinates)
			.setHTML(description)
			.addTo(map);
	}

	function zoomIn() {
		this.map.flyTo({
			center: this.state.currentStop.coordinates,
			zoom: 16,
			speed: props.style.speed,
		});
	}
}