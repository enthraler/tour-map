import haxe.extern.EitherType;
import haxe.Constraints.Function;
import js.html.*;
import js.Error;

extern class MapBox {
	public static var Map: Class<Map>;
	public static var accessToken: String;
}

@:native('MapBox.Map')
extern class Map {
	public function new(options: MapBoxOptions);
	var scrollZoom: ScrollZoomHandler;
	var boxZoom: BoxZoomHandler;
	var dragRotate: DragRotateHandler;
	var dragPan: DragPanHandler;
	var keyboard: KeyboardHandler;
	var doubleClickZoom: DoubleClickZoomHandler;
	var touchZoomRotate: TouchZoomRotateHandler;
	function addControl(control: IControl, position: CornerPosition): Map;
	function removeControl(control: IControl): Map;
	function resize(?event: Dynamic): Map;
	function getBounds(): LngLatBounds;
	function getMaxBounds(): Null<LngLatBounds>;
	function setMaxBounds(bounds: Null<LngLatBounds>): Map;
	function setMinZoom(zoom: Null<Float>): Map;
	function setMaxZoom(zoom: Null<Float>): Map;
	function getMinZoom(): Null<Float>;
	function getMaxZoom(): Null<Float>;
	function getRenderWorldCopies(): Bool;
	function setRenderWorldCopies(renderWorldCopies: Bool): Map;
	/** Find the pixel co-ordinates of long-lat co-ordinates. **/
	function project(lngLat: LngLatLike): Point;
	/** Find the long-lat co-ordinates of pixel co-ordinates. **/
	function unproject(coordinates: Point): LngLatLike;
	function isMoving(): Bool;
	function isZooming(): Bool;
	function isRotating(): Bool;
	@:overload(function(type: MapEvents, listener: Function): Map { })
	function on(type: MapEvents, layer: String, listener: Function): Map;
	@:overload(function(type: MapEvents, listener: Function): Map { })
	function off(type: MapEvents, layer: String, listener: Function): Map;
	function queryRenderedFeatures(?geometry: EitherType<PointLike, Array<PointLike>>, ?options: {
		?layers: Array<String>,
		?filter: Array<Dynamic>
	}): Array<Dynamic>;
	function querySourceFeatures(sourceID: String, ?options: {
		?sourceLayer: String,
		?filter: Array<Dynamic>
	}): Array<Dynamic>;
	function setStyle(style: EitherType<String, StyleSpecification>, ?options: {
		?diff: Bool,
		?localIdeographFontFamily: Null<String>
	}): Map;
	function getStyle(): Dynamic;
	function isStyleLoaded(): Bool;
	function addSource(id: String, source: Dynamic): Map;
	function removeSource(id: String): Map;
	function getSource(id: String): Null<Dynamic>;
	function isSourceLoaded(id: String): Bool;
	function areTilesLoaded(): Bool;
	function addImage(id: String, image: EitherType<ImageElement, {
		width: Int,
		height: Int,
		data: EitherType<Uint8Array, Uint8ClampedArray>
	}>, ?options: {
		?pixelRatio: Float,
		?sdf: Bool
	}): Void;
	function hasImage(id: String): Bool;
	function removeImage(id: String): Void;
	function loadImage(url: String, callback: Error->Dynamic->Void):Void;
	function addLayer(layer: LayerDefinition, ?before: String): Map;
	function moveLayer(id: String, ?beforeId: String): Map;
	function removeLayer(id: String): Map;
	function getLayer(id: String): Dynamic;
	function setFilter(layerId: String, filter: Filter): Map;
	function setLayerZoomRange(layerId: String, minzoom: Float, maxzoom: Float): Map;
	function getFilter(layerId: String): Filter;
	function setPaintProperty(layer: String, name: String, value: Dynamic): Map;
	function getPaintProperty(layer: String, name: String): Map;
	function setLayoutProperty(layer: String, name: String, value: Dynamic): Map;
	function getLayoutProperty(layer: String, name: String): Dynamic;
	function setLight(light: LightSpecification): Map;
	function getLight(): Dynamic;
	function getContainer(): HtmlElement;
	function getCanvasContainer(): HtmlElement;
	function getCanvas(): CanvasElement;
	function loaded(): Bool;
	function remove(): Void;
	var showTileBoundaries: Bool;
	var showCollisionBoxes: Bool;
	var repaint: Bool;
	function getCenter(): LngLat;
	function setCenter(center: LngLatLike, ?eventData: Dynamic): Map;
	function panBy(offset: PointLike, ?options: AnimationOptions, ?eventData: Dynamic): Map;
	function panTo(lnglat: LngLatLike, ?options: AnimationOptions, ?eventData: Dynamic): Map;
	function getZoom(): Float;
	function setZoom(zoom: Float, ?eventData: Dynamic): Map;
	function zoomTo(zoom: Float, ?options: AnimationOptions, ?eventData: Dynamic): Map;
	function zoomIn(?options: AnimationOptions, ?eventData: Dynamic): Map;
	function zoomOut(?options: AnimationOptions, ?eventData: Dynamic): Map;
	function getBearing(): Float;
	function setBearing(bearing: Float, ?eventData: Dynamic): Void;
	function rotateTo(bearing: Float, ?options: AnimationOptions, ?eventData: Dynamic): Map;
	function resetNorth(?options: AnimationOptions, ?eventData: Dynamic): Map;
	function snapToNorth(?options: AnimationOptions, ?eventData: Dynamic): Map;
	function getPitch(): Float;
	function setPitch(pitch: Float, ?eventData: Dynamic): Map;
	function fitBounds(bounds: LngLatBoundsLike, ?options: {
		?padding: EitherType<Float, PaddingOptions>,
		?linear: Bool,
		?easing: Float->Float,
		?offset: PointLike,
		?maxZoon: Float
	}, ?eventData: Dynamic): Map;
	function jumpTo(options: CameraOptions, ?eventData: Dynamic): Map;
	function easeTo(options: {
		> CameraOptions,
		> AnimationOptions,
	}, ?eventData: Dynamic): Map;
	function flyTo(options: {
		> CameraOptions,
		> AnimationOptions,
		?curve: Float,
		?minZoom: Float,
		?speed: Float,
		?screenSpeed: Float,
		?maxDuration: Int,
	}, ?eventData: Dynamic): Map;
	function stop(): Map;
}

typedef MapBoxOptions = {
	var container: EitherType<String, Element>;
	@:optional var minZoom: Float;
	@:optional var maxZoom: Float;
	@:optional var style: EitherType<String, Dynamic>;
	@:optional var hash: Bool;
	@:optional var interactive: Bool;
	@:optional var bearingSnap: Float;
	@:optional var pitchWithRotate: Bool;
	@:optional var attributionControl: Bool;
	@:optional var logoPositionstring: CornerPosition;
	@:optional var failIfMajorPerformanceCaveat: Bool;

	@:optional var preserveDrawingBuffer: Bool;
	@:optional var refreshExpiredTiles: Bool;
	/** [[west, south], [east, north]]. Note: there are also LngLat or LngLatBounds objects you could use instead. **/
	@:optional var maxBounds: EitherType<
		Array<Array<Float>>,
		EitherType<
			Array<LngLat>,
			LngLatBounds
		>
	>;
	@:optional var scrollZoom: EitherType<Bool, {
		/** 'center' **/
		?around: String
	}>;
	@:optional var boxZoom: Bool;
	@:optional var dragRotate: Bool;
	@:optional var dragPan: Bool;
	@:optional var keyboard: Bool;
	@:optional var doubleClickZoom: Bool;
	@:optional var touchZoomRotate: EitherType<Bool, {
		/** 'center' **/
		?around: String
	}>;
	@:optional var trackResize: Bool;
	@:optional var center: LngLatLike;
	@:optional var zoom: Float;
	@:optional var bearing: Float;
	@:optional var pitch: Float;
	@:optional var renderWorldCopies: Float;
	@:optional var maxTileCacheSize: Null<Float>;
	@:optional var localIdeographFontFamily: Null<String>;
	@:optional var transformRequest:Null<String->{
		url: String,
		?headers: Dynamic,
		?credentials: String
	}>;
}

@:enum abstract CornerPosition(String) {
	var TopLeft = 'top-left';
	var BottomLeft = 'bottom-left';
	var TopRight = 'top-right';
	var BottomRight = 'bottom-right';
}

typedef AnimationOptions = {
	?duration: Float,
	?easing: Float->Float,
	?offset: PointLike,
	?animate: Bool
};

typedef CameraOptions = {
	?center: LngLatLike,
	?zoom: Float,
	?bearing: Float,
	?pitch: Float,
	?around: LngLatLike
};

typedef PaddingOptions = {
	?top: Float,
	?bottom: Float,
	?left: Float,
	?right: Float,
};

@:enum abstract MapEvents(String) from String to String {
	var resize = "resize";
	var remove = "remove";
	var mousedown = "mousedown";
	var mouseup = "mouseup";
	var mouseover = "mouseover";
	var mousemove = "mousemove";
	var click = "click";
	var dblclick = "dblclick";
	var mouseenter = "mouseenter";
	var mouseleave = "mouseleave";
	var mouseout = "mouseout";
	var contextmenu = "contextmenu";
	var wheel = "wheel";
	var touchstart = "touchstart";
	var touchend = "touchend";
	var touchmove = "touchmove";
	var touchcancel = "touchcancel";
	var movestart = "movestart";
	var move = "move";
	var moveend = "moveend";
	var dragstart = "dragstart";
	var drag = "drag";
	var dragend = "dragend";
	var zoomstart = "zoomstart";
	var zoom = "zoom";
	var zoomend = "zoomend";
	var rotatestart = "rotatestart";
	var rotate = "rotate";
	var rotateend = "rotateend";
	var pitchstart = "pitchstart";
	var pitch = "pitch";
	var pitchend = "pitchend";
	var boxzoomstart = "boxzoomstart";
	var boxzoomend = "boxzoomend";
	var boxzoomcancel = "boxzoomcancel";
	var webglcontextlost = "webglcontextlost";
	var webglcontextrestored = "webglcontextrestored";
	var load = "load";
	var render = "render";
	var error = "error";
	var data = "data";
	var styledata = "styledata";
	var sourcedata = "sourcedata";
	var dataloading = "dataloading";
	var styledataloading = "styledataloading";
	var sourcedataloading = "sourcedataloading";
}

extern class BoxZoomHandler {
	function isEnabled(): Bool;
	function isActive(): Bool;
	function enable(): Void;
	function disable(): Void;
}

extern class ScrollZoomHandler {
	function isEnabled(): Bool;
	function enable(): Void;
	function disable(): Void;
}

extern class DragPanHandler {
	function isEnabled(): Bool;
	function isActive(): Bool;
	function enable(): Void;
	function disable(): Void;
}

extern class DragRotateHandler {
	function isEnabled(): Bool;
	function isActive(): Bool;
	function enable(): Void;
	function disable(): Void;
}

extern class KeyboardHandler {
	function isEnabled(): Bool;
	function enable(): Void;
	function disable(): Void;
}

extern class DoubleClickZoomHandler {
	function isEnabled(): Bool;
	function isActive(): Bool;
	function enable(): Void;
	function disable(): Void;
}

extern class TouchZoomRotateHandler {
	function isEnabled(): Bool;
	function enable(): Void;
	function disable(): Void;
	function disableRotation(): Void;
	function enableRotation(): Void;
}

interface IControl {
	function onAdd(map: Map): HtmlElement;
	function onRemove(): Void;
	var getDefaultPosition: Null<Void->CornerPosition>;
}

@:native('MapBox.NavigationControl')
extern class NavigationControl implements IControl {
	function new(?options: {
		?positionOptions: {
			?enableHighAccuracy: Bool,
			?timeout: Float,
			?maximumAge: Float,
		}
	});
	function onAdd(map: Map): HtmlElement;
	function onRemove(): Void;
	var getDefaultPosition: Null<Void->CornerPosition>;
}

@:native('MapBox.GeolocateControl')
extern class GeolocateControl implements IControl {
	function new(?options: {
		?showCompass: Bool,
		?showZoom: Bool
	});
	function onAdd(map: Map): HtmlElement;
	function onRemove(): Void;
	var getDefaultPosition: Null<Void->CornerPosition>;
}

@:native('MapBox.AttributionControl')
extern class AttributionControl implements IControl {
	function new(?options: {
		?compact: Bool,
	});
	function onAdd(map: Map): HtmlElement;
	function onRemove(): Void;
	var getDefaultPosition: Null<Void->CornerPosition>;
}

@:native('MapBox.ScaleControl')
extern class ScaleControl implements IControl {
	function new(?options: {
		?maxWidth: Float,
		?unit: String, // 'imperial' 'metric' or 'nautical'
	});
	function onAdd(map: Map): HtmlElement;
	function onRemove(): Void;
	/** Valid values: 'imperial' 'metric' or 'nautical' **/
	function setUnit(unit: String): Void;
	var getDefaultPosition: Null<Void->CornerPosition>;
}

@:native('MapBox.FullscreenControl')
extern class FullscreenControl implements IControl {
	function new();
	function onAdd(map: Map): HtmlElement;
	function onRemove(): Void;
	var getDefaultPosition: Null<Void->CornerPosition>;
}

@:native('MapBox.Popup')
extern class Popup implements IControl {
	function new(?options: {
		?closeButton: Bool,
		?closeOnClick: Bool,
		?anchor: String, // 'top', 'bottom', 'left', 'right', 'top-left', 'top-right', 'bottom-left', 'bottom-right'
		?offset: EitherType<
			Float,
			EitherType<
				PointLike,
				Dynamic<PointLike> // prop name is the anchor, prop value is the point for the offset.
			>
		>,
	});
	function onAdd(map: Map): HtmlElement;
	function onRemove(): Void;
	var getDefaultPosition: Null<Void->CornerPosition>;
	function addTo(map: Map): Popup;
	function isOpen(): Bool;
	function remove(): Popup;
	function getLngLat(): LngLat;
	function setLngLat(lngLat: LngLatLike): Popup;
	function setText(text: String): Popup;
	function setHTML(html: String): Popup;
	function setDOMContent(node: Node): Popup;
}


/** Untyped in Haxe externs. See docs: https://www.mapbox.com/mapbox-gl-js/style-spec/ **/
typedef StyleSpecification = Dynamic;

/** Untyped in Haxe externs. See docs: https://www.mapbox.com/mapbox-gl-js/style-spec/#layers **/
typedef LayerDefinition = Dynamic;

/** Untyped in Haxe externs. See docs: https://www.mapbox.com/mapbox-gl-style-spec/#light **/
typedef LightSpecification = Dynamic;

/** See https://www.mapbox.com/mapbox-gl-js/style-spec/#other-filter **/
typedef Filter = Array<String>;

@:native('MapBox.LngLat')
/** Note you can also just use an array: `[lng, lat]` **/
extern class LngLat {
	public function new(lng: Float, lat: Float);
	public var lng: Float;
	public var lat: Float;
}

typedef LngLatLike = EitherType<
	LngLat,
	EitherType<
		Array<Float>,
		{
			lng: Float,
			lat: Float
		}
	>
>;

@:native('MapBox.LngLatBounds')
extern class LngLatBounds {
	public function new(sw: LngLatLike, ne: LngLatLike);
}

typedef LngLatBoundsLike = EitherType<
	LngLatBounds,
	EitherType<
		// sw, ne order
		Array<LngLatLike>,
		// west, south, east, north order
		Array<Float>
	>
>;

extern class Point {
	public function new(x: Float, y: Float);
}

typedef PointLike = EitherType<Point, Array<Float>>;
