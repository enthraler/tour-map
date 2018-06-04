// Generated by Haxe 3.4.4
(function () { "use strict";
var EnthralerHost = function() { };
EnthralerHost.__name__ = true;
EnthralerHost.main = function() {
	if(window.document.readyState != "loading") {
		EnthralerHost.init();
	} else {
		window.document.addEventListener("DOMContentLoaded",EnthralerHost.init);
	}
};
EnthralerHost.init = function() {
	EnthralerHost.addMessageListeners();
};
EnthralerHost.addMessageListeners = function() {
	window.addEventListener("message",function(e) {
		var frameWindow = e.source;
		var message = e.data;
		var allFrames = window.document.querySelectorAll("iframe.enthraler-embed");
		var currentFrame = null;
		var _g = 0;
		while(_g < allFrames.length) {
			var elm = allFrames[_g];
			++_g;
			var iframe = elm;
			if(iframe.contentWindow == frameWindow) {
				currentFrame = iframe;
			}
		}
		if(currentFrame == null) {
			return;
		}
		var data;
		try {
			data = JSON.parse(message);
		} catch( e1 ) {
			haxe_Log.trace("Failed to parse JSON from window message:",{ fileName : "EnthralerHost.hx", lineNumber : 51, className : "EnthralerHost", methodName : "addMessageListeners", customParams : [e1,message]});
			return;
		}
		var _g1 = data.context;
		if(_g1 == "iframe.resize") {
			if(currentFrame != null) {
				currentFrame.style.height = data.height + "px";
			}
		} else {
			haxe_Log.trace("Received message from frame",{ fileName : "EnthralerHost.hx", lineNumber : 60, className : "EnthralerHost", methodName : "addMessageListeners", customParams : [frameWindow,data]});
		}
	});
};
Math.__name__ = true;
var haxe_Log = function() { };
haxe_Log.__name__ = true;
haxe_Log.trace = function(v,infos) {
	js_Boot.__trace(v,infos);
};
var js_Boot = function() { };
js_Boot.__name__ = true;
js_Boot.__unhtml = function(s) {
	return s.split("&").join("&amp;").split("<").join("&lt;").split(">").join("&gt;");
};
js_Boot.__trace = function(v,i) {
	var msg = i != null ? i.fileName + ":" + i.lineNumber + ": " : "";
	msg += js_Boot.__string_rec(v,"");
	if(i != null && i.customParams != null) {
		var _g = 0;
		var _g1 = i.customParams;
		while(_g < _g1.length) {
			var v1 = _g1[_g];
			++_g;
			msg += "," + js_Boot.__string_rec(v1,"");
		}
	}
	var d;
	var tmp;
	if(typeof(document) != "undefined") {
		d = document.getElementById("haxe:trace");
		tmp = d != null;
	} else {
		tmp = false;
	}
	if(tmp) {
		d.innerHTML += js_Boot.__unhtml(msg) + "<br/>";
	} else if(typeof console != "undefined" && console.log != null) {
		console.log(msg);
	}
};
js_Boot.__string_rec = function(o,s) {
	if(o == null) {
		return "null";
	}
	if(s.length >= 5) {
		return "<...>";
	}
	var t = typeof(o);
	if(t == "function" && (o.__name__ || o.__ename__)) {
		t = "object";
	}
	switch(t) {
	case "function":
		return "<function>";
	case "object":
		if(o instanceof Array) {
			if(o.__enum__) {
				if(o.length == 2) {
					return o[0];
				}
				var str = o[0] + "(";
				s += "\t";
				var _g1 = 2;
				var _g = o.length;
				while(_g1 < _g) {
					var i = _g1++;
					if(i != 2) {
						str += "," + js_Boot.__string_rec(o[i],s);
					} else {
						str += js_Boot.__string_rec(o[i],s);
					}
				}
				return str + ")";
			}
			var l = o.length;
			var i1;
			var str1 = "[";
			s += "\t";
			var _g11 = 0;
			var _g2 = l;
			while(_g11 < _g2) {
				var i2 = _g11++;
				str1 += (i2 > 0 ? "," : "") + js_Boot.__string_rec(o[i2],s);
			}
			str1 += "]";
			return str1;
		}
		var tostr;
		try {
			tostr = o.toString;
		} catch( e ) {
			return "???";
		}
		if(tostr != null && tostr != Object.toString && typeof(tostr) == "function") {
			var s2 = o.toString();
			if(s2 != "[object Object]") {
				return s2;
			}
		}
		var k = null;
		var str2 = "{\n";
		s += "\t";
		var hasp = o.hasOwnProperty != null;
		for( var k in o ) {
		if(hasp && !o.hasOwnProperty(k)) {
			continue;
		}
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
			continue;
		}
		if(str2.length != 2) {
			str2 += ", \n";
		}
		str2 += s + k + " : " + js_Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str2 += "\n" + s + "}";
		return str2;
	case "string":
		return o;
	default:
		return String(o);
	}
};
String.__name__ = true;
Array.__name__ = true;
EnthralerHost.main();
})();
