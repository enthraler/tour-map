import react.ReactComponent.ReactComponentOfProps;
import react.ReactMacro.jsx;
import AuthorData;
import js.html.DivElement;
import js.Lib.require;
import js.Browser.window;

class ShowList extends ReactComponentOfProps<{
	> AuthorData,
	current: Stop,
	onSelect: Stop->Void
}> {
	var container: DivElement;

	override public function render() {
		var stops = props.stops.map(stop -> jsx('<StopTile stop=${stop} isCurrent=${props.current == stop} onSelect=${props.onSelect} />'));
		return jsx('<div className=${Styles.ShowList} ref=${elm -> this.container = elm}>
			<div className=${Styles.ShowList__scrollContainer}>
				<div className=${Styles.ShowList__padding} />
				<ul>${stops}</ul>
				<div className=${Styles.ShowList__padding} />
			</div>
		</div>');
	}

	override public function componentDidUpdate(prevProps, prevState: Dynamic) {
		if (prevProps.current != props.current) {
			scrollToCurrent();
		}
	}

	override public function componentDidMount() {
		scrollToCurrent();
	}

	function scrollToCurrent() {
		var animatedScrollTo = require('animated-scroll-to');
		var index = props.stops.indexOf(props.current);
		var item = container.querySelector('li:nth-child(${index + 1})');
		var itemOffset = item.offsetLeft;
		var leftPadding = window.innerWidth / 2;
		var halfItemWidth = item.offsetWidth / 2;
		// itemOffset includes the left padding, but when the position we call animatedScrollTo() should not.
		var position = itemOffset + halfItemWidth - leftPadding;
		animatedScrollTo(position, {
			minDuration: 1000,
			maxDuration: 3000,
			element: container,
			horizontal: true,
		});
	}
}

class StopTile extends ReactComponentOfProps<{
	stop: Stop,
	isCurrent: Bool,
	onSelect: Stop->Void
}> {
	override public function render() {
		var stop = props.stop;
		var date = Date.fromString(stop.date);
		var day = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'][date.getDay()];
		var month = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dev'][date.getMonth()];
		var className = props.isCurrent ? '${Styles.ShowList__Show} ${Styles.ShowList__Show__active}' : Styles.ShowList__Show;
		return jsx('<li className=${className}>
			<button onClick=${() -> props.onSelect(stop)}>
				<div className=${Styles.Show__Container}>
					<div className=${Styles.Date}>
						<span className=${Styles.Date__day}>$day</span>
						<span className=${Styles.Date__date}>${date.getDate()}</span>
						<span className=${Styles.Date__month}>${month}</span>
						<span className=${Styles.Date__year}>${date.getFullYear()}</span>
					</div>
					<div className=${Styles.Show__Details}>
						<span className=${Styles.Show__City}>${stop.city}</span>
						<span className=${Styles.Show__Byline}>${stop.byline}</span>
					</div>
				</div>
			</button>
		</li>');
	}
}