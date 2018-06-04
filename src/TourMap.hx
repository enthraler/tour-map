import enthraler.HaxeTemplate;
import enthraler.Environment;
import react.ReactDOM;
import react.ReactMacro.jsx;
import MapBox;
import AuthorData;

@:enthralerDependency('https://api.mapbox.com/mapbox-gl-js/v0.44.2/mapbox-gl.js', MapBox)
@:enthralerDependency('css!https://api.mapbox.com/mapbox-gl-js/v0.44.2/mapbox-gl.css')
class TourMap implements HaxeTemplate<AuthorData> {
	var env: Environment;
	var map: Map;

	public function new(environment: Environment) {
		this.env = environment;
		MapBox.accessToken = 'pk.eyJ1IjoiZW50aHJhbGVyIiwiYSI6ImNqNmRoMWp5dDIxdzYycW16cjBjMXhqc3UifQ.hACXMOxwXWy379v3vyJXfw';
	}

	public function render(authorData: AuthorData) {
		ReactDOM.render(
			jsx('<MapComponent {...authorData} />'),
			env.container,
			function () {
				// env.requestHeightChange();
			}
		);
	}
}